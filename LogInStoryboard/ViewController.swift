//
//  ViewController.swift
//  LogInStoryboard
//
//  Created by Remote Tiger on 4/7/23.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var registerbutton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var mainImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainImage.image = UIImage(named: "questionchick")
        // Do any additional setup after loading the view.
    }
    

    @IBAction func logInPressed(_ sender: UIButton) {
                let username = usernameField.text ?? ""
                let password = passwordField.text ?? ""
                
                if authenticate(username: username, password: password) {
                    let nextViewController = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "tableView")
                    self.present(nextViewController, animated:true, completion:nil)

                } else {
                    errorLabel.text = "Invalid username or password"
                }
            }
            
            func authenticate(username: String, password: String) -> Bool {
                
            
                let context = (UIApplication.shared.delegate as!AppDelegate).persistentContainer.viewContext
                
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
                fetchRequest.returnsObjectsAsFaults = false
                //fetchRequest.predicate = NSPredicate(format: "username == %@", "test2")
                
                do {
                    let fetchedUsers = try context.fetch(User.fetchRequest())
                   // print(fetchedUsers)
                    for user in fetchedUsers as [NSManagedObject]{
                        if username == user.value(forKey: "username") as? String{
                            if password == user.value(forKey: "password") as! String{
                                return true
                            }
                        }
                    }
                                
                    return false
                }catch{
                    print("Error")
                    
                }
                return false
                 // o
    }
    

}

