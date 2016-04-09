//
//  QuestionViewController.swift
//  Quiz_PetroKov
//
//  Created by administrator on 09.04.16.
//  Copyright © 2016 PetroKov_LSR_P. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var questionList:[Question]? {//опциональная переменная, там может не быть значения
        //афтерсеттер
        didSet {
            currentQuestion = questionList?.first
        }
    }
    var currentQuestion:Question?{
        didSet{
            updateViews()
        }
    }
    
    //вызывается, когда контроллер загрузил View
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
    }

    func loadData(){
        let fileName = "cinema"
        let fileExt = "json"
        //запросить у Bundle (хранилища) конкретный файл
        let pathToVictineFile = NSBundle.mainBundle().pathForResource(fileName, ofType: fileExt)! //если файла нет, будем падать
        
        //считаем данные из файла. Там содержатся любые данные. Более ничего неизвестно
        let data = NSData(contentsOfFile: pathToVictineFile)! //тоже развернем данные, ну потому что стопудово должно жбыть
        
        print(data)
        
        //try пишется перед методом, который может выкинуть exception
        //try! - гарантируем, что данне будут корреткро считаны
        //try? - если ничего не запишется, будет просо пусто
        let json = try! NSJSONSerialization.JSONObjectWithData(data, options: [])
        
        print ("Содержимое \(json)")
        
        //json может быть что угодно, поэтому приводим его к коллекции
        //представлили, что JSON - это та самая коллекция Строка -> Любой объект
        guard let questionJson = json as? [String:AnyObject],
            //если это так, то считаем из questionJson содержимое и
            //если это окажется массив, в котором лежит коллекуии вида String:AnyObject, то окей
            let questionsToParse = questionJson["questions"] as? [ [String:AnyObject] ] else {
                print("Fail to load dataModel")
                return
        }
        
        //наш новый массив с вопросами
        //map преобразовывает массив одного типа данных в массив другого типа
        // in - применяется для каждого элемента
        let questionModels = questionsToParse.map { json -> Question in
            let parsedModel = Question(json: json)
            return parsedModel
        }
        
        print("Получили модель\n\(questionModels)")
        
        questionList = questionModels
    }
    
    func updateViews()
    {
        imageView.image = currentQuestion?.image
        
        label.text = currentQuestion?.question
        
    }
}
