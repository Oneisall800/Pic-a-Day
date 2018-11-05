//
//  ViewController.swift
//  sample-app
//
//  Created by Takudzwa Mhonde on 2018-10-31.
//  Copyright © 2018 Takudzwa Mhonde. All rights reserved.
//

import UIKit

class ClipboardViewController: UIViewController {
    @IBOutlet weak var clipboardCollectionView: UICollectionView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var addButton: UIButton!
    var collectionData = [#imageLiteral(resourceName: "class-day"), #imageLiteral(resourceName: "birthday-party2"), #imageLiteral(resourceName: "class-day"), #imageLiteral(resourceName: "birthday-party2")]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let width = (view.frame.size.width) / 5
        let layout = clipboardCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        navigationItem.rightBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem?.title = "Select"
        navigationController?.isToolbarHidden = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addItem() {
        let image = #imageLiteral(resourceName: "class-day")
        collectionData.append(image)
        let indexPath = IndexPath(row: collectionData.count-1, section: 0)
        clipboardCollectionView.insertItems(at: [indexPath])
    }
    
    @IBAction func deleteSelectedItems() {
        if let selected = clipboardCollectionView.indexPathsForSelectedItems{
            let items = selected.map { $0.item }.sorted().reversed()
            for item in items {
                collectionData.remove(at: item)
            }
            clipboardCollectionView.deleteItems(at: selected)
        }
        navigationController?.isToolbarHidden = true
    }
    
    @IBAction func backButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    // 
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        backButton.isEnabled = !editing
        addButton.isEnabled = !editing
        addButton.isHidden = editing
        clipboardCollectionView.allowsMultipleSelection = editing
        // ensures selected cells become deselected when done is tapped
        clipboardCollectionView.indexPathsForSelectedItems?.forEach{
            clipboardCollectionView.deselectItem(at: $0, animated: false)
        }
        let indexPaths = clipboardCollectionView.indexPathsForVisibleItems
        for indexPath in indexPaths {
            let cell = clipboardCollectionView.cellForItem(at: indexPath) as! ClipboardCollectionViewCell
         cell.isEditing = editing
        }
        // change the edit button to select -> Done
        if(self.isEditing)
        {
            self.editButtonItem.title = "Cancel"
        }else
        {
            self.editButtonItem.title = "Select"
        }
        if !editing {
            navigationController?.isToolbarHidden = true
        }
    
    }
    // SEGUES HERE (if necessary
}

extension ClipboardViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClipboardCollectionViewCell", for: indexPath)
        if let imageView = cell.viewWithTag(100) as? UIImageView{
            imageView.image = collectionData[indexPath.row]
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isEditing {
            navigationController?.isToolbarHidden = false
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if isEditing {
            if let selected = collectionView.indexPathsForSelectedItems, selected.count == 0{
                navigationController?.isToolbarHidden = true
            }
        }
    }
}
