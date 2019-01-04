//
//  ViewController.swift
//  MusicFit
//
//  Created by Emily Reynolds on 11/27/18.
//  Copyright © 2018 Emily Reynolds. All rights reserved.
//
import UIKit

protocol WorkoutZoomDelegate: class {
    func seeWorkout(imageName: String, name: String, type: [String], description: String, index: Int)
}

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var toolBar: UIToolbar!
    var friendsButton: UIBarButtonItem!
    var homeButton: UIBarButtonItem!
    var workoutCollection: UICollectionView!
    var workouts: [Workout]!
    var filterCollection: UICollectionView!
    var filters: [Filter]!
    var ogWorkouts: [Workout]!
    let workoutCellReuseIdentifier = "restaurantCellReuseIdentifier"
    let filterReuseIdentifier = "filterReuseIdentifier"
    let Rpadding: CGFloat = 7.0
    let Fpadding: CGFloat = 2.0
    var shadowLayer: UIView!
    
    weak var viewWorkoutDelegate: ViewWorkoutDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Workouts"
        view.backgroundColor = .white
        
        let jumpingJacks = Workout(imageName: "jumpingjacks", name: "Jumping Jacks", type: ["Cardio"], description: "Stand with feet together, knees slightly bent, and arms to sides. Execution. Jump while raising arms and separating legs to sides. Land on forefoot with legs apart and arms overhead. Jump again while lower arms and returning legs to midline.")
        let sideLegRaises = Workout(imageName: "sidelegraises", name: "Side Leg Raises", type: ["Legs"], description: "Stand straight, directly behind table, feet slightly apart. Hold table for balance. Slowly lift one leg to side, 6-12 inches. Hold position. Slowly lower leg. Repeat with other leg. Back and both knees are straight throughout exercise.")
        let kneeToElbows = Workout(imageName: "knee-to-elbows", name: "Knee-to-Elbows", type: ["Abs"], description: "Lie flat on your back and place your hands behind your head. Bend your knees and bring them up so that your thighs and hips form a 90 degree angle, calves parallel to the floor. With elbows flared lift your shoulder blades off the floor and hold the position. Twist your upper body in one direction bringing the elbow to the opposite knee while fully extending your other leg. Hold and then return back to the starting position to repeat in the opposite direction.")
        let lungePunches = Workout(imageName: "lungepunches", name: "Lunge Punches", type: ["Arms", "Legs"], description: "Stand straight with your feet hip-width apart. Position your amrms at shoulder height with your palms facing each other. Take a step back with your left leg, flex your knees and push your left arm out in a punching motion. Stand back up, switch legs and repeat. Keep alternating legs until the set is complete.")
        let squatSideKick = Workout(imageName: "squat+sidekick", name: "Squat + Side Kick", type: ["Legs", "Butt"], description: "Stand with your feet shoulder-width distance apart, feet parallel. Hold your hands out in front of you for balance. Bend your knees, lowering your hips deeply into a squat, keeping weight back in your heels. Then rise back up, straightening the legs completely and lifting the right leg out to the side, squeezing the outer glute. As you step the foot back into shoulder-width distance position, squat down again. Then stand up and do a side leg lift on the left side. Lower the leg back to the starting position.")
        let squatFrontKick = Workout(imageName: "squat+frontkick", name: "Squat + Front Kick", type: ["Legs", "Butt"], description: "Stand with your feet shoulder-width distance apart, feet parallel. Hold your hands out in front of you for balance. Bend your knees, lowering your hips deeply into a squat, keeping weight back in your heels. Then rise back up, straightening the legs completely and lifting the right leg out to the front, squeezing the outer glute. As you step the foot back into shoulder-width distance position, squat down again. Then stand up and do a front leg kick on the left side. Lower the leg back to the starting position.")
        let legRaises = Workout(imageName: "legraises", name: "Leg Raises", type: ["Legs"], description: "Lay down with your hands to your sides for support. Raise your legs so they are off the ground, keeping the abdominals tight. Slowly raise your legs 90 degrees, contracting the abdominal muscles. Slowly return to starting position. Do not touch the floor with your feet.")
        let squatHold = Workout(imageName: "squathold", name: "Squat Hold", type: ["Butt"], description: "Place your feet at shoulder-width or just outside of shoulder-width. Turn your toes out slightly. Brace your core and keep your chest up. Swing your arms up to shoulder level as you slowly bend your knees and push your hips backward. Lower yourself until your thighs are parallel with the ground. Pause and stay in this position for as long as you can. Return to the starting position by dropping your arms and push your hips forward.")
        let marchSteps = Workout(imageName: "marchsteps", name: "March Steps", type: ["Cardio"], description: "Stand straight with your elbows bent at a 90-degree angle and your feet hip width apart. Bring your right elbow forward at the same time as you bring your left knee up. Repeat on the opposite side and keep alternating sides until the set is complete.")
        let calfRaises = Workout(imageName: "calfraises", name: "Calf Raises", type: ["Legs"], description: "Raise your heels as you breathe out by extending your ankles as high as possible and flexing your calf. Ensure that the knee is kept stationary at all times. There should be no bending at any time. Hold the contracted position by a second before you start to go back down. Go back slowly to the starting position as you breathe in by lowering your heels as you bend the ankles until calves are stretched. Repeat until the desired number of repititions is completed.")
        let lunges = Workout(imageName: "lunges", name: "Lunges", type: ["Legs"], description: "Stand upright. Step forward with one foot. The toes of both feet should be facing straight ahead. Be sure your legs are aligned - your front knee should be aligned with the foot. Lower your back knee towards the floor. Push back up to the starting position. Concentrate on squeezing your buttocks to push yourself up, and keep the abdominals tight and the lower back in a neutral position. Throughout the exercise, maintain the body in an upright position and avoid leaning forward.")
        let shoulderTaps = Workout(imageName: "shouldertaps", name: "Shoulder Taps", type: ["Abs"], description: "Get into a push-up position with your arms fully extended, your body in a straight line, and up on your toes. This will be your starting position. Quickly bring one hand up to tap the opposite-side shoulder, placing that hand back on the floor before repeating to the opposite side. Concurrently your body will slightly shift from one side to the other to better maintain balance. Move back and forth for the designated number of reps.")
        let plankRotations = Workout(imageName: "plankrotations", name: "Plank Rotations", type: ["Abs"], description: "Lie on your left side on the mat and position your elbow directly under your right shoulder. Stack together your legs, knees, ankles and feet. Tighten abs. Push your right elbow against the floor as you lift up your glutes and hips off the floor until left shoulder, left hip, and left foot are in a straight line. Reach up with your right hand and extend. Rotate your torso downwards and reach under your body with your left arm. Rotate back to the side plank with arm up and repeat for 10 times before switching sides. ")
        let highCrunches = Workout(imageName: "highcrunches", name: "High Crunches", type: ["Abs"], description: "Lie on your back with your knees bent and feet flat on the floor, hip-width apart. Position your arms perpendicular to your chest. Tilt your chin slightly, leaving a few inches of space between your chin and your chest. Gently pull your abdominals inward. Curl up and forward so that your head, neck, and shoulder blades lift off the floor while stretching your arms upwards. Hold for a moment at the top of the movement and then lower slowly back down.")
        //let sideJacks = Workout(imageName: "sidejacks", name: "Side Jacks", type: ["Abs"], description: "")
        let bridges = Workout(imageName: "bridges", name: "Bridges", type: ["Abs"], description: "Lie flat on the floor on your back with the hands by your side and your knees bent. Your feet should be placed around shoulder width. This will be your starting position. Pushing mainly with your heels, lift your hips off the floor while keeping your back straight. Breathe out as you perform this part of the motion and hold at the top for a second. Slowly go back to the starting position as you breathe in.")
        let hollowHold = Workout(imageName: "hollowhold", name: "Hollow Hold", type: ["Abs"], description: "Lie down flat on your back and contract the abs, pulling the belly button towards the floor. The arms and legs should be held straight out from the body with hands and toes pointed. Slowly raise shoulders and legs from the ground. The arms and head should be raised along with the shoulders. The lower back must remain in contact with the floor. The goal is to find the lowest position that you can hold the arms and legs, without them touching the floor and without breaking lower back contact.")
        let crunches = Workout(imageName: "crunches", name: "Crunches", type: ["Abs"], description: "Lie on your back with your knees bent and feet flat on the floor, hip-width apart. Place your hands behind your head so your thumbs are behind your ears. Hold your elbows out to the sides but rounded slightly in. Tilt your chin slightly, leaving a few inches of space between your chin and your chest.")
        let sitUps = Workout(imageName: "sit-ups", name: "Sit-ups", type: ["Abs"], description: "Lie down on the floor placing your feet either under something that will not move or by having a partner hold them. Your legs should be bent at the knees. Place your hands behind your head and lock them together by clasping your fingers. Elevate your upper body so that it creates an imaginary V-shape with your thighs. Breathe out when performing this part of the exercise.Lower your upper body back down to the starting position while inhaling.")
        let sittingTwists = Workout(imageName: "sittingtwists", name: "Sitting Twists", type: ["Abs"], description: "Sit on the ground with your knees bent and your heels about a foot from your butt. Lean slightly back without rounding your spine at all. It is really important, and difficult, to keep your back straight, but don't let it curve. Place your arms straight out in front of you with your hands one on top of the other. Your hands should be level with the bottom of your ribcage. Pull your navel to your spine and twist slowly to the left. The movement is not large and comes from the ribs rotating, not from your arms swinging. Inhale through center and rotate to the right. Repeat for the desired number of repititions.")
        let jumpSquats = Workout(imageName: "jumpsquats", name: "Jump Squats", type: ["Cardio", "Butt"], description: "Stand with your feet shoulder-width apart.Start by doing a regular squat, then engage your core and jump up explosively. When you land, lower your body back into the squat position to complete one rep. Land as quietly as possible, which requires control. Repeat for the desired number of repititions.")
        let sideKicks = Workout(imageName: "sidekicks", name: "Side Kicks", type: ["Legs"], description: "Start on all fours with hands underneath your shoulders and knees under your hips. Keeping the knee bent 90 degrees, lift the right leg until it is parallel to the floor. Keep the right thigh still as you straighten your right knee, kicking your leg out to the side. Don't let the leg lower as you kick it. Bend the right knee back to 90 degrees, and then lower the leg. Repeat for the desired number of repititions.")
        //let climberTaps = Workout(imageName: "climbertaps", name: "Climber Taps", type: ["Cardio", "Abs"], description: "")
        let highKnees = Workout(imageName: "highknees", name: "High Knees", type: ["Cardio"], description: "Stand up straight and place your feet about hip-width apart. Place your hands palms down facing the floor, hovering just above your belly button. Quickly drive your right knee up to meet your right hand, bring the same leg back to the ground immediately bring the left knee coming up to meet your left hand. As you are alternating knees, you want to do it with a hopping motion, staying on the balls of your feet the entire time. Make sure you are engaging your abdominal muscles as each knee comes up to meet the hands.")
        let plankHold = Workout(imageName: "plankhold", name: "Plank Hold", type: ["Abs"], description: "Plant the hands directly under the shoulders (slightly wider than shoulder-width apart) like you’re about to do a push-up. Ground the toes into the floor and squeeze the glutes to stabilize the body. Your legs should be working in the move too; careful not to lock or hyperextend your knees. Neutralize the neck and spine by looking at a spot on the floor about a foot beyond the hands. Your head should be in line with your back. Hold the position for the desired amount of time.")
        let raisedArmCircles = Workout(imageName: "raisedarmcircles", name: "Raised Arm Cicles", type: ["Arms"], description: "Stand tall and raise your arms to the sides so they are parallel to the floor. Point your fingers outward and make quick, small circles with your arms.")
        let pushUps = Workout(imageName: "push-ups", name: "Push-ups", type: ["Arms"], description: "Get on the floor on all fours, positioning your hands slightly wider than your shoulders. Extend your legs back so that you are balanced on your hands and toes. Keep your body in a straight line from head to toe without sagging in the middle or arching your back. You can position your feet to be close together or a bit wider depending on what is most comfortable for you. Before you begin any movement, contract your abs and tighten your core by pulling your belly button toward your spine. Keep a tight core throughout the entire push up. Inhale as you slowly bend your elbows and lower yourself until your elbows are at a 90-degree angle. Exhale as you begin contracting your chest muscles and pushing back up through your hands to the start position. Don't lock out the elbows; keep them slightly bent.")
        let elbowPlankHold = Workout(imageName: "elbowplankhold", name: "Elbow Plank Hold", type: ["Abs"], description: "Start face down on the floor resting on your forearms and knees. Push off the floor, raising up off your knees onto your toes and resting mainly on your elbows. Contract your abdominals to keep yourself up and prevent your booty from sticking up. Keep your back flat. Hold the position for the desired amount of time.")
        let kneeToElbowCrunches = Workout(imageName: "knee-to-elbowcrunches", name: "Knee-to-Elbow Crunches", type: ["Abs"], description: "Lie flat on your back and place your hands behind your head. Bend your knees and bring them up so that your thighs and hips form a 90 degree angle, calves parallel to the floor. With elbows flared lift your shoulder blades off the floor and hold the position. Twist your upper body in one direction bringing the elbow to the opposite knee while fully extending your other leg. Hold and then return back to the starting position to repeat in the opposite direction.")
        let sideLunge = Workout(imageName: "sidelunge", name: "Side Lunge", type: ["Legs"], description: "Start standing with legs slightly wider than shoulder-distance apart and toes pointed forward. Shift your body weight to one leg bending the knee until it reaches a 90-degree angle and the other leg is straight. Glutes are pressing back behind you. Return to center and switch sides.")
        let armScissors = Workout(imageName: "armscissors", name: "Arm Scissors", type: ["Arms"], description: "Stand up straight with your legs wide apart. Take your arms out to the sides, and bring them to your front. One hand should overlap the other, resembling the letter Х. Return your arms to the original position. Repeat for the desired number of repititions.")
        let punches = Workout(imageName: "punches", name: "Punches", type: ["Arms"], description: "Start with your feet shoulder width apart, and place your dominant foot forward slightly. Bend your knees, and hold your hands up near the top of your chest. Starting with your dominant arm first, punch your arm forward, slightly rotating your shoulder, and twisting at the torso. The target of your punch should be straight in front of you and at shoulder height. As you retract your dominant arm by pulling your elbow back to your side, extend your other arm forward, again rotating at the shoulder and torso. Make sure to keep your abs flexed during the movement.")
        let frontKicks = Workout(imageName: "frontkicks", name: "Front Kicks", type: ["Legs"], description: "Stand with feet hip width apart and arms bent and held in front of you. Lift right leg up, bending knee slightly, and kick right foot forward. Keep ankle flexed and push through your heel. Place the right foot down and switch to the left. Continue to repeat for desired amount of time or number or repetitions.")
        let sitUpPunches = Workout(imageName: "sit-uppunches", name: "Sit-up Punches", type: ["Abs", "Arms"], description: "Start seated on the floor/mat sitting straight up, with heels touching the ground in front of you. Use your abdominal muscles to lower yourself to the floor. Continue your abdominal hold to lift yourself back up. From the top of your sit-up, punch your right arm diagonally across your body to the left, opening your elbow and fully extending your arm as you punch. Your upper body can turn slightly with your punch, but should not fully twist. Come back to center and punch your left arm diagonally to your right, and then return to center. From the center, lower your upper body back to the floor, controlling your downward motion through your core. Repeat for the desired number of repititions.")
        
        let abs = Filter(type: "Abs")
        let arms = Filter(type: "Arms")
        let legs = Filter(type: "Legs")
        let butt = Filter(type: "Butt")
        let cardio = Filter(type: "Cardio")
        
        workouts = [jumpingJacks, sideLegRaises, kneeToElbows, lungePunches, squatSideKick, squatFrontKick, legRaises, squatHold, marchSteps, calfRaises, lunges, shoulderTaps, plankRotations, highCrunches, bridges, hollowHold, crunches, sitUps, sittingTwists, jumpSquats, sideKicks, highKnees, plankHold, raisedArmCircles, pushUps, elbowPlankHold, kneeToElbowCrunches, sideLunge, armScissors, punches, frontKicks, sitUpPunches]
        
        ogWorkouts = [jumpingJacks, sideLegRaises, kneeToElbows, lungePunches, squatSideKick, squatFrontKick, legRaises, squatHold, marchSteps, calfRaises, lunges, shoulderTaps, plankRotations, highCrunches, bridges, hollowHold, crunches, sitUps, sittingTwists, jumpSquats, sideKicks, highKnees, plankHold, raisedArmCircles, pushUps, elbowPlankHold, kneeToElbowCrunches, sideLunge, armScissors, punches, frontKicks, sitUpPunches]
        
        filters = [abs, arms, legs, butt, cardio]
        
        let filterLayout = UICollectionViewFlowLayout()
        filterLayout.scrollDirection = .horizontal
        filterLayout.minimumInteritemSpacing = Fpadding
        
        filterCollection = UICollectionView(frame: .zero, collectionViewLayout: filterLayout)
        filterCollection.translatesAutoresizingMaskIntoConstraints = false
        filterCollection.backgroundColor = UIColor(red: 102/255, green: 185/255, blue: 191/255, alpha: 0.45)
        filterCollection.layer.cornerRadius = 5.0
        filterCollection.clipsToBounds = true
        filterCollection.delegate = self
        filterCollection.dataSource = self
        filterCollection.alwaysBounceHorizontal = true
        filterCollection.register(FilterCollectionViewCell.self,  forCellWithReuseIdentifier: filterReuseIdentifier)
        filterCollection.allowsMultipleSelection = true
        view.addSubview(filterCollection)
        
        let workoutLayout = UICollectionViewFlowLayout()
        workoutLayout.scrollDirection = .vertical
        workoutLayout.minimumLineSpacing = Rpadding*2
        
        workoutCollection = UICollectionView(frame: .zero, collectionViewLayout: workoutLayout)
        workoutCollection.translatesAutoresizingMaskIntoConstraints = false
        workoutCollection.backgroundColor = .white
        workoutCollection.delegate = self
        workoutCollection.dataSource = self
        workoutCollection.register(WorkoutCollectionViewCell.self, forCellWithReuseIdentifier: workoutCellReuseIdentifier)
        view.addSubview(workoutCollection)
        
        // navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Friends", style: .plain, target: self, action: #selector(friends))
        
        toolBar = UIToolbar()
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        toolBar.sizeToFit()
        toolBar.layer.cornerRadius = 5.0
        toolBar.clipsToBounds = true
        toolBar.barTintColor = UIColor(red: 7/255, green: 136/255, blue: 155/255, alpha: 0.35)
        toolBar.tintColor = UIColor(red: 7/255, green: 136/255, blue: 155/255, alpha: 0.35)
        toolBar.layer.borderWidth = 3
        toolBar.layer.borderColor = UIColor(red: 7/255, green: 136/255, blue: 155/255, alpha: 0.70).cgColor
        
//        shadowLayer = UIView(frame: toolBar.frame)
//        shadowLayer.layer.shadowPath = UIBezierPath(roundedRect: toolBar.frame, cornerRadius: 5).cgPath
//        shadowLayer.backgroundColor = UIColor.clear
//
//        shadowLayer.layer.shadowColor = UIColor.black.cgColor
//        shadowLayer.layer.shadowOffset = CGSize(width: 1, height: 1)
//        shadowLayer.layer.shadowOpacity = 0.25
//        shadowLayer.layer.shadowRadius = 2
//        shadowLayer.clipsToBounds = false
//
//        toolBar.superview?.addSubview(shadowLayer)
//        toolBar.superview?.bringSubviewToFront(toolBar)
        
        friendsButton = UIBarButtonItem(title: "Friends", style: .plain, target: self, action: #selector(friends))
        friendsButton.tintColor = .white
        
        var items = [UIBarButtonItem]()
        items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
        items.append(friendsButton)
        items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))

        toolBar.items = items
        view.addSubview(toolBar)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            toolBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            toolBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            toolBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            toolBar.heightAnchor.constraint(equalToConstant: 40)
            ])
        
        NSLayoutConstraint.activate([
            filterCollection.topAnchor.constraint(equalTo: toolBar.bottomAnchor, constant: 10),
            filterCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            filterCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            filterCollection.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        NSLayoutConstraint.activate([
            workoutCollection.topAnchor.constraint(equalTo: filterCollection.bottomAnchor, constant: 15),
            workoutCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Rpadding),
            workoutCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            workoutCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Rpadding)
            ])
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.workoutCollection {
            return workouts.count
        }
        else {
            return filters.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.workoutCollection {
            let cellA = workoutCollection.dequeueReusableCell(withReuseIdentifier: workoutCellReuseIdentifier, for: indexPath) as! WorkoutCollectionViewCell
            let workout = workouts[indexPath.item]
            cellA.configure(with: workout)
            cellA.setNeedsUpdateConstraints()
            return cellA
        }
        if collectionView == self.filterCollection {
            let cellB = filterCollection.dequeueReusableCell(withReuseIdentifier: filterReuseIdentifier, for: indexPath) as! FilterCollectionViewCell
            let filter = filters[indexPath.item]
            cellB.configure(with: filter)
            cellB.setNeedsUpdateConstraints()
            return cellB
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.workoutCollection {
            let width1 = (collectionView.frame.width - Rpadding * 2.0) / 2.0
            return CGSize(width: width1, height: width1)
        }
        if collectionView == self.filterCollection {
            let width2 = (collectionView.frame.width - Fpadding * 10.0) / 4.0
            return CGSize(width: width2, height: 30)
        }
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.workoutCollection {
            let workout = workouts[indexPath.item]
            let workoutViewController = WorkoutViewController()
            viewWorkoutDelegate = workoutViewController
            workoutViewController.workoutZoomDelegate = self
            let img = workout.imageName
            let name = workout.name
            let type = workout.type
            let description = workout.description
            viewWorkoutDelegate?.workoutInfo(imageName: img!, name: name!, type: type!, description: description!, index: indexPath.item)
            present(workoutViewController, animated: true, completion: nil)
        }
        else {
            let cellB = filterCollection.dequeueReusableCell(withReuseIdentifier: filterReuseIdentifier, for: indexPath)
            cellB.isSelected = !cellB.isSelected
            self.filtering()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == self.workoutCollection {}
        else {
            let cellB = filterCollection.dequeueReusableCell(withReuseIdentifier: filterReuseIdentifier, for: indexPath)
            cellB.isSelected = !cellB.isSelected
            self.filtering()
        }
    }
    
    func filtering() {
        workouts = ogWorkouts
        var filteredWorkouts: [Workout]! = []
        for cell in self.filterCollection!.visibleCells as! [FilterCollectionViewCell] {
            if cell.isSelected {
                let type = cell.filter.text!
                for w in workouts {
                    let tf = filteredWorkouts.contains(where: { $0.name == w.name })
                    for t in w.type {
                        if t == type && !tf {
                            filteredWorkouts.append(w)
                        }
                    }
                }
            }
        }
        if filteredWorkouts.count != 0 {
            workouts = filteredWorkouts
        }
        if filteredWorkouts.count == 0 {
            workouts = ogWorkouts
        }
        workoutCollection.reloadData()
    }
    
    @objc func friends() {
        let socialViewController = SocialViewController()
        navigationController?.pushViewController(socialViewController, animated: true)
    }
    
    @objc func home() {
        
    }

}

extension ViewController: WorkoutZoomDelegate {
    func seeWorkout(imageName: String, name: String, type: [String], description: String, index: Int) {
        let w = workouts[index]
        w.imageName =  imageName
        w.name = name
        w.type = type
        w.description = description
        workoutCollection.reloadData()
    }
}
