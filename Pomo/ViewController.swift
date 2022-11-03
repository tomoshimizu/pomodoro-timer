//
//  ViewController.swift
//  Pomo
//
//  Created by Tomo Shimizu on 2022/11/02.
//

import UIKit
import UICircularProgressRing

class ViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    
    let pomodoroTime = 10
    let timerRingSize: CGFloat = 250
    
    let timerRing = UICircularTimerRing()
    var flag = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // リングの位置・サイズ
        let screenWidth = UIScreen.main.bounds.width
        let x = (screenWidth / 2) - (timerRingSize / 2)
        timerRing.frame = CGRect(x: x, y: 100, width: timerRingSize, height: timerRingSize)
        
        // リングのスタイル
        timerRing.style = .ontop
        
        // リングの太さ
        timerRing.outerRingWidth = 10.0
        timerRing.innerRingWidth = 10.0
        
        // リングの色
        timerRing.outerRingColor = UIColor(hex: "DFDFDF")
        timerRing.innerRingColor = UIColor(hex: "DF4749")
        
        self.view.addSubview(timerRing)
    }
    
    @IBAction func startTimer(_ sender: Any) {
        
        switch flag {
            
        case 0:
            
            self.startButton.setImage(UIImage(named: "stop"), for: .normal)
            self.flag = 1
            
            // ここに秒数を入れる
            timerRing.startTimer(to: TimeInterval(pomodoroTime)) { state in
                
                switch state {
                case .finished:
                    self.timerRing.resetTimer()
                    self.startButton.setImage(UIImage(named: "start"), for: .normal)
                    self.flag = 0
                case .continued:
                    self.startButton.setImage(UIImage(named: "stop"), for: .normal)
                    self.flag = 1
                case .paused:
                    self.startButton.setImage(UIImage(named: "start"), for: .normal)
                    self.flag = 2
                }
            }
            break
            
        case 1:
            timerRing.pauseTimer()
            break
            
        case 2:
            timerRing.continueTimer()
            break
            
        default:
            break
        }
    }
}
