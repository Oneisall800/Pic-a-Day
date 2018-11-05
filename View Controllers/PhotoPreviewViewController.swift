//
//  PhotoPreviewViewController.swift
//  sample-app
//
//  Created by Takudzwa Mhonde on 2018-10-30.
//  Copyright © 2018 Takudzwa Mhonde. All rights reserved.
//

import UIKit

class PhotoPreviewViewController: UIViewController {
    @IBOutlet private weak var photo: UIImageView!
    var image: UIImage!
    
    @IBAction func saveBtnPressed_TouchUpInside(_ sender: Any){
        //push the image into the gallery array
        //must be func ----
        guard let imageToSave = image else{
            return
        }
        // use completion selector to save the image to our array
        // this saves the image to the photo album
        //UIImageWriteToSavedPhotosAlbum(imageToSave, nil, #selector (addToCamera), nil)
        UIImageWriteToSavedPhotosAlbum(imageToSave, nil, nil, nil)
    }
    @IBAction func cancelBtnPressed_TouchUpInside(_ sender: Any){
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // load the image
        photo.image = image
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
