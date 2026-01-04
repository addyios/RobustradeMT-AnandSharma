//
//  ViewController.swift
//  RobustradeMT-AnandSharma
//
//  Created by APPLE on 03/01/26.
//

import UIKit

class ProductListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private let loader = UIActivityIndicatorView(style: .medium)
    private let viewModel = ProductListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = ""
        setupTableView()
        setupLoader()
        viewModel.delegate = self
        viewModel.fetchProducts()
    }
    
    private func setupTableView() {
        tableView.register(
            UINib(nibName: "ProductTVCell", bundle: nil),
            forCellReuseIdentifier: "ProductTVCell"
        )
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func setupLoader() {
        view.addSubview(loader)
        loader.center = view.center
    }
}

//Mark: Table Delegate & Data source method calling
extension ProductListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "ProductTVCell",
            for: indexPath
        ) as! ProductTVCell
        
        let product = viewModel.products[indexPath.row]
        cell.configure(with: product)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(
            withIdentifier: "ProductDetailslViewController"
        ) as! ProductDetailslViewController
        
        vc.product = viewModel.products[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        
        let lastIndex = viewModel.products.count - 1
        
        if indexPath.row == lastIndex {
            viewModel.fetchProducts()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 126
    }
}

//Mark: Delegate method calling
extension ProductListViewController: ProductListViewModelDelegate {
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func showLoader(_ show: Bool) {
        show ? loader.startAnimating() : loader.stopAnimating()
    }
    
    func showError(_ error: NetworkError) {
        self.showAlert(
            message: error.message,
            retryHandler: { [weak self] in
                self?.viewModel.fetchProducts()
            }
        )
    }
}
