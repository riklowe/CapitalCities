//
//  helper.swift
//  CustomMapAnnotation
//
//  Created by Richard Lowe on 02/03/2018.
//  Copyright © 2018 Richard Lowe All rights reserved.
//

import Foundation
import MapKit

func convert(cmage:CIImage) -> UIImage
{
    let context:CIContext = CIContext.init(options: nil)
    let cgImage:CGImage = context.createCGImage(cmage, from: cmage.extent)!
    let image:UIImage = UIImage.init(cgImage: cgImage)
    return image
}

func randomLetter() -> String {
    let alphabet: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    let rand = Int(arc4random_uniform(26))
    return(alphabet[rand])
}

func RandomInt(min: Int, max: Int) -> Int {
    
    return Int( arc4random_uniform(UInt32(max)) + UInt32(min))
    
    //return Int((Double(arc4random()) / Double(UInt32.max)) * (max - min) + min)
}


func RandomFixedColor() -> UIColor {
    
    let i = RandomInt(min: 1, max: 7)
    var retVal: UIColor
    
    switch i {
    case 1:
        retVal = UIColor.blue
    case 2:
        retVal = UIColor.lightGray
    case 3:
        retVal = UIColor.darkGray
    case 4:
        retVal = UIColor.purple
    case 5:
        retVal = UIColor.brown
    case 6:
        retVal = UIColor.orange
    case 7:
        retVal = UIColor.gray
    default:
        retVal = UIColor.yellow
    }
    
    return retVal
    
}
