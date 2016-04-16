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
    }
    //сама анимация
    func animateAppeating(){
        //Это замыкание. То, что внутри () -> Void, будет выполняться в течение 0.3 сек
        UIView.animateWithDuration(0.3) { () -> Void in
            self.secondView.alpha = 1;
            self.firshView.backgroundColor = UIColor.yellowColor()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
