

import UIKit

class PetsTableViewController: UITableViewController {
    
    var pets: [Pet]?
    var personId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadTableView()
    }
        
    func reloadTableView () {
        let predicate = NSPredicate(format: "person_id == %@", personId)
        pets = RealmManager().getAllPets(filter: predicate)
        self.tableView.reloadData()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pets?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let petToShow = pets?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "petCellIdentifier", for: indexPath)
        cell.textLabel?.text = petToShow?.name
        cell.detailTextLabel?.text = petToShow?.type
        return cell
    }
    
}
