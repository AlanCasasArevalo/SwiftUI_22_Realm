
import Foundation
import RealmSwift

class Pet: Object {
    // el identificador UUID tiene que ser el mismo que el se devuelva en el primaryKey
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var type = ""
    @objc dynamic var person_id = ""
    @objc dynamic var age = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    
    @objc dynamic var owner : Person? {
        return LinkingObjects(fromType: Person.self, property: "pets").first
    }
    
}
