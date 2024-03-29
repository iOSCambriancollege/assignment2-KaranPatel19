//
//  DogTableViewController.swift
//  A2_WebServices
//
//  Created by Karan Patel on 2023-02-01.
//

import UIKit

class DogTableViewController: UITableViewController {
    var dogBreeds: [[String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        DogAPI_Helper.fetchDogs{ response in
            switch response{
            case let .success(dogBreeds):
                let sortedDogBreeds = dogBreeds.sorted(by: { $0.0 < $1.0 })
                var subBreeds: [String]
                for (key, value) in sortedDogBreeds {
                    subBreeds = []
                    subBreeds = value
                    subBreeds.insert(key, at: 0)
                    self.dogBreeds.append(subBreeds)
                }
            case let .failure(error):
                print(error)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dogBreeds.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dogbreed", for: indexPath)

        // Configure the cell...
        let mainBreed = dogBreeds[indexPath.row][0]
        if dogBreeds[indexPath.row].count < 2 {
            cell.textLabel?.text = mainBreed
        } else {
            let curBreeds = dogBreeds[indexPath.row]
            let from1 = curBreeds.index(after: curBreeds.startIndex)
            let toEnd = curBreeds.endIndex
            let subBreeds = curBreeds[from1..<toEnd].map { String($0) }
                .joined(separator: ", ")
            
            let breedsToShow = "\(mainBreed): \(subBreeds)"
            let myMutableString = NSMutableAttributedString(string: breedsToShow)
            myMutableString.addAttribute(
                NSAttributedString.Key.foregroundColor,
                value: UIColor.gray,
                range: NSRange(location:mainBreed.count + 2,length:subBreeds.count)
            )
            cell.textLabel?.attributedText = myMutableString
        }

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
