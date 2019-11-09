//
//  ViewController.swift
//  MemoFrame
//
//  Created by Satoshi Kuhara on 2019/06/05.
//  Copyright © 2019年 Satoshi Kuhara. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {
    @IBAction func stopButton(_ sender: Any) {
        if self.stopped{ //止まっている時、動かしたい
            self.colorstop = false
            self.stopped = false
            (sender as AnyObject).setTitle("●", for: .normal)
        }
        else{ //動いている時、止めたい
            self.stopped = true
            (sender as AnyObject).setTitle("■", for: .normal)
        }
    }
    var stopped = false
    
    @IBAction func isGreen(_ sender: Any) {
        self.colorstop = true
        view.backgroundColor = UIColor(hex:"58be89")
        self.labelView.textColor = UIColor(hex:"ffffff")
    }
    
    @IBAction func isBlue(_ sender: Any) {
        self.colorstop = true
        view.backgroundColor = UIColor(hex:"40aaef")
        self.labelView.textColor = UIColor(hex:"ffffff")
    }
    
    @IBAction func isYellow(_ sender: Any) {
        self.colorstop = true
        view.backgroundColor = UIColor(hex:"fff26b")
        self.labelView.textColor = UIColor(hex:"333333")
    }
    
    @IBAction func isPink(_ sender: Any) {
        self.colorstop = true
        view.backgroundColor = UIColor(hex:"f28eb1")
        self.labelView.textColor = UIColor(hex:"ffffff")
    }
    
    @IBAction func isRed(_ sender: Any) {
        self.colorstop = true
        view.backgroundColor = UIColor(hex:"f254541")
        self.labelView.textColor = UIColor(hex:"ffffff")
    }
    
    @IBOutlet weak var labelView: UILabel!
    var txt = "Now Loading..."
    var color = 0;
    var colorstop = false;
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hex:"58be89")
        self.labelView.textColor = UIColor(hex:"ffffff")
        timer = Timer.scheduledTimer(
            timeInterval: 2,
            target: self,
            selector: #selector(self.startTimer),
            userInfo: nil,
            repeats: true
        )
    }
    
    /// 0.5秒ごとに呼び出される
    @objc func startTimer() {
        if !self.stopped{
            var status = 200
            let url = URL(string: "API_URL")
            
            let request = URLRequest(url: url!)
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                if error == nil, let data = data, let response = response as? HTTPURLResponse {
                    status = response.statusCode
                    let received = String(data: data, encoding: String.Encoding.utf8)!
                    if let dataFromString = received.data(using: .utf8, allowLossyConversion: false) {
                        let json = try?JSON(data: dataFromString)
                        self.txt = json!["message"].stringValue
                        if self.color != json!["color"].intValue{
                            self.colorstop = false
                        }
                        self.color = json!["color"].intValue
                    }
                }
                }.resume()
            if status == 200 {
                if self.labelView.text != self.txt{
                    self.colorstop = false
                }
                self.labelView.text = self.txt
                if self.colorstop == false { //常に色を変え続ける場合
                    if self.color==1{
                        self.view.backgroundColor = UIColor(hex:"40aaef")
                        self.labelView.textColor = UIColor(hex:"ffffff")
                    }
                    else if self.color==2{
                        view.backgroundColor = UIColor(hex:"fff26b")
                        self.labelView.textColor = UIColor(hex:"333333")
                    }
                    else if self.color==3{
                        view.backgroundColor = UIColor(hex:"f28eb1")
                        self.labelView.textColor = UIColor(hex:"ffffff")
                    }
                    else if self.color==4{
                        view.backgroundColor = UIColor(hex:"f254541")
                        self.labelView.textColor = UIColor(hex:"ffffff")
                    }
                    else{
                        self.view.backgroundColor = UIColor(hex:"58be89")
                        self.labelView.textColor = UIColor(hex:"ffffff")
                    }
                }
            }
        }
    }
}
