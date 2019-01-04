//
//  PostViewController.swift
//  MusicFit
//
//  Created by Emily Reynolds on 11/29/18.
//  Copyright © 2018 Emily Reynolds. All rights reserved.
//
import UIKit

protocol PostField: class {
    func postField(workoutName: String, workoutImg: String)
}

class PostViewController: UIViewController {
    
    var backButton: UIButton!
    var viewLabel = UILabel()
    var nameLabel = UILabel()
    var nameField = UITextField()
    var workoutText = UILabel()
    var workoutImageName: String = ""
    var workoutImage = UIImageView()
    var postLabel = UILabel()
    var postDescription = UITextField()
    var postButton: UIButton!
    
    weak var pushDelegate: PushField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 223/255, green: 243/255, blue: 246/255, alpha: 1)
        
        backButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.layer.cornerRadius = 5.0
        backButton.clipsToBounds = true
        backButton.setTitle("Back", for: .normal)
        backButton.backgroundColor = UIColor(red: 7/255, green: 136/255, blue: 155/255, alpha: 0.8)
        backButton.setTitleColor(.white, for: .normal)
        view.addSubview(backButton)
        
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        
        viewLabel.translatesAutoresizingMaskIntoConstraints = false
        viewLabel.backgroundColor = UIColor(red: 223/255, green: 243/255, blue: 246/255, alpha: 1)
        viewLabel.textAlignment = .center
        viewLabel.font = UIFont.boldSystemFont(ofSize: 24)
        viewLabel.text = "Create a post to share with friends!"
        view.addSubview(viewLabel)
        
        workoutText.translatesAutoresizingMaskIntoConstraints = false
        workoutText.backgroundColor = UIColor(red: 223/255, green: 243/255, blue: 246/255, alpha: 1)
        workoutText.textAlignment = .center
        workoutText.font = UIFont.systemFont(ofSize: 18)
        view.addSubview(workoutText)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.backgroundColor = UIColor(red: 223/255, green: 243/255, blue: 246/255, alpha: 1)
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont.systemFont(ofSize: 18)
        nameLabel.text = "Nickname:"
        view.addSubview(nameLabel)
        
        nameField.translatesAutoresizingMaskIntoConstraints = false
        nameField.backgroundColor = .white
        nameField.textAlignment = .left
        nameField.clearsOnBeginEditing = true
        nameField.layer.cornerRadius = 5.0
        nameField.clipsToBounds = true
        nameField.borderStyle = .roundedRect
        nameField.layer.borderWidth = 2
        nameField.layer.borderColor = UIColor(red: 7/255, green: 136/255, blue: 155/255, alpha: 0.5).cgColor
        view.addSubview(nameField)
        
        workoutImage.translatesAutoresizingMaskIntoConstraints = false
        workoutImage.contentMode = .scaleAspectFit
        workoutImage.layer.cornerRadius = 10.0
        workoutImage.clipsToBounds = true
        workoutImage.layer.borderWidth = 2
        workoutImage.layer.borderColor = UIColor(red: 7/255, green: 136/255, blue: 155/255, alpha: 0.5).cgColor

        view.addSubview(workoutImage)
        
        postLabel.translatesAutoresizingMaskIntoConstraints = false
        postLabel.backgroundColor = UIColor(red: 223/255, green: 243/255, blue: 246/255, alpha: 1)
        postLabel.textAlignment = .left
        postLabel.font = UIFont.systemFont(ofSize: 18)
        postLabel.text = "Write your post below:"
        view.addSubview(postLabel)
        
        postDescription.translatesAutoresizingMaskIntoConstraints = false
        postDescription.backgroundColor = .white
        postDescription.textAlignment = .left
        postDescription.contentVerticalAlignment = .top
        postDescription.clearsOnBeginEditing = true
        postDescription.layer.cornerRadius = 5.0
        postDescription.clipsToBounds = true
        postDescription.borderStyle = .roundedRect
        postDescription.layer.borderWidth = 2
        postDescription.layer.borderColor = UIColor(red: 7/255, green: 136/255, blue: 155/255, alpha: 0.5).cgColor
        view.addSubview(postDescription)
        
        postButton = UIButton()
        postButton.translatesAutoresizingMaskIntoConstraints = false
        postButton.layer.cornerRadius = 5.0
        postButton.clipsToBounds = true
        postButton.setTitle("Share", for: .normal)
        postButton.backgroundColor = UIColor(red: 7/255, green: 136/255, blue: 155/255, alpha: 0.65)
        view.addSubview(postButton)
        
        postButton.addTarget(self, action: #selector(postToSocial), for: .touchUpInside)
                
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            backButton.widthAnchor.constraint(equalToConstant: 75)
            ])
        
        NSLayoutConstraint.activate([
            viewLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 5),
            viewLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            viewLabel.heightAnchor.constraint(equalToConstant: 40)
            ])
        
        NSLayoutConstraint.activate([
            workoutText.topAnchor.constraint(equalTo: viewLabel.bottomAnchor, constant: 15),
            workoutText.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            workoutText.heightAnchor.constraint(equalToConstant: 20)
            ])
        
        NSLayoutConstraint.activate([
            workoutImage.topAnchor.constraint(equalTo: workoutText.bottomAnchor, constant: 20),
            workoutImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            workoutImage.heightAnchor.constraint(equalToConstant: 260),
            workoutImage.widthAnchor.constraint(equalToConstant: 260)
            ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: workoutImage.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            nameLabel.heightAnchor.constraint(equalToConstant: 20)
            ])
        
        NSLayoutConstraint.activate([
            nameField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            nameField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            nameField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            nameField.heightAnchor.constraint(equalToConstant: 40)
            ])
        
        NSLayoutConstraint.activate([
            postLabel.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 10),
            postLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            postLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            postLabel.heightAnchor.constraint(equalToConstant: 20)
            ])
        
        NSLayoutConstraint.activate([
            postDescription.topAnchor.constraint(equalTo: postLabel.bottomAnchor, constant: 10),
            postDescription.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            postDescription.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            postDescription.heightAnchor.constraint(equalToConstant: 180)
            ])
        
        NSLayoutConstraint.activate([
            postButton.topAnchor.constraint(equalTo: postDescription.bottomAnchor, constant: 30),
            postButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            postButton.heightAnchor.constraint(equalToConstant: 40),
            postButton.widthAnchor.constraint(equalToConstant: 150)
            ])
        
    }
    
    @objc func postToSocial() {
        let text = postDescription.text!
        let nickname = nameField.text!
        let workout = workoutText.text!
        NetworkManager.sharePost(text: text, nickname: nickname, workout: workout) { (PostData) in
            print("shared")
            print(workout)
        }
        dismiss(animated: true, completion: nil)
        }

    
    @objc func workoutDescription() {
        let workoutViewController = WorkoutViewController()
        workoutViewController.postDelegate = self
        pushDelegate?.pushField(workoutName: viewLabel.text!, workoutImg: workoutImageName)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func backAction() {
        dismiss(animated: true, completion: nil)
    }
    
}

extension PostViewController: PostField {
    func postField(workoutName: String, workoutImg: String) {
        workoutText.text = workoutName
        workoutImage.image = UIImage(named: workoutImg)
        print("delegate working")
    }
    }
