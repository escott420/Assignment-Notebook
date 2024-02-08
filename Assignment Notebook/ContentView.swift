//
//  ContentView.swift
//
//
//  Created by Ethan Scott on 1/25/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var toDoList = ToDoList()
    @State private var showingAddItemView = false
    var body: some View {
        NavigationView {
            List {
                ForEach(toDoList.items) { item in
                    HStack{
                        VStack(alignment: .leading){
                            Text(item.classes)
                                .font(.headline)
                            Text(item.description)
                        }
                        Spacer()
                        Text(item.dueDate, style: .date)
                    }
                        }
                .onMove(perform:  { indices, newOffset in
                    toDoList.items.move(fromOffsets: indices, toOffset: newOffset)
                })
                .onDelete { IndexSet in
                    toDoList.items.remove(atOffsets: IndexSet)
                }
            }
            .sheet(isPresented: $showingAddItemView, content: {
                AddItemView(toDoList: toDoList)
            })
            .navigationBarTitle("Assignment Notebook")
            .navigationBarItems(leading: EditButton(), trailing:
            Button(action: {
                showingAddItemView = true}) {
                    Image(systemName: "plus")
                })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ToDoItem: Identifiable, Codable {
    var id = UUID()
    var classes = String()
    var description = String()
    var dueDate = Date()
        
}
