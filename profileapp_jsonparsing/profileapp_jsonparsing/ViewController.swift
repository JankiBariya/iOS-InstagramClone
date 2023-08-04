//
//  ViewController.swift
//  profileapp_jsonparsing
//
//  Created by PMCLAP1240 on 02/02/23.
//

import UIKit

//model file
import Foundation


struct WelcomeElement: Codable {
    let login: String
    let id: Int
    let nodeID: String
    let avatarURL: String
    let gravatarID: String
    let url, htmlURL, followersURL: String
    let followingURL, gistsURL, starredURL: String
    let subscriptionsURL, organizationsURL, reposURL: String
    let eventsURL: String
    let receivedEventsURL: String
    let type: String
    let siteAdmin: Bool

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case siteAdmin = "site_admin"
    }
}

typealias Welcome = [WelcomeElement]



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var response = [WelcomeElement]()
    var currentPage = 1
    var hasMoreFollowers = true
    var page = 1
    
    //properties
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return response.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        
        var data = response[indexPath.row]

        
        let followersCount = data.followersURL.count
        cell.follorwersUlrString = data.followersURL
       // cell.reflectFollowersLabel.text = "\(followersCount)"
        cell.reflectFollowersLabel.text = "\(cell.getFolloers())"
        cell.textLabel?.numberOfLines = 0
        
        let followingCount = data.followingURL.count
        cell.reflectFollowingLabel.text = "\(followingCount)"
        
        cell.reflectWebsiteLabel.text = data.url
        cell.unameLabel.text = data.login
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(followersTapped))
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(followingTapped))
        
        cell.reflectFollowersLabel.addGestureRecognizer(tapGesture)
        cell.reflectFollowersLabel.isUserInteractionEnabled = true
        cell.reflectFollowingLabel.addGestureRecognizer(tapGesture2)
        cell.reflectFollowingLabel.isUserInteractionEnabled = true
     
        
    
        let imageUrl = URL(string: data.avatarURL)
           DispatchQueue.global().async {
               let data = try? Data(contentsOf: imageUrl!)
               DispatchQueue.main.async {
                   cell.imgView?.image = UIImage(data: data!)
               }
        
           }
       
      

       return cell
    }
    
    @objc func followersTapped() {
      
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "secondViewController") as! secondViewController

        
       // let vc.data = username
        
        self.navigationController?.pushViewController(vc, animated: true)
        
//        if let url = URL(string: "https://api.github.com/users?per_page=5&since=2")
//        {
//            UIApplication.shared.open(url)
//        }
//
   }
       
        @objc func followingTapped() {
            if let url = URL(string: "https://api.github.com/users?per_page=5&since=2")
            {
                UIApplication.shared.open(url)
                
            }
            
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "ShowFollowers" {
                guard let secondViewController = segue.destination as? secondViewController else { return }
                secondViewController.response2 = response
            }
        }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()

        if let jsonEvents = try? decoder.decode(Welcome.self, from: json) {
            
            response = jsonEvents
            
            tableView.reloadData()
            
//         print(response)
        }
    }

//    func loadFollowers() {
//            guard hasMoreFollowers else { return }
//
//            let url = URL(string: "https://api.github.com/users?per_page=5&since=\(page)")!
//
//            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
//                guard let self = self else { return }
//                guard let data = data else { return }
//
//                let decoder = JSONDecoder()
//
//                do {
//                    let response = try decoder.decode([WelcomeElement].self, from: data)
//                    if response.count == 0 {
//                        self.hasMoreFollowers = false
//                    } else {
//                        self.response.append(contentsOf: response)
//                        self.page += 1
//                    }
//                    DispatchQueue.main.async {
//                        self.tableView.reloadData()
//                    }
//                } catch {
//                    print(error)
//                }
//            }.resume()
//        }
    
    //https://api.github.com/users?per_page=5&since=2
    //https://api.github.com/users/pjhyett/followers
    
   private func loadFollowers(page: Int) {
       // let data = response.login
           let perPage = 10
           //let since = 2
           //let urlString = "https://api.github.com/users?per_page=\(perPage)&since=\(since)"
        
      //  let urlString = "https://api.github.com/users/\(data.login)/followers"
           
//           guard let url = URL(string: urlString) else { return }
           
//           URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
//               guard let self = self, let data = data else { return }
               
//               let decoder = JSONDecoder()
//               decoder.keyDecodingStrategy = .convertFromSnakeCase
//
//               do {
//                   let response = try decoder.decode([WelcomeElement].self, from: data)
//                   if  response.count < perPage {
//                       self.hasMoreFollowers = false
//                   }
//
//
//                   self.response.append(contentsOf: response)
//                                   self.currentPage += 1
//                               } catch {
//                                   print("Error decoding followers: \(error)")
//                               }
//                           }.resume()
                       }
                       
//                      func loadMoreFollowers() {
//                           if hasMoreFollowers {
//                               loadFollowers(page: currentPage)
//                           }
//                       }
//
    ///controller
    //lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profiles"
        
        loadFollowers(page: currentPage)
        
        tableView.rowHeight = 200
        tableView.dataSource = self
        tableView.delegate = self
        let urlString = "https://api.github.com/users?per_page=5&since=2"

            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url){
                   parse(json: data)
                    print(parse(json: data))
                    print(response)
                }
            }
        let followersURL = URL(string: "https://api.github.com/users/pjhyett/followers")!

        URLSession.shared.dataTask(with: followersURL) { (data, response, error) in
            if let error = error {
                print("Error fetching followers: \(error)")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let followers = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]

                let names = followers?.compactMap({ $0["name"] as? String })

                print(names)
            } catch {
                print("Error parsing followers: \(error)")
            }
        }.resume()
    }
    
    
// func followersLabelTapped(_ sender: UITapGestureRecognizer) {
     //let followersURL = URL(string: "https://api.github.com/users/pjhyett/followers")!
     
//     let followers = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
//
//     let names = followers?.compactMap({ $0["name"] as? String })
//
//     guard let names = self.names else {
            // Show an error message if the names haven't been fetched yet
//            return
//        }
//
//        let message = names.joined(separator: "\n")
//        let alert = UIAlertController(title: "Followers", message: message, preferredStyle: .alert)
//        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
//        alert.addAction(action)
//        present(alert, animated: true, completion: nil)
//    }
}

