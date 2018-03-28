//
//  ViewController.swift
//  retro-calculator
//
//  Created by Aleksei Degtiarev on 02/02/2018.
//  Copyright © 2018 Aleksei Degtiarev. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var btnSound: AVAudioPlayer!
    @IBOutlet weak var outputLbl: UILabel!
    var runningNumber = ""
    var leftValString = ""
    var rightVarString = ""
    var result = ""
    var currentOperation = Operation.Empty
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        outputLbl.text = "0"
        
    }
    
    
    @IBAction func numberPressed (sender: UIButton){
        
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
        
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
        
    }
    
    @IBAction func onDividePressed (sender: AnyObject){
        processOperation(operation: .Divide)
    }
    
    @IBAction func onMultiplyPressed (sender: AnyObject){
        processOperation(operation: .Multiply)
    }
    
    @IBAction func onAdditionPressed (sender: AnyObject){
        processOperation(operation: .Add)
    }
    
    @IBAction func onSubtractionPressed (sender: AnyObject){
        processOperation(operation: .Subtract)
    }
    
    @IBAction func onEqualPressed (sender: AnyObject){
        processOperation(operation: currentOperation)
    }
    
    func processOperation (operation: Operation) {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
        
        
        if currentOperation != Operation.Empty {
            
            // selecting operator, but selecting operator without selecting first entering a number
            if runningNumber != "" {
                rightVarString = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValString)! * Double(rightVarString)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValString)! + Double(rightVarString)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValString)! / Double(rightVarString)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValString)! - Double(rightVarString)!)"
                }
                
                leftValString = result
                outputLbl.text = result
                
            }
            
            currentOperation = operation
        } else {
            // first time operator pressed
            leftValString = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

