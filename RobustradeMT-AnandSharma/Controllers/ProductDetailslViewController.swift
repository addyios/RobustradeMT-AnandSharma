//
//  ProductDetailslViewController.swift
//  RobustradeMT-AnandSharma
//
//  Created by APPLE on 04/01/26.
//

import UIKit

class ProductDetailslViewController: UIViewController {

    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    @IBOutlet weak var RatingLabel: UILabel!
    
    @IBOutlet weak var specsLabel: UILabel!
    
    @IBOutlet weak var brandNameLabel: UILabel!
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .black
        setupUI()
        
    }
    private func setupUI() {
           guard let product = product else { return }

           title = product.title ?? "Details"

           titleLabel.text = product.title ?? "-"
           descriptionLabel.text = product.description ?? "-"
        RatingLabel.text = "\(product.rating.rate)"
        amountLabel.text = "₹\(product.price ?? 0)"

           ImageLoader.shared.load(
               urlString: product.image ?? "",
               into: productImg
           )
        specsLabel.numberOfLines = 0
        specsLabel.text = specsText(from: product.specs)
        brandNameLabel.text = product.brand
        categoryNameLabel.text = product.category
       }
    
    private func specsText(from specs: [String: SpecValue]?) -> String {
        guard let specs = specs else { return "" }

        return specs
            .map { "\($0.key.capitalized) : \($0.value.displayValue())" }
            .sorted()
            .joined(separator: "\n")
    }
}
