//
//  UIImage+GYExtension.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/6/19.
//  Copyright © 2017年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/6/19  下午4:23
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit
import Accelerate

extension UIImage {
    
    //增加模糊的效果（需要添加Accelerate.Framework）
    
    func gaosiBlur(blur:Double) ->UIImage{
        
        var blurAmount = blur
        
        //高斯模糊参数(0-1)之间，超出范围强行转成0.5
        
        if(blurAmount < 0.0||blurAmount > 1.0) {
            
            blurAmount = 0.5
            
        }
        
        var boxSize = Int(blurAmount * 40)
        
        boxSize = boxSize - (boxSize % 2) + 1
        
        let img = self.cgImage
        
        var inBuffer = vImage_Buffer()
        
        var outBuffer = vImage_Buffer()
        
        let inProvider = img!.dataProvider
        
        let inBitmapData = inProvider!.data
        
        inBuffer.width = vImagePixelCount(img!.width)
        
        inBuffer.height = vImagePixelCount(img!.height)
        
        inBuffer.rowBytes = img!.bytesPerRow
        
        inBuffer.data = UnsafeMutableRawPointer(mutating:CFDataGetBytePtr(inBitmapData))
        
        //手动申请内存
        
        let pixelBuffer = malloc(img!.bytesPerRow * img!.height)
        
        outBuffer.width = vImagePixelCount(img!.width)
        
        outBuffer.height = vImagePixelCount(img!.height)
        
        outBuffer.rowBytes = img!.bytesPerRow
        
        outBuffer.data = pixelBuffer
        
        var error = vImageBoxConvolve_ARGB8888(&inBuffer,
                                              &outBuffer,nil,vImagePixelCount(0),vImagePixelCount(0),
                                              
                                              UInt32(boxSize),UInt32(boxSize),nil,vImage_Flags(kvImageEdgeExtend))
        
        if(kvImageNoError != error)
            
        {
            
            error = vImageBoxConvolve_ARGB8888(&inBuffer,
                                               
                                               &outBuffer,nil,vImagePixelCount(0),vImagePixelCount(0),
                                               
                                               UInt32(boxSize),UInt32(boxSize),nil,vImage_Flags(kvImageEdgeExtend))
            
            if(kvImageNoError != error)
                
            {
                
                error = vImageBoxConvolve_ARGB8888(&inBuffer,
                                                   
                                                   &outBuffer,nil,vImagePixelCount(0),vImagePixelCount(0),
                                                   
                                                   UInt32(boxSize),UInt32(boxSize),nil,vImage_Flags(kvImageEdgeExtend))
                
            }
            
        }
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let ctx = CGContext(data: outBuffer.data,
                            
                            width:Int(outBuffer.width),
                            
                            height:Int(outBuffer.height),
                            
                            bitsPerComponent:8,
                            
                            bytesPerRow: outBuffer.rowBytes,
                            
                            space: colorSpace,
                            
                            bitmapInfo:CGImageAlphaInfo.premultipliedLast.rawValue)
        
        let imageRef = ctx!.makeImage()
        
        //手动申请内存
        
        free(pixelBuffer)
        
        return UIImage(cgImage: imageRef!)
        
    }
    
    func gaosiImage() -> UIImage{
        
        let ciImage = CIImage.init(image: self)
        
        let blurFilter = CIFilter.init(name: "CIGaussianBlur")
        
        blurFilter?.setValue(600, forKey: "inputRadius")
        blurFilter?.setValue(ciImage, forKey: kCIInputImageKey)
        
        let outCiImage = blurFilter?.value(forKey: kCIInputImageKey)
        
        let context = CIContext(options: nil)
        let outCGImage = context.createCGImage(outCiImage as! CIImage, from: (appDelegate.window?.frame)!)
        
        let blurImage = UIImage.init(cgImage: outCGImage!)
        
        return blurImage
        
        
        
        
        
    }
    
}
