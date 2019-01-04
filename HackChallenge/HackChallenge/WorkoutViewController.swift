//
//  WorkoutViewController.swift
//  MusicFit
//
//  Created by Emily Reynolds on 11/29/18.
//  Copyright © 2018 Emily Reynolds. All rights reserved.
//
import UIKit

protocol ViewWorkoutDelegate: class {
    func workoutInfo(imageName: String, name: String, type: [String], description: String, index: Int)
}

protocol PushField: class {
    func pushField(workoutName: String, workoutImg: String)
}


class WorkoutViewController: UIViewController {
    
    var backButton: UIButton!
    var viewLabel = UILabel()
    var workoutImage = UIImageView()
    var workoutImageName: String = ""
    var workoutDescription = UITextView()
    var workoutType: String = ""
    var playButton: UIButton!
    var postButton: UIButton!
    var playlist: [String] = []
    var shadowLayer: CAShapeLayer!
    
    let song1: String = "https://m.soundcloud.com/lil-baby-4pf/drip-too-hard"
    let song2: String = "https://soundcloud.com/kanyewest/power-explicit-version"
    let song3: String = "https://soundcloud.com/wearegalantis/galantis-runaway-u-i-1?in=sebaalomar/sets/grooveey-danceyy"
    let song4: String = "https://soundcloud.com/lifeofdesiigner/desiigner-panda"
    let song5: String = "https://soundcloud.com/kanyewest/stronger-1"
    let song6: String = "https://soundcloud.com/user294601250/drake-ft-future-jumpman"
    let song7: String = "https://soundcloud.com/steveaoki/kid-cudi-pursuit-of-happiness"
    let song8: String = "https://soundcloud.com/vince-staples-official/big-fish"
    let song9: String = "https://soundcloud.com/vince-staples-official"
    let song10: String = "https://soundcloud.com/pearrozay/drive-me-crazy-kaytranada-feat-vic-mensa"
    let song11: String = "https://soundcloud.com/flume/insane-feat-moon-holiday"
    let song12: String = "https://soundcloud.com/childish-gambino/iv-sweatpants"
    let song13: String = "https://soundcloud.com/watchthethrone/no-church-in-the-wild"
    let song14: String = "https://soundcloud.com/interscope/schoolboy-q-hands-on-the-wheel"
    let song15: String = "https://soundcloud.com/unofficialthey/u-rite-1"
    
    weak var postDelegate: PostField?
    weak var workoutZoomDelegate: WorkoutZoomDelegate?
    
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
        viewLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        view.addSubview(viewLabel)
      
        workoutImage.translatesAutoresizingMaskIntoConstraints = false
        //workoutImage.contentMode = .scaleAspectFit
        workoutImage.layer.cornerRadius = 10.0
        workoutImage.clipsToBounds = true
        workoutImage.layer.masksToBounds = true
        workoutImage.layer.borderWidth = 2
        workoutImage.layer.borderColor = UIColor(red: 7/255, green: 136/255, blue: 155/255, alpha: 0.5).cgColor
        view.addSubview(workoutImage)
        
        workoutDescription.translatesAutoresizingMaskIntoConstraints = false
        workoutDescription.backgroundColor = .white
        //workoutDescription.layer.borderColor = color.cgColor
        workoutDescription.layer.cornerRadius = 5.0
        workoutDescription.clipsToBounds = true
        workoutDescription.textAlignment = .left
        workoutDescription.isEditable = false
        workoutDescription.font = UIFont.systemFont(ofSize: 15)
        workoutDescription.layer.borderWidth = 2
        workoutDescription.layer.borderColor = UIColor(red: 7/255, green: 136/255, blue: 155/255, alpha: 0.5).cgColor
        view.addSubview(workoutDescription)
        
        playButton = UIButton()
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.layer.cornerRadius = 5.0
        playButton.clipsToBounds = true
        playButton.setTitle("Play Song", for: .normal)
        playButton.backgroundColor = UIColor(red: 7/255, green: 136/255, blue: 155/255, alpha: 0.65)
        playButton.setTitleColor(.white, for: .normal)
        view.addSubview(playButton)
        
        playButton.addTarget(self, action: #selector(playSong), for: .touchUpInside)
        
        postButton = UIButton()
        postButton.translatesAutoresizingMaskIntoConstraints = false
        postButton.layer.cornerRadius = 5.0
        postButton.clipsToBounds = true
        postButton.layer.masksToBounds = false
        postButton.setTitle("Share", for: .normal)
        postButton.backgroundColor = UIColor(red: 7/255, green: 136/255, blue: 155/255, alpha: 0.65)
        postButton.setTitleColor(.white, for: .normal)
        view.addSubview(postButton)
        
        postButton.addTarget(self, action: #selector(sharePost), for: .touchUpInside)
        
//        let playRect = CGRect(x: playButton.frame.origin.x, y: playButton.frame.origin.y, width: playButton.bounds.size.width, height: playButton.bounds.size.height)

//        shadowLayer = CAShapeLayer()
//        shadowLayer.path = UIBezierPath(roundedRect: playButton.bounds, cornerRadius: 5).cgPath
//        shadowLayer.fillColor = UIColor.white.cgColor
//
//        shadowLayer.shadowColor = UIColor.black.cgColor
//        shadowLayer.shadowPath = shadowLayer.path
//        shadowLayer.shadowOffset = CGSize(width: 10, height: 10)
//        shadowLayer.shadowOpacity = 0.25
//        shadowLayer.shadowRadius = 10
//
//        playButton.layer.insertSublayer(shadowLayer, below: nil)
        
        playlist = [song1, song2, song3, song4, song5, song6, song7, song8, song9, song10, song11, song12, song13, song14, song15]
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            backButton.widthAnchor.constraint(equalToConstant: 75)
            ])
        
        NSLayoutConstraint.activate([
            viewLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            viewLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            viewLabel.heightAnchor.constraint(equalToConstant: 40)
            ])
        
        NSLayoutConstraint.activate([
            workoutImage.topAnchor.constraint(equalTo: viewLabel.bottomAnchor, constant: 30),
            workoutImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            workoutImage.heightAnchor.constraint(equalToConstant: 260),
            workoutImage.widthAnchor.constraint(equalToConstant: 260)
            ])
        
        NSLayoutConstraint.activate([
            workoutDescription.topAnchor.constraint(equalTo: workoutImage.bottomAnchor, constant: 30),
            workoutDescription.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            workoutDescription.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            workoutDescription.heightAnchor.constraint(equalToConstant: 240)
            ])
        
        NSLayoutConstraint.activate([
            playButton.topAnchor.constraint(equalTo: workoutDescription.bottomAnchor, constant: 30),
            playButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            playButton.heightAnchor.constraint(equalToConstant: 40),
            playButton.widthAnchor.constraint(equalToConstant: 150)
            ])
        
        NSLayoutConstraint.activate([
            postButton.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 30),
            postButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            postButton.heightAnchor.constraint(equalToConstant: 40),
            postButton.widthAnchor.constraint(equalToConstant: 150)
            ])
    }
    
    @objc func playSong() {
        let rand = Int.random(in: 0 ... 14)
        if let url = URL(string: playlist[rand]) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    @objc func sharePost() {
        print("start share")
        let postViewController = PostViewController()
        postDelegate = postViewController
        postViewController.pushDelegate = self
        present(postViewController, animated: true, completion: nil)
        postDelegate?.postField(workoutName: viewLabel.text!, workoutImg: workoutImageName)
    }
    
    @objc func backAction() {
        dismiss(animated: true, completion: nil)
    }
    
    /*
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension WorkoutViewController: ViewWorkoutDelegate {
    func workoutInfo(imageName: String, name: String, type: [String], description: String, index: Int) {
        viewLabel.text = name
        workoutImage.image = UIImage(named: imageName)
        workoutImageName = imageName
        workoutType = type.joined(separator: ", ")
        workoutDescription.text = description
    }
}

extension WorkoutViewController: PushField {
    func pushField(workoutName: String, workoutImg: String) {
        viewLabel.text = workoutName
        workoutImage.image = UIImage(named: workoutImg)
    }
}

