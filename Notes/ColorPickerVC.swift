//
//  ColorPickerViewController.swift
//  lab_1
//
//  Created by Владислав Якубец on 27.11.2020.
//

import UIKit

class ColorPickerVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collection: UICollectionView!
    
    var complition: ((UIColor) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    // UICollectionViewDataSource Protocol:
    // Returns the number of columns in collection view
    internal func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    // UICollectionViewDataSource Protocol:
    // Inilitializes the collection view cells
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "cellInCollection", for: indexPath)
        if indexPath.row == 1 {
            cell.backgroundColor = UIColor.red
        } else if indexPath.row == 2 {
            cell.backgroundColor = UIColor.green
        } else {
            cell.backgroundColor = UIColor.yellow
        }
        cell.contentView.layer.cornerRadius = 45.0
        
        return cell
    }
    
    // Recognizes and handles when a collection view cell has been selected
    internal func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == 1 {
            complition?(UIColor.red)
        } else if indexPath.row == 2 {
            complition?(UIColor.green)
        } else {
            complition?(UIColor.yellow)
        }
       
        dismiss(animated: true, completion: nil)
    }
    
    
    
}
