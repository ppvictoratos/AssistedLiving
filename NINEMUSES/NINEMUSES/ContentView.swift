//
//  ContentView.swift
//  NINEMUSES
//
//  Created by Petie Positivo on 6/17/23.
//

import SwiftUI

struct student {
    var name: Student
    var id: UUID
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var students: FetchedResults<Student>
    
    var body: some View {
        VStack {
            List(students) { student in
                Text(student.name ?? "Scrumpits")
            }
            
            Button("Add") {
                let firstNames = ["Ginny", "Johnny", "Tony"]
                let chosenName = firstNames.randomElement()!
                
                let student = Student(context: moc)
                student.id = UUID()
                student.name = "\(chosenName)"
                
                try? moc.save()
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
