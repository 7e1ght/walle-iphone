//
//  ViewController.swift
//  walle
//
//  Created by Владислав Разводовский on 05.06.2023.
//

import UIKit
import CoreBluetooth



class ViewController: UIViewController {
    var btController: WalleBluetoothController!
    @IBOutlet weak var ConnectionState: UITextField!
    
    @IBAction func leftSideDown(_ sender: UIButton) {
        btController.setDirection(dir: .LEFT)
    }
    
    @IBAction func forwardDown(_ sender: UIButton) {
        btController.setDirection(dir: .FORWARD)
    }
    
    @IBAction func backwardDown(_ sender: UIButton) {
        btController.setDirection(dir: .BACKWARD)
    }
    
    
    @IBAction func rightSideDown(_ sender: UIButton) {
        btController.setDirection(dir: .RIGHT)
    }
    
    @IBAction func buttonUP(_ sender: Any)
    {
        btController.setDirection(dir: .IDLE)
    }
    
    
    func setBTConnectEstablished()
    {
        ConnectionState.text = "Connected"
        ConnectionState.backgroundColor = .green
        ConnectionState.textColor = .black
    }
    
    override func viewDidLoad() {
        btController = WalleBluetoothController(view: self)
        
        super.viewDidLoad()
    }
}
