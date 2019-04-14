//
//  SuperheroTableViewController.swift
//  SuperherosAndLaureates
//
//  Created by student on 4/13/19.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit

class SuperheroesTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Superheroes.shared.fetchJSONDataFromURL()
        NotificationCenter.default.addObserver(self, selector:#selector(superHeroesDataDelivered(notification: )),name: NSNotification.Name("Superheroes squad - delivered"), object:nil)
    }
    
    @objc func superHeroesDataDelivered(notification: Notification){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Superheroes.shared.superheroesSquad.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "superheroIdentifier", for: indexPath)
        let superheroinCell = Superheroes.shared.superheroesSquad[indexPath.row]
        cell.textLabel?.text = "\(superheroinCell.name) (aka: \(superheroinCell.secretIdentity))"
        var powersData = ""
        for i in 0..<superheroinCell.powers.count{
            if i == superheroinCell.powers.count - 1  {
                powersData += superheroinCell.powers[i]
            }else{
                powersData += "\(superheroinCell.powers[i]), "
            }
        }
        cell.detailTextLabel?.text = powersData
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "SUPERHEROS"
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return ""
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 170
    }
    
    
}
