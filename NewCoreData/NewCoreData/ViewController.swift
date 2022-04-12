//
//  ViewController.swift
//  NewCoreData
//
//  Created by Apple User on 08/04/22.
//

import UIKit
import CoreData
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
    @IBOutlet weak var tableView: UITableView!
    private weak var cellDelegate: CustomTableViewCell!
//    var myData: [AnyObject] = []
    var people: [NSManagedObject] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        title = "The Task"
        fetchData()
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            UIView.animate(withDuration: 0.2, animations: {
                self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
            })
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.2, animations: {
            self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        })
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
   
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _ , _, _ in
           
           
          let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
             
            if indexPath.row == 0 {
                                return
                            }
                                let item = self.people[indexPath.row]
                                self.people.remove(at: indexPath.row)
                                context.delete(item)

                              do{
                                try context.save()
                              }catch{
                              print("Error deleting item with \(error)")
                              }
                                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                                self.tableView.reloadData()
                              }
                              
        let swipeconfig = UISwipeActionsConfiguration(actions: [deleteAction])
                        return swipeconfig
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let value = people.count == 0 ? 1 : people.count 
      return  value
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomTableViewCell
        if people.isEmpty {
            cell.textField.text = ""
        }
        else {
            cell.textField.text = people[indexPath.row].value(forKeyPath: "name") as? String
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("Tapped cell number \(indexPath.row).")
        tableView.setEditing(true, animated: true)
        }

    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            
      if editingStyle == .insert{
          guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                   let context = appDelegate.persistentContainer.viewContext
                   let entity = NSEntityDescription.entity(forEntityName: "Person", in: context)
                   let manageObject = NSManagedObject(entity: entity!, insertInto: context)

//          manageObject.setValue("", forKey: "name")
          do {
              try context.save()
              people.append(manageObject)
          }
          catch {
              print("could not insert")
          }
          self.tableView.insertRows(at: [indexPath], with: .automatic)
          //print(self.people.count)
          self.tableView.setEditing(false, animated: true)
          self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle{
        return .insert
    }
    
    func fetchData(){
    
        if let appDelegate =
             UIApplication.shared.delegate as? AppDelegate {
            
     
        let managedContext =
          appDelegate.persistentContainer.viewContext
        let fetchRequest =
          NSFetchRequest<NSManagedObject>(entityName: "Person")
        do {
    people = try managedContext.fetch(fetchRequest)
          

        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }


}
        
    }
}

    

