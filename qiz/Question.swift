//
//  Question.swift
//  Quiz_PetroKov
//
//  Created by administrator on 09.04.16.
//  Copyright © 2016 PetroKov_LSR_P. All rights reserved.
//

import UIKit

//Объявлем структуру, потому что ничего не надо будет наследовать
struct Question {
    //описываем поля JSON
    let question:String
    let answers:[String] //массив
    let correctAnswer:String
    private let imageName:String
    
    //Вычисляемое поле
    var image:UIImage?{
        return UIImage(named: imageName)
    }
    
    //конструктор
    init(json:[String:AnyObject]){ //можно было NSDictionary
        
        //нужно привести к типу данных, так как непонятно что там
        question = json["question"] as! String
        answers = json["answers"] as! [String]
        correctAnswer = json["correctAnswer"] as! String
        imageName = json["image"] as! String
    }
    
    //Проверка ответа на правильность
    func isCorrectAnswer(answer:String?)->Bool{
        guard answer != nil else {
            return false
        }
        
        return correctAnswer == answer
    }
}
