//
//  DayViewController.swift
//  sample-app
//
//  Created by Takudzwa Mhonde on 2018-11-04.
//  Copyright © 2018 Takudzwa Mhonde. All rights reserved.
//

import UIKit

class DayViewController: UIViewController {

    @IBOutlet weak var SelectedDate: UILabel?
    @IBAction func backButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    var myDate = String()
    var myDateNumber = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        SelectedDate?.text = myDate
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
