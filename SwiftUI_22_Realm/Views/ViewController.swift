
import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    let reusableCellId = "userCell"
    var isEditingSaveView: Bool = false
    
    @IBOutlet weak var userTableView: UITableView!
    
    var people: [Person]?
    var personSelected: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadTableView()
    }
    
    func reloadTableView () {
        people = RealmManager().getAllPeople(filter: nil)
        userTableView.reloadData()
    }
    
    // enviar a swiftUI
    @IBSegueAction func saveView(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: SaveView(isEditingSaveView: false))
    }
    
    @IBSegueAction func editView(_ coder: NSCoder) -> UIViewController? {
        guard let indexPath = self.userTableView.indexPathForSelectedRow else { fatalError("Fallo al seleccionar la celda") }
        personSelected = people?[indexPath.row]
        return UIHostingController(coder: coder, rootView: SaveView(isEditingSaveView: true, person: personSelected))
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let personToShow = people?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableCellId, for: indexPath)
        cell.textLabel?.text = "Nombre: \(personToShow?.name ?? "")"
        cell.detailTextLabel?.text = "Edad: \(personToShow?.age ?? 0)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Borrar") { [weak self] (_, _, _) in
            guard let objectToDelete = self?.people?[indexPath.row] else { return () }
            
            RealmManager().delete(object: objectToDelete) { [weak self] success in
                if success {
                    self?.reloadTableView()
                } else {
                    print("error al borrar el usuario")
                }
            }
        }
        
        let showPets = UIContextualAction(style: .normal, title: "Ver mascotas") { (_, _, _) in
            self.performSegue(withIdentifier: "showPets", sender: indexPath )
        }
        
        let actions = UISwipeActionsConfiguration(actions: [ delete, showPets ])
        
        return actions
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPets" {
            let indexPath = sender as? NSIndexPath
            let personToShow = people?[indexPath?.row ?? 0]
            let petsTableVC = segue.destination as! PetsTableViewController
            petsTableVC.personId = personToShow?.id ?? ""
        }
    }
    
}
