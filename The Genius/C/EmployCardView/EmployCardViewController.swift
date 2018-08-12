//
//  EmployCardViewController.swift
//  The Genius
//
//  Created by JunsangYu on 31/07/2018.
//  Copyright © 2018 votoserver. All rights reserved.
//

import UIKit

class EmployCardViewController: UIViewController {
    var mainView: UIScrollView!
    var cardView: UIView!
    var employLbl: UILabel!
    var employImgview: UIImageView!
    var employNameTxtfield: UITextField!
    var employNameTxtfieldLine: UIView!
    var nextBtn: UIButton!
    
    func setupUI() {
        //mainView 설정
        self.mainView = UIFunc.scroll(x: 0, y: UIApplication.shared.statusBarFrame.height + (navigationController?.navigationBar.frame.height ?? 0), width: view.frame.width, height: view.frame.height - (UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.height ?? 0)), contentSize: CGSize(width: view.frame.width, height: view.frame.height - (UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.height ?? 0))))
        //뷰 width, height 변수 지정
        let (width, height) = UIFunc.getPos(view: mainView)
        //뷰 생성및 위치설정
        self.cardView = UIFunc.view(x: width * 0.1, y: height * 0.1, width: width * 0.8, height: height * 0.65)
        self.nextBtn = UIFunc.btn(x: width * 0.1, y: height * 0.8, width: width * 0.8, height: height * 0.075, title: "다음")
        let (cardWidth, cardHeight) = UIFunc.getPos(view: self.cardView) // 카드뷰 변수 지정
        self.employLbl = UIFunc.lbl(x: cardWidth * 0.3, y: cardHeight * 0.1, width: cardWidth * 0.4, height: cardHeight * 0.1, text: "사원증")
        self.employImgview = UIFunc.imgView(x: cardWidth * 0.275, y: cardHeight * 0.3, width: cardWidth * 0.45, height: cardHeight * 0.4, img: #imageLiteral(resourceName: "square_choose_a_picture"))
        self.employNameTxtfield = UIFunc.txtField(x: cardWidth * 0.2, y: cardHeight * 0.8, width: cardWidth * 0.6, height: cardHeight * 0.1, placeHolder: "이름을 입력하세요")
        self.employNameTxtfieldLine = UIFunc.view(x: cardWidth * 0.2, y: cardHeight * 0.9 - 5, width: cardWidth * 0.6, height: 1.0)
        //뷰 세부설정
        self.view.backgroundColor = UIColor(rgb: 0xe6e6e6)
        self.cardView.backgroundColor = UIColor(rgb: 0xffffff)
        self.cardView.layer.cornerRadius = self.cardView.frame.width * 0.015
        self.cardView.dropShadow(color: UIColor.black, opacity: 0.3, offSet: CGSize(width: -0.2, height: 3.3), radius: 1, scale: true)
        self.employLbl.textAlignment = NSTextAlignment.center
        self.employLbl.font = UIFont(name: "NanumSquareRoundL", size: 32)
        self.employImgview.contentMode = .scaleAspectFit
        self.employNameTxtfield.delegate = self
        self.employNameTxtfieldLine.backgroundColor = UIColor(rgb: 0x000000)
        self.nextBtn.backgroundColor = UIColor(rgb: 0x8e8e8e)
        self.nextBtn.layer.cornerRadius = self.nextBtn.frame.height * 0.5
        self.nextBtn.titleLabel?.font = UIFont(name: "NanumSquareRoundL", size: 30)
        self.nextBtn.setTitleColor(UIColor(rgb: 0x000000), for: .normal)
        self.nextBtn.dropShadow(color: UIColor(rgb: 0x000000), opacity: 0.2, offSet: CGSize(width: 0, height: 5), radius: self.nextBtn.frame.height * 0.5, scale: true)
        
        self.nextBtn.addTarget(self, action: #selector(login), for: .touchUpInside)
        //뷰 add
        self.view.addSubview(mainView)
        self.mainView.addSubview(cardView)
        self.cardView.addSubview(employLbl)
        self.cardView.addSubview(employImgview)
        self.cardView.addSubview(employNameTxtfield)
        self.cardView.addSubview(employNameTxtfieldLine)
        self.mainView.addSubview(nextBtn)
    }
    func setup() {
        setupUI()
        self.registerForKeyboardNotifications()
        self.tapHideKeyboard()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    @objc func login(_ sender: UIButton) {

    }
}

extension EmployCardViewController {
    //키보드 올라왔을때 다른곳 누르면 키보드 내려가는 동작
    func tapHideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.mainView.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        self.mainView.endEditing(true)
    }
    
    //키보드 올라왔을때 스크롤뷰 올리는것 or 반대
    func registerForKeyboardNotifications() {
        // 옵저버 등록
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    func unregisterForKeyboardNotifications() {
        // 옵저버 등록 해제
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        //키보드 올라갔을때
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            self.mainView.contentSize = CGSize(width: mainView.frame.width, height: mainView.frame.height + keyboardHeight)
            self.mainView.setContentOffset(CGPoint(x: mainView.frame.origin.x, y: mainView.frame.origin.y + keyboardHeight), animated: false)
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        //키보드 내려갔을때
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            self.mainView.contentSize = CGSize(width: mainView.frame.width, height: mainView.frame.height - keyboardHeight)
        }
    }
}

extension EmployCardViewController: UITextFieldDelegate {
    //return키 눌렀을때 동작
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.mainView.endEditing(true)
        return false
    }
}
