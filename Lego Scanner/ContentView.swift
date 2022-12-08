//
//  ContentView.swift
//  Lego Img Classifier
//



import SwiftUI
import AVFoundation
import CoreML

@available(iOS 15.0, *)
struct ContentView: View {
    let imgClassifier:ImageClassifier = ImageClassifier()
    let speak:AudioOutput = AudioOutput()
    
    @State private var showSheet: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    
    @State private var classificationLabel: String = "The result"
    
    @State private var image: UIImage?
    
    func classifyImage(){
        //resizing the image to be predicted and and converted to pixel buffer
        guard let image = image,
                        let resizedImage = image.resizeImageTo(size: CGSize(width: 224, height: 224)),
              let buffer = resizedImage.convertToBuffer() else {
                return
        }
        //Calling Image Classifier which returns back the predicted text and outputs as audio
        let strPredictedLabel:String = imgClassifier.classifyImage(imageBuffer: buffer)
        self.classificationLabel = strPredictedLabel
        
        speak.speakThePrediction(stringToSpeak:classificationLabel)

    }
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                Image(uiImage: image ?? UIImage(named: "vecteezy_purple-lego-block-isolated_")!)
                    .resizable()
                    .frame(width: 400, height: 350)
                Text("\(classificationLabel)")
                    .padding()
                    .font(.body)
                Button{
                  classifyImage()
                }label:{
                    Text("Predict Image")
                }.foregroundColor(.blue)
                    .padding(.all, 26.0)
                    .overlay(RoundedRectangle(cornerRadius: 26).stroke( Color.yellow, lineWidth: 2))
                
                    .accessibility(identifier:"btnPredictImage")
                
                Button{
                    self.showSheet = true
                }label:{
                    Text("Choose Lego/Capture").accessibilityIdentifier("btnChooseLogo")
                    
                }.padding()
                    .actionSheet(isPresented: $showSheet) {
                        ActionSheet(title: Text("Select a image where lego is present"), message: Text("Choose"), buttons: [
                                                .default(
                                                    Text("Photo Library")
                                                ) {
                                                    self.showImagePicker = true
                                                    self.sourceType = .photoLibrary
                                                },
                                                
                                                .default(
                                                    Text("Camera")
                                                ) {
                                                    self.showImagePicker = true
                                                    self.sourceType = .camera
                                                },
                                                .cancel()
                                            ])
                                    }
                
            }.navigationBarTitle("Scan a Lego")
                .accessibilityIdentifier("assibility")
            
            
        }.sheet(isPresented: $showImagePicker) {
            ImagePicker(image: self.$image, isShown: self.$showImagePicker, sourceType: self.sourceType)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15.0, *) {
            ContentView()
        } else {
            // Fallback on earlier versions
        }
    }
}
