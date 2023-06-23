//
//  AboutPageVC.swift
//  SecondProject
//
//  Created by 邱裕芳 on 2023/6/12.
//

import UIKit
import SnapKit
import SafariServices

class AboutPageVC: UIViewController , UITableViewDelegate , UITableViewDataSource , SFSafariViewControllerDelegate {

    var aboutTableView : UITableView!
    var selectBool = false
    
    var titleBGView : UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        uiInit()
    }
    
    func uiInit(){
        navigationItem.title = "ABOUT"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24) ,
            NSAttributedString.Key.kern: 2 ,
            NSAttributedString.Key.foregroundColor : UIColor(cgColor: CGColor(red: 2 / 255, green: 69 / 255, blue: 113 / 255, alpha: 1))]
        
        view.backgroundColor = UIColor(cgColor: CGColor(red: 171 / 255, green: 225 / 255, blue: 254 / 255, alpha: 1))
        
        titleBGView = UIView()
        titleBGView.backgroundColor = UIColor(cgColor: CGColor(red: 79 / 255, green: 177 / 255, blue: 252 / 255, alpha: 1))
        view.addSubview(titleBGView)
        titleBGView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
        
        aboutTableView = UITableView()
        aboutTableView.dataSource = self
        aboutTableView.delegate = self
        aboutTableView.bounces = false
        aboutTableView.separatorStyle = .none
        aboutTableView.backgroundColor = .clear
        aboutTableView.register(AboutTableCell.self, forCellReuseIdentifier: AboutTableCell.cellIdentifier)
        view.addSubview(aboutTableView)
        aboutTableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(-10)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-30)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AboutTableCell.cellIdentifier) as! AboutTableCell

        switch indexPath.section {
        case 0 :
            cell.titleLabel.attributedText = NSAttributedString(string: "About" , attributes: [
                NSAttributedString.Key.kern:2 ,
                NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 20) ,
                NSAttributedString.Key.foregroundColor:UIColor(cgColor: CGColor(red: 2 / 255, green: 69 / 255, blue: 113 / 255, alpha: 1)) ])
            
            cell.titleImage.isHidden = false
            cell.versionLabel.isHidden = true
            
            if selectBool{
                cell.titleImage.image = UIImage(systemName: "chevron.up")
                cell.indexTextView.isHidden = false
            }else{
                cell.titleImage.image = UIImage(systemName: "chevron.down")
                cell.indexTextView.isHidden = true
            }
            
        case 1 :
            cell.titleLabel.attributedText = NSAttributedString(string: "Rating" , attributes: [
                NSAttributedString.Key.kern:2 ,
                NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 20) ,
                NSAttributedString.Key.foregroundColor:UIColor(cgColor: CGColor(red: 2 / 255, green: 69 / 255, blue: 113 / 255, alpha: 1)) ])
            
            cell.titleImage.isHidden = false
            cell.versionLabel.isHidden = true
            cell.indexTextView.isHidden = true
            cell.titleImage.image = UIImage(systemName: "chevron.right")
            
        case 2 :
            cell.titleLabel.attributedText = NSAttributedString(string: "Version" , attributes: [
                NSAttributedString.Key.kern:2 ,
                NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 20) ,
                NSAttributedString.Key.foregroundColor:UIColor(cgColor: CGColor(red: 2 / 255, green: 69 / 255, blue: 113 / 255, alpha: 1)) ])
            cell.titleImage.isHidden = true
            cell.versionLabel.isHidden = false
            cell.indexTextView.isHidden = true
        default:
            break
        }
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if selectBool{
                return 200
            }else{
                return UITableView.automaticDimension
            }
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0 :
            selectBool = !selectBool
        case 1 :
            let ShareUrl = URL(string: "https://www.google.com.tw/")!
            let SafariVC = SFSafariViewController(url: ShareUrl)
            SafariVC.preferredBarTintColor = .black
            SafariVC.preferredControlTintColor = .white
            SafariVC.dismissButtonStyle = .close
            SafariVC.delegate = self
            present(SafariVC , animated: true)
        default:
            break
        }
        
        tableView.reloadData()
    }
}
