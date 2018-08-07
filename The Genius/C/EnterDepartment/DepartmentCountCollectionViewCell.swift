//
//  DepartmentCountCollectionViewCell.swift
//  The Genius
//
//  Created by JunsangYu on 06/08/2018.
//  Copyright © 2018 votoserver. All rights reserved.
//

import UIKit

class DepartmentCountCollectionViewCell: UICollectionViewCell {
    var num: Int!
    
    var mainView: UIView!
    var numLbl: UILabel!
    
    func setupUI() {
        //mainView 설정
        self.mainView = UIFunc.view(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        self.addSubview(mainView)
        //뷰 width, height 변수 지정
        let (width, height) = UIFunc.getPos(view: self.mainView)
        //뷰 생성및 위치설정
        self.numLbl = UIFunc.lbl(x: 0, y: 0, width: width, height: height, text: "1")
        //뷰 세부설정
        self.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        self.mainView.backgroundColor = UIColor.white
        self.mainView.layer.cornerRadius = 5.0
        self.numLbl.textAlignment = .center
        self.numLbl.font = UIFont(name: "NanumSquareRoundL", size: 30)
        //뷰 add
        self.mainView.addSubview(numLbl)
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
