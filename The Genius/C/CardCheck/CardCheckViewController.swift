//
//  CardCheckViewController.swift
//  The Genius
//
//  Created by JunsangYu on 05/08/2018.
//  Copyright © 2018 votoserver. All rights reserved.
//

import UIKit
import SDWebImage

class CardCheckViewController: UIViewController {
    var mainView: UIView!
    var cardView: UIView!
    var cardImgview: UIImageView!
    var confirmBtn: UIButton!
    var cardLabelView: UIView!
    var cardNameLbl: UILabel!
    var cardIncomeLbl: UILabel!
    var cardWinningConditionLbl: UILabel!
    var cardLosingConditionLbl: UILabel!
    var cardDetailLbl: UILabel!
    
    func setupUI() {
        //mainView 설정
        self.mainView = UIFunc.view(x: 0, y: UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.height ?? 0), width: self.view.frame.width, height: self.view.frame.height - (UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.height ?? 0)))
        self.view.addSubview(mainView)
        //뷰 width, height 변수 지정
        let (width, height) = UIFunc.getPos(view: self.mainView)
        //뷰 생성및 위치설정
        self.cardView = UIFunc.view(x: width * 0.1, y: height * 0.1, width: width * 0.8, height: height * 0.65)
        let (cardWidth, cardHeight) = UIFunc.getPos(view: cardView)
        self.cardImgview = UIFunc.imgView(x: cardWidth * 0.2, y: cardHeight * 0.05, width: cardWidth * 0.6, height: cardHeight * 0.5, img: #imageLiteral(resourceName: "ㅇㄹㅇㄹㅇㄹ"))
        self.cardLabelView = UIFunc.view(x: cardWidth * 0.1, y: cardHeight * 0.6, width: cardWidth * 0.8, height: cardHeight * 0.35)
        let (cardLabelWidth, cardLabelHeight) = UIFunc.getPos(view: cardLabelView)
        self.cardNameLbl = UIFunc.lbl(x: 0, y: 0, width: cardLabelWidth, height: cardLabelHeight * 0.2, text: "이름")
        self.cardIncomeLbl = UIFunc.lbl(x: 0, y: cardLabelHeight * 0.5, width: cardLabelWidth * 0.5, height: cardLabelHeight * 0.1, text: "연봉: ")
        self.cardWinningConditionLbl = UIFunc.lbl(x: cardLabelWidth * 0.4, y: cardLabelHeight * 0.25, width: cardLabelWidth * 0.6, height: cardLabelHeight * 0.35, text: "승리조건: ")
        self.cardLosingConditionLbl = UIFunc.lbl(x: cardLabelWidth * 0.4, y: cardLabelHeight * 0.6, width: cardLabelWidth * 0.6, height: cardLabelHeight * 0.15, text: "패배조건: ")
        self.cardDetailLbl = UIFunc.lbl(x: 0, y: cardLabelHeight * 0.7, width: cardLabelWidth, height: cardLabelHeight * 0.4, text: "특이사항: ")
        self.confirmBtn = UIFunc.btn(x: width * 0.1, y: height * 0.8, width: width * 0.8, height: height * 0.075, title: "확인")
        //뷰 세부설정
        self.cardView.backgroundColor = UIColor(rgb: 0xd8c38d)
        self.cardView.dropShadow(color: UIColor(rgb: 0x000000), opacity: 0.3, offSet: CGSize(width: 0, height: 0), radius: self.confirmBtn.frame.height * 0.5, scale: true)
        self.cardNameLbl.font = UIFont(name: "SeoulNamsanB", size: 30)
        self.cardNameLbl.textColor = UIColor(rgb: 0x444444)
        self.cardNameLbl.textAlignment = .center
        
        self.cardIncomeLbl.font = UIFont(name: "SeoulNamsanB", size: 15)
        self.cardIncomeLbl.textColor = UIColor(rgb: 0x444444)
        
        self.cardWinningConditionLbl.adjustsFontSizeToFitWidth = true
        self.cardWinningConditionLbl.minimumScaleFactor = CGFloat(0.5)
        self.cardWinningConditionLbl.font = UIFont(name: "SeoulNamsanB", size: 14)
        self.cardWinningConditionLbl.textColor = UIColor(rgb: 0x444444)
        self.cardWinningConditionLbl.lineBreakMode = .byWordWrapping
        self.cardWinningConditionLbl.numberOfLines = 0
        
        
        self.cardLosingConditionLbl.adjustsFontSizeToFitWidth = true
        self.cardLosingConditionLbl.minimumScaleFactor = CGFloat(0.5)
        self.cardLosingConditionLbl.font = UIFont(name: "SeoulNamsanB", size: 14)
        self.cardLosingConditionLbl.textColor = UIColor(rgb: 0x444444)
        self.cardLosingConditionLbl.lineBreakMode = .byWordWrapping
        self.cardLosingConditionLbl.numberOfLines = 0
        
        
        self.cardDetailLbl.font = UIFont(name: "SeoulNamsanB", size: 15)
        self.cardDetailLbl.textColor = UIColor(rgb: 0x444444)
        self.cardDetailLbl.lineBreakMode = .byWordWrapping
        self.cardDetailLbl.numberOfLines = 0
        self.cardDetailLbl.adjustsFontSizeToFitWidth = true
        self.cardDetailLbl.minimumScaleFactor = 0.5
        self.confirmBtn.backgroundColor = UIColor(rgb: 0x8e8e8e)
        self.confirmBtn.layer.cornerRadius = self.confirmBtn.frame.height * 0.5
        self.confirmBtn.titleLabel?.font = UIFont(name: "NanumSquareRoundL", size: 30)
        self.confirmBtn.setTitleColor(UIColor(rgb: 0x000000), for: .normal)
        self.confirmBtn.dropShadow(color: UIColor(rgb: 0x000000), opacity: 0.3, offSet: CGSize(width: 1, height: 1), radius: self.confirmBtn.frame.height * 0.5, scale: true)
        //뷰 add
        self.mainView.addSubview(cardView)
        self.mainView.addSubview(confirmBtn)
        self.cardView.addSubview(cardImgview)
        self.cardView.addSubview(cardLabelView)
        self.cardLabelView.addSubview(cardNameLbl)
        self.cardLabelView.addSubview(cardIncomeLbl)
        self.cardLabelView.addSubview(cardWinningConditionLbl)
        self.cardLabelView.addSubview(cardLosingConditionLbl)
        self.cardLabelView.addSubview(cardDetailLbl)
    }
    
    func setup() {
        setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        cardNameLbl.text = API.currentUser?.game_data.name
        
        cardWinningConditionLbl.append(API.currentUser?.game_data.win_condition.joined(separator: "&"))
        cardLosingConditionLbl.append(API.currentUser?.game_data.lose_condition)
        
        cardDetailLbl.append(API.currentUser?.game_data.uniqueness.joined(separator: "&"))
        
        cardIncomeLbl.append(API.currentUser?.game_data.pay)
        
        if let profileLink = API.currentUser?.game_data.profile {
            cardImgview.sd_setImage(with: URL(string: "\(API.base_url)\(profileLink)"))
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
