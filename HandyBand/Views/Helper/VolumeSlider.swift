//
//  VolumeSlider.swift
//  HandyBand
//
//  Created by Dan on 10/29/21.
// Who is this file?
    // Volume slider View

import SwiftUI

struct VolumeSlider: View {
    @State private var volume : Double = 50.0
    var body: some View {
        List{
            Text("Volume: \(volume)")
            Slider(value: $volume, in: 0...100) {
            }
        }.frame(width: 400.0, height: 150.0)
    }
}

struct VolumeSlider_Previews: PreviewProvider {
    static var previews: some View {
        VolumeSlider()
    }
}
