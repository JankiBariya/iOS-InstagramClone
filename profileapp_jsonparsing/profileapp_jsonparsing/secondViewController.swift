//
//  secondViewController.swift
//  profileapp_jsonparsing
//
//  Created by PMCLAP1240 on 03/02/23.
//

import UIKit



class secondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    typealias Welcome2 = [WelcomeElement]
    var response2 = [WelcomeElement]()

   // var followers = [Follower]()
//        var currentPage = 1
//        var hasMoreFollowers = true
    
    @IBOutlet weak var tableView2: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return response2.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = response2[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! secondTableViewCell
        
             cell.outputFollowersLabel.text = data.login
        
      
        
            let imageUrl = URL(string: data.avatarURL)
               DispatchQueue.global().async {
                   let data = try? Data(contentsOf: imageUrl!)
                   DispatchQueue.main.async {
                       
                       cell.imgView2?.image = UIImage(data: data!)
                   }
               }
                   return cell
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()

        if let jsonEvents = try? decoder.decode(Welcome.self, from: json) {
            
            response2 = jsonEvents
            
            tableView2.reloadData()
            
//         print(response)
        }
    }
    
    
    
                   
                   
                   
                   
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView2.reloadData()
       
        tableView2.rowHeight = 150
        tableView2.delegate = self
        tableView2.dataSource = self
        let urlString = "https://api.github.com/users/pjhyett/followers"

            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url){
                   parse(json: data)
                    print(parse(json: data))
                    print(response2)
                }
            }
    
    }
    

}
