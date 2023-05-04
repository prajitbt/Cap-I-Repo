//
//  ContentView.swift
//  LegoScannerBlind
//
//

import SwiftUI
import Combine
func announceVoiceOver(_ message: String) {
    UIAccessibility.post(notification: .announcement, argument: message)
}

struct ContentView: View {
    @State private var isLoading: Bool = false
    @State private var capturedImage: UIImage? = nil
    @State private var apiResponse: ApiResponse? = nil
    @State private var detectedCls: [String] = [String]()
    @State private var detectedLbl: String = "no_size"
    @State private var isCustomCameraViewPresented = false
    @State private var detectedLegoBoundingBox: CGRect?
    @Environment(\.colorScheme) var colorScheme
    @State private var cancellables = Set<AnyCancellable>()

    // Function to handle VoiceOver announcements
        func announceVoiceOver(_ message: String) {
            UIAccessibility.post(notification: .announcement, argument: message)
        }
    
    var body: some View {
        VStack {
            if(isLoading){
                LoadingView()
            } else {
                
                if(capturedImage != nil){
                    Image(uiImage: capturedImage!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.7)
                        .ignoresSafeArea()
                } else {
                    Color(UIColor.systemBackground)
                }
                
                Text(detectedLbl)
                    .multilineTextAlignment(.center)
                    .frame(height: 50)
                    .padding(.vertical)
                
                
                VStack
                {
                    Spacer()
                    Button(action:{
                        isCustomCameraViewPresented.toggle()
                        if(isCustomCameraViewPresented){
                            UIAccessibility.post(notification: .layoutChanged, argument: "On to the camera screen to capture the lego")
                        }
                    }){
                        Text("Capture")
                            .font(.system(.headline, design: .rounded))
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .foregroundColor(colorScheme == .dark ? .black : .white)
                            .background(colorScheme == .dark ? Color.white.opacity(0.9) : Color.black.opacity(0.9))
                            .cornerRadius(40)
                            .padding(.horizontal)
                            .accessibilityLabel("Capture")
                            .accessibilityHint("Tap to capture an image and detect Lego")
                    }
                    .padding(.bottom)
                    .accessibilityLabel("Capture")
                    .accessibilityHint("Double-tap to capture an image and detect Lego")
                    .accessibility(addTraits: .isButton)
                    .sheet(isPresented: $isCustomCameraViewPresented, content: {
                        CustomCameraView(capturedImage: $capturedImage, apiResponseFinal: $apiResponse, detectedCls: $detectedCls, detectedLbl: $detectedLbl, isLoading: $isLoading)
                    })
                }
            }
            }
                .navigationBarTitle("Lego Detector", displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                    // Add an action to toggle Voice Assistant (e.g. AVSpeechSynthesizer)
                }) {
                    Image(systemName: "speaker.wave.3.fill")
                        .accessibilityLabel("Toggle Voice Assistant")
                        .accessibilityHint("Double-tap to toggle Voice Assistant on or off")
                    
                })
                .onAppear(perform: {
                    UIAccessibility.post(notification: .screenChanged, argument: nil)
                    announceVoiceOver("Lego Detector app launched. Double-tap the Capture button to detect a Lego.")
                })
            
        }
    
       
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .primary))
                .scaleEffect(2)
            Text("Please wait while we are detecting a lego on image")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.top)
                .accessibilityLabel("Processing image")
                .accessibilityHint("Please wait while we are detecting a lego on image")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground).edgesIgnoringSafeArea(.all))
        .disabled(true)
        .onAppear(perform: {
            UIAccessibility.post(notification: .screenChanged, argument: nil)
            announceVoiceOver("Loading Screen. lease wait while we are detecting a lego on image.")
        })
    }
}
