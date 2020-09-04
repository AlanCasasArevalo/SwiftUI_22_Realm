
import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    let reusableCellId = "userCell"
    
    @IBOutlet weak var userTableView: UITableView!
    
    var people: [Person]?
    
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
        return UIHostingController(coder: coder, rootView: SaveView())
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let objectToDelete = people?[indexPath.row] else { return }
        RealmManager().delete(object: objectToDelete) { [weak self] success in
            if success {
                self?.reloadTableView()
            } else {
                print("error al borrar el usuario")
            }
        }
    }
    
}
