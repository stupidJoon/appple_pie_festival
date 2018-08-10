//
//  MemberCollectionViewCell.swift
//  The Genius
//
//  Created by JunsangYu on 10/08/2018.
//  Copyright © 2018 votoserver. All rights reserved.
//

import UIKit

class MemberCollectionViewCell: UICollectionViewCell {
    var num: Int!
    
    var mainView: UIView!
    var numLbl: UILabel!
    var imgView: UIImageView!
    
    func setupUI() {
        //mainView 설정
        self.mainView = UIFunc.view(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        self.addSubview(mainView)
        //뷰 width, height 변수 지정
        let (width, height) = UIFunc.getPos(view: self.mainView)
        //뷰 생성및 위치설정
        self.imgView = UIFunc.imgView(x: width * 0.1, y: height * 0.05, width: width * 0.8, height: height * 0.6, img: #imageLiteral(resourceName: "card_picture"))
        //뷰 세부설정
        self.mainView.layer.cornerRadius = 5.0
        self.mainView.dropShadow(color: UIColor.black, opacity: 0.3, offSet: CGSize(width: 0, height: 0), radius: 2, scale: true)
        self.imgView.contentMode = .scaleAspectFit
        //뷰 add
        self.mainView.addSubview(imgView)
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
