import RealmSwift
import Foundation

final public class RealmManager {
    
    let realm = try? Realm()
    
    func saveNewUser(name: String, age: Int, isEditingSaveView: Bool, personToUpdate: Person?, completion: @escaping (Bool) -> Void) {
        if isEditingSaveView {
            edit(name: name, age: age, personToUpdate: personToUpdate) { success in
                completion(success)
            }
        } else {
            save(name: name, age: age) { success in
                completion(success)
            }
        }
    }
    
    private func edit (name: String, age: Int, personToUpdate: Person?, completion: @escaping (Bool) -> Void) {
        
        do {
            try realm?.write{
                personToUpdate?.name = name
                personToUpdate?.age = age
                completion(true)
            }
        } catch let error {
            print(error.localizedDescription)
            completion(false)
        }
    }
    
    private func save (name: String, age: Int, completion: @escaping (Bool) -> Void) {
        let person = Person()
        person.name = name
        person.age = age
        
        do {
            try realm?.write{
                realm?.add(person)
                completion(true)
            }
        } catch let error {
            print(error.localizedDescription)
            completion(false)
        }
    }
    
    func savePet (person: Person, petName: String, petAge: Int, petType: String, completion: @escaping (Bool) -> Void ) {
        let pet = Pet()
        pet.name = petName
        pet.age = petAge
        pet.type = petType
        pet.person_id = person.id
        
        do {
            try realm?.write{
                person.pets.append(pet)
                print(person)
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
    
    func delete (object: Object, completion: @escaping (Bool) -> Void) {
        do {
            try realm?.write{
                realm?.delete(object)
                completion(true)
            }
        } catch let error {
            print(error.localizedDescription)
            completion(false)
        }
    }
    
}
