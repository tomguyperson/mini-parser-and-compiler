//
//  DetailViewController.swift
//  tableViewCoreData
//
//  Created by Tommy Mesquita on 3/16/22.
//  Copyright © 2022 ASU. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var selectedCity:City?
    
    var empty:Data = Data()
    
    var m:Model?
    
    let picker = UIImagePickerController()
    
    @IBOutlet weak var cityImage: UIImageView!
    @IBOutlet weak var cityDescription: UILabel!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var imageSource: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cityDescription.text = selectedCity?.details
        self.cityName.text = selectedCity?.name
        self.cityImage.image = UIImage(data:(selectedCity?.picture) ?? empty)
        
        picker.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func AddImage(_ sender: Any)
    {
        if imageSource.selectedSegmentIndex == 0
        {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                picker.allowsEditing = false
                picker.sourceType = UIImagePickerController.SourceType.camera
                picker.cameraCaptureMode = .photo
                picker.modalPresentationStyle = .fullScreen
                present(picker,animated: true,completion: nil)
            } else {
                print("No camera")
            }
            
        }else{
            picker.allowsEditing = false
            picker.sourceType = .photoLibrary
            picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            picker.modalPresentationStyle = .popover
            present(picker, animated: true, completion: nil)
        }
    }
    
    
    //MARK: - Delegates
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        // Local variable inserted by Swift 4.2 migrator.
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        
        picker .dismiss(animated: true, completion: nil)
        cityImage.image=info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage
        
        selectedCity?.picture = cityImage.image!.pngData()
        
        let rec = self.m?.findRecord(name: (selectedCity?.name)!)
        rec?.setValue(selectedCity, forKey: (selectedCity?.name)!)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Helper function inserted by Swift 4.2 migrator.
    fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
        return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
    }
    
    // Helper function inserted by Swift 4.2 migrator.
    fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
        return input.rawValue
    }
}


