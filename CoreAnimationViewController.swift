//
//  CoreAnimationViewController.swift
//  ContinueTraining
//
//  Created by Apple User on 31/03/22.
//

import UIKit

    class CoreAnimationViewController: UIViewController{
        var myView: UIView!
        var myNewVeiw: UIView!
        var secondsRemaining = 4
        var beginPosition: CGPoint!
     
        
        override func viewDidLoad() {
            super.viewDidLoad()
            let frame = CGRect(origin: CGPoint(x: 0, y: 100), size: CGSize(width: 100, height: 100))
//            let frame1 = CGRect(origin: CGPoint(x: -100, y: view.bounds.size.height/2), size: CGSize(width: 100, height: 100))
//            myNewVeiw = UIView(frame: frame1)
//            myNewVeiw.backgroundColor = .red
//            view.addSubview(myNewVeiw)
            myView = UIView(frame: frame)
            myView.backgroundColor = .red
            view.addSubview(myView)
           
//            let jump = CASpringAnimation(keyPath: "transform.scale")
//                   jump.damping = 10
//                   jump.mass = 1
//                   jump.initialVelocity = 100
//                   jump.stiffness = 1000
//
//                   jump.fromValue = 1.0
//                   jump.toValue = 2.0
//                   jump.duration = jump.settlingDuration
//            myView.layer.add(jump, forKey: nil)
              
           
        }
      
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            taskAnimation()
            clock()
            
      

//            let animation = CABasicAnimation(keyPath: "position.x")
//            animation.fromValue = CGPoint.init(x:-20, y:view.bounds.size.height/2)
//            animation.toValue = view.bounds.size.width + 50
//            animation.duration = 4
//            animation.beginTime = CACurrentMediaTime() + 0.3
//            animation.repeatCount = .infinity
//            animation.autoreverses = false
//            myView.layer.position = CGPoint.init(x:-20, y:view.bounds.size.height/2)
//
//            myView.layer.add(animation, forKey: nil)
//
//            let animationNew = CABasicAnimation(keyPath: "position.x")
//            animationNew.fromValue = CGPoint.init(x:-70, y:view.bounds.size.height/2)
//            animationNew.toValue = view.bounds.size.width + 20
//            animationNew.duration = 4
//            animationNew.beginTime = animation.beginTime + 3.7
//            animationNew.repeatCount = .infinity
//
//            animationNew.autoreverses = false
//            myNewVeiw.layer.position = CGPoint.init(x:-20, y:view.bounds.size.height/2)
//            myNewVeiw.layer.add(animationNew, forKey: nil)

            
       }
        func clock(){
            
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
          if self.secondsRemaining > 0 {
              print ("\(self.secondsRemaining) seconds")
              self.secondsRemaining -= 1
            } else {
                self.secondsRemaining = 4
                self.taskAnimation()
                self.myView.center = self.beginPosition
                print(self.myView.center)
            }
        }
        }
        
        func taskAnimation(){
        UIView.animateKeyframes(withDuration: 5,
          delay: 0,
                                options: [.calculationModeLinear, .repeat],
          animations: {
            UIView.addKeyframe(
                withRelativeStartTime: 0,
                relativeDuration: 0.20) {
                    self.myView.center = self.randomCoordinates()
            }
            UIView.addKeyframe(withRelativeStartTime: 0.20, relativeDuration: 0.20) {
                self.myView.center = self.randomCoordinates()                }

            UIView.addKeyframe(withRelativeStartTime: 0.40, relativeDuration: 0.20) {
                self.myView.center = self.randomCoordinates()
            }
            UIView.addKeyframe(withRelativeStartTime: 0.60, relativeDuration: 0.20) {
                self.myView.center = self.randomCoordinates()
            }
            UIView.addKeyframe(withRelativeStartTime: 0.80, relativeDuration: 0.20) {
                self.myView.center = self.randomCoordinates()
                self.beginPosition = self.myView.center
                //print(self.beginPosition)
            }
            UIView.addKeyframe(withRelativeStartTime: 1, relativeDuration: 0) {
                self.myView.center = self.beginPosition
                self.myView.layer.speed = 1
                //print(self.beginPosition)
                
            }
        })

        }
     
        func randomCoordinates()-> CGPoint{
            let maxXValue = view.frame.width
            let maxYValue = view.frame.height
            
            var rand_x = CGFloat(arc4random_uniform(UInt32(maxXValue)))
            var rand_y = CGFloat(arc4random_uniform(UInt32(maxYValue)))
            let position = CGPoint(x: rand_x, y: rand_y)
           print(position)
            return position
        }
        
    }


