//
//  ResultViewController.swift
//  Quiz_PetroKov
//
//  Created by administrator on 09.04.16.
//  Copyright © 2016 PetroKov_LSR_P. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    var result = 0 {//from 0 to 100
        didSet{
            switch result {
//            case 0...100: //в диапазоне
//                return
            case let r where r < 0: //result записывается в r
                result = 0
            case let r where r > 100:
                result = 100
            default:
                return
            }
            
            // Можно еще и так, но это какой-то изврат:
            // case Int.min ..< 0 :- не включая ноль
            // case 101 ... Int.max :- включая 101
            // ... - включительно
            // ..< - невключительно
        }
    }
    
    @IBOutlet weak var resultLabel: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }

    func updateViews(){
        var text = ""
        switch result {
        case 0:
            text = "ПОТРАЧЕНО"
        case 1 ... 30:
            text = "Слабовато"
        case 31 ... 55:
            text = "Not bad"
        case 56 ... 99:
            text = "Отлично"
        case 100:
            text = "Точно бот!"
        default:
            print("Не учтено значение рейтинга \(result)")
            text = "Error"
        }
        resultLabel.text = text
    }
    
    //Обработка освобождения ресурсов, когда ОС сообщаает, что мало памяти. Тогда приложение наверное не вышибут
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
