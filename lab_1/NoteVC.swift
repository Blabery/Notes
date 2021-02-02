//
//  Created by Владислав Якубец on 26.11.2020.
//

import UIKit

class NoteVC: UIViewController, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var noteTitleField: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var dateLable: UILabel!
    @IBOutlet weak var colorButton: UIButton!
    
    var completion: ((String, String, Int) -> Void)?
    
    var noteTitle: String = ""
    var noteText: String = ""
    var date: String = ""
    var color: UIColor!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteTextView.layer.borderWidth = 1.0
        noteTextView.layer.cornerRadius = 6.0
        noteTextView.layer.borderColor = #colorLiteral(red: 0.8940202594, green: 0.8941736817, blue: 0.8940106034, alpha: 1)
        
        
        
        noteTitleField.text = noteTitle
        noteTextView.text = noteText
        dateLable.text = date
        colorButton.tintColor = color
        
    }
    
    @IBAction func saveNote() {
        
        var important = 0
        
        if colorButton.tintColor == UIColor.red {
            important = 3
            
        } else if colorButton.tintColor == UIColor.yellow {
            important = 2
            
        } else if colorButton.tintColor == UIColor.green {
            important = 1
            
        }
        
        if let noteTitle = noteTitleField.text, let noteText = noteTextView.text {
            completion?(noteTitle, noteText, important)
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
