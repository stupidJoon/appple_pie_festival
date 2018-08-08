//
//  MainViewController.swift
//  The Genius
//
//  Created by JunsangYu on 02/08/2018.
//  Copyright © 2018 votoserver. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    var mainView: UIView!
    
    func setupUI() {
        //mainView 설정
        self.mainView = UIFunc.view(x: 0, y: UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.height ?? 0), width: self.view.frame.width, height: self.view.frame.height - (UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.height ?? 0)))
        self.view.addSubview(mainView)
        //뷰 width, height 변수 지정
        let (width, height) = UIFunc.getPos(view: self.mainView)
        //뷰 생성및 위치설정
        
        //뷰 세부설정
        
        //뷰 add
        
    }
    func setup() {
        setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        API.User.fetch(withToken: "2TSka0qETEQs9ZlouQcVX3G2F5tfmlkZ") { (response,status) in
            guard let user = response,status != 401 else {
                print("Can't find user!")
                return
            }
            API.User.set(withUser: user)
            let vc = CardCheckViewController()
            self.present(vc, animated: true, completion: {
                return
            })
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
