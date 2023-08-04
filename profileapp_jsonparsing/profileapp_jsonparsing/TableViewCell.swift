//
//  TableViewCell.swift
//  profileapp_jsonparsing
//
//  Created by PMCLAP1240 on 02/02/23.
//

import UIKit

class TableViewCell: UITableViewCell {

    var follorwersUlrString: String = ""
    //properties
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var unameLabel: UILabel!
    
    @IBOutlet weak var reflectFollowersLabel: UILabel!
    
    @IBOutlet weak var reflectFollowingLabel: UILabel!
    
    @IBOutlet weak var FollowersLabel: UILabel!
    
    @IBOutlet weak var FollowingLabel: UILabel!
    
    @IBOutlet weak var WebsiteLabel: UILabel!
    
    @IBOutlet weak var reflectWebsiteLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgView.layer.cornerRadius = imgView.frame.size.width/2
        
        imgView.clipsToBounds = true
        
        
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    
    }
    
    func getFolloers() -> Int {
        
//        let urlString = "https://api.github.com/users?per_page=5&since=2"
//
//            if let url = URL(string: urlString) {
//                if let data = try? Data(contentsOf: url){
//                   parse(json: data)
//                    print(parse(json: data))
//                    print(response)
//                }
//            }
        
        guard let urlFolloers = URL(string: self.follorwersUlrString) else {return 0}
        
        var count: Int = 0

        URLSession.shared.dataTask(with: urlFolloers) { (data, response, error) in
            if let error = error {
                print("Error fetching followers: \(error)")
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let followers = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
                count = followers?.count ?? 0
                //let names = followers?.compactMap({ $0["name"] as? String })

                //print(names!)
            } catch {
                print("Error parsing followers: \(error)")
            }
        }.resume()
        return count
    }

}
