//
//  quiz.swift
//  KisahKataWatchApp Extension
//
//  Created by Nahl Basalamah on 12/01/1443 AH.
//

import Foundation

struct Answers {
    var text : String
}

struct Quiz {
    var videoUrl : String
    var question : String
    var answers : [Answers]
    var correctAnswerIndex : Int
}

var appQuiz : [Quiz] = [
    Quiz(videoUrl: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4", question: "Zebra apa yang belang belang?", answers: [Answers(text: "Zebra cross"), Answers(text: "Kuda Zebra"), Answers(text: "Zebra Afrika"), Answers(text: "Anak Zebra")], correctAnswerIndex: 1)
]
