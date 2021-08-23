//
//  VideoView.swift
//  KisahKataWatchApp Extension
//
//  Created by Nahl Basalamah on 12/01/1443 AH.
//

import SwiftUI
import AVKit
import AVFoundation

struct VideoView: View {
    var video : String
    var player : AVPlayer
    
    init() {
        video = "bermain.mp4"
        let file = video.components(separatedBy: ".")
        let filePath = Bundle.main.path(forResource: file[0], ofType:file[1])
        player = AVPlayer(url: URL(fileURLWithPath: filePath!))
    }
    
    
    var body: some View {
        VStack {
            VideoPlayer(player: player)
                .onAppear(perform: {
                    player.play()
                })
            
        }
    }
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView()
    }
}
