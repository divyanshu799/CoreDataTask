//
//  CustomTableViewCell.swift
//  NewCoreData
//
//  Created by Apple User on 08/04/22.
//

import Foundation
import UIKit
import CoreData
class CustomTableViewCell: UITableViewCell,UITextFieldDelegate {
    private weak var tableDelegate: UITableView?

    var value: [NSManagedObject] = []
    @IBOutlet weak var textField: UITextField!
    var names: [String] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        self.textField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text: NSString = (textField.text ?? "") as NSString
            let resultString = text.replacingCharacters(in: range, with: string)

            return true
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
       
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
           return true
       }
       func textFieldDidEndEditing(_ textField: UITextField) {
           if let text = textField.text, textField.text != "" {
               let nameToSave = text
               names.append(nameToSave)
               save(name: nameToSave)
               print(names)
               textField.resignFirstResponder()
               
           }
       }
       func save(name: String){
           guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                    let context = appDelegate.persistentContainer.viewContext
                    let entity = NSEntityDescription.entity(forEntityName: "Person", in: context)
                    let person = NSManagedObject(entity: entity!, insertInto: context)
                    person.setValue(name, forKey: "name")
                    do {
                        
                        try context.save()
                        
                    } catch {
                        print(error)
                    }
       }
       
    
       }
