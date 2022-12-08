//  SplashScreen.swift
//  CoreMLwithSwiftUI

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        NavigationView {
            VStack{
                VStack{
                    Image("blocks")
                        .resizable()
                                            .edgesIgnoringSafeArea(.all)
                                            .scaledToFill()
                                            .frame(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.height/3)
                    Text("LEGO IDENTIFIER FOR BLINDS")
                        .font(Font.custom("Baskerville-Bold", size: 26))
                    
                    if #available(iOS 15.0, *) {
                        NavigationLink(destination:ContentView()) {
                            
                            
                            HStack(spacing:30){
                                Text("GET STARTED").font(.title)
                                    .accessibilityIdentifier("btnGetStarted")
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                            }
                            .foregroundColor(.blue)
                            .padding(.all, 26.0)
                            .overlay(RoundedRectangle(cornerRadius: 26).stroke( Color.yellow, lineWidth: 2))
                            
                            
                        }
                    } else {
                        // Fallback on earlier versions
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
