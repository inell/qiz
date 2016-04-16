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
// MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView1()
        self.setupImageView()
    }
    
// MARK: - Setup
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
    
// MARK: - ImageView
    func setupImageView(){
        imageView = UIImageView(image: UIImage(named: "fourthQuestion2")!)
        self.view.addSubview(self.imageView)
        //Позиционируемся по центру
        imageView.center = CGPoint(x: CGRectGetMidX(view.frame), y: CGRectGetMidY(view.frame))
        
        //включаеся интерактивнсть в вьюхи
        imageView.userInteractionEnabled = true
        
        //жест перемещения
        let panGesture = UIPanGestureRecognizer(
            target: self,
            action: "translateStalone:")
        imageView.addGestureRecognizer(panGesture)
        
        //жест зума
        let pichGesture = UIPinchGestureRecognizer(
            target: self,
            action: "scaleStaloneFires:")
        imageView.addGestureRecognizer(pichGesture)
        
        //жест вращения
        let rotateGesture = UIRotationGestureRecognizer(
            target: self,
            action: "rotateStaloneFired:")
        imageView.addGestureRecognizer(rotateGesture)
        
        //Станем делегатом для распознателя жестов, чтобы работали одновременно
        panGesture.delegate = self
        rotateGesture.delegate = self
        pichGesture.delegate = self
    }
    
    //Будем двигать Сталлоне (imageView)
    func translateStalone(gesture:UIPanGestureRecognizer){
        //Если жест работает и палец убран от экрана
        if (gesture.state == .Changed || gesture.state == .Ended){
            //считаем премещение по imageView
            var translation = gesture.translationInView((imageView))
            print("translated to \(translation)")
            
            //сместим картинку на это перемещение
            translation.x += imageView.center.x
            translation.y += imageView.center.y
            imageView.center = translation
            
            //Обнуляем накопление перемещения в жесте, чтобы не было лишнего наращения
            gesture.setTranslation(CGPointZero, inView:imageView)
        }
    }
    
    //будем масштабировать Сталлоне
    func scaleStaloneFires(gesture:UIPinchGestureRecognizer){
        switch gesture.state {
        case .Ended, .Changed :
            let scale = gesture.scale
            print("scale \(scale)")
            
            //трансформация, которую нужно выполнить
            let transformToApply = CGAffineTransformMakeScale(scale, scale)
            //границы, которые трансформированы
            let bounds = CGRectApplyAffineTransform(imageView.bounds, transformToApply)
            imageView.bounds = bounds
            
            //Сбрасываем масштаб
            gesture.scale = 1
        default: break
        }
    }
    
    //будем вращать Сталлонне
    func rotateStaloneFired(gesture:UIRotationGestureRecognizer){
        switch gesture.state{
        case .Ended, .Changed:
            let rotation = gesture.rotation
            print("rotation \(rotation)")
            
            imageView.transform = CGAffineTransformRotate(imageView.transform, rotation)
            //Сбрасываем ротэйшн
            gesture.rotation = 0
        default: break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //это событие, перетянутое со storyboard
    @IBAction func longGesturePressed(sender: UILongPressGestureRecognizer) {
        sender.view?.backgroundColor = UIColor.blackColor()
    }
}

extension GesturesViewController:UIGestureRecognizerDelegate{
    //Определяет, могут ли обработчики жестов работать одновременно
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
