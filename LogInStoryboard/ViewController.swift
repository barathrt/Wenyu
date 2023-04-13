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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                
                let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "username == %@", "test2")
                
                do {
                    let fetchedUsers = try context.fetch(User.fetchRequest())
                   // print(fetchedUsers)
                    if let user = fetchedUsers.first,user.password == password{
                        return true
                    }else{
                        return false
                    }
                }catch{
                    print("Error")
                    
                }
                return false
                 // o
    }
    

}

