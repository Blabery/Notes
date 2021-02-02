//
//  EntryVC.swift
//  lab_1
//
//  Created by Владислав Якубец on 26.11.2020.
//

import UIKit

class EntryVC: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var noteTitleView: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var colorButton: UIButton!
    
    var completion: ((String, String, String, Int) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noteTextView.layer.borderWidth = 1.0
        noteTextView.layer.cornerRadius = 6.0
        noteTextView.layer.borderColor = #colorLiteral(red: 0.8940202594, green: 0.8941736817, blue: 0.8940106034, alpha: 1)
    }
    
    @IBAction func saveNote() {
        
        if var noteTitle = noteTitleView.text, let noteText = noteTextView.text {
            
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.YY HH:mm";
            let dateText = dateFormatter.string(from: date)
            if noteTitle.isEmpty {
                
                noteTitle = dateFormatter.string(from: date)
            }
            
            var important = 0
            
            if colorButton.tintColor == UIColor.red {
                important = 3
               
            } else if colorButton.tintColor == UIColor.yellow {
                important = 2
                
            } else if colorButton.tintColor == UIColor.green {
                important = 1
            }
            
            completion?(noteTitle, noteText, dateText, important)
            
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @IBAction func setColor(_ sender: UIButton) {
        
        let colorPicker = storyboard?.instantiateViewController(identifier: "colorPickerVC") as? ColorPickerVC
        colorPicker!.modalPresentationStyle = .popover
        colorPicker!.preferredContentSize = CGSize(width: 184, height: 73)
        
        if let popoverController = colorPicker!.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = sender.frame
            popoverController.permittedArrowDirections = .any
            popoverController.delegate = self
            
        }
        
        colorPicker?.complition = { color in
            sender.tintColor = color
        }
        
        present(colorPicker!, animated: true, completion: nil)
        
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        // Return no adaptive presentation style, use default presentation behaviour
        return .none
    }
}


