//
//  ViewController.swift
//  Web Service Tutorial
//
//  Created by Ario on 09/01/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    
    var animeItems = [MyResults]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //for url
        let url = "https://api.jikan.moe/v4/seasons/now";
        
        tableView.dataSource = self
        tableView.register(
            UINib(nibName: "AnimeTableViewCell", bundle: nil), forCellReuseIdentifier: "AnimeCell")
        
        getDataFromURL(from: url)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animeItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AnimeCell", for: indexPath) as? AnimeTableViewCell{
            let anime = animeItems[indexPath.row]
            cell.animeTitle.text = anime.title
            
            return cell
        }else{
            return UITableViewCell()
        }
    }
    
    private func getDataFromURL(from url: String){
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
            guard let data = data, error == nil else{
                print("something went wrong")
                return
            }
            
            //have data
            var result: Response?
            do{
                result = try JSONDecoder().decode(Response.self, from:data)
                
            }catch{
                print("failed to convert the data \(error) ")
            }
            
            guard let json = result else{
                return
            }
            
            json.data.forEach{data in print(data.title)}
            
            self.animeItems = json.data
        }).resume()
    }
}

struct Response: Codable{
    let pagination: MyPaginations
    let data: [MyResults]
}

struct MyPaginations: Codable{
    let last_visible_page: Int
    let has_next_page: Bool
    let current_page: Int
}

struct MyResults: Codable{
    let mal_id: Int
    let url: String
    let title: String
}

