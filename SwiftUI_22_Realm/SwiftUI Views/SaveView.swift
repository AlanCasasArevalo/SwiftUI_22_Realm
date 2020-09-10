
import SwiftUI

struct SaveView: View {
    
    @State var isEditingSaveView: Bool
    
    @State private var name = ""
    @State private var age = ""
    
    @State private var petName = ""
    @State private var petAge = ""
    @State private var petType = ""
    
    @State private var title = ""
    @State private var buttonText = ""
    
    var person: Person?
    
    @Environment(\.presentationMode) var back
    
    var body: some View {
        VStack (alignment: .center) {
            Text(title)
                .font(.system(.title, design: .rounded))
            TextField("Nombre", text: self.$name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Edad", text: self.$age)
                .keyboardType(.decimalPad)            
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                self.save(isEditingSaveView: self.isEditingSaveView)
            }) {
                HStack {
                    Image(systemName: "person.crop.circle.fill.badge.plus")
                        .font(.system(.title, design: .rounded))
                        .foregroundColor(.white)
                    Text(buttonText)
                        .font(.system(.title, design: .rounded))
                        .foregroundColor(.white)
                }
                .onAppear {
                    self.title = self.isEditingSaveView ? "Editar persona" : "Guardar persona"
                    self.buttonText = self.isEditingSaveView ? "Editar" : "Guardar"
                    self.name = self.isEditingSaveView ? (self.person?.name ?? "") : ""
                    self.age = self.isEditingSaveView ? "\(self.person?.age ?? 0)" : ""
                }
            }
            .frame(width: 150, height: 30, alignment: .center)
            .padding()
            .background(Color(.darkGray))
            .cornerRadius(10, antialiased: true)
            .shadow(color: Color(.systemGray2), radius: 5, x: 10, y: 10)
            if isEditingSaveView {
                Text("Guardar Mascota")
                    .font(.system(.largeTitle, design: .rounded))
                TextField("Nombre de la mascota", text: self.$petName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Edad de la mascota", text: self.$petAge)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Tipo de la mascota", text: self.$petType)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button(action: {
                    self.savePet()
                }) {
                    HStack {
                        Image(systemName: "tortoise.fill")
                            .font(.system(.title, design: .rounded))
                            .foregroundColor(.white)
                        Text("Guardar")
                            .font(.system(.title, design: .rounded))
                            .foregroundColor(.white)
                    }
                }
                .frame(width: 200, height: 30, alignment: .center)
                .padding()
                .background(Color(.darkGray))
                .cornerRadius(10, antialiased: true)
                .shadow(color: Color(.systemGray2), radius: 5, x: 10, y: 10)
            } else {
                
            }
            
            Spacer()
        }
        .padding()
        
    }
}

extension SaveView {
    func save (isEditingSaveView: Bool) {
        RealmManager().saveNewUser(name: self.name, age: Int(self.age) ?? 0, isEditingSaveView: isEditingSaveView, personToUpdate: person) { success in
            if success {
                self.back.wrappedValue.dismiss()
            } else {
                print("algo ha fallado con el guardado")
            }
        }
    }
    
    func savePet () {
        RealmManager().savePet(person: self.person ?? Person(), petName: self.petName, petAge: Int(self.age) ?? 0, petType: self.petType) { (success) in
            if success {
                self.back.wrappedValue.dismiss()
            } else {
                print("algo ha fallado con el guardado")
            }
        }
    }
    
}

struct SaveView_Previews: PreviewProvider {
    static var previews: some View {
        SaveView(isEditingSaveView: false)
    }
}
