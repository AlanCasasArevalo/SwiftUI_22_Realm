import RealmSwift
import Foundation

final public class RealmManager {
    
    let realm = try? Realm()
    
    func saveNewUser(name: String, age: Int, completion: @escaping (Bool) -> Void) {
        let person = Person()
        person.name = name
        person.age = age
        save(object: person) { success in
            completion(success)
        }
    }
    
    private func save (object: Object, completion: @escaping (Bool) -> Void) {
        do {
            try realm?.write{
                realm?.add(object)
                completion(true)
            }
        } catch let error {
            print(error.localizedDescription)
            completion(false)
        }
    }
    
    func getAllPeople(filter: String?) -> [Person]? {
        // Se pueden filtras los datos si son necesario filtrarlos
//        guard let result: Results<Person> = realm?.objects(Person.self).filter("age > 10") else { return [] }
        guard let result: Results<Person> = realm?.objects(Person.self) else { return [] }
        var people = [Person]()
        for person in result {
            people.append(person)
        }
        return people
    }
    
}
