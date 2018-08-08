//
//  WaitingPeopleCollectionViewCell.swift
//  The Genius
//
//  Created by JunsangYu on 04/08/2018.
//  Copyright © 2018 votoserver. All rights reserved.
//

import UIKit

class WaitingPeopleCollectionViewCell: UICollectionViewCell {
    var mainView: UIView!
    var imgView: UIImageView!
    var textLbl: UILabel!
    
    func setupUI() {
        //mainView 설정
        self.mainView = UIFunc.view(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        //뷰 width, height 변수 지정
        let (width, height) = UIFunc.getPos(view: self.mainView)
        //뷰 생성및 위치설정
        self.imgView = UIFunc.imgView(x: width * 0.1, y: height * 0.05, width: width * 0.8, height: height * 0.6, img: #imageLiteral(resourceName: "card_picture"))
        //뷰 세부설정
        self.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        self.mainView.backgroundColor = UIColor.white
        self.mainView.layer.cornerRadius = 5.0
        self.imgView.contentMode = .scaleAspectFit
        
        self.textLbl = UIFunc.lbl(x: width * 0.1, y: height * 0.5, width: width * 0.8, height: height * 0.6, text: "test")
        self.textLbl.textAlignment = .center
        self.textLbl.font = UIFont(name: "NanumSquareRoundL", size: 15)
        
        //뷰 add
        self.addSubview(mainView)
        self.mainView.addSubview(imgView)
        self.mainView.addSubview(textLbl)
    }
    func setup() {
        setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
