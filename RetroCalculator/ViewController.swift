//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Abdullah A Mamun on 1/27/16.
//  Copyright © 2016 Abdullah A Mamun. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    enum Operation:String
    {
        case Add = "+"
        case Subtract = "-"
        case Multiply = "*"
        case Divide = "/"
        
        case Empty = ""
    }
    @IBOutlet weak var outputLbl:UILabel!
    var butSound:AVAudioPlayer!
    var currentNum = ""
    var leftval = ""
    var rightVal = ""
    var currentOperation:Operation = Operation.Empty
    var result = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        do
        {
          try  butSound = AVAudioPlayer(contentsOfURL: soundUrl)
            butSound.prepareToPlay()
            butSound.volume = 0.01
        }catch let err as NSError
        {
           print(err.debugDescription)
        }
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func numberPressed(but:UIButton!)
    {
        
        playSound()
        currentNum += "\(but.tag)"
        outputLbl.text = currentNum
    }

    @IBAction func divide(sender: AnyObject)
    {
        playSound()
        processedOperation(Operation.Divide)
        
    }


    @IBAction func multiply(sender: AnyObject)
    {
        playSound()
        processedOperation(Operation.Multiply)
        
    }

    @IBAction func subtract(sender: AnyObject)
    {
        playSound()
        processedOperation(Operation.Subtract)
    }


    @IBAction func addition(sender: AnyObject)
    {
        playSound()
        processedOperation(Operation.Add)
    }

    @IBAction func equal(sender: AnyObject)
    {
        playSound()
        processedOperation(currentOperation)
    }

    func processedOperation(op:Operation)
    {
        if currentOperation != Operation.Empty
        {
          rightVal = currentNum
            currentNum = ""
            if currentOperation == Operation.Add
            {
              result = "\(Int(leftval)!  + Int(rightVal)!)"
                
            }
            else if currentOperation == Operation.Subtract
            {
                 result = "\(Int(leftval)! - Int(rightVal)!)"
               
            }
            else if currentOperation == Operation.Multiply
            {
                result = "\(Int(leftval)! * Int(rightVal)!)"
               
            }
            else if currentOperation == Operation.Divide
            {
                result = "\(Int(leftval)! / Int(rightVal)!)"
                
            }
             leftval = result
             outputLbl.text = result

        }
        else
        {
          leftval = currentNum
          currentNum = ""
          currentOperation = op
        }
    }
    func playSound()
    {
        if butSound.playing
        {
          butSound.stop()
        }
        butSound.play()
    }
}

