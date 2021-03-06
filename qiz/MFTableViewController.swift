//
//  MFTableViewController.swift
//  Quiz_PetroKov
//
//  Created by administrator on 09.04.16.
//  Copyright © 2016 PetroKov_LSR_P. All rights reserved.
//

import UIKit

class MFTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    //MODEL
    //создаем массив элементов. это - замыкание. Обычный список
    var model1:[String] = {
        var aLotOfStrings = "Любой текст бла-бла-бла MFTable ViewController .swift Quiz PetroKov Nigga Palevo 1 2 3 4 5 6".componentsSeparatedByString(" ")
        print("Total items: \(aLotOfStrings.count)") // \(...) - выводит значение
        return aLotOfStrings
    }()
    //Для примера - секционированная табилца
    var model2: [[String]] = [["111", "222", "333"], ["444", "555"]]
    
    //    конструктор после загрузки
    override func viewDidLoad() {
        super.viewDidLoad()

        //становимя делегатами (обработчик событий) самих себя. Объект tableView с протоколом (итерфейсом) dataSource
        //для того, чтобы tableView мог наполнить себя элементами, о которых еще ничего не знает, нужно реализовать протокол
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

// поддержка протокола для UITableViewDataSource
extension MFTableViewController: UITableViewDataSource {
    //много optional методов, так что реазиуем избранные
    
    //вернуть количество строк в этом view
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("tableVeiw asked cells count")
        //return model.count //число ячеек соответствует числу строк
        return model2[section].count
    }
    
    //подготовить ячейку для вывода
    /*
     cellForRowAtIndexPath - название параметра
     indexPath - сам параметр
     : NSIndexPath - тип параметра
     */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //indexPath - содержит номер секции и номер ячейки
        print("tableView asked cell for \(indexPath)")
        
        let cellIdentifier = "basicStringCell"
        
        //запросить у TableView ячеку, прототип которой так назвается
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        //row - это номер строки, Это информация о строке на экране
        let stringIndex = indexPath.row
        let section = indexPath.section
        
        //вывод текста по индексу
        cell?.textLabel?.text = model2[section][stringIndex]
        return cell!
    }
    
    //Заголовок секции
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Секция \(section)"
    }
    
    //Количество секций
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return model2.count
    }
}