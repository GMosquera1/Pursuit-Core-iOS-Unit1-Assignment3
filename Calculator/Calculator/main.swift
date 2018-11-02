//
//  main.swift
//  Calculator
//
//  Created by Alex Paul on 10/25/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

func mathStuffFactory(opString: String) -> (Double, Double) -> Double {
    switch opString {
    case "+":
        return {x, y in x + y }
    case "-":
        return {x, y in x - y }
    case "*":
        return {x, y in x * y }
    case "/":
        return {x, y in x / y }
    default:
        return {x, y in x + y }
    }
}

func myFilter (arr: [Double], closure: (Double) -> Bool) -> [Double] {
    var emptyArr = [Double]()
    for number in arr {
        if closure(number) {
            emptyArr.append(number)
        }
          }
        return emptyArr
}
func myReduce(arr: [Double], orderByThis: Double, reduceClosure: (Double, Double) -> Double) -> Double{
    var myReduceOp = orderByThis
    for num in arr{
        myReduceOp = reduceClosure(myReduceOp, num)
    }
    return myReduceOp
}
func myMap(arr: [Double], mapClosure: (Double) -> Double) -> [Double]{
    var emptyArray = [Double]()
    for num in arr{
        emptyArray.append(mapClosure(num))
    }
    return emptyArray
}

var properInput = true
repeat {
    print ("What would you want to do: (Calc) (RandomOp) (HighOrder)")
    
    if let response = readLine() {
        switch response.lowercased() {
        case "calc":
            print("Enter your function, e.g 2 + 4")
            
            var userInputArray = [String]()
            var firstNumber = 0.0
            var secondNumber = 0.0
            let randomOp = ""
            let newRandom: String = ""
            if let userInput = readLine() {
                let components = userInput.components(separatedBy: " ")
                userInputArray = components
            }
            
            if let firstNumberInput = Double(userInputArray[0]) {
                firstNumber = firstNumberInput
            } else {
                continue
            }
        
            
            if let secondNumberInput = Double(userInputArray[2]) {
                secondNumber = secondNumberInput
            } else {
                continue
            }
            
            let mathOperation = mathStuffFactory(opString: userInputArray[1])
            let result = mathOperation(firstNumber, secondNumber)
            print(" \(userInputArray[0]) \(userInputArray[1]) \(userInputArray[2]) = \(result)")
            print("Would you like to play again? Yes or No")
            let answer = readLine()
            if answer?.lowercased() ==  "yes" {
                continue
            } else {
                if answer == "no" {
                    break
                }
            }
            
        case "randomop":
            print("Enter your function e.g 2 ? 4")
            
            var userInputArray = [String]()
            var firstNumber = 0.0
            var secondNumber = 0.0
            let randomOp = ""
            let randomOperand = ["*","/","+","-"]
            if let userInput = readLine() {
                let components = userInput.components(separatedBy: " ")
                userInputArray = components
            }
            
            if let firstNumberInput = Double(userInputArray[0]) {
                firstNumber = firstNumberInput
            } else {
                continue
            }
            
            if let secondNumberInput = Double(userInputArray[2]) {
                secondNumber = secondNumberInput
            } else {
                continue
            }
            
            if userInputArray.contains("?") {
                if let newRandom = randomOperand.randomElement(){
                    let mathOperation = mathStuffFactory(opString: newRandom)
                    let result = mathOperation(firstNumber, secondNumber)
                    //print(newRandom)
                   print(result)
                    properInput = true // temp
                    print("Enter your guess e.g + ")
                    let usersResponse = readLine() ?? "invalid value"
                    if usersResponse == newRandom {
                        print("Correct!")
                    } else {
                        print("Sorry, better luck next time. The correct response is \(newRandom)")
                    }
                }
            }
            
        case "highorder":
            print("Enter your high order function e.g. filter 1,5,2,6 by < 4 ")
            let usersInput = readLine() ?? "invalid value"
            let inputComponents = usersInput.components(separatedBy: " ")
            print(inputComponents) // comment out
            if inputComponents.count == 5 {
            let highOrderFunc = inputComponents[0]
            let numberArray = inputComponents[1].components(separatedBy: ",").compactMap{Double($0)}
            let funcOperator = inputComponents[3]
            let orderBy = Double(inputComponents[4]) ?? 0
          
            
            switch highOrderFunc {
            case "filter":
                if funcOperator ==  "<" {
                    print(myFilter(arr: numberArray, closure:{ $0 < orderBy ? true : false}))
                } else {
                    if funcOperator == ">" {
                        print(myFilter(arr: numberArray, closure:{ $0 > orderBy ? true : false}))
                    }
                }
            case "reduce":
                if funcOperator == "+"{
                    print(myReduce(arr: numberArray, orderByThis: orderBy){$0 + $1})
                } else if funcOperator == "*" {
                    print(myReduce(arr: numberArray, orderByThis: orderBy){$0 * $1})
                }
                
            case "map":
                if funcOperator == "*" {
                    print(myMap(arr: numberArray){orderBy * $0})
                } else if funcOperator == "/"{
                    print(myMap(arr: numberArray){orderBy / $0})
                } else {
                    print("Try, try again")
                    
                }
            default :
                print("That is not a Higher Order function")
            }
            } else {
                print("Enter a function that looks like this: reduce 1,2,3,4 by * 4 ")
            }
                
            default :
                print("Unrecognizable Function")
                
            }
        }
    } while properInput
