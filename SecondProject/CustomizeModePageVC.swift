//
//  CustomizeModePageVC.swift
//  SecondProject
//
//  Created by 邱裕芳 on 2023/6/15.
//

import UIKit
import SnapKit

protocol TimerFunctionDelegate {
    func appendTimer(hour : Int , min : Int , sec : Int)
    func editTimer(editdata : TimerModel , hour : Int , min : Int , sec : Int)
}

class CustomizeModePageVC: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource , TimerFunctionDelegate {
    
    func appendTimer(hour : Int , min : Int , sec : Int) {
        let model = TimerModel()
        
        for i in 0..<customTimers.count{
            if model.checkNumber == customTimers[i].checkNumber{
                continue
            }
            model.checkNumber = i
        }
        
        model.hour = hour
        model.min = min
        model.sec = sec
        
        customTimers.append(model)
        customTimerArray.setTimers(array: customTimers)
        listCV.reloadData()
    }
    
    func editTimer(editdata : TimerModel , hour : Int , min : Int , sec : Int) {
        let model = TimerModel()
        
        model.hour = hour
        model.min = min
        model.sec = sec
        
        for i in 0..<customTimers.count{
            if customTimers[i].checkNumber == editdata.checkNumber{
                model.checkNumber = editdata.checkNumber
                customTimers[i] = model
                break
            }
        }
        customTimerArray.setTimers(array: customTimers)
        listCV.reloadData()
    }
    
    var titleBGView : UIView!
    var titleLabel : UILabel!
    var listFL : UICollectionViewFlowLayout!
    var listCV : UICollectionView!
    var backBtn , addBtn , editBtn : UIButton!
    
    var customTimers :[TimerModel] = []
    var customTimerArray : CustomTimerArrayDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiInit()
        customTimers = customTimerArray.getTimers()
    }
    
    func uiInit(){
        view.backgroundColor = UIColor(cgColor: CGColor(red: 171 / 255, green: 225 / 255, blue: 254 / 255, alpha: 1))
        
        titleBGView = UIView()
        titleBGView.backgroundColor = UIColor(cgColor: CGColor(red: 79 / 255, green: 177 / 255, blue: 252 / 255, alpha: 1))
        view.addSubview(titleBGView)
        titleBGView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        titleLabel = UILabel()
        titleLabel.attributedText = NSAttributedString(string: "Customize Mode" , attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize:24),
            NSAttributedString.Key.kern: 2 ,
            NSAttributedString.Key.foregroundColor: UIColor(cgColor: CGColor(red: 2 / 255, green: 69 / 255, blue: 113 / 255, alpha: 1))])
        
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(-10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        backBtn = UIButton()
        backBtn.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        
        backBtn.tintColor = UIColor(cgColor: CGColor(red: 2 / 255, green: 69 / 255, blue: 113 / 255, alpha: 1))
        backBtn.addTarget(self, action: #selector(backBtnAction(sender:)), for: .touchUpInside)
        view.addSubview(backBtn)
        backBtn.snp.makeConstraints { make in
            make.top.equalTo(titleLabel)
            make.leading.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        editBtn = UIButton()
        editBtn.setImage(UIImage(systemName: "pencil"), for: .normal)
        editBtn.tintColor = UIColor(cgColor: CGColor(red: 2 / 255, green: 69 / 255, blue: 113 / 255, alpha: 1))
        view.addSubview(editBtn)
        editBtn.snp.makeConstraints { make in
            make.top.equalTo(titleLabel)
            make.trailing.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        editBtn.showsMenuAsPrimaryAction = true
        editBtn.menu = UIMenu(children: [
            UIAction(title: "Clear All",image: UIImage(systemName: "trash.fill") , handler: { Action in
                let ac = UIAlertController(title: "Alert", message: "Are You Sure Delete All Timer Data?", preferredStyle: .alert)
                let yes = UIAlertAction(title: "Yes", style: .default) { Action in
                    self.customTimers = []
                    self.customTimerArray.setTimers(array: self.customTimers)
                    self.listCV.reloadData()
                }
                let no = UIAlertAction(title: "No", style: .default)
                ac.addAction(yes)
                ac.addAction(no)
                self.present(ac , animated: true)
            })
        ])
        
        
        listFL = UICollectionViewFlowLayout()
        listFL.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        listFL.itemSize = CGSize(width: UIScreen.main.bounds.width - 10, height: 60)
        listFL.scrollDirection = .vertical
        
        listCV = UICollectionView(frame: CGRect(), collectionViewLayout: listFL)
        listCV.dataSource = self
        listCV.delegate = self
        listCV.backgroundColor = .clear
        listCV.register(CustomListCollectionCell.self, forCellWithReuseIdentifier: CustomListCollectionCell.cellIdentifier)
        listCV.backgroundColor = .clear

        view.addSubview(listCV)
        listCV.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-90)
        }
        
        addBtn = UIButton()
        addBtn.setBackgroundImage(UIImage(named: "add_icon"), for: .normal)
        addBtn.imageView?.contentMode = .scaleAspectFill
        addBtn.addTarget(self, action: #selector(addBtnAction(sender:)), for: .touchUpInside)
        view.addSubview(addBtn)
        addBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.centerX.equalToSuperview()
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return customTimers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomListCollectionCell.cellIdentifier, for: indexPath) as! CustomListCollectionCell
        
        if indexPath.item < 9{
            cell.numLabel.text = "0\(String(indexPath.item + 1))"
        }else{
            cell.numLabel.text = String(indexPath.item + 1)
        }
        
        let hour = customTimers[indexPath.item].hour
        let min = customTimers[indexPath.item].min
        let sec = customTimers[indexPath.item].sec
        
        var str = ""
        
        if hour > 0 {
            if hour < 10 {
                str += "0\(hour) hour "
            }else{
                str += "\(hour) hour "
            }
        }
        
        if min > 0 {
            if min < 10 {
                str += "0\(min) min "
            }else{
                str += "\(min) min "
            }
        }
        
        if sec > 0 {
            if sec < 10{
                str += "0\(sec) sec"
            }else{
                str += "\(sec) sec"
            }
        }
        
        cell.titleLabel.attributedText = NSAttributedString(string: "Timer : \(str)" , attributes: [
            NSAttributedString.Key.kern: 2 ,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20) ,
            NSAttributedString.Key.foregroundColor: UIColor(cgColor: CGColor(red: 2 / 255, green: 69 / 255, blue: 113 / 255, alpha: 1))
        ])
        
        cell.optionBtn.tag = indexPath.item
        cell.optionBtn.addTarget(self, action: #selector(editBtnAction(sender: )), for: .touchUpInside)
                
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//            cell.transform = CGAffineTransform(scaleX: 0, y: 0)
//
//            UIView.animate(withDuration: 0.5,delay: 0.1 * Double(indexPath.item) , animations: {
//                cell.transform = CGAffineTransform(scaleX: 1, y: 1)
//            })
//    }
    
    @objc func editBtnAction(sender : UIButton){
        let ac = UIAlertController(title: "", message: "Option", preferredStyle: .actionSheet)
        let edit = UIAlertAction(title: "Edit", style: .default) { Action in
            let vc = TimePickerVC()
            
            if let sheet = vc.sheetPresentationController{
                sheet.detents = [.medium()]
            }
            vc.arrayDelegate = self
            vc.prevFrom = PrevFromEnum.edit.rawValue
            vc.editData = self.customTimers[sender.tag]
            self.present(vc , animated: true)
        }
        let del = UIAlertAction(title: "Delete", style: .default) { Action in
            self.customTimers.remove(at: sender.tag)
            self.customTimerArray.setTimers(array: self.customTimers)
            self.listCV.reloadData()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        ac.addAction(edit)
        ac.addAction(del)
        ac.addAction(cancel)
        present(ac , animated: true)
    }
    
    @objc func backBtnAction(sender : UIButton){
        dismiss(animated: true)
    }
    
    @objc func addBtnAction(sender : UIButton){
        let vc = TimePickerVC()
        
        if let sheetController = vc.sheetPresentationController{
            sheetController.detents = [.medium()]
        }
        vc.arrayDelegate = self
        vc.prevFrom = PrevFromEnum.append.rawValue
        present(vc , animated: true)
    }
}
