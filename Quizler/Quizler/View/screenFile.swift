//
//  screenFile.swift
//  Quizler
//
//  Created by Sakthivel Balakrishnan on 25/08/18.
//  Copyright © 2018 Sakthivel Balakrishnan. All rights reserved.
//

import UIKit

class screenFile:UIViewController{
    let allQuestions=QuestionBank()
    var questionNumber:Int=0
    var score:Int=0
    @objc func callController(sender:UIButton!){
        var answerReceived:Bool
        if(questionNumber<allQuestions.list.count){
            if(sender.tag==1){
                answerReceived=true
            }
            else{
                answerReceived=false
            }
            if(allQuestions.list[questionNumber].answer==answerReceived){
                ProgressHUD.showSuccess("Correct")
                score+=1
                Score.text="Score=\(score)"
            }
            else{
                ProgressHUD.showError("Wrong")
            }
            questionNumber+=1
            
            setQuestion()
        }
        if(questionNumber==allQuestions.list.count){
            let alert=UIAlertController(title: "COMPLETE", message: "Do you like to restart the quiz", preferredStyle: .alert)
            let restart=UIAlertAction(title: "Restart", style: .default,handler: { (UIAlertAction) in
                self.questionNumber=0
                self.score=0
                self.Score.text="Score=\(0)"
                self.setQuestion()
            })
            alert.addAction(restart)
            present(alert,animated: true,completion: nil)
        }
    }
    var questionLabel:UILabel={
        var label=UILabel()
        label.translatesAutoresizingMaskIntoConstraints=false
        label.textColor=UIColor.white
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 10
        label.font=label.font.withSize(25)
        return label
    }()
    let trueButton:UIButton={
        let button=UIButton()
        button.setTitle("True", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints=false
        button.backgroundColor=UIColor.green
        button.tag=1
        button.addTarget(self, action: #selector(callController), for: .touchUpInside)
        return button
    }()
    let falseButton:UIButton={
        let button=UIButton()
        button.setTitle("False", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints=false
        button.backgroundColor=UIColor.red
        button.tag=2
        button.addTarget(self, action: #selector(callController), for: .touchUpInside)
        return button
    }()
    let progress:UIProgressView={
        let progress=UIProgressView(progressViewStyle: UIProgressViewStyle.default)
        progress.translatesAutoresizingMaskIntoConstraints=false
        progress.progress=0
        progress.tintColor=UIColor.yellow
        return progress
    }()
    var numberQuestion:UILabel={
        let label=UILabel()
        label.translatesAutoresizingMaskIntoConstraints=false
        label.textColor=UIColor.white
        label.text="0/13"
        return label
    }()
    var Score:UILabel={
        let label=UILabel()
        label.translatesAutoresizingMaskIntoConstraints=false
        label.textColor=UIColor.white
        label.text="Score:\(0)"
        return label
    }()
    func setupQuestion(){
        view.addSubview(questionLabel)
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            questionLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            questionLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            questionLabel.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5)
            ])
    }
    func setUpStack(){
        let stack=UIStackView(arrangedSubviews: [trueButton,falseButton])
        stack.translatesAutoresizingMaskIntoConstraints=false
        stack.axis = .horizontal
        stack.spacing = view.frame.width/10
        stack.distribution = .fillEqually
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stack.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.7),
            stack.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: view.frame.height/8),
            stack.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1)
            ])
    }
    func setUpProgress(){
        view.addSubview(progress)
        NSLayoutConstraint.activate([
            progress.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            progress.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            progress.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            progress.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.03)
            ])
    }
    func setUpButton(){
        view.addSubview(numberQuestion)
        NSLayoutConstraint.activate([
            numberQuestion.bottomAnchor.constraint(equalTo: progress.topAnchor),
            numberQuestion.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor)
            ])
        view.addSubview(Score)
        NSLayoutConstraint.activate([
            Score.bottomAnchor.constraint(equalTo: progress.topAnchor),
            Score.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
            ])
    }
    func setQuestion(){
        if(questionNumber<allQuestions.list.count){
            questionLabel.text=allQuestions.list[questionNumber].questionText
            numberQuestion.text="\(questionNumber+1)/\(allQuestions.list.count)"
            progress.progress=Float(questionNumber+1)/Float(allQuestions.list.count)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor=UIColor.blue
        setupQuestion()
        setUpStack()
        setUpProgress()
        setUpButton()
        setQuestion()
    }
}
