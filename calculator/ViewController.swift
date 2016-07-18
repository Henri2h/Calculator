//
//  ViewController.swift
//  calculator
//
//  Created by Emagination Camper on 7/12/16.
//  Copyright © 2016 Emagination Camper. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController{
    var total:Double = 0
    var display: String = ""
    var previousChange = false
    var operatorUsed:String = ""
    var totalLive : Double = 0
    @IBOutlet weak var tbDisplay: UILabel!
    @IBOutlet weak var tbOut: UILabel!
    
    @IBOutlet weak var tbResult: UILabel!
    
    var left = ""
    var oldValue = false
    
    
    @IBAction func btClear(sender: AnyObject) {
        
        display = "0"
        
        total = 0
        totalLive = 0
        
        left = ""
        
        tbOut.text = display
        
        previousChange = false
        operatorUsed = ""
        define()
    }
    var audioPlayer = AVAudioPlayer()
    
    // ===== don't know the name .... ====
    @IBAction func btEqual(sender: AnyObject) {
        
        result()
        
        previousChange = false
        operatorUsed = ""
        
        if(total == 10.0)
        {
            
            
            let audioFilePath = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")
            
            if audioFilePath != nil {
                
                let audioFileUrl = NSURL.fileURLWithPath(audioFilePath!)
                
                do {
                    audioPlayer = try AVAudioPlayer(contentsOfURL: audioFileUrl)
                    
                    audioPlayer.prepareToPlay()
                    audioPlayer.play()
                    
                    
                   display = "playing ..."

                }
                catch{
                    display = "error"
                }
                
              
            } else {
             display = "error playing music"
            }

        }
        
        defineEqual()
        oldValue = true
        
        total = 0
        totalLive = 0
        
       
    }
    
    @IBAction func substract(sender: AnyObject) {
        Add("-")
    }
    @IBAction func add(sender: AnyObject) {
        Add("+")
    }
    @IBAction func divide(sender: AnyObject) {
        Add("/")
    }
    @IBAction func multiply(sender: AnyObject) {
        Add("x")
    }
    
    
    
    // ========= key ========
    @IBAction func bt0(sender: AnyObject) {
        addInt(0)
    }
    @IBAction func bt1(sender: AnyObject) {
        addInt(1)
    }
    @IBAction func bt2(sender: AnyObject) {
        addInt(2)
    }
    @IBAction func bt3(sender: AnyObject) {
        addInt(3)
    }
    @IBAction func bt4(sender: AnyObject) {
        addInt(4)
    }
    @IBAction func bt5(sender: AnyObject) {
        addInt(5)
    }
    @IBAction func bt6(sender: AnyObject) {
        addInt(6)
    }
    @IBAction func bt7(sender: AnyObject) {
        addInt(7)
    }
    @IBAction func bt8(sender: AnyObject) {
        addInt(8)
    }
    @IBAction func bt9(sender: AnyObject) {
        addInt(9)
    }
    @IBAction func btComma(sender: AnyObject) {
        addString(".")
    }
    
    @IBAction func btRemove(sender: AnyObject) {
        if (oldValue) {
         left = ""
        }else {
        
            if(left != ""){
            left.removeAtIndex(left.endIndex.predecessor())
        }
        else{
                previousChange = false
                operatorUsed = ""
        }
        }
        
        define()
        
    }
    
   
    func result (){
        
        if(previousChange == true){
            if(operatorUsed == "-"){
                total = total - (double_t)(left)!
            }
            else if(operatorUsed == "+"){
                total = total + (double_t)(left)!
            }
            else if(operatorUsed == "/"){
                total = total / (double_t)(left)!
            }
            else if(operatorUsed == "*"){
                total = total * (double_t)(left)!
            }
        }
        else
        {
            total = (Double)(left)!
        }
        
        oldValue = true
        previousChange = true
        
        totalLive = total
        define()
    }
    // calculate the sum of the left and right number of the operator
   
    
    // add a number to the display and process it
    func addInt( give: integer_t){
        
        if(left == "0" || oldValue){
        left = (String)(give)
            oldValue = false
        }else{
            left += (String)(give)
    }
    
            totalLive = calculate(Number: total, Number: (Double)(left)!)
        define()
    }
    
    func Add(input : String){
        if (operatorUsed == "x"){
            operatorUsed="*"
        }
        
        
        result()
        
        operatorUsed = input
        previousChange = true
        
        define()
    }
    
    func addString(give : String){
        if(left == "0" || oldValue){
            left = "0" + give
            oldValue = false
        } else {
        
        left += give
    }
        define()
    }
    
    
    
    func calculate(Number calculateLeft : Double, Number calculateRight : Double)-> double_t {
        
        var calculateResult:double_t = 0
        
        if(operatorUsed == "-"){
            calculateResult = calculateLeft - calculateRight
        }
        else if(operatorUsed == "+"){
           calculateResult = calculateLeft + calculateRight
        }
        else if(operatorUsed == "/"){
            calculateResult = calculateLeft / calculateRight
        }
        else if(operatorUsed == "*"){
            calculateResult = calculateLeft * calculateRight
        }
        
    return calculateResult
    }
    
    // operator
    @IBOutlet weak var btModulo: UIButton!
    @IBOutlet weak var btMinus: UIButton!
    @IBOutlet weak var btAdd: UIButton!
    @IBOutlet weak var btDivide: UIButton!
    @IBOutlet weak var btMultiply: UIButton!
    
    //number
    @IBOutlet weak var btZero: UIButton!
    @IBOutlet weak var btOne: UIButton!
    @IBOutlet weak var btTwo: UIButton!
    @IBOutlet weak var btThree: UIButton!
    @IBOutlet weak var btFour: UIButton!
    @IBOutlet weak var btFive: UIButton!
    @IBOutlet weak var btSix: UIButton!
    @IBOutlet weak var btSeven: UIButton!
    @IBOutlet weak var btEight: UIButton!
    @IBOutlet weak var btNine: UIButton!
    var color = true
    func changeNumbColor(){
        var clr:UIColor
        var operatorColor:UIColor
        
        
        
        if(color){
        color = false
            clr = UIColor.redColor()
            operatorColor = UIColor.greenColor()
        }
        else{
            color = true
            clr = UIColor.greenColor()
            operatorColor = UIColor.orangeColor()
        }
        
        
        btZero.backgroundColor = clr
        btOne.backgroundColor = clr
        btTwo.backgroundColor = clr
        btThree.backgroundColor = clr
        btFour.backgroundColor = clr
        btFive.backgroundColor = clr
        btSix.backgroundColor = clr
        btSeven.backgroundColor = clr
        btEight.backgroundColor = clr
        btNine.backgroundColor = clr
        
        btModulo.backgroundColor = operatorColor
        btMinus.backgroundColor = operatorColor
        btAdd.backgroundColor = operatorColor
        btDivide.backgroundColor = operatorColor
        btMultiply.backgroundColor = operatorColor
    }
    
    // ================= UI =====================
    
    
    func define(){
        changeNumbColor()
        tbDisplay.text = operatorUsed
        tbOut.text = left
        
        tbResult.text = (String)(totalLive)
    }
    
    
    func defineEqual(){
        
        tbDisplay.text = ""
        tbOut.text = (String)(total)
        
        tbResult.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

