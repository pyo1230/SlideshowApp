//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 高橋 陽介 on 2017/04/26.
//  Copyright © 2017年 Yosuke.Takahashi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nextImage: UIButton!
    @IBOutlet weak var backImage: UIButton!
    @IBOutlet weak var button: UIButton!
    
    let imageNameArray = ["spring1", "spring2", "spring3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let image = UIImage(named:"spring1")
        imageView.image = image
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextImage(_ sender: Any) {
        dispImageNo += 1
        displayImage()
    }
    
    @IBAction func backImage(_ sender: Any) {
        dispImageNo -= 1
        displayImage()
    }
    
    var timer: Timer?
    var dispImageNo = 0
    
    func displayImage() {
        if dispImageNo < 0 {
            dispImageNo = 2
        }
        if dispImageNo > 2 {
            dispImageNo = 0
        }
        let name = imageNameArray[dispImageNo]
        let image = UIImage(named: name)
        imageView.image = image
    }
    
    func onUpdate() {
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(ViewController.onTimer(timer:)), userInfo: nil, repeats: true)
    }
    
    @IBAction func startStop(_ sender: Any) {
        if timer == nil {
            onUpdate()
            button.setTitle("停止", for: .normal)
            nextImage.isEnabled = false
            backImage.isEnabled = false
        } else {
            timer?.invalidate()
            timer = nil
            button.setTitle("再生", for: .normal)
            nextImage.isEnabled = true
            backImage.isEnabled = true
        }
    }
    
    func onTimer(timer: Timer) {
        dispImageNo += 1
        displayImage()
    }
    
    @IBAction func onTapImage(_ sender: Any) {
        performSegue(withIdentifier: "result", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "result" {
            let nextVC: ScaleViewController = segue.destination as! ScaleViewController
            nextVC.pic = imageNameArray[dispImageNo]
        }
    }
    @IBAction func unwind(segue: UIStoryboardSegue) {
    }
}









