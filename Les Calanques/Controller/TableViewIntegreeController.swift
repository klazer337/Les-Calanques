//
//  TableViewIntegreeController.swift
//  Les Calanques
//
//  Created by Kevin Trebossen on 23/09/18.
//  Copyright © 2018 KTD. All rights reserved.
//

import UIKit

let segueID = "Detail"

class TableViewIntegreeController: UITableViewController {
    
    var calanques: [Calanque] = []
    var cellID = "CalanqueCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        calanques = CalanqueCollection().all()          // on récupère toutes les calanques
        tableView.backgroundColor = UIColor.clear
        let bg = UIImageView(frame: view.bounds)
        bg.image = calanques[0].image
        bg.contentMode = .scaleAspectFill
        tableView.backgroundView = bg
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calanques.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {       //----- Configuration de la Cell -----//
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? CalanqueCell {
            cell.setupCell(calanques[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
            let calanque = calanques[indexPath.row]
            cell.textLabel?.text = calanque.nom
            cell.imageView?.image = calanque.image
            return cell
        }
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {             //----- Hauteur de la Cell -----//
        return 175
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {        // sélection de la row
        performSegue(withIdentifier: segueID, sender: calanques[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {                             // préparation de la segue
        if segue.identifier == segueID {
            if let vc = segue.destination as? DetailController {
                vc.calanqueRecue = sender as? Calanque
            }
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            calanques.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }  
    }
    
    
    @IBAction func reloadAction(_ sender: Any) {
        calanques = CalanqueCollection().all()  // on récupère toutes les calanques
        tableView.reloadData()          // on recharge la tableView
    }
    

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
