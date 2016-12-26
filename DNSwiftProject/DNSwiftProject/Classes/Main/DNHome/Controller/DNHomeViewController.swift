//
//  DNHomeViewController.swift
//  DNSwiftProject
//
//  Created by mainone on 16/11/25.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit
import Alamofire

class DNHomeViewController: UIViewController {
    
    var myLabel: UILabel!
    
    var imageV: UIImageView!
    var selectImage:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.view.addSubview(tempView)
        
        myLabel = UILabel(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        myLabel.text = "发动机是发奖;束带结发爱的是减肥熬时间放进去哦;文件而发生大家;放假安静的收费记录;卡倒计时;浪费就;阿来得及说放假啊大事发生"
        myLabel.numberOfLines = 0
        myLabel.font = UIFont.boldSystemFont(ofSize: 13)
        myLabel.attributedText = NSAttributedString(string: myLabel.text!).underline()
        myLabel.backgroundColor = UIColor.red
        let height = myLabel.getEstimatedHeight()
        myLabel.h = height
        self.view.addSubview(myLabel)
        
        let dragView = DNDragView(frame: CGRect(x: 100, y: 250, width: 100, height: 100))
        dragView.isKeepBounds = true
        dragView.backgroundColor = UIColor.green
        self.view.addSubview(dragView)
        dragView.onClickDrageBlock = { dragV in
            
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true
            picker.sourceType = .photoLibrary
            picker.videoQuality = .typeLow;
            self.present(picker, animated: true, completion: nil)
//            let detail = DetailViewController()
//            self.navigationController?.pushViewController(viewController: detail, completion: {
//                print("xxx")
            
            
//            })
        }
        
        let img = UIImage(named: "tx")?.roundCorners(159).apply(border: 5, color: UIColor.green)
        imageV = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        dragView.addSubview(imageV)
        imageV.image = img
        
        imageV.style = .sector
        
    }
    
    // 模拟头像上传
    func uploadImage(_ image: UIImage) {
        var progress: Float = 0.0
        selectImage = image
        imageV.uploadImage(image: image, progress: 0.0)
        _ = Timer.runThisEvery(seconds: 0.01) { [weak self](timer) in
            progress = progress + 0.01
            self?.imageV.uploadImage(image: image, progress: progress)
            if progress >= 1 {
                self?.imageV.uploadCompleted()
                timer?.invalidate()
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    var tempView: UIView = {
        let myView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        myView.backgroundColor = UIColor.red
        return myView
    }()

}

extension DNHomeViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if  let img = info[UIImagePickerControllerEditedImage] as? UIImage {
            uploadImage(img)
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
