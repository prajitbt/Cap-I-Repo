//
//  ImageClassifier.swift
//  LegoScanner
//


import Foundation
import SwiftUI
import CoreML

@available(iOS 15.0, *)
class ImageClassifier{
    
    let model = try! mobilenet()
    
    let cutoff: Double = 70.0
    let keyBlue2 = [0, 0] as [NSNumber]
    let keyBlue3 = [0,1] as [NSNumber]
    let keyBlue4 = [0,2] as [NSNumber]
    let keyGreen2 = [0,3] as [NSNumber]
    let keyGreen3 = [0,4] as [NSNumber]
    let keyGreen4 = [0,5] as [NSNumber]
    let keyRed2 = [0,6] as [NSNumber]
    let keyRed3 = [0,7] as [NSNumber]
    let keyRed4 = [0,8] as [NSNumber]
    let keyYellow2 = [0,9] as [NSNumber]
    let keyYellow3 = [0,10] as [NSNumber]
    let keyYellow4 = [0,11] as [NSNumber]
    
    func classifyImage(imageBuffer:CVPixelBuffer?) -> String {
        var lbl = "Image is not present"
        var flbl = ""
        
        let output = try? model.prediction(keras_layer_1_input: imageBuffer!)
        var highestkey: String=""
        var results: MLMultiArray!
        var highestVal:Double = 0
        
        if let output = output {
            results = output.Identity
        }else{
            lbl = "Could not detect anything in image.Please try again.Thank you"
            return lbl
        }
        
        let valBlue2 = results[keyBlue2]
        let valBlue3 = results[keyBlue3]
        let valBlue4 = results[keyBlue4]
        let valGreen2 = results[keyGreen2]
        let valGreen3 = results[keyGreen3]
        let valGreen4 = results[keyGreen4]
        let valRed2 = results[keyRed2]
        let valRed3 = results[keyRed3]
        let valRed4 = results[keyRed4]
        let valYellow2 = results[keyYellow2]
        let valYellow3 = results[keyYellow3]
        let valYellow4 = results[keyYellow4]
        
        let resDict : [String:NSNumber] = [
            "Blue_2":valBlue2,
            "Blue_3":valBlue3,
            "Blue_4":valBlue4,
            "Green_2":valGreen2,
            "Green_3":valGreen3,
            "Green_4":valGreen4,
            "Red_2":valRed2,
            "Red_3":valRed3,
            "Red_4":valRed4,
            "Yellow_2":valYellow2,
            "Yellow_3":valYellow3,
            "Yellow_4":valYellow4
        ]
        
        for (k,v) in resDict{
            
            if(Double(v.doubleValue)*100>highestVal){
                highestVal = Double(v.doubleValue)*100
                highestkey = k
            }
            print(Double(v.doubleValue)*100)
            print(k)
        }
        print("highestValue is " + String(highestVal))
        print("highestKey is " + highestkey)
        
        if( highestVal > cutoff){
            var colorSizeArr = highestkey.components(separatedBy: "_")
            flbl = colorSizeArr[0].lowercased() + "_2x" + colorSizeArr[1]
            lbl = "This is  " + colorSizeArr[0] + " colored lego of size 2 by " + colorSizeArr[1] + " with probablity of " + String(format:"%.2f",highestVal) + " Percentage"
        }
        else {
            lbl = "Could not detect anything in image.Please try again.Thank you"
            flbl = "no_size"
        }
        
        return flbl
        
    }
}
