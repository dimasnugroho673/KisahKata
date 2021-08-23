//
//  PlayView.swift
//  KisahKataWatchApp Extension
//
//  Created by Nahl Basalamah on 12/01/1443 AH.
//

import SwiftUI

struct PlayView: View {
    @State var isShowingVideo : Bool = true
    var body: some View {
        VStack {
            if(isShowingVideo) {
                VStack {
                }.sheet(isPresented: $isShowingVideo) {
                    VideoView()
                }
            } else {
                QuizView()
            }
        }
    }
}

struct PlayView_Previews: PreviewProvider {
    static var previews: some View {
        PlayView()
    }
}
