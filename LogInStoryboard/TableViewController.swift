//
//  TableViewController.swift
//  LogInStoryboard
//
//  Created by Remote Tiger on 4/13/23.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    let sampleUrl = "https://jsonplaceholder.typicode.com/posts"
    var responseArray = [DataModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        myTableView.estimatedRowHeight = 100.0 // Adjust Primary table height
        myTableView.rowHeight = UITableView.automaticDimension
        callAPI()
        // Do any additional setup after loading the view.
    }
    
    func callAPI(){
        let url = URL(string: sampleUrl)!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let unwrappedData = data else{return}
            do {
                let decodeJson = JSONDecoder()
                decodeJson.keyDecodingStrategy = .convertFromSnakeCase
                self.responseArray = try decodeJson.decode([DataModel].self, from: unwrappedData)
                
                // always async data in main thread
                DispatchQueue.main.async{
                    self.myTableView.reloadData()
                }
            }
            catch{
                print(error.localizedDescription)
            }
        }
        task.resume()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responseArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        //print(responseArray[indexPath.row])
        cell.titleLabel?.text = responseArray[indexPath.row].title
        cell.idLabel?.text = String(responseArray[indexPath.row].id ?? 0)
        cell.textView?.text = responseArray[indexPath.row].body
        
        
        cell.textView?.textColor = UIColor(red: 70/256, green: 130/256, blue: 180/256, alpha: 1.0)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAtIndexPath section: Int) -> CGFloat {
        return 150
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
