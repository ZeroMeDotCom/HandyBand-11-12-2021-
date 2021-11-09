//
//  LoopPlayerApp.swift
//  LoopPlayer
//
//  Created by Dan on 10/28/21.
//

import SwiftUI

@main
struct LoopPlayerApp: App {
    var fileManage = FileManageLogic()
    var recorderPlayer = RecordingLogic()
    var playCreationModel = playCreationsModel()
//    var savedFileNames = SavedFileNames()
    @State private var selection = 0
    var body: some Scene {
        WindowGroup {
            //頭部
            HStack {
                DangDangDangView()
                    .environmentObject(recorderPlayer)
//                    .environmentObject(savedFileNames)
                PlayYourCreationView().environmentObject(fileManage)
            }
            .border(.green, width: 2)
            VStack {
                ContentView()
                    .environmentObject(fileManage)
                    .environmentObject(playCreationModel)
                //整體四個
                .frame(width: fourGroupWidth, height: fourGroupHeight, alignment: .center)
                .position(x: screenWidth / 2, y: fourGroupHeight - 150)
                .border(.red, width: 2)
                
                Picker(selection: $selection, label: Text("Plug-in or Build-in")) {
                    Text("Build-in").tag(0)
                    Text("Plug-in").tag(1)
                }.pickerStyle(.segmented)
                if selection == 0 {
                    PodKeyBoard().environmentObject(fileManage)
                } else if selection == 1 {
                    //PlUGIN-Guitar/Bass
                    PlugInView()
                    .border(.red, width: 1)
                    .frame(width: screenWidth / 3, height: screenHeight / 5, alignment: .trailing)
                    .position(x: screenWidth / 1.5, y: screenHeight / 4)
                }
            }
            .border(.black, width: 3)
            
    
        }
    }
}
