//
//  QuestionViewController.swift
//  Quiz_PetroKov
//
//  Created by administrator on 09.04.16.
//  Copyright © 2016 PetroKov_LSR_P. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    //вызывается, когда контроллер загрузил View
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
    }

    func loadData(){
        let fileName = "cinema"
        let fileExt = "json"
        //запросить у Bundle (хранилища) конкретный файл
        let pathToVictineFile = NSBundle.mainBundle().pathForResource(fileName, ofType: fileExt)! //даже если фйла нет, будем падать
        
        //считаем данные из файла. Там содержатся любые данные. Более ничего неизвестно
        let data = NSData(contentsOfFile: pathToVictineFile)! //тоже развернем данные, ну потому что стопудово должно жбыть
        
        print(data)
        
        //try пишется перед методом, который может выкинуть exception
        //try! - гарантируем, что данне будут корреткро считаны
        //try? - если ничего не запишется, будет просо пусто
        let json = try! NSJSONSerialization.JSONObjectWithData(data, options: [])
        
        print ("Содержимое \(json)")
    }
}
