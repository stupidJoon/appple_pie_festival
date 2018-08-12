//
//  WaitingViewController.swift
//  The Genius
//
//  Created by JunsangYu on 02/08/2018.
//  Copyright © 2018 votoserver. All rights reserved.
//

import UIKit

class WaitingViewController: UIViewController {
    var mainView: UIView!
    var moveDepartmentView: UIView!
    var moveDepartmentBtn: UIButton!
    
    //이건 계속해서 쓰이니까 아예 코드 파일을 하나 더 만들어서 그 안에 init으로 다 넣어준 다음에 뷰마다 재사용하는게 맞음 ㅠㅠ
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
        self.moveDepartmentView = UIFunc.view(x: 0, y: 0, width: width, height: height * 0.65)
        self.waitingPeopleView = UIFunc.view(x: 0, y: height * 0.65, width: width, height: height * 0.35)
        let (moveWidth, moveHeight) = UIFunc.getPos(view: moveDepartmentView)
        let (waitWidth, waitHeight) = UIFunc.getPos(view: waitingPeopleView)
        
        self.moveDepartmentBtn = UIFunc.btn(x: (moveWidth - moveHeight * 0.5) / 2, y: moveHeight * 0.25, width: moveHeight * 0.5, height: moveHeight * 0.5, title: "부서이동")
        moveDepartmentBtn.addTarget(self, action: #selector(moveDepartmentBtnPressed(sender:)), for: .touchUpInside)
        
        
        self.waitingPeopleCollection = UIFunc.collection(x: waitWidth * 0.05, y: waitWidth * 0.05, width: waitWidth * 0.9, height: waitHeight - waitWidth * 0.1, cell: WaitingPeopleCollectionViewCell.self, reuseIdentifier: "waitingCell")
        //뷰 세부설정
        self.view.backgroundColor = UIColor(rgb: 0xe6e6e6)
        self.moveDepartmentView.backgroundColor = UIColor(rgb: 0xe6e6e6)
        self.moveDepartmentBtn.setImage(#imageLiteral(resourceName: "button_start_available"), for: .normal)
        self.waitingPeopleView.backgroundColor = UIColor(rgb: 0xffffff)
        self.waitingPeopleView.dropShadow(color: UIColor.black, opacity: 0.01, offSet: CGSize(width: 0, height: -2), radius: 1, scale: true)
        self.waitingPeopleCollection.backgroundColor = UIColor(rgb: 0xffffff)
        self.waitingPeopleCollection.dataSource = self
        self.waitingPeopleCollection.delegate = self
        //뷰 add
        self.view.addSubview(self.mainView)
        self.mainView.addSubview(self.moveDepartmentView)
        self.mainView.addSubview(self.waitingPeopleView)
        self.moveDepartmentView.addSubview(self.moveDepartmentBtn)
        self.waitingPeopleView.addSubview(self.waitingPeopleCollection)
    }
    
    func setup() {
        setupUI()
        
        API.User.fetch_userlist(withToken: current_token, completion: { (response,status) in
            guard status != 401 else {
                print("Error!")
                return
            }
            self.set_otherUsers(with: response)
        })
    }
    
    func set_otherUsers(with:[LightUser]) {
        API.otherUsers = with
        waitingPeopleCollection.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    @objc func moveDepartmentBtnPressed(sender:UIButton!) {
        API.Game.fetch_isGameStarted(withToken: current_token) { (start, status) in
            if status == 401 {
                print("token error")
                return
            }
            //게임 ㅅ
            if start == true {
                self.move_department()
            } else {
                self.show_alert(with: "시작할 수 없습니다.")
            }
        }
    }
    
    func move_department() {
        self.goto(VC: MoveDepartmentViewController())
    }

}

extension WaitingViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.waitingPeopleCollection.dequeueReusableCell(withReuseIdentifier: "waitingCell", for: indexPath as IndexPath) as! WaitingPeopleCollectionViewCell
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
