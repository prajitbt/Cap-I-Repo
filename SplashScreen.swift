

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        NavigationView {
            VStack{
                VStack{
                    Image(systemName: "hare.fill")
                        .font(.system(size:80))
                        .foregroundColor(.red)
                    Text("LEGO IDENTIFIER FOR BLINDS")
                        .font(Font.custom("Baskerville-Bold", size: 26))
                    
                    NavigationLink(destination:ContentView()) {
                        
                            
                            HStack(spacing:30){
                                Text("GET STARTED").font(.title)
                                
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                            }
                            .foregroundColor(.blue)
                            .padding(.all, 26.0)
                            .overlay(RoundedRectangle(cornerRadius: 26).stroke( Color.yellow, lineWidth: 2))
                        
                        
                    }
                    
                    //Button Instance with label view
                    
                }
            }
        }
    
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
