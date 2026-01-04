//
//  ProductTVCell.swift
//  RobustradeMT-AnandSharma
//
//  Created by APPLE on 04/01/26.
//

import UIKit

class ProductTVCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var BGView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        BGviewDesing()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func BGviewDesing(){
        BGView.layer.cornerRadius = 6
        BGView.layer.shadowColor = UIColor.lightGray.cgColor
        BGView.layer.shadowOpacity = 0.15
        BGView.layer.shadowOffset = CGSize(width: 0, height: 1)
        BGView.layer.shadowRadius = 2
        BGView.layer.masksToBounds = false
    }
    func configure(with product: Product) {
        titleLabel.text = product.title ?? ""
        descriptionLabel.text = product.description ?? ""
        priceLabel.text = "₹\(product.price ?? 0)"
        ImageLoader.shared.load(urlString: product.image ?? "", into: productImage)
    }
    
}
