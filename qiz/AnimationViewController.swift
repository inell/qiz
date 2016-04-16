//
//  AnimationViewController.swift
//  Quiz_PetroKov
//
//  Created by Admin on 16.04.16.
//  Copyright © 2016 PetroKov_LSR_P. All rights reserved.
//

import UIKit

class AnimationViewController: UIViewController {

    @IBOutlet weak var firshView: UIView!
    @IBOutlet weak var secondView: UIImageView!
    @IBOutlet weak var secondViewToGreetingSpace: NSLayoutConstraint!
    @IBOutlet weak var watchInCinemaCeterX: NSLayoutConstraint!
    @IBOutlet weak var wathLabel: UILabel!
    @IBOutlet weak var phrase: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//         Простая анимация доступна для следующих параметров UIView и его наследников:
//        1. alpha - прозрачность
//        2. Положение и размер
//        3. Цвет фона
//        4. transform - структруа, которая определяет положение, вращение и масштаб вьюхи. С autolayout - внимательно
    }
    
    //здесь начнем анимацию
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.prepareForAnimation()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.animateAppeating()
    }
    
    // MARK: - Animation
    
    //подготовка анимации
    func prepareForAnimation(){
        secondView.alpha = 0;
        firshView.backgroundColor = UIColor.greenColor()
        
        //играемся с constrains
        secondViewToGreetingSpace.constant = -40
        //уедем на всю ширину вьюхи в сторону
        phrase.constant = view.bounds.width
        watchInCinemaCeterX.constant = view.bounds.width
    }
    //сама анимация
    func animateAppeating(){
        //Это замыкание. То, что внутри () -> Void, будет выполняться в течение 0.3 сек
        UIView.animateWithDuration(0.3) { () -> Void in
            self.secondView.alpha = 1;
            self.firshView.backgroundColor = UIColor.yellowColor()
            
            self.secondViewToGreetingSpace.constant = 20
            self.phrase.constant = 0
            
            //Если меняются какие-либо constrains, то можно пнуть вьюуху все пересчитать
            self.view.layoutIfNeeded()
        }
        
        //еще одна анимация
//        UIViewAnimationOptions.CurveEaseInOut - плавно начать, плавно закончить
//        UIViewAnimationOptions.CurveEaseIn - начать плавно, закончить резко
        UIView.animateWithDuration(0.3,
            delay: 0.5,
            options: UIViewAnimationOptions.CurveEaseIn,
            animations: { () -> Void in
                self.watchInCinemaCeterX.constant = -10;
                self.view.layoutIfNeeded()
            }) { a in
                //этот параметр, который передается в конце анимации, озанчает, завршилась ли вызывающая анимация
                //по завершении этого блока анимации будет вызвана другая анимация
                UIView.animateWithDuration(0.5,
                    delay: 0,
                    options: [.Repeat, .Autoreverse], //.Repeat, .Autoreverse работают только с геометрией
                    animations: { () -> Void in
                        self.watchInCinemaCeterX.constant = 15
                        self.wathLabel.textColor = UIColor.greenColor()
                        //немного вращения =) 
                        self.wathLabel.transform = CGAffineTransformMakeRotation(CGFloat(M_PI) / CGFloat(180) * CGFloat(20))
                        
                        self.view.layoutIfNeeded()
                    }, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
