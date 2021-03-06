//
//  button_sample_play.swift
//  HandyBand
//
//  Created by Dan on 10/28/21.
//  What's this file for?
        //Define the play button
        //.. and the slider
        //Whether the file to play in next loop

import SwiftUI
import AudioKit

struct button_sample_play: View {
    @EnvironmentObject var fileManage : FileManageLogic
    
    @State private var selection = 0
    
    //Delay: varible for slider
    @State private var delay_balance : Double = 0.5
    @State private var delay_feedback : Double = 50
    @State private var delay_time : Double = 0.1
    @State private var value : Double = 50
    @State private var isOn = false
    var trackID : String

    var samplePlyer : SamplePlyer!
    
//    var filename : String
    
    init(fileURL: String, filename: String, url: URL, path: String, engine: AudioEngine, samplePlayer: AudioPlayer, isLooping: Bool, trackID: String){
        self.trackID = trackID
        samplePlyer = SamplePlyer(fileURL: fileURL, filename: filename, url: url, path: path, engine: engine, samplePlayer: samplePlayer, isLooping: isLooping)
    }
    var body: some View {
        VStack {
            HStack {
                Button(isOn ? "□" : "▷") {
                    //
                }
                .buttonStyle(MyButtonStyle(color: .gray))
                .clipShape(Circle())
                .gesture(TapGesture(count: 1).onEnded {
                    samplePlyer.play()
                    isOn = true
                })
                .simultaneousGesture(TapGesture(count: 2).onEnded {
                    samplePlyer.stop()
                    isOn = false

                })
                
                //Send to Bus
                Button(action: {
                    fileManage.addingToPlayNextTime(trackID: self.trackID) ? fileManage.setToEdit(trackID: self.trackID) : fileManage.setReady(trackID: self.trackID)
                    print(fileManage.whichToPlay)
                    
                }, label: {
                    Image(systemName: fileManage.addingToPlayNextTime(trackID: self.trackID) ? "arrow.up.circle.fill" : "arrow.up.circle")
                })
            }

            Slider(value: $value, in: 0...100, onEditingChanged: {_ in
                samplePlyer.changeVolume(value: $value.wrappedValue)
            })
            
            Picker(selection: $selection, label: Text("controlPicker")) {
                Text("Delay").tag(0)
                Text("Reverb").tag(1)
                Text("Convolution").tag(2)
            }.pickerStyle(.segmented)
            
            if selection == 0 {
                
                //Delay Setting
                Slider(value: $delay_time, in: 0...10, onEditingChanged: {_ in
                    samplePlyer.changeDelay_time(delay_time: $delay_time.wrappedValue)
                })
            
                Slider(value: $delay_feedback, in: 0...100, onEditingChanged: {_ in
                    samplePlyer.changeDelay_feedback(delay_feedback: $delay_feedback.wrappedValue)
                })
                Slider(value: $delay_balance, in: 0...100, onEditingChanged: {_ in
                    samplePlyer.changeDelay_balance(delay_balance: $delay_balance.wrappedValue)
                })
            } else if selection == 1 {
                //Reverb Setting
                ReverbPicker(samplePlayer: samplePlyer)
                
            } else if selection == 2 {
               //Convolution Setting
               ConvolutionSlider(samplePlayer: samplePlyer)
            }

        }
    }
}


//Button style setting
struct MyButtonStyle: ButtonStyle {
      var color: Color = .gray
      
      public func makeBody(configuration: MyButtonStyle.Configuration) -> some View {
          MyButton(configuration: configuration, color: color)
      }
      
      struct MyButton: View {
          let configuration: MyButtonStyle.Configuration
          let color: Color
          
          var body: some View {
              
              return configuration.label
                  .foregroundColor(.white)
                  .padding(15)
                  .frame(width: 50, height: 50)
                  .background(RoundedRectangle(cornerRadius: 5).fill(color))
                  .compositingGroup()
                  .shadow(color: .black, radius: 3)
                  .opacity(configuration.isPressed ? 0.5 : 1.0)
          }
      }
  
  }

struct button_sample_play_Previews: PreviewProvider {
    static var previews: some View {
        button_sample_play(fileURL: "", filename: "", url: URL(fileURLWithPath: ""), path: "", engine: AudioEngine(), samplePlayer: AudioPlayer(), isLooping: false, trackID: "")
    }
}
