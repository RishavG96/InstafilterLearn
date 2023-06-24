//
//  ImageSaver.swift
//  InstafilterLearn
//
//  Created by Rishav Gupta on 24/06/23.
//

import UIKit

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
//        UIImageWriteToSavedPhotosAlbum(inputImage, nil, nil, nil)
        // 2nd - object should be notified about the save finishing
        // 3rd - method on the object which we run
        // 4th - It will be passed back when the 3rd method is called on 2nd object
        
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
        // 2nd - who to tell when we are finished - tell us = self
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished")
    }
}
