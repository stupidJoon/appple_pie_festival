//
//  MoveDepartmentViewController.swift
//  The Genius
//
//  Created by JunsangYu on 04/08/2018.
//  Copyright © 2018 votoserver. All rights reserved.
//

import UIKit

class MoveDepartmentViewController: UIViewController {
    var mainView: UIView!
    var departmentView: UIView!
    var humanresourcesBtn: UIButton!
    var businessBtn: UIButton!
    var produceBtn: UIButton!
    var waitingPeopleView: UIView!
    var waitingPeopleCollection: UICollectionView!
    
    
    var users:[LightUser] {
        return API.otherUsers
    }
    
    func setupUI() {
        //mainView 설정
        self.mainView = UIFunc.view(x: 0, y: UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.height ?? 0), width: self.view.frame.width, height: self.view.frame.height - (UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.height ?? 0)))
        //뷰 width, height 변수 지정
        let (width, height) = UIFunc.getPos(view: self.mainView)
        //뷰 생성및 위치설정
        self.departmentView = UIFunc.view(x: 0, y: 0, width: width, height: height * 0.65)
        self.waitingPeopleView = UIFunc.view(x: 0, y: height * 0.65, width: width, height: height * 0.35)
        let (departmentWidth, departmentHeight) = UIFunc.getPos(view: departmentView)
        let (waitingWidth, waitingHeight) = UIFunc.getPos(view: waitingPeopleView)
        self.humanresourcesBtn = UIFunc.btn(x: departmentWidth * 0.15, y: departmentHeight * 0.15, width: departmentWidth * 0.7, height: departmentHeight * 0.25, title: "인사")
        self.businessBtn = UIFunc.btn(x: departmentWidth * 0.15, y: departmentHeight * 0.4, width: departmentWidth * 0.7, height: departmentHeight * 0.25, title: "영업")
        self.produceBtn = UIFunc.btn(x: departmentWidth * 0.15, y: departmentHeight * 0.645, width: departmentWidth * 0.7, height: departmentHeight * 0.25, title: "생산")
        
        humanresourcesBtn.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        businessBtn.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        produceBtn.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)

        
        self.waitingPeopleCollection = UIFunc.collection(x: waitingWidth * 0.05, y: waitingWidth * 0.05, width: waitingWidth * 0.9, height: waitingHeight - waitingWidth * 0.1, cell: WaitingPeopleCollectionViewCell.self, reuseIdentifier: "moveDepartmentCell")
        //뷰 세부설정
        self.mainView.backgroundColor = UIColor(rgb: 0xe6e6e6)
        self.departmentView.backgroundColor = UIColor(rgb: 0xe6e6e6)
        self.waitingPeopleView.backgroundColor = UIColor(rgb: 0xffffff)
        self.waitingPeopleView.dropShadow(color: UIColor.black, opacity: 0.01, offSet: CGSize(width: 0, height: -2), radius: 1, scale: true)
        self.humanresourcesBtn.setImage(#imageLiteral(resourceName: "insa_fixed"), for: .normal)
        self.humanresourcesBtn.imageView?.contentMode = .scaleAspectFit
        self.businessBtn.setImage(#imageLiteral(resourceName: "unavailable_fixed_yungup"), for: .normal)
        self.businessBtn.imageView?.contentMode = .scaleAspectFit
        self.produceBtn.setImage(#imageLiteral(resourceName: "saengsan_fixed"), for: .normal)
        self.produceBtn.imageView?.contentMode = .scaleAspectFit
        self.waitingPeopleCollection.backgroundColor = UIColor(rgb: 0xffffff)
        self.waitingPeopleCollection.dataSource = self
        self.waitingPeopleCollection.delegate = self
        //뷰 add
        self.view.addSubview(mainView)
        self.mainView.addSubview(departmentView)
        self.mainView.addSubview(waitingPeopleView)
        self.departmentView.addSubview(humanresourcesBtn)
        self.departmentView.addSubview(businessBtn)
        self.departmentView.addSubview(produceBtn)
        self.waitingPeopleView.addSubview(waitingPeopleCollection)
    }
    
    @objc func buttonPressed(sender:UIButton!) {
        let text = sender.title(for: .normal)
        API.Game.move_department(withToken: current_token, goto: text!) { (message, status) in
            guard status == 200 else {
                self.show_alert(with: message)
                return
            }
            if message == "이동이 불가능합니다" {
                self.show_alert(with: message)
                return
            }
            self.setUser()
            
        }
    }
    
    func setUser() {
        API.User.fetch_user(withToken: current_token) { (response,status) in
            guard let user = response,status != 401 else {
                self.show_alert(with: "유저를 찾을 수 없습니다.")
                print("Can't find user!")
                return
            }
            API.User.setCurrentUser(with: user)
            self.goto(VC: EnterDepartmentViewController())
        }
    }
    
    func setup() {
        setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }


    

}

extension MoveDepartmentViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.waitingPeopleCollection.dequeueReusableCell(withReuseIdentifier: "moveDepartmentCell", for: indexPath as IndexPath) as! WaitingPeopleCollectionViewCell
        cell.mainView.backgroundColor = UIColor.white
        cell.mainView.dropShadow(color: UIColor.black, opacity: 0.3, offSet: CGSize(width: 0, height: 0), radius: 2, scale: true)
        cell.textLbl.text = users[indexPath.row].user_name
        cell.imgView.sd_setImage(with: URL(string: "\(API.base_url)\(users[indexPath.row].user_profile)"))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.waitingPeopleView.frame.width * 0.15, height: self.waitingPeopleView.frame.height * 0.35)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}
