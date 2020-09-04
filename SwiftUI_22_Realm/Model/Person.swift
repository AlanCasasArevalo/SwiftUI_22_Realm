
import Foundation
import RealmSwift
class Person: Object {
    // el identificador UUID tiene que ser el mismo que el se devuelva en el primaryKey
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var age = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
