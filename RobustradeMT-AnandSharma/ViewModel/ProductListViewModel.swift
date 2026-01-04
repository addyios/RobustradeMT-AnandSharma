//
//  ProductListViewModel.swift
//  RobustradeMT-AnandSharma
//
//  Created by APPLE on 03/01/26.
//

import Foundation

protocol ProductListViewModelDelegate: AnyObject {
    func reloadData()
    func showLoader(_ show: Bool)
    func showError(_ error: NetworkError)
}

final class ProductListViewModel {
    
    private let apiService: APIServiceProtocol
     var products: [Product] = []
    
    private var currentPage = 1
    private var totalItems = 0
    private var isLoading = false
    private var hasReachedEnd = false
    
    weak var delegate: ProductListViewModelDelegate?
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func fetchProducts() {
        guard !isLoading, !hasReachedEnd else { return }
        isLoading = true
        if currentPage == 1 {
            delegate?.showLoader(true)
        }
        
        apiService.fetchProducts(page: currentPage) { [weak self] result in
            DispatchQueue.main.async {
                defer {
                    self?.isLoading = false
                    self?.delegate?.showLoader(false)
                }
                debugPrint("the result is : \(result)")
                switch result {
                case .success(let response):
                    if response.data.isEmpty {
                        self?.hasReachedEnd = true
                        return
                    }
                    self?.products.append(contentsOf: response.data)
                    self?.totalItems = response.pagination.total
                    if self?.products.count ?? 0 >= response.pagination.total {
                        self?.hasReachedEnd = true
                    } else {
                        self?.currentPage += 1
                    }
                    self?.delegate?.reloadData()
                    
                case .failure:
                    self?.delegate?.showError(.noInternet)
                }
            }
        }
    }
    
    //    func loadMoreIfNeeded(index: Int) {
    //        if index == products.count - 2 && products.count < totalItems {
    //            fetchProducts()
    //        }
    //    }
}
