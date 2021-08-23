//
//  QuizView.swift
//  KisahKataWatchApp Extension
//
//  Created by Nahl Basalamah on 12/01/1443 AH.
//

import SwiftUI

struct QuizView: View {
    var body: some View {
        ScrollView {
            Text("Ibu Kota Indonesia")
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Text("Jakarta")
            })
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Text("Depok")
            })
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Text("Cimanggis")
            })
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Text("Batam")
            })
        }
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
    }
}
