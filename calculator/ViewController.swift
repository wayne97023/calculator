//
//  ViewController.swift
//  calculator
//
//  Created by 林奇杰 on 2020/3/22.
//  Copyright © 2020 林奇杰. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //  第一次、前一次的值
    var number01:Double?
    //  點選運算符號後輸入的值，若未輸入則會以原來的值繼續在計算
    var number02:Double?
    //  運算符號
    var operationSign:String?
    //  結果值
    var result:Double?
    //  是否正在輸入狀態（沒有點選其他功能鍵)
    var typeing:Bool = false
    //  是否有計按下等於鍵
    var equalityPressed:Bool = false
    //  用於判斷正負號按鈕，監聽使用者是否有點選運算符號，那就代表沒有輸入要變負號的值
    var typeOperation = false
    //  紀錄點選的運算符號按鈕
    var currentOperatorBtn:UIButton?
    //  畫面上顯示結果的Label
    @IBOutlet weak var ansLabel: UILabel!
    //  白色
    let white:UIColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
    //  橘色
    let orange:UIColor = UIColor.systemOrange
    
    //  呼叫時若=在左邊代表要get，反之是set
    var input: Double{
        //  將使用者輸入的值傳回
        get{
            return Double(ansLabel.text!)!
        }
        //  顯示話格式於ansLabel顯示
        set{
            ansLabel.text = "\(formatDecimal(num: newValue))"
            typeing = false
        }
    }

    // 計算小數格式化用
    func formatDecimal (num: Double) -> String {
        var formatNum = ""
        if num != 0 {
            if num.truncatingRemainder(dividingBy: 1.0) == 0.0{
                formatNum =  String(format: "%.0f", num)
            }else if (num * 10).truncatingRemainder(dividingBy: 1.0) == 0.0{
                formatNum =  String(format: "%.1f", num)
            }else if (num * 100).truncatingRemainder(dividingBy: 1.0) == 0.0{
                formatNum =  String(format: "%.2f", num)
            }else if (num * 1000).truncatingRemainder(dividingBy: 1.0) == 0.0{
                formatNum =  String(format: "%.3f", num)
            }else if (num * 10000).truncatingRemainder(dividingBy: 1.0) == 0.0{
                formatNum =  String(format: "%.4f", num)
            }else if (num * 100000).truncatingRemainder(dividingBy: 1.0) == 0.0{
                formatNum =  String(format: "%.5f", num)
            }else if (num * 1000000).truncatingRemainder(dividingBy: 1.0) == 0.0{
                formatNum =  String(format: "%.6f", num)
            }else if (num * 10000000).truncatingRemainder(dividingBy: 1.0) == 0.0{
                formatNum =  String(format: "%.7f", num)
            }else if (num * 100000000).truncatingRemainder(dividingBy: 1.0) == 0.0{
                formatNum =  String(format: "%.8f", num)
            }else if (num * -1).truncatingRemainder(dividingBy: 1.0) == 0.0{
                formatNum =  String(format: "%.0f", num)
            }else if (num * -10).truncatingRemainder(dividingBy: 1.0) == 0.0{
                formatNum =  String(format: "%.1f", num)
            }else if (num * -100).truncatingRemainder(dividingBy: 1.0) == 0.0{
                formatNum =  String(format: "%.2f", num)
            }else if (num * -1000).truncatingRemainder(dividingBy: 1.0) == 0.0{
                formatNum =  String(format: "%.3f", num)
            }else if (num * -10000).truncatingRemainder(dividingBy: 1.0) == 0.0{
                formatNum =  String(format: "%.4f", num)
            }else if (num * -100000).truncatingRemainder(dividingBy: 1.0) == 0.0{
                formatNum =  String(format: "%.5f", num)
            }else if (num * -1000000).truncatingRemainder(dividingBy: 1.0) == 0.0{
                formatNum =  String(format: "%.6f", num)
            }else if (num * -10000000).truncatingRemainder(dividingBy: 1.0) == 0.0{
                formatNum =  String(format: "%.7f", num)
            }else if (num * -100000000).truncatingRemainder(dividingBy: 1.0) == 0.0{
                formatNum =  String(format: "%.8f", num)
            }else {
                formatNum = String(format: "%.10f", num)
            }
        }else {
            formatNum = "0"
        }
        
        return formatNum
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //  預設值設定為0
        ansLabel.text = String(Int(0))
        ansLabel.adjustsFontSizeToFitWidth = true
    }
    
    //  數字鍵點按時候
    @IBAction func NumberBtn(_ sender: UIButton) {
        //   取得點選的數字
        let number = sender.currentTitle!
        //  如果已經有其他數字在之前就輸入，就要記錄串起來
        if typeing {
                ansLabel.text = ansLabel.text! + number
        //  若之前沒有輸入過數值，若為0也可能是第一次
        }else{
            print(number)
            //  如果不是輸入0
            if number != "0"{
                //  就當做第一次輸入然後顯示出來，不串起來
                ansLabel.text = number
                //  認為使用者會再輸入其他數字，就會進入上面那段
                typeing = true
            //  如果他是輸入0，且是第一次，就還是顯示0，因為不可能顯示000000...
            }else{
                ansLabel.text = "0"
                typeing = false
            }
        }
        //  若在點選數字鍵前有按過運算符號，點選數字鍵後要將運算符號的顏色恢復
        changeColor()
        typeOperation = false
    }
    
    //  計算
    func operation (num1: Double, num2: Double) -> Double {
        switch operationSign {
        //  如果是+
        case "+":
            result = num1 + num2
        //  如果是-
        case "-":
            result = num1 - num2
        //  如果是x
        case "x":
            result = num1 * num2
        //  如果是/，因為案按鍵上是使用÷
        case "÷":
            result = num1 / num2
        default:
            break
        }
        return result!
    }
    
    //  運算按鈕點選
    @IBAction func operationBtnPressed(_ sender: UIButton) {
        //  若無按過等於，那就要進入計算
        if !equalityPressed {
            //  若之前沒有點選過運算符號或第一次
            if operationSign == nil{
                //  抓出運算符號
                operationSign = sender.currentTitle!
                //  先不做計算，但將值計入至畫面上label
                number01 = input
                //  且認為上一次的輸入已經結束
                typeing = false
                //  百分比計算處理
                if operationSign == "%"{
                    //  將畫面值直接除以100，計算百分比
                    var tempResult:Double = 0
                    operationSign! = "÷"
                    number02 = Double(100)
                    tempResult = operation(num1: number01 ?? 0, num2: number02 ?? 0)
                    //  將結果塞回畫面
                    input = tempResult
                    //  將結果塞回到第一個值
                    number01 = input
                    //  清除所有狀態
                    number02 = nil
                    operationSign = nil
                }
            //  通常為第二次點選，也就是有可能是第二個值輸入完畢後再點運算符號
            }else {
                //  認為使用者已經輸入完
                typeing = false
                //  暫存結果
                var tempResult:Double = 0
                //  百分比計算處理
                if operationSign == "%"{
                    //  將畫面值直接除以100，計算百分比
                    var tempResult:Double = 0
                    operationSign! = "÷"
                    number02 = Double(100)
                    tempResult = operation(num1: number01 ?? 0, num2: number02 ?? 0)
                    input = tempResult
                    //  將結果塞回到第一個值
                    number01 = input
                    //  清除所有狀態
                    number02 = nil
                    operationSign = nil
                }else{
                    //  抓取畫面上輸入的第二次值
                    number02 = input
                    //  計算
                    tempResult = operation(num1: number01 ?? 0, num2: number02 ?? 0)
                    //  顯示於畫面上結果
                    input = tempResult
                    //  將此次用的運算符號再次記錄下來，因為他若重複按運算符號，會用第二個的值再做一次運算
                    operationSign = sender.currentTitle!
                    //  將結果塞回到第一個值
                    number01 = input
                }
            }
        //  如果已經有按過=的話，因為=的按鈕會做計算，所以這邊舊只就將結果放到第一個值，等待按下一次的運算符號
        }else {
            operationSign = sender.currentTitle!
            number01 = input
            typeing = false
            equalityPressed = false
        }
        //  清除上一次運算符號的背景顏色和Tint的顏色
        changeColor()
        if sender.currentTitle! != "%" {
            //  變更此次按的運算符號按鈕的背景顏色和Tint的顏色
            sender.backgroundColor = white
            sender.tintColor = orange
            //  記錄下來，下次清除會需要
            currentOperatorBtn = sender
            typeOperation = true
        }
    }
    
    //  正負號按鈕
    @IBAction func negativeBtn(_ sender: UIButton) {
        //  抓取畫面上的值
        var tempResult = input
        //  因為等等為了要運算，所以先記錄最後一次的運算符號
        var orgOperationSign = operationSign
        //  如果使用者上一個動作是按運算符號，那就只需將畫面上的值做變更
        if typeOperation {
            input = -0
        //  若是已經輸入完要變更正復值，那就是值輸入值 X -1
        }else{
            operationSign = "x"
            tempResult = operation(num1: tempResult ?? 0, num2: -1)
            //  變完後要把最後一次的運算值放回去
            operationSign = orgOperationSign
            input = tempResult
        }
    }
    
    //  變更按鈕顏色（用於運算符號）
    func changeColor(){
        if currentOperatorBtn != nil {
            currentOperatorBtn?.backgroundColor = orange
            currentOperatorBtn?.tintColor = white
            currentOperatorBtn = nil
        }
    }
    
    //  等於
    @IBAction func equalityPressed(_ sender: UIButton) {
        //  認為使用者輸入完畢
        typeing = false
        //  結果暫存檔
        var tempResult:Double = 0
        //  若沒有點選過
        if !equalityPressed {
            //  若是按完第二次值，所以等於必須依據第一個值和第二個值中間的運算符號進行處理結果
            if operationSign != nil {
                //  抓取第二個值
                number02 = input
                //  運算
                tempResult = operation(num1: number01 ?? 0, num2: number02 ?? 0)
                //  顯示於畫面上
                input = tempResult
                //  設定使用者點選過=鍵計算過結果
                equalityPressed = true
            }
        //  若有點選過
        } else {
            //  將畫面上的結果丟給第一個值，然後有點類似累加的概念，會在算一次也就是第一次結果＋第二個值＝第二次結果，若再按一次就是第二次的結果＋第二個值＝第三個值
            number01 = input
            //  運算
            tempResult = operation(num1: number01 ?? 0, num2: number02 ?? 0)
            //  顯示於畫面上
            input = tempResult
        }
        //  清除上一次運算符號的背景顏色和Tint的顏色
        changeColor()
        //  變更此次按的運算符號按鈕的背景顏色和Tint的顏色
        sender.backgroundColor = white
        sender.tintColor = orange
        //  記錄下來，下次清除會需要
        currentOperatorBtn = sender
        typeOperation = false
        
    }
    
    //  如果按了AC，則將全部過程和記錄都清空
    @IBAction func acButton(_ sender: UIButton) {
        input = 0
        result = nil
        number01 = nil
        number02 = nil
        operationSign = nil
        equalityPressed = false
        typeing = false
        typeOperation = false
        changeColor()
    }
}

