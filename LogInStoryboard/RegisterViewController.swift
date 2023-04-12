//
//  RegisterViewController.swift
//  LogInStoryboard
//
//  Created by Remote Tiger on 4/10/23.
//

//
//  RegisterViewController.swift
//  LogInStoryboard
//
//  Created by Remote Tiger on 4/10/23.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController{
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func registerPressed(_ sender: UIButton) {
                let username = usernameField.text ?? ""
                let password = passwordField.text ?? ""
                
        if username.isEmpty || password.isEmpty{
            errorLabel.text = "Invalid username or password"
            return
        }
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
//        let entity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
//        let user = NSManagedObject(entity: entity, insertInto: managedContext)
//
//        user.setValue(username, forKeyPath: "username")
//        user.setValue(password, forKeyPath: "password")
        
        let newUser = User(context: managedContext)
        newUser.username = username
        newUser.password = password
        
        do{
            try managedContext.save()
            errorLabel.text = "New user created successfully"
        }catch let error as NSError{
            errorLabel.text = "Failed to create new user.\(error)"
        }
        
        
    }
    

}



