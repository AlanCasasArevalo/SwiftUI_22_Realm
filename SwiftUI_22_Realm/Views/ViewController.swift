
import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    let reusableCellId = "userCell"
    
    @IBOutlet weak var userTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }


    // enviar a swiftUI
    @IBSegueAction func saveView(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: SaveView())
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableCellId, for: indexPath)
        cell.textLabel?.text = "Titulo de la celd"
        cell.detailTextLabel?.text = "subtitulo de la celda"
        return cell
    }
    
    
}
