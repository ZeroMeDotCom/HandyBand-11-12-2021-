//
//  SoundCardPlugInView.swift
//  LoopPlayer
//
//  Created by Dan on 11/4/21.
//

import SwiftUI

struct SoundCardPlugInView: View {
    @StateObject var soundCardPlugIn = SoundCardPlugInLogic()
    @EnvironmentObject var fileManage : FileManageLogic
    @EnvironmentObject var playCreationModel : playCreationsModel
    @State var stopFlag: Bool
    
    //Delay
    @State private var delay_balance : Double = 0.5
    @State private var delay_feedback : Double = 0.5
    @State private var delay_time : Double = 0.01
    
    init() {
        self.stopFlag = true
    }
    var body: some View {
        HStack {
            
            VStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Guitar").foregroundColor(.yellow)
                        Image(systemName: "guitars").foregroundColor(.yellow)
                    }
                    PlaySampleBassGroup()
                        .environmentObject(fileManage)
                        .environmentObject(playCreationModel)
                }
            .border(.blue, width: 4)

        }
            VStack {
                HStack {
                    Text("Session!!")
                    Button(action: {
                        self.stopFlag ? self.soundCardPlugIn.stopSession() : self.soundCardPlugIn.openSession()
                        self.stopFlag = !self.stopFlag
                        
                    }, label: {
                        Image(systemName: self.stopFlag ? "powerplug,fill" : "powerplug")
                    })
                }
                
                //delay
                VStack {
                    Slider(value: $delay_time, in: 0...1, onEditingChanged: {_ in
                        soundCardPlugIn.changeDelay_time(delay_time: $delay_time.wrappedValue)
                    })
                    Slider(value: $delay_feedback, in: 0...100, onEditingChanged: {_ in
                        soundCardPlugIn.changeDelay_feedback(delay_feedback: $delay_feedback.wrappedValue)
                    })
                    Slider(value: $delay_balance, in: 0...99, onEditingChanged: {_ in
                        soundCardPlugIn.changeDelay_balance(delay_balance: $delay_balance.wrappedValue)
                    })
                }
            }


        }

    }
}

struct SoundCardPlugInView_Previews: PreviewProvider {
    static var previews: some View {
        SoundCardPlugInView()
    }
}
