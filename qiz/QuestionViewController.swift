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
    
    //Список вопросов
    var questionList:[Question]? {//опциональная переменная, там может не быть значения
        //афтерсеттер, выполняется после установки переменной
        didSet {
            currentQuestion = questionList?.first
        }
    }
    //Текущий вопрос
    var currentQuestion:Question?{
        didSet{
            updateViews()
        }
    }
    
    //Получает ответы для вопроса
    var answers:[String]?{
        return currentQuestion?.answers
    }
    
    var totalPoints = 0;
    var currentQuestionIndex = 0;
    
    //вызывается, когда контроллер загрузил View
    override func viewDidLoad() {
        super.viewDidLoad()
        //отвечает за то, как и что показывать
        tableView.dataSource = self
        
        //отвечает за то, что делать при возникновении различных событий
        tableView.delegate = self
        
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
    
    //Обновляет отображение при получении вопроса
    func updateViews()
    {
        //настроили картинку
        imageView.image = currentQuestion?.image
        //задали вопрос
        label.text = currentQuestion?.question
        //перезаполнить tableView
        tableView.reloadData()
    }
}

//Расширение для поддержки отображения данных
extension QuestionViewController:UITableViewDataSource{
    //это будет список ответов
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers?.count ?? 0 //если вдруг answersCount не существует, то вернется 0
    }
    
    //подготовить ячейку для вывода
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")!
        cell.textLabel?.text = answers?[indexPath.row]
        cell.detailTextLabel?.text = isAnswerAtIndexIsCorrect(indexPath) ? "Тыкай сюда!" : ""
        return cell
    }
    
    //проверяет, верный ли ответ по данному индексу
    func isAnswerAtIndexIsCorrect(index: NSIndexPath)-> Bool{
        return currentQuestion?.isCorrectAnswer(answers?[index.row]) ?? false
    }
}

//Расширение для обработки событий нажатия и прочее
extension QuestionViewController:UITableViewDelegate{
    
    //событие выделения ячейки
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if isAnswerAtIndexIsCorrect(indexPath){
            totalPoints += 1
        }
        currentQuestionIndex += 1
        guard currentQuestionIndex < questionList?.count else {
            print("DEAD")
            return
        }
        
        currentQuestion = questionList?[currentQuestionIndex]
        
        
    }
}