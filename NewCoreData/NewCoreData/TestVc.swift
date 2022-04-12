//
//  TestVc.swift
//  NewCoreData
//
//  Created by Apple User on 08/04/22.
//

import UIKit
import CoreData
class TestVc: UIViewController {
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var text: UITextField!
    var value:[NSManagedObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func fetchData(_ sender: UIButton){
        fetchData()
    }
    @IBAction func saveData(_ sender: UIButton){
        save(name: "raman")
    }
    func save(name: String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                 let context = appDelegate.persistentContainer.viewContext
                 let entity = NSEntityDescription.entity(forEntityName: "Person", in: context)
                 let manageObject = NSManagedObject(entity: entity!, insertInto: context)
                 manageObject.setValue(name, forKey: "name")
                 do {
                     
                     try context.save()
                 } catch {
                     print(error)
                 }
    }
    func fetchData(){
    
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext =
          appDelegate.persistentContainer.viewContext
        let fetchRequest =
          NSFetchRequest<NSManagedObject>(entityName: "Person")
        do {
      value = try managedContext.fetch(fetchRequest)
            print(value.last?.value(forKeyPath: "name") as? String )

        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }


}
}
