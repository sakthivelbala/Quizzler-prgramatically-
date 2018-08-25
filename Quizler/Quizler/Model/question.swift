//
//  question.swift
//  Quizler
//
//  Created by Sakthivel Balakrishnan on 25/08/18.
//  Copyright © 2018 Sakthivel Balakrishnan. All rights reserved.
//

import Foundation
class question{
    let questionText:String
    let answer:Bool
    init(text:String,correctAnswer:Bool) {
        questionText=text
        answer=correctAnswer
    }
    
}
