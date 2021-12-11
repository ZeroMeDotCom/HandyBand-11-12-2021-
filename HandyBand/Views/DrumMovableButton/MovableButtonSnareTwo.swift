//
//  MovableButtonSnareTwo.swift
//  HandyBand
//
//  Created by DanTereson on 06/12/2021.
//Who is this file?
    // 1. drum snare2 view

import SwiftUI

struct MovableButtonSnareTwo: View {
    @EnvironmentObject var fileManage : FileManageLogic
    @State private var dragAmount: CGPoint?
    @State private var isPressed: Bool = false
    private var exclusiveColor: SwiftUI.Color!
    init(exclusiveColor: SwiftUI.Color) {
        self.exclusiveColor = exclusiveColor
    }
    var body: some View {
        GeometryReader { gp in // just to center initial position
            ZStack {
                Button(action: {
                //
                }) {
                    ZStack {
                        Text("Snare2")
                            .foregroundColor(.white)
                            .font(.system(.caption, design: .serif))
                    }
                }
                .onLongPressGesture(perform: {
                    //
                }, onPressingChanged: { pressing in
                    print(pressing.description)
                    if pressing {
                        self.playSound()
                    } else {
//                        self.stopSound()
                    }
                })
                .buttonStyle(PodKeyStyle(color: self.exclusiveColor))
//                .animation(.default)
                .position(self.dragAmount ?? CGPoint(x: gp.size.width / 2, y: gp.size.height / 2))
                .highPriorityGesture(  // << to do no action on drag !!
                    DragGesture()
                        .onChanged { self.dragAmount = $0.location})
            }
            .frame(width: MoveAreaW, height: MoveAreaH, alignment: .center) // full space
        }
    }
    
    func playSound() {
        fileManage.playSingle(url: fileManage.url_PlusD, samplePlayer: fileManage.samplePlayer_PlusD, engine: fileManage.engine_PlusD)
    }
    func stopSound() {
        fileManage.stopSingle(url: fileManage.url_PlusD, samplePlayer: fileManage.samplePlayer_PlusD, engine: fileManage.engine_PlusD)
    }
}

struct MovableButtonSnareTwo_Previews: PreviewProvider {
    static var previews: some View {
        MovableButtonSnareTwo(exclusiveColor: .white)
    }
}
