//
//  ImagePicker.swift
//  InstafilterLearn
//
//  Created by Rishav Gupta on 24/06/23.
//

import PhotosUI
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable { // UIViewControllerRepresentable builds on SwiftUI View protocol, but does not require a body
    @Binding var image: UIImage?
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate { // inherit from NSObject as all UIViewController comes from NSObject
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            guard let provider = results.first?.itemProvider else { return }
            
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    self.parent.image = image as? UIImage
                }
            }
        }
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        // we should tell the PHPickerViewController class that when some something happens that user clicks and cancels, it should tell our coordinator what happened
        picker.delegate = context.coordinator
        // We dont call the makeCoordinator method ourselves, SwiftUI automatically calls it when it makes instance of ImagePicker struct. BY above line it will send in the coordinator for us by passing the context
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator { // handle communication with the viewController and SwiftUI using coordinator class
        Coordinator(self)
    }
}
