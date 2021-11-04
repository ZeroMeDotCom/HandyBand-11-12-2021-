//
//  ConvolutionSlider.swift
//  LoopPlayer
//
//  Created by Dan on 11/2/21.
//

import SwiftUI
import AudioToolbox

struct ConvolutionSlider: View {
    @State private var saltMixerBalance : AUValue = 0.5
    var samplePlayer : SamplePlyer!
    
    init(samplePlayer: SamplePlyer) {
        self.samplePlayer = samplePlayer
    }
    
    var body: some View {
        Slider(value: $saltMixerBalance, in: 0...1, onEditingChanged: {_ in
            samplePlayer.changeConvolution_balance(convolution_balance: $saltMixerBalance.wrappedValue)
            print("\($saltMixerBalance.wrappedValue)")
        })
    }
}

struct ConvolutionSlider_Previews: PreviewProvider {
    static var previews: some View {
        let samplePlayer = SamplePlyer(filename: "sample_drum_one.wav", isLooping: true)
        ConvolutionSlider(samplePlayer: samplePlayer)
    }
}