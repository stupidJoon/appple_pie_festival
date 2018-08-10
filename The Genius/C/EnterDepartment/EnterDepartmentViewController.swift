//
//  EnterDepartmentViewController.swift
//  The Genius
//
//  Created by JunsangYu on 06/08/2018.
//  Copyright © 2018 votoserver. All rights reserved.
//

import UIKit

class EnterDepartmentViewController: UIViewController {
    var mainView: UIView!
    var timeLbl: UILabel!
    var departmentCountCollection: UICollectionView!
    var memberView: UIView!
    var memberViewFrist: UIView!
    var memberImgviewFirst: UIImageView!
    var memberViewSecond: UIView!
    var memberImgviewSecond: UIImageView!
    var memberViewThird: UIView!
    var memberImgviewThird: UIImageView!
    var memberViewFourth: UIView!
    var memberImgviewFourth: UIImageView!
    var memberViewFifth: UIView!
    var memberImgviewFifth: UIImageView!
    
    var usersinroom:[LightUser] = []
    
    var waitingPeopleView: UIView!
    var waitingPeopleCollection: UICollectionView!
    
    var users:[LightUser] {
        return API.otherUsers
    }
    
    func setupUI() {
        //mainView 설정
        self.mainView = UIFunc.view(x: 0, y: UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.height ?? 0), width: self.view.frame.width, height: self.view.frame.height - (UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.height ?? 0)))
        
        
        
        self.waitingPeopleView.backgroundColor = UIColor(rgb: 0xffffff)
        self.waitingPeopleView.dropShadow(color: UIColor.black, opacity: 0.01, offSet: CGSize(width: 0, height: -2), radius: 1, scale: true)
        
        self.view.backgroundColor = UIColor.getColor(with: API.currentUser?.now_room ?? "인사")
        self.view.addSubview(mainView)
        //뷰 width, height 변수 지정
        let (width, height) = UIFunc.getPos(view: self.mainView)
        
        self.waitingPeopleView = UIFunc.view(x: 0, y: height * 0.65, width: width, height: height * 0.35)
        let (waitWidth, waitHeight) = UIFunc.getPos(view: waitingPeopleView)
        self.waitingPeopleCollection.backgroundColor = UIColor(rgb: 0xffffff)
        self.waitingPeopleCollection.dataSource = self
        self.waitingPeopleCollection.delegate = self
        
        //뷰 생성및 위치설정
        self.timeLbl = UIFunc.lbl(x: width * 0.3, y: height * 0.05, width: width * 0.4, height: height * 0.1, text: "10:00")
        self.departmentCountCollection = UIFunc.collection(x: width * 0.2, y: height * 0.15, width: width * 0.6, height: height * 0.1, cell: DepartmentCountCollectionViewCell.self, reuseIdentifier: "departmentCountCell")
        self.memberView = UIFunc.view(x: width * 0.15, y: height * 0.35, width: width * 0.7, height: height * 0.3)
        let (memberWidth, memberHeight) = UIFunc.getPos(view: memberView)
        self.memberViewFrist = UIFunc.view(x: memberWidth * 0.2, y: memberHeight * 0.05, width: memberWidth * 0.25, height: memberHeight * 0.45)
        self.memberViewSecond = UIFunc.view(x: memberWidth * 0.5, y: memberHeight * 0.05, width: memberWidth * 0.25, height: memberHeight * 0.45)
        self.memberViewThird = UIFunc.view(x: memberWidth * 0.05, y: memberHeight * 0.55, width: memberWidth * 0.25, height: memberHeight * 0.45)
        self.memberViewFourth = UIFunc.view(x: memberWidth * 0.35, y: memberHeight * 0.55, width: memberWidth * 0.25, height: memberHeight * 0.45)
        self.memberViewFifth = UIFunc.view(x: memberWidth * 0.65, y: memberHeight * 0.55, width: memberWidth * 0.25, height: memberHeight * 0.45)
        let (memberEachWidth, memberEachHeight) = UIFunc.getPos(view: memberViewFrist)
        self.memberImgviewFirst = UIFunc.imgView(x: memberEachWidth * 0.1, y: memberEachHeight * 0.05, width: memberEachWidth * 0.8, height: memberEachHeight * 0.6, img: #imageLiteral(resourceName: "card_picture"))
        self.memberImgviewSecond = UIFunc.imgView(x: memberEachWidth * 0.1, y: memberEachHeight * 0.05, width: memberEachWidth * 0.8, height: memberEachHeight * 0.6, img: #imageLiteral(resourceName: "card_picture"))
        self.memberImgviewThird = UIFunc.imgView(x: memberEachWidth * 0.1, y: memberEachHeight * 0.05, width: memberEachWidth * 0.8, height: memberEachHeight * 0.6, img: #imageLiteral(resourceName: "card_picture"))
        self.memberImgviewFourth = UIFunc.imgView(x: memberEachWidth * 0.1, y: memberEachHeight * 0.05, width: memberEachWidth * 0.8, height: memberEachHeight * 0.6, img: #imageLiteral(resourceName: "card_picture"))
        self.memberImgviewFifth = UIFunc.imgView(x: memberEachWidth * 0.1, y: memberEachHeight * 0.05, width: memberEachWidth * 0.8, height: memberEachHeight * 0.6, img: #imageLiteral(resourceName: "card_picture"))
        //뷰 세부설정
        self.mainView.backgroundColor = self.view.backgroundColor
        self.timeLbl.textAlignment = .center
        self.timeLbl.font = UIFont(name: "NanumSquareRoundL", size: 40)
        self.departmentCountCollection.backgroundColor = UIColor(rgb: 0xffefcc)
        self.departmentCountCollection.dataSource = self
        self.departmentCountCollection.delegate = self
        self.memberViewFrist.backgroundColor = UIColor(rgb: 0xffffff)
        self.memberViewFrist.layer.cornerRadius = 5.0
        self.memberViewFrist.dropShadow(color: UIColor.black, opacity: 0.3, offSet: CGSize(width: 0, height: 0), radius: 2, scale: true)
        self.memberViewSecond.backgroundColor = UIColor(rgb: 0xffffff)
        self.memberViewSecond.layer.cornerRadius = 5.0
        self.memberViewSecond.dropShadow(color: UIColor.black, opacity: 0.3, offSet: CGSize(width: 0, height: 0), radius: 2, scale: true)
        self.memberViewThird.backgroundColor = UIColor(rgb: 0xffffff)
        self.memberViewThird.layer.cornerRadius = 5.0
        self.memberViewThird.dropShadow(color: UIColor.black, opacity: 0.3, offSet: CGSize(width: 0, height: 0), radius: 2, scale: true)
        self.memberViewFourth.backgroundColor = UIColor(rgb: 0xffffff)
        self.memberViewFourth.layer.cornerRadius = 5.0
        self.memberViewFourth.dropShadow(color: UIColor.black, opacity: 0.3, offSet: CGSize(width: 0, height: 0), radius: 2, scale: true)
        self.memberViewFifth.backgroundColor = UIColor(rgb: 0xffffff)
        self.memberViewFifth.layer.cornerRadius = 5.0
        self.memberViewFifth.dropShadow(color: UIColor.black, opacity: 0.3, offSet: CGSize(width: 0, height: 0), radius: 2, scale: true)
        
        //뷰 add
        self.mainView.addSubview(timeLbl)
        self.mainView.addSubview(departmentCountCollection)
        self.mainView.addSubview(memberView)
        self.memberView.addSubview(memberViewFrist)
        self.memberView.addSubview(memberViewSecond)
        self.memberView.addSubview(memberViewThird)
        self.memberView.addSubview(memberViewFourth)
        self.memberView.addSubview(memberViewFifth)
        self.memberViewFrist.addSubview(memberImgviewFirst)
        self.memberViewSecond.addSubview(memberImgviewSecond)
        self.memberViewThird.addSubview(memberImgviewThird)
        self.memberViewFourth.addSubview(memberImgviewFourth)
        self.memberViewFifth.addSubview(memberImgviewFifth)
        
        self.mainView.addSubview(self.waitingPeopleView)

        self.waitingPeopleView.addSubview(self.waitingPeopleCollection)

    }
    func setup() {
        setupUI()
        API.Game.fetch_userlist_inroom(withToken: current_token) { (response, status) in
            guard status != 401 else {
                self.show_alert(with: "오류 발생")
                print("Can't find user!")
                return
            }
            self.setusersinroom(with:response)
        }
    }
    
    func setusersinroom(with:[LightUser]) {
        self.usersinroom = with
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

extension EnterDepartmentViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.departmentCountCollection.dequeueReusableCell(withReuseIdentifier: "departmentCountCell", for: indexPath as IndexPath) as! DepartmentCountCollectionViewCell
        cell.mainView.backgroundColor = UIColor.white
        cell.mainView.dropShadow(color: UIColor.black, opacity: 0.3, offSet: CGSize(width: 0, height: 0), radius: 2, scale: true)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: departmentCountCollection.frame.height * 0.6, height: departmentCountCollection.frame.height * 0.6)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
