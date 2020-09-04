
import SwiftUI

struct SaveView: View {
    
    @State private var name = ""
    @State private var age = ""
    @Environment(\.presentationMode) var back
    
    var body: some View {
        VStack (alignment: .center) {
            Text("Guardar persona")
                .font(.system(.title, design: .rounded))
            TextField("Nombre", text: self.$name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Edad", text: self.$age)
                .keyboardType(.decimalPad)            
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                RealmManager().saveNewUser(name: self.name, age: Int(self.age) ?? 0) { success in
                    if success {                        
                        self.back.wrappedValue.dismiss()
                    }
                }
            }) {
                HStack {
                    Image(systemName: "person.crop.circle.fill.badge.plus")
                        .font(.system(.title, design: .rounded))
                        .foregroundColor(.white)
                    Text("Guardar")
                    .font(.system(.title, design: .rounded))
                    .foregroundColor(.white)
                }
            }
            .frame(width: 150, height: 30, alignment: .center)
            .padding()
            .background(Color(.darkGray))
            .cornerRadius(10, antialiased: true)
            .shadow(color: Color(.systemGray2), radius: 5, x: 10, y: 10)
            Spacer()
        }
        .padding()
    }
}

struct SaveView_Previews: PreviewProvider {
    static var previews: some View {
        SaveView()
    }
}
