//
//  MovableButtonC.swift
//  LoopPlayer
//
//  Created by Dan on 11/13/21.
//

import SwiftUI

struct MovableButtonC: View {
    @EnvironmentObject var fileManage : FileManageLogic
    @State private var dragAmount: CGPoint?
    var body: some View {
        GeometryReader { gp in // just to center initial position
            ZStack {
                Button(action: self.performAction) {
                    ZStack {
                        Text("C")
                            .foregroundColor(.white)
                            .font(.system(.caption, design: .serif))
                    }
                }
                .buttonStyle(PodKeyStyle(color: .purple))
                .animation(.default)
                .position(self.dragAmount ?? CGPoint(x: gp.size.width / 2, y: gp.size.height / 2))
                .highPriorityGesture(  // << to do no action on drag !!
                    DragGesture()
                        .onChanged { self.dragAmount = $0.location})
            }
            .frame(width: MoveAreaW, height: MoveAreaH, alignment: .center) // full space
        }
    }
    
    func performAction() {
        print("button pressed")
        fileManage.playSingle(url: fileManage.url_C, samplePlayer: fileManage.samplePlayer_C, engine: fileManage.engine_C)
    }
}

struct MovableButtonC_Previews: PreviewProvider {
    static var previews: some View {
        MovableButtonC()
    }
}
