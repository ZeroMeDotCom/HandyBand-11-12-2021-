//
//  button_sample_play.swift
//  LoopPlayer
//
//  Created by Dan on 10/28/21.
//  What's this file for?
        //Define the play button
        //.. and teh slider
        //Whether the file to play in next loop

import SwiftUI
import AudioKit

struct button_sample_play: View {
    @EnvironmentObject var fileManage : FileManageLogic
    
    @State private var selection = 0
    //Delay: varible for slider
    @State private var delay_balance : Double = 0.5
    @State private var delay_feedback : Double = 0.5
    @State private var delay_time : Double = 0.01
    @State private var value : Double = 50
    @State private var isOn = false
    var trackID : String

    var samplePlyer : SamplePlyer!
    
//    var filename : String
    
    init(filename: String, url: URL, path: String, engine: AudioEngine, samplePlayer: AudioPlayer, isLooping: Bool, trackID: String){
        self.trackID = trackID
        samplePlyer = SamplePlyer(filename: filename, url: url, path: path, engine: engine, samplePlayer: samplePlayer, isLooping: isLooping)
    }
    var body: some View {
        VStack {
            Button(isOn ? "□" : "▷") {
                //
            }
            .buttonStyle(MyButtonStyle(color: .gray))
            .clipShape(Circle())
            .gesture(TapGesture(count: 1).onEnded {
//                samplePlyer.play()
                isOn = true
                if self.trackID == "track1" {
                    fileManage.isWish = true
                    print("track1 is: \(fileManage.isWish)")
                } else if self.trackID == "track2" {
                    fileManage.isWish2 = true
                    print("track2 is: \(fileManage.isWish2)")
                } else if self.trackID == "track3" {
                    fileManage.isWish3 = true
                    print("track3 is: \(fileManage.isWish3)")
                }
            })
            .simultaneousGesture(TapGesture(count: 2).onEnded {
//                samplePlyer.stop()
                isOn = false
                if self.trackID == "track1" {
                    fileManage.isWish = false
                    print("track1 is: \(fileManage.isWish)")
                } else if self.trackID == "track2" {
                    fileManage.isWish2 = false
                    print("track2 is: \(fileManage.isWish2)")
                } else if self.trackID == "track3" {
                    fileManage.isWish3 = false
                    print("track3 is: \(fileManage.isWish3)")
                }

            })
            
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
                Slider(value: $delay_time, in: 0...1, onEditingChanged: {_ in
                    samplePlyer.changeDelay_time(delay_time: $delay_time.wrappedValue)
                })
            
                Slider(value: $delay_feedback, in: 0...100, onEditingChanged: {_ in
                    samplePlyer.changeDelay_feedback(delay_feedback: $delay_feedback.wrappedValue)
                })
                Slider(value: $delay_balance, in: 0...99, onEditingChanged: {_ in
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
        button_sample_play(filename: "", url: URL(fileURLWithPath: ""), path: "", engine: AudioEngine(), samplePlayer: AudioPlayer(), isLooping: false, trackID: "")
    }
}
