//
//  GesturesViewController.swift
//  Quiz_PetroKov
//
//  Created by Admin on 16.04.16.
//  Copyright © 2016 PetroKov_LSR_P. All rights reserved.
//

import UIKit

class GesturesViewController: UIViewController {

//    добавим вьюхи программно
    //знак ! означает, что мы обещаем: при первом обращении view1 уже будет существовать
    var view1:UIView!
    var imageView:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView1()
    }
    
    func setupView1(){
        view1 = UIView(frame: CGRect(x: 40, y: 50, width: 200, height: 300))
        view1.backgroundColor = UIColor(patternImage: UIImage(named: "fourthQuestion4")!)
        // self.view - основня вьюха каждого контроллера
        
        self.view.addSubview(self.view1)
        
        //спсоб для старого xcode
        let tapGesture = UITapGestureRecognizer(
            target: self,               //к кому обращаться
            action: "tapGestureFired:") //какой метод вызвать (: - один передаваемй параметр, :: - два праметра и т.д.)
        //tapGestureFired:someAnotherParam, если func tapGestureFired(a:Int, someAnotherParam b:Int
        
        //накинем рекогнайзер
        view1.addGestureRecognizer(tapGesture)
        
        tapGesture.numberOfTapsRequired = 3     //тройное касание
        tapGesture.numberOfTouchesRequired = 2 //два пальца
    }
    
    //событие жеста
    func tapGestureFired(gesture:UITapGestureRecognizer){
        print("gestur fired \(gesture)")
        UIView.animateWithDuration(0.4) { () -> Void in
            //будем поворачивать view
            self.view1.transform = CGAffineTransformRotate(
                self.view1.transform, //какой трансформ будем поворачивать
                CGFloat(M_PI_4)         //на сколько ротировать
            )
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
