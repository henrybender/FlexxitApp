//
//  PostTableViewCell.swift
//  SocialMediaPg
//
//  Created by Henry Bender on 11/29/18.
//  Copyright © 2018 Henry Bender. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    
    var likes: UILabel!
//    var id: Int
    var postText: UITextView!
    var workout: UILabel!
    var nickname: UILabel!
    var heartImageButton: UIButton!
    var justDid: UILabel!
    var likeButton: UIButton!
    
    let heartImageWidth: CGFloat = 25
    let heartImageHeight: CGFloat = 25
    
    let padding: CGFloat = 10
    let labelHeight: CGFloat = 20
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //contentView.backgroundColor = UIColor(red: 1, green: 232/255, blue: 224/255, alpha: 1)
        
        likes = UILabel()
        likes.translatesAutoresizingMaskIntoConstraints = false
        likes.font = UIFont.boldSystemFont(ofSize: 10)
        likes.textColor = UIColor(red: 1, green: 102/255, blue: 51/255, alpha: 1)
        
        heartImageButton = UIButton()
        heartImageButton.translatesAutoresizingMaskIntoConstraints = false
//        heartImageView.contentMode = .scaleAspectFit
//        heartImageView.isHidden = false
        
        
        justDid = UILabel()
        justDid.translatesAutoresizingMaskIntoConstraints = false
        justDid.font = UIFont.systemFont(ofSize: 14)
        
        postText = UITextView()
        postText.translatesAutoresizingMaskIntoConstraints = false
        postText.isEditable = false
        postText.layer.cornerRadius = 5.0
        postText.clipsToBounds = true
        postText.font = UIFont.systemFont(ofSize: 14)
        postText.backgroundColor = UIColor(red: 1, green: 232/255, blue: 224/255, alpha: 0.65)
        
        workout = UILabel()
        workout.translatesAutoresizingMaskIntoConstraints = false
        workout.font = UIFont.systemFont(ofSize: 14)
        
        nickname = UILabel()
        nickname.translatesAutoresizingMaskIntoConstraints = false
        nickname.layer.cornerRadius = 5.0
        nickname.clipsToBounds = true
        nickname.backgroundColor = UIColor(red: 1, green: 102/255, blue: 51/255, alpha: 0.55)
        nickname.tintColor = UIColor(red: 1, green: 102/255, blue: 51/255, alpha: 0.55)
        nickname.textColor = .white
        nickname.font = UIFont.boldSystemFont(ofSize: 16)
        
        
        contentView.addSubview(likes)
        contentView.addSubview(postText)
        contentView.addSubview(workout)
        contentView.addSubview(nickname)
        contentView.addSubview(heartImageButton)
        
        
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            nickname.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            nickname.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            nickname.heightAnchor.constraint(equalToConstant: labelHeight + 5),
            nickname.widthAnchor.constraint(equalToConstant: 340)
            ])
        
        NSLayoutConstraint.activate([
            workout.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            workout.topAnchor.constraint(equalTo: nickname.bottomAnchor, constant: 2),
            workout.heightAnchor.constraint(equalToConstant: labelHeight)
            ])
        
        NSLayoutConstraint.activate([
            postText.leadingAnchor.constraint(equalTo: nickname.leadingAnchor),
            postText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            postText.topAnchor.constraint(equalTo: workout.bottomAnchor, constant: 3),
            postText.heightAnchor.constraint(equalToConstant: 35)
            ])
        
        NSLayoutConstraint.activate([
            likes.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            likes.topAnchor.constraint(equalTo: heartImageButton.bottomAnchor),
            likes.heightAnchor.constraint(equalToConstant: 15),
            likes.widthAnchor.constraint(equalToConstant: 15)
            ])
        
        NSLayoutConstraint.activate([
            heartImageButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            heartImageButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -padding*2),
            heartImageButton.heightAnchor.constraint(equalToConstant: heartImageHeight),
            heartImageButton.widthAnchor.constraint(equalToConstant: heartImageWidth)
            ])
        
        super.updateConstraints()
    }
    
    func configure(for post: Post) {
        nickname.text = post.nickname
        workout.text = post.workout
        likes.text = String(post.likes)
        postText.text = post.text
//        id = post.id
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func heartOn(id: Int) {
        heartImageButton.setImage(UIImage(named: "heart"), for: .normal)
    }
    func heartOff(id: Int) {
        heartImageButton.setImage(UIImage(named: "heart-border"), for: .normal)
    }
}

