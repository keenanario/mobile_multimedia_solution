//
//  ViewController.swift
//  Touch Gestures
//
//  Created by Ario on 09/01/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var txtStatus: UILabel!
    @IBOutlet var txtTouchCounter: UILabel!
    @IBOutlet var txtTapCounter: UILabel!
    @IBOutlet var txtForceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(singleTap))
        singleTap.numberOfTapsRequired = 1
        singleTap.numberOfTouchesRequired = 1
        view.addGestureRecognizer(singleTap)
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTap))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.numberOfTouchesRequired = 1
        view.addGestureRecognizer(doubleTap)
        
//        let vertical = UISwipeGestureRecognizer(target: self, action: #selector(reportVerticalSwipe(_:)))
//        vertical.direction = [.up, .down]
//        view.addGestureRecognizer(vertical)
        
//        let horizontal = UISwipeGestureRecognizer(target: self, action: #selector(reportHorizontalSwipe(_:)))
//        horizontal.direction = [.left, .right]
//        view.addGestureRecognizer(horizontal)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        txtStatus.text = "Touch Began"
        updateLabelsFromTouches(touches.first, allTouches:event?.allTouches)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        txtStatus.text = "Touch Ended"
        updateLabelsFromTouches(touches.first, allTouches:event?.allTouches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        txtStatus.text = "Drag Detected"
        updateLabelsFromTouches(touches.first, allTouches:event?.allTouches)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        txtStatus.text = "Touch Cancelled"
        updateLabelsFromTouches(touches.first, allTouches:event?.allTouches)
    }
    
    @objc func singleTap(){
        let tapsMessage = "single tap detected"
        txtTapCounter.text = tapsMessage
    }
    
    @objc func doubleTap(){
        let tapsMessage = "double taps detected"
        txtTapCounter.text = tapsMessage
    }
    
//    @objc func reportVerticalSwipe(_ recognizer:UIGestureRecognizer){
//        txtForceLabel.text = "Vertical Swipe Detected"
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(2*NSEC_PER_SEC)) / Double(NSEC_PER_SEC), execute: {
//            self.txtForceLabel.text = ""
//        })
//    }
    
//    @objc func reportHorizontalSwipe(_ recognizer:UIGestureRecognizer){
//        txtForceLabel.text = "Horizontal Swipe Detected"
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(2*NSEC_PER_SEC)) / Double(NSEC_PER_SEC), execute: {
//            self.txtForceLabel.text = ""
//        })
//    }
    
    private func updateLabelsFromTouches(_ touch: UITouch?, allTouches: Set<UITouch>? ){
//        let numTaps = touch?.tapCount ?? 0
//        let tapsMessage = "\(numTaps) taps detected"
//        txtTapCounter.text = tapsMessage
                
        let numTouches = allTouches?.count ?? 0
        let touchMsg = "\(numTouches) touches detected"
        txtTouchCounter.text = touchMsg
                
//        if traitCollection.forceTouchCapability == .available {
//            txtForceLabel.text = "Force: \(touch?.force ?? 0)\n Max force: \(touch?.maximumPossibleForce ?? 0)"
//        } else {
//            txtForceLabel.text = "3D Touch not available"
//        }
    }
}



