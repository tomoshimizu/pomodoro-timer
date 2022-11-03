//
//  ViewController.swift
//  Pomo
//
//  Created by Tomo Shimizu on 2022/11/02.
//

import UIKit
import UICircularProgressRing

/*
 TODO: -
 ・デフォルトは25分タイマー
 ・25分経過したら5分の休憩タイマーに変更（背景色を緑？）
 ・4セット繰り返す
 ・繰り返したら達成ボタンを表示 > 達成ボタン押下で最初の状態にリセット
 */
class ViewController: UIViewController {

    // MARK: - Variables
    
    @IBOutlet weak var setOneView: UIView!
    @IBOutlet weak var setTwoView: UIView!
    @IBOutlet weak var setThreeView: UIView!
    @IBOutlet weak var setFourView: UIView!
    @IBOutlet weak var startButton: UIButton!
    
    let screenWidth = UIScreen.main.bounds.width
    
    let timerRing = UICircularTimerRing()
    var timerRingSize: CGFloat = 0
    var stateNum = 0
    
    var isWorking: Bool = true
    /// 現在何セット目かカウント
    var setCount: Int = 0
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
    }
    
    
    // MARK: - IBAction
    
    @IBAction func startTimer(_ sender: Any) {
        self.startTimer()
    }
    
    
    // MARK: Private Methods
    
    private func setupViews() {
        self.view.backgroundColor = self.isWorking ? UIColor(hex: "F33E3B") : UIColor(hex: "20b2aa")
        self.setupTimer()
        self.setupSetCount()
    }
    
    private func setupTimer() {
        timerRing.removeFromSuperview()
        
        // リングの位置・サイズ
        timerRingSize = screenWidth - (50 * 2)
        let x = (screenWidth / 2) - (timerRingSize / 2)
        timerRing.frame = CGRect(x: x, y: 100, width: timerRingSize, height: timerRingSize)
        
        // リングのスタイル
        timerRing.style = .ontop
        
        // リングの太さ
        timerRing.outerRingWidth = 5
        timerRing.innerRingWidth = 5
        
        // リングの色
        timerRing.outerRingColor = self.isWorking ? UIColor(hex: "E01204") : UIColor(hex: "5f9ea0")
        timerRing.innerRingColor = .white
        
        self.view.addSubview(timerRing)
    }
    
    private func setupSetCount() {
        // 角丸を追加
        setOneView.layer.cornerRadius = 10
        setTwoView.layer.cornerRadius = 10
        setThreeView.layer.cornerRadius = 10
        setFourView.layer.cornerRadius = 10
        
        let themeColor = isWorking ? UIColor(hex: "E01204") : UIColor(hex: "5f9ea0")
        
        switch self.setCount {
        case 1:
            setOneView.backgroundColor = .white
            setTwoView.backgroundColor = themeColor
            setThreeView.backgroundColor = themeColor
            setFourView.backgroundColor = themeColor
            break
        case 2:
            setOneView.backgroundColor = .white
            setTwoView.backgroundColor = .white
            setThreeView.backgroundColor = themeColor
            setFourView.backgroundColor = themeColor
            break
        case 3:
            setOneView.backgroundColor = .white
            setTwoView.backgroundColor = .white
            setThreeView.backgroundColor = .white
            setFourView.backgroundColor = themeColor
            break
        case 4:
            setOneView.backgroundColor = .white
            setTwoView.backgroundColor = .white
            setThreeView.backgroundColor = .white
            setFourView.backgroundColor = .white
            break
        default:
            setOneView.backgroundColor = themeColor
            setTwoView.backgroundColor = themeColor
            setThreeView.backgroundColor = themeColor
            setFourView.backgroundColor = themeColor
            break
        }
    }
    
    private func startTimer() {
        let time: TimeInterval = isWorking ? 10 : 5
        
        switch stateNum {
        case 0:
            self.startButton.setImage(UIImage(named: "stop"), for: .normal)
            self.stateNum = 1
            
            timerRing.startTimer(to: time) { state in
                switch state {
                case .finished:
                    
                    /*
                     TODO: -
                     ・音を鳴らす&ポップアップ（OKを押すと休憩開始）
                     ・休憩タイマーに切り替え
                     */
                    self.timerRing.resetTimer()
                    self.startButton.setImage(UIImage(named: "start"), for: .normal)
                    self.stateNum = 0
                    
                    // 休憩後にセットカウントを更新
                    if !self.isWorking {
                        if self.setCount > 4 {
                            self.setCount = 0
                        } else {
                            self.setCount += 1
                        }
                    }
                    
                    // フラグを更新
                    self.isWorking = !self.isWorking
                    
                    // UIを更新
                    self.setupViews()
                    
                    break
                    
                case .continued:
                    self.startButton.setImage(UIImage(named: "stop"), for: .normal)
                    self.stateNum = 1
                    break
                    
                case .paused:
                    self.startButton.setImage(UIImage(named: "start"), for: .normal)
                    self.stateNum = 2
                    break
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
