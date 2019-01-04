//
//  WorkoutCollectionViewCell.swift
//  HackChallenge
//
//  Created by Emily Reynolds on 11/29/18.
//  Copyright © 2018 Emily Reynolds. All rights reserved.
//

import UIKit

class WorkoutCollectionViewCell: UICollectionViewCell {
    
    var photo: UIImageView!
    var title: UILabel!
    var type: UILabel!
    var shadowLayer: CAShapeLayer!
    
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

        contentView.backgroundColor = UIColor(red: 1, green: 102/255, blue: 51/255, alpha: 0.35)
        contentView.layer.cornerRadius = 5.0
        contentView.clipsToBounds = true
//        contentView.layer.borderWidth = 2
//        contentView.layer.borderColor = UIColor(red: 1, green: 102/255, blue: 51/255, alpha: 0.55).cgColor
        
        photo = UIImageView(frame: .zero)
        photo.translatesAutoresizingMaskIntoConstraints = false
        //photo.contentMode = .scaleAspectFit
        photo.layer.cornerRadius = 5.0
        photo.clipsToBounds = true
        photo.layer.borderWidth = 2
        photo.layer.borderColor = UIColor(red: 1, green: 102/255, blue: 51/255, alpha: 0.55).cgColor
        contentView.addSubview(photo)
        
        title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        contentView.addSubview(title)
        
        type = UILabel()
        type.translatesAutoresizingMaskIntoConstraints = false
        type.font = UIFont.systemFont(ofSize: 12, weight: .light)
        contentView.addSubview(type)
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            //photo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -30),
            photo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            photo.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            photo.heightAnchor.constraint(equalToConstant: 144),
            photo.widthAnchor.constraint(equalToConstant: 144)
            ])
        
        NSLayoutConstraint.activate([
            //title.topAnchor.constraint(equalTo: photo.bottomAnchor, constant: -15),
            title.topAnchor.constraint(equalTo: photo.bottomAnchor, constant: 5),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8)
            ])
        
        NSLayoutConstraint.activate([
            type.topAnchor.constraint(equalTo: title.bottomAnchor),
            type.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 9),
            type.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            type.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
            ])
        
        super.updateConstraints()
    }
    
    func configure(with workout: Workout) {
        photo.image = UIImage(named: workout.imageName)
        title.text = workout.name
        type.text = workout.type.joined(separator: ", ")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
