import SwiftUI

struct AddItemView: View {
    @ObservedObject var toDoList: ToDoList
    @State private var selectedClass = "" // Renamed to selectedClass
    @State private var description = ""
    @State private var dueDate = Date()
    static let classes = ["Math", "English", "Science"]

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                Picker("Courses", selection: $selectedClass) {
                    ForEach(Self.classes, id: \.self) { priority in
                        Text(priority)
                    }
                }
                TextField("Description", text: $description)
                DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
            }
            .navigationBarTitle("Add New To-Do Item", displayMode: .inline)
            .navigationBarItems(trailing: Button("Save") {
                if selectedClass.count > 0 && description.count > 0 {
                    let item = ToDoItem(id: UUID(),  description: description, dueDate: dueDate)
                    toDoList.items.append(item)
                    presentationMode.wrappedValue.dismiss()
                }
            })
        }
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView(toDoList: ToDoList())
    }
}
