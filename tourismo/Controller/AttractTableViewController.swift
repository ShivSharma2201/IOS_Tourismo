//
//  AttractTableViewController.swift
//  pro5
//
//  
//

import UIKit

class AttractTableViewController: UITableViewController {

    @IBOutlet weak var welcName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        welcName.text="Welcome \(UserDefaults.standard.string(forKey: "User_Email")!)"
        self.tableView.rowHeight = 200
        self.navigationItem.title = "All Attractions"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "My Favorites", style: .plain, target: self, action: #selector(goToFavoritesScreen))
  
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return AttractionsDB.shared.attractionsList.count
    }
    
    @objc func goToFavoritesScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        let favoriteVC = storyboard.instantiateViewController(withIdentifier: "Favscreen") as! FavTableViewController
        
        self.navigationController?.pushViewController(favoriteVC, animated: true)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AttractionCell", for: indexPath) as! AttractCell

        // Configure the cell...
        let currentAttraction = AttractionsDB.shared.attractionsList[indexPath.row]
        cell.lblName.text = currentAttraction.attractionName
        cell.lblPrice.text = "Price: $\(currentAttraction.price) / person"
        cell.imgPhoto.image = UIImage(named: currentAttraction.imageFileID)
        

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailScreen = storyboard?.instantiateViewController(withIdentifier: "Detailscreen") as? DetailViewController else {
            print("Can't get to other screen")
            return
        }
        
        detailScreen.selectedAttraction = AttractionsDB.shared.attractionsList[indexPath.row]
        
        self.navigationController?.pushViewController(detailScreen, animated: true)
    }

    
    @IBAction func tickBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        let favoriteVC = storyboard.instantiateViewController(withIdentifier: "Ticketscreen") as! TickTableViewController
        
        self.navigationController?.pushViewController(favoriteVC, animated: true)
    }
    
    @IBAction func logBtn(_ sender: Any) {
        UserDefaults.standard.set("", forKey: "User_Email")
        UserDefaults.standard.set("", forKey: "User_Password")
            UserDefaults.standard.set(false,forKey: "RemME")
        self.navigationController?.popViewController(animated: true)
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
