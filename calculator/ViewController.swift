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
    
    @IBOutlet weak var tbMusic: UILabel!
    
    var left = ""
    var oldValue = false
    
    // timer for the disco
    var timer = NSTimer()
    
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
   
    
    // ===== don't know the name .... ====
    @IBAction func btEqual(sender: AnyObject) {
        
        result()
        
        previousChange = false
        operatorUsed = ""
        
        defineEqual()
        oldValue = true
        
        
        
        if(total == 10.0)
        {
       playMusic()

        }
        
        
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
    @IBAction func btNegate(sender: UIButton) {
        if(left != ""){
        left = (String)(-(Double)(left)!)
        }
        define()
        
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
    
    @IBAction func btPi(sender: UIButton) {
        addString((String)(M_PI))
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
            else if(operatorUsed == "x"){
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
        else if(operatorUsed == "x"){
            calculateResult = calculateLeft * calculateRight
        }
        
    return calculateResult
    }
    
    
    // ==================== UI =========================
    
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
    
    //equal
    @IBOutlet weak var btEqual: UIButton!
    
    //special
    @IBOutlet weak var btClear: UIButton!
    @IBOutlet weak var btRemove: UIButton!
    @IBOutlet weak var btNegate: UIButton!
    
    @IBOutlet weak var btComma: UIButton!
    @IBOutlet weak var btPi: UIButton!
    
    
    var pos = 0
    var inputText = ""
    var totalText = 0
    
    var color = false
    var toDisplay = ""
    
    // music
     var audioPlayer = AVAudioPlayer()
    
    func playMusic (){
        
        let selectedMusic = Int(arc4random_uniform(1))
        let music = (String)(selectedMusic)
        let audioFilePath = NSBundle.mainBundle().pathForResource(music, ofType: "mp3")
        var selectedMusicName = ""
        
        switch(selectedMusic){
        case 0: selectedMusicName = "little Ensteins"
        case 1: selectedMusicName = "Game of thrones remix"
        case 2: selectedMusicName  = "Wake me up inside"
        case 3 : selectedMusicName = "Never give you up"
        default: selectedMusicName = "This is a music"
        }
        
        if audioFilePath != nil {
            
            let audioFileUrl = NSURL.fileURLWithPath(audioFilePath!)
            
            do {
                audioPlayer = try AVAudioPlayer(contentsOfURL: audioFileUrl)
                
                audioPlayer.prepareToPlay()
                audioPlayer.play()
                
                
                tbMusic.text = "playing : " + selectedMusicName
                
                startDisco()
                
            }
            catch{
                tbMusic.text = "error"
            }
            
            
        } else {
            tbMusic.text = "error playing music"
        }
        
    }
    func changeNumbColor(){
        if(pos==0){
            let k : [String] = [
                "C# is my god because it is great !",
                "Just do it",
                "Steave Jobs is my god",
                "My memes are better than yours",
                "The little einstiens will destroy you.",
                "Never gonna give you up",
                "JOHN CENA",
                "Pray Tim Cook"
            ]
            let rand = Int(arc4random_uniform(8))
            let inputChar = k.startIndex.advancedBy(rand)
            inputText =  k[inputChar]

        }
        totalText = inputText.characters.count
        
        var clr:UIColor
        var operatorColor:UIColor
        
        var comma:UIColor
        var special:UIColor
        var equal:UIColor
       
        
        if(color){
            
            clr = getRandomColor()
            operatorColor = getRandomColor()
            comma = getRandomColor()
            special = getRandomColor()
            equal = getRandomColor()
            
            if(pos < totalText){
                
                
                    let inputChar = inputText.startIndex.advancedBy(pos)
                    toDisplay += String(inputText[inputChar])
                    
                    pos += 1
                
            }
            else
            {
                if(pos > (totalText + 3)){
                pos = 0
                toDisplay = ""
                }
                else{
                    pos += 1
                }
            }
            
            tbOut.text = toDisplay
            
          
                let playing = try audioPlayer.playing
                
                if(playing == false){
                    stopDisco()
                    tbMusic.text = ""
                    changeNumbColor()
                }
          
        }
        else{
            clr = UIColor.greenColor()
            operatorColor = UIColor.orangeColor()
            comma = UIColor.grayColor()
            special = UIColor.redColor()
            equal = UIColor.yellowColor()
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
        
        btComma.backgroundColor = comma
        btPi.backgroundColor = comma
        
        btEqual.backgroundColor = equal
        
        btClear.backgroundColor = special
        btRemove.backgroundColor = special
        btNegate.backgroundColor = special
    }
    
 func getRandomColor() -> UIColor{
        
    let randomRed:CGFloat = CGFloat(drand48())
    let randomGreen:CGFloat = CGFloat(drand48())
    let randomBlue:CGFloat = CGFloat(drand48())
        
    return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
         }
    
    //start
    func startDisco(){
        color = true
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(changeNumbColor), userInfo: nil, repeats: true)
    }
    //stop
    func stopDisco()
    {
        color = false
        timer.invalidate()
        define()
    }
    
    // ================= textbox =====================
    
    
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
changeNumbColor()
        
    }



}

