
//
//  FilterCollectionViewCell.swift
//  MusicFit
//
//  Created by Emily Reynolds on 11/28/18.
//  Copyright © 2018 Emily Reynolds. All rights reserved.
//
import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    
    var filter: UILabel!
    var shadowLayer: CAShapeLayer!
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                filter.backgroundColor = UIColor(red: 7/255, green: 136/255, blue: 155/255, alpha: 0.8)
                shadowLayer.fillColor = UIColor(red: 7/255, green: 136/255, blue: 155/255, alpha: 0.8).cgColor
                filter.textColor = .white
            } else {
                filter.backgroundColor = .white
                shadowLayer.fillColor = UIColor.white.cgColor
                filter.textColor = .black
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 5).cgPath
        shadowLayer.fillColor = UIColor.white.cgColor
        
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 1, height: 1)
        shadowLayer.shadowOpacity = 0.25
        shadowLayer.shadowRadius = 2
        
        layer.insertSublayer(shadowLayer, below: nil)

        
        filter = UILabel(frame: .zero)
        filter.layer.cornerRadius = 5.0
        filter.clipsToBounds = true
        filter.backgroundColor = .white
        filter.translatesAutoresizingMaskIntoConstraints = false
        filter.textColor = .black
        filter.textAlignment = .center

        contentView.addSubview(filter)
        
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            filter.topAnchor.constraint(equalTo: contentView.topAnchor),
            filter.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            filter.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            filter.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            ])
        super.updateConstraints()
    }
    
    func configure(with filter: Filter) {
        self.filter.text = filter.type
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
