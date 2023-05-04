//
//  CameraView.swift
//  LegoScannerBlind
//
//

import Foundation
import SwiftUI
import AVFoundation

struct CameraView: UIViewControllerRepresentable{
    typealias UIViewControllerType = UIViewController
    
    let cameraService: CameraService
    let didFinishProcessingPhoto: (Result<AVCapturePhoto, Error>) -> ()
    
    func makeUIViewController(context: Context) -> UIViewController{
        
        cameraService.start(delegate: context.coordinator){ err in
            if let err = err {
                didFinishProcessingPhoto(.failure(err))
                return
            }
        }
        
        let viewController = UIViewController()
        viewController.view.backgroundColor = .green
        viewController.view.layer.addSublayer(cameraService.previewLayer)
        cameraService.previewLayer.frame = viewController.view.bounds
        return viewController
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, didFisishProcessingPhoto: didFinishProcessingPhoto)
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context){
        
    }
    
    class Coordinator: NSObject, AVCapturePhotoCaptureDelegate {
        let parent: CameraView
        private var didFisishProcessingPhoto: (Result<AVCapturePhoto, Error>)-> ()
        
        init(_ parent: CameraView, didFisishProcessingPhoto:@escaping (Result<AVCapturePhoto, Error>)-> ()){
            self.parent = parent
            self.didFisishProcessingPhoto = didFisishProcessingPhoto
        }
        
        func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
            if let error = error {
                didFisishProcessingPhoto(.failure(error))
                return
            }
            didFisishProcessingPhoto(.success(photo))
        }
    }
}
