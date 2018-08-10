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
    var memberCollection: UICollectionView!
    var confirmBtn: UIButton!
    var enterDepartmentPeopleView: UIView!
    var enterDepartmentPeopleCollection: UICollectionView!
    
    func setupUI() {
        //mainView 설정
        self.mainView = UIFunc.view(x: 0, y: UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.height ?? 0), width: self.view.frame.width, height: self.view.frame.height - (UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.height ?? 0)))
        self.view.backgroundColor = UIColor(rgb: 0xffefcc)
        self.view.addSubview(mainView)
        //뷰 width, height 변수 지정
        let (width, height) = UIFunc.getPos(view: self.mainView)
        //뷰 생성및 위치설정
        self.enterDepartmentPeopleView = UIFunc.view(x: 0, y: height * 0.65, width: width, height: height * 0.35)
        let (peopleWidth, peopleHeight) = UIFunc.getPos(view: enterDepartmentPeopleView)
        self.timeLbl = UIFunc.lbl(x: width * 0.3, y: height * 0.025, width: width * 0.4, height: height * 0.1, text: "10:00")
        self.departmentCountCollection = UIFunc.collection(x: width * 0.2, y: height * 0.125, width: width * 0.6, height: height * 0.1, cell: DepartmentCountCollectionViewCell.self, reuseIdentifier: "departmentCountCell")
        self.memberCollection = UIFunc.collection(x: width * 0.15, y: height * 0.225, width: width * 0.7, height: height * 0.3, cell: MemberCollectionViewCell.self, reuseIdentifier: "memberCell")
        self.confirmBtn = UIFunc.btn(x: width * 0.15, y: height * 0.55, width: width * 0.7, height: height * 0.05, title: "확인")
        self.confirmBtn.dropShadow(color: .black, opacity: 0.1, offSet: CGSize(width: 0, height: 0), radius: 10, scale: true)
        self.enterDepartmentPeopleCollection = UIFunc.collection(x: peopleWidth * 0.05, y: peopleWidth * 0.05, width: peopleWidth * 0.9, height: peopleHeight - peopleWidth * 0.1, cell: WaitingPeopleCollectionViewCell.self, reuseIdentifier: "enterDepartmentCell")
        //뷰 세부설정
        self.mainView.backgroundColor = UIColor(rgb: 0xffefcc)
        self.timeLbl.textAlignment = .center
        self.timeLbl.font = UIFont(name: "NanumSquareRoundL", size: 40)
        self.departmentCountCollection.backgroundColor = UIColor(rgb: 0xffefcc)
        self.departmentCountCollection.dataSource = self
        self.departmentCountCollection.delegate = self
        self.memberCollection.backgroundColor = UIColor(white: 1, alpha: 0)
        self.memberCollection.dataSource = self
        self.memberCollection.delegate = self
        self.confirmBtn.backgroundColor = UIColor(rgb: 0x8e8e8e)
        self.confirmBtn.layer.cornerRadius = confirmBtn.frame.height / 2
        self.confirmBtn.setTitleColor(UIColor.black, for: .normal)
        self.confirmBtn.titleLabel?.font = UIFont(name: "NanumSquareRoundL", size: 25)
        self.enterDepartmentPeopleView.backgroundColor = UIColor(rgb: 0xffffff)
        self.enterDepartmentPeopleView.dropShadow(color: UIColor.black, opacity: 0.1, offSet: CGSize(width: 0, height: 0), radius: 1, scale: true)
        self.enterDepartmentPeopleCollection.backgroundColor = UIColor(white: 1, alpha: 0)
        self.enterDepartmentPeopleCollection.dataSource = self
        self.enterDepartmentPeopleCollection.delegate = self
        //뷰 add
        self.mainView.addSubview(enterDepartmentPeopleView)
        self.mainView.addSubview(timeLbl)
        self.mainView.addSubview(departmentCountCollection)
        self.mainView.addSubview(memberCollection)
        self.mainView.addSubview(confirmBtn)
        self.enterDepartmentPeopleView.addSubview(enterDepartmentPeopleCollection)
    }
    func setup() {
        setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension EnterDepartmentViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    //collectionview section 개수
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == memberCollection {
            return 2
        }
        else {
            return 1
        }
    }
    //collectionview item 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == departmentCountCollection {
            return 4
        }
        else if collectionView == memberCollection {
            if section == 0 {
                return 2
            }
            else if section == 1 {
                return 3
            }
            else {
                return 0
            }
        }
        else if collectionView == enterDepartmentPeopleCollection {
            return 10
        }
        else {
            return 0
        }
    }
    //collectionview cell 만들기
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == departmentCountCollection {
            let cell = self.departmentCountCollection.dequeueReusableCell(withReuseIdentifier: "departmentCountCell", for: indexPath as IndexPath) as! DepartmentCountCollectionViewCell
            cell.mainView.backgroundColor = UIColor.white
            cell.mainView.dropShadow(color: UIColor.black, opacity: 0.3, offSet: CGSize(width: 0, height: 0), radius: 2, scale: true)
            cell.numLbl.text = String(indexPath.row + 1)
            return cell
        }
        else if collectionView == memberCollection {
            let cell = self.memberCollection.dequeueReusableCell(withReuseIdentifier: "memberCell", for: indexPath as IndexPath) as! MemberCollectionViewCell
            cell.mainView.backgroundColor = UIColor.white
            cell.mainView.dropShadow(color: UIColor.black, opacity: 0.3, offSet: CGSize(width: 0, height: 0), radius: 2, scale: true)
            return cell
        }
        else if collectionView == enterDepartmentPeopleCollection {
            let cell = self.enterDepartmentPeopleCollection.dequeueReusableCell(withReuseIdentifier: "enterDepartmentCell", for: indexPath as IndexPath) as! WaitingPeopleCollectionViewCell
            cell.mainView.backgroundColor = UIColor.white
            cell.mainView.dropShadow(color: UIColor.black, opacity: 0.3, offSet: CGSize(width: 0, height: 0), radius: 2, scale: true)
            return cell
        }
        else {
            return UICollectionViewCell()
        }
    }
    //collectionview 크기 조정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == departmentCountCollection {
            let (_, height) = UIFunc.getPos(view: departmentCountCollection)
            return CGSize(width: height * 0.6, height: height * 0.6)
        }
        else if collectionView == memberCollection {
            let (width, height) = UIFunc.getPos(view: memberCollection)
            return CGSize(width: width * 0.25, height: height * 0.45)
        }
        else if collectionView == enterDepartmentPeopleCollection {
            let (width, height) = UIFunc.getPos(view: enterDepartmentPeopleView)
            return CGSize(width: width * 0.15, height: height * 0.35)
        }
        else {
            return CGSize()
        }
    }
    //collectionview UIIdgeInsets 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let (width, height) = UIFunc.getPos(view: collectionView)
        if collectionView == departmentCountCollection {
            return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        }
        else if collectionView == memberCollection {
            if section == 0 {
                return UIEdgeInsets(top: height * 0.025, left: width * 0.225, bottom: height * 0.05, right: width * 0.225)
            }
            else if section == 1 {
                return UIEdgeInsets(top: 0, left: width * 0.075, bottom: height * 0.025, right: width * 0.075)
            }
            else {
                return UIEdgeInsets()
            }
        }
        else if collectionView == enterDepartmentPeopleCollection {
            return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        }
        else {
            return UIEdgeInsets()
        }
    }
    //collectionview item margin
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let (_, height) = UIFunc.getPos(view: collectionView)
        if collectionView == departmentCountCollection {
            return 0
        }
        else if collectionView == memberCollection {
            return height * 0.1
        }
        else {
            return 10
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let (width, _) = UIFunc.getPos(view: collectionView)
        if collectionView == departmentCountCollection {
            return width * 0.05
        }
        else if collectionView == memberCollection {
            return width * 0.05
        }
        else {
            return 10
        }
    }
}
