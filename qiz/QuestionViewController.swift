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
    @IBOutlet var imageHeightConstraint: NSLayoutConstraint!
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
    
    //MARK: - ViewControoler Life Cycle
//    1. Инициализация. Вызвается при инициализации из Storyboard
    required init?(coder aDecoder:NSCoder){
        super.init(coder: aDecoder)
        print("init")
    }
//    2. Загрузка View
//    Если нужно сощдать все View из кода, то в нем их надо создавать, как-то накидывать друг на друга и настраивать.
//    Если ViewController был описан через Storyboard, то этот ментод переопределять не надо
    override func loadView() {
        super.loadView()
        print("loadView")
    }
    
//    3. Вызвается, когда все View котроллера загружены
//    В этот момент ViewCintroller еще не присутствует на экране.
//    Это - отличное место для инициализации данных, запуска длительных процессов.
//    В этот момент Views еще не приняли конечных положений.
//    Вызывается, когда контроллер загрузил View (вызывается только один раз)
    override func viewDidLoad() {
        print("viewDidLoad")
        super.viewDidLoad()
        //отвечает за то, как и что показывать
        tableView.dataSource = self
        
        //отвечает за то, что делать при возникновении различных событий
        tableView.delegate = self
        
        loadData()
        
    }
    
//   4. Вызывается, когда View сейчас отобразится на экране (вызывается каждый раз)
    override func viewWillAppear(animated: Bool) {
        //вернемся в начало викторины
        super.viewWillAppear(animated)
        currentQuestion = questionList?.first
        currentQuestionIndex = 0
        totalPoints = 0
        
        print("viewWillAppear")
    }
    
//    5. Вызвается, когда View появилось на экране.
//    Отличное место, чтобы запустить анимацию
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        print("viewDidAppear")
    }
    
//    6. View начинает изсчезать с экрана
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("viewWillDisappear")
    }
    
//    7. View полностью изчез
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        print("viewDidDisappear")
    }
    
//    8. У любого класса есть этот метод
    deinit{
        print("deinit")
    }
    
//    Когда приложение полуает сообщение о нехватке памяти
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("didReceiveMemoryWarning")
    }

    // MARK: - Setup
    
    func loadData(){
        let fileName = "cinema"
        let fileExt = "json"
        //запросить у Bundle (хранилища) конкретный файл
        let pathToVictineFile = NSBundle.mainBundle().pathForResource(fileName, ofType: fileExt)! //если файла нет, будем падать
        
        //считаем данные из файла. Там содержатся любые данные. Более ничего неизвестно
        let data = NSData(contentsOfFile: pathToVictineFile)! //тоже развернем данные, ну потому что стопудово должно жбыть
        
        //print(data)
        
        //try пишется перед методом, который может выкинуть exception
        //try! - гарантируем, что данне будут корреткро считаны
        //try? - если ничего не запишется, будет просо пусто
        let json = try! NSJSONSerialization.JSONObjectWithData(data, options: [])
        
        //print ("Содержимое \(json)")
        
        //в json может быть что угодно, поэтому приводим его к коллекции
        //представили, что JSON - это та самая коллекция Строка -> Любой объект
        guard let questionJson = json as? [String:AnyObject],
            //если это так, то считаем из questionJson содержимое и
            //если это окажется массив, в котором лежит коллекции вида String:AnyObject, то окей все
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
        
        //print("Получили модель\n\(questionModels)")
        
        questionList = questionModels
    }

    //Обновляет отображение при получении вопроса
    func updateViews()
    {
        self.updateImage()
        
        self.updateLabel()
        //перезаполнить tableView
        tableView.reloadData()
    }
    
    //обновление картинки вопроса
    func updateImage(){
//        так как высота ответов и картинки задана =conctrains, то при изменении одного колбасит и другого
        //1. Уменьшаем картинку до 0
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.imageHeightConstraint.constant = 0
            self.view.layoutIfNeeded()
            }) { _ in
                //2. Заменим изборажение
                self.imageView.image = self.currentQuestion?.image
                
                //3. Растянем картинку обратно
                UIView.animateWithDuration(1.2,
                    delay: 0,
                    usingSpringWithDamping: 0.4, //0 - очень сильно колбасит струну; 1 - без колебаний
                    initialSpringVelocity: 3, //Относительная началная скорость изменения парметров
                    options: [],
                    animations: { () -> Void in
                        self.imageHeightConstraint.constant = 100
                        self.view.layoutIfNeeded()
                    },
                    completion: nil)
        }
        
    }
    
    //обновление текста вопроса
    func updateLabel(){
        
        UIView.animateWithDuration(0.4, delay: 0,
            options: [UIViewAnimationOptions.CurveEaseIn],
            animations: { () -> Void in
                self.label.transform = CGAffineTransformMakeTranslation(self.view.frame.width, 0)
            }) { (_) -> Void in
                //задали вопрос
                self.label.text = self.currentQuestion?.question
                self.label.transform = CGAffineTransformMakeTranslation( -self.view.frame.width, 0)
                // layoutIfNeeded() не нужно, потому что не меняли constrains
                
                UIView.animateWithDuration(0.4, delay: 0,
                    options: [UIViewAnimationOptions.CurveEaseOut],
                    animations: { (_) -> Void in
                        self.label.transform = CGAffineTransformIdentity
                    }, completion: nil)
        }
        
    }
    
    // MARK: -
    
    //Метод запускается при перехода на новый экран
    //Вызывается после performSegueWithIdentifier()
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        //проверили типизацию целевого контроллера и сразу записали в переменную
        if let newVC = segue.destinationViewController as? ResultViewController {
            //передади но новый view наш результат
            newVC.result = sender as! Int
        }
        
        //А можно еще и так
        /*
        if segue.identifier == "ShowResult" {
            let newVC = segue.destinationViewController as! ResultViewController
            newVC.result = sender as! Int
        }
        */
    }
}

// MARK: - UITableViewDataSource

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

// MARK: - UITableViewDelegate

//Расширение для обработки событий нажатия и прочее
extension QuestionViewController:UITableViewDelegate{
    
    //событие выделения ячейки
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if isAnswerAtIndexIsCorrect(indexPath){
            totalPoints += 1
        }
        currentQuestionIndex += 1
        guard currentQuestionIndex < questionList?.count else {
            
            let rating = Int(Double(totalPoints) / Double(questionList!.count) * 100)
            
            //переход на новый экран
            performSegueWithIdentifier("ShowResult", sender: rating)
            return
        }
        
        currentQuestion = questionList?[currentQuestionIndex]
        
        
    }
}