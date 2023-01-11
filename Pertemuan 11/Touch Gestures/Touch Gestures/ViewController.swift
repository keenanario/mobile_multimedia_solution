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
        // Do any additional setup after loading the view.
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
    
    private func updateLabelsFromTouches(_ touch: UITouch?, allTouches: Set<UITouch>? ){
        let numTaps = touch?.tapCount ?? 0
        let tapsMessage = "\(numTaps) taps detected"
        txtTapCounter.text = tapsMessage
                
        let numTouches = allTouches?.count ?? 0
        let touchMsg = "\(numTouches) touches detected"
        txtTouchCounter.text = touchMsg
                
        if traitCollection.forceTouchCapability == .available {
            txtForceLabel.text = "Force: \(touch?.force ?? 0)\n Max force: \(touch?.maximumPossibleForce ?? 0)"
            } else {
                txtForceLabel.text = "3D Touch not available"
            }
    }
}



