//
//  SocialViewController.swift
//  MusicFit
//
//  Created by Emily Reynolds on 11/29/18.
//  Copyright © 2018 Emily Reynolds. All rights reserved.
//
import UIKit

class SocialViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView!
    var posts = [Post]()
    let reuseIdentifier = "PostCellReuse"
    let cellHeight: CGFloat = 100
    var likes: [String]!
    var refreshControl: UIRefreshControl!


    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Friends"
        view.backgroundColor = .white
        
        let post1 = Post(likes: 1, id: 0, text: "That was quite a workout! Wow! I never work out! This feels great!", workout: "Lunge", nickname: "John Bender")
        
        let post2 = Post(likes: 1, id: 0, text: "So much fun!", workout: "Front Kick", nickname: "Allison Portis")
        
        posts = [post1, post2]
        
        
        tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorColor = UIColor(red: 1, green: 102/255, blue: 51/255, alpha: 0.55)
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.dataSource = self
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pulledToRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)
        
        getPosts()
        
        likes = [String](repeating: "heart-border", count: 100)

        
        setupConstraints()
    }
    
    func setupConstraints() {
        // Setup the constraints for our views
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
    }
    
    
    
    func getPosts() {
        NetworkManager.getPosts { (posts) in
            self.posts = posts
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! PostTableViewCell
        cell.selectionStyle = .none
        cell.configure(for: posts[indexPath.row])
        if likes[indexPath.row] == "heart"{
            cell.heartImageButton.setImage(UIImage(named: "heart"), for: .normal)
        }
        else{
            cell.heartImageButton.setImage(UIImage(named: "heart-border"), for: .normal)
        }
        cell.heartImageButton.tag = indexPath.row
        cell.heartImageButton.addTarget(self, action: #selector(handleLikes), for: .touchUpInside)
        cell.setNeedsUpdateConstraints()
        return cell
    }
    
    @objc func handleLikes(sender: PostTableViewCell) {
        print(sender.tag)
        let id = posts[sender.tag].id
        if likes[sender.tag] == "heart" {
            print("already liked")
            tableView.reloadData()
        }
        else {
            likes[sender.tag] = "heart"
            NetworkManager.likePost(id: id)
            print("LikeButton")
            tableView.reloadData()
        }
        getPosts()
    }
    
    @objc func workouts() {
        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    @objc func pulledToRefresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.getPosts()
            self.refreshControl.endRefreshing()
        }
    }
}
