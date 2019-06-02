//
//  GameScene.swift
//  iosGame
//
//  Created by Chris Lee on 01/06/2019.
//  Copyright © 2019 ChrisLee0727. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var player = SKSpriteNode(imageNamed: "Player")
    var lock = SKSpriteNode(imageNamed: "Lock")
    var dot = SKSpriteNode(imageNamed: "Dot")
    var myLabel = SKLabelNode()
    var path = UIBezierPath()
    
    var gameStarted = Bool()
    var movingClockWise = Bool()
    
    var intersected = false
    
    var LevelLabel = UILabel()
    
    var currentLevel = Int()
    var currentScore = Int()
    var highLevel = Int()
    
//    var View1 = UIView()
    
    override func didMove(to view: SKView) {
        loadView()
        
        let defaults = UserDefaults.standard
        
        if  defaults.integer(forKey: "HighLevel") != 0{
            
            highLevel = UserDefaults.standard.value(forKey: "HighLevel") as! Int
            currentLevel = highLevel
            currentScore = currentLevel
            LevelLabel.text = "\(currentScore)"
        }
        else{
            
            UserDefaults.standard.set(1, forKey: "HighLevel")
        }
//        View1 = UIView(frame: CGRect(origin: CGPoint(x: 120, y: self.frame.height / 0), size: CGSize(width: self.frame.width, height: self.frame.height)))

        
    }
    
    func loadView() {
        movingClockWise = true
        backgroundColor = SKColor.white
        
        lock.size = CGSize(width: 300, height: 300)
        lock.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        lock.zPosition = 0
        self.addChild(lock)
        
        player.size = CGSize(width: 40, height: 7)
        player.position = CGPoint(x: 0, y: 120)
        player.zPosition = 2.0
        player.zRotation = 3.14 / 2
        self.addChild(player)
        addDot()
        
//        LevelLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 100))
//        LevelLabel.center = (self.view?.center)!
//        LevelLabel.text = "\(currentScore)"
//        LevelLabel.textColor = SKColor.darkGray
//        LevelLabel.textAlignment = NSTextAlignment.center
//        LevelLabel.font = UIFont.systemFont(ofSize: 60)
//        self.View1.addSubview(LevelLabel)
        
        
        myLabel.text = "\(currentScore)"
        myLabel.color = SKColor.darkGray
        myLabel.fontSize = 60
        myLabel.position = CGPoint(x: 0, y: 0)
        self.addChild(myLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameStarted == false {
            moveClockWise()
            movingClockWise = true
            gameStarted = true
        } else {
            if movingClockWise == true {
                moveCounterClockWise()
                movingClockWise = false
            }
            else {
                moveClockWise()
                movingClockWise = true
            }
            DotTouched()
        }
    }
    
    func moveClockWise() {
        let dx = player.position.x
        let dy = player.position.y
        
        let rad = atan2(dy, dx)
        
        path = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: 120, startAngle: rad, endAngle: rad + CGFloat(Double.pi * 4), clockwise: true)
        let follow = SKAction.follow(path.cgPath, asOffset: false, orientToPath: true, speed: 200)
        player.run(SKAction.repeatForever(follow).reversed())
    }
    
    func moveCounterClockWise() {
        let dx = player.position.x
        let dy = player.position.y 
        
        let rad = atan2(dy, dx)
        
        path = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: 120, startAngle: rad, endAngle: rad + CGFloat(Double.pi * 4), clockwise: true)
        let follow = SKAction.follow(path.cgPath, asOffset: false, orientToPath: true, speed: 200)
        player.run(SKAction.repeatForever(follow))
    }
    
    func addDot() {
        dot.size = CGSize(width: 30, height: 30)
        dot.zPosition = 1.0
        
        let dx = player.position.x - self.frame.width / 2
        let dy = player.position.y - self.frame.height / 2
        
        let rad = atan2(dy, dx)
        
        if movingClockWise == true{
            let tempAngle = CGFloat.random(in: rad - 2.5 ... rad - 1.0)
            let Path2 = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: 120, startAngle: tempAngle, endAngle: tempAngle + CGFloat(Double.pi * 4), clockwise: true)
            dot.position = Path2.currentPoint
            
        }
        else if movingClockWise == false{
            let tempAngle = CGFloat.random(in: rad + 1.0 ... rad + 2.5)
            let Path2 = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: 120, startAngle: tempAngle, endAngle: tempAngle + CGFloat(Float.pi * 4), clockwise: true)
            dot.position = Path2.currentPoint
            
            
        }
        self.addChild(dot)
        
    }
    
    func DotTouched() {
        if intersected == true{
            dot.removeFromParent()
            addDot()
            intersected = false
            
            currentScore -= 1
            LevelLabel.text = "\(currentScore)"
            if currentScore <= 0{
                nextLevel()
                
            }
            
        }
        else if intersected == false{
            
            died()
        }
        
    }
    
    func nextLevel() {
        currentLevel += 1
        currentScore = currentLevel
        LevelLabel.text  = "\(currentScore)"
        won()
        if currentLevel > highLevel{
            highLevel = currentLevel
            let Defaults = UserDefaults.standard
            Defaults.set(highLevel, forKey: "HighLevel")
        }
        
        
    }

    
    func died(){
        self.removeAllChildren()
        let action1 = SKAction.colorize(with: UIColor.red, colorBlendFactor: 1.0, duration: 0.2)
        let action2 = SKAction.colorize(with: UIColor.white, colorBlendFactor: 1.0, duration: 0.2)
        self.scene?.run(SKAction.sequence([action1,action2]))
        intersected = false
        gameStarted = false
        LevelLabel.removeFromSuperview()
        currentScore = currentLevel
        self.loadView()
        
        
    }
    func won() {
        self.removeAllChildren()
        let action1 = SKAction.colorize(with: UIColor.green, colorBlendFactor: 1.0, duration: 0.2)
        let action2 = SKAction.colorize(with: UIColor.white, colorBlendFactor: 1.0, duration: 0.2)
        self.scene?.run(SKAction.sequence([action1,action2]))
        intersected = false
        gameStarted = false
        LevelLabel.removeFromSuperview()
        self.loadView()
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        if player.intersects(dot){
            intersected = true
        }
        else{
            if intersected == true{
                if player.intersects(dot) == false{
                    died()
                }
            }
        }
        
    }
}
