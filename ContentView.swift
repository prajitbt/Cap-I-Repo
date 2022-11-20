

import SwiftUI

struct ContentView: View {
    
    @State private var showSheet: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    
    @State private var image: UIImage? 
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                Image(uiImage: image ?? UIImage(named: "placeholder")!)
                    .resizable()
                    .frame(width: 500, height: 500)
                
                Button("Choose Lego") {
                    self.showSheet = true
                }.padding()
                .actionSheet(isPresented: $showSheet) {
                                                            ActionSheet(title: Text("Select a image where lego is present"), message: Text("Choose"), buttons: [
                                                                .default(Text("Photo Library")) {
                                                                    self.showImagePicker = true
                                                                    self.sourceType = .photoLibrary
                                                                },
                                                                .default(Text("Camera")) {
                                                                    self.showImagePicker = true
                                                                    self.sourceType = .camera
                                                                },
                                                                .cancel()
                                                            ])
                                                    }
                
            }.navigationBarTitle("Scan a Lego")
            
        }.sheet(isPresented: $showImagePicker) {
            ImagePicker(image: self.$image, isShown: self.$showImagePicker, sourceType: self.sourceType)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
