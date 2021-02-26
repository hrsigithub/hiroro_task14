//
//  ContentView.swift
//  task14
//
//  Created by Hiroshi.Nakai on 2021/02/25.
//

import SwiftUI

struct Task: Identifiable {
    var id = UUID()
    var fruitsName: String
    var isDone: Bool
}

struct ContentView: View {

    @State private var tasks: [Task] = [
        .init(fruitsName: "りんご", isDone: false),
        .init(fruitsName: "みかん", isDone: true),
        .init(fruitsName: "バナナ", isDone: false),
        .init(fruitsName: "パイナップル", isDone: true)
    ]

    @State private var isShowModal = false

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(tasks) { task in
                        HStack {
                            CheckViewRow(task: task)
                        }
                    }
                }
                .navigationBarItems(trailing: Button(action: {
                    isShowModal.toggle()
                }) {
                    Text("+")
                        .font(.largeTitle)
                })
            }
        }
        .sheet(isPresented: $isShowModal, content: {
            TaskDetialView(isShowModal: $isShowModal, tasks: $tasks)
        })
    }
}

struct TaskDetialView: View {

    @Binding var isShowModal: Bool
    @Binding var tasks: [Task]

    @State private var fruitsName: String = ""

    var body: some View {
        VStack {
            HStack {
                Button("Cancel") {
                    isShowModal.toggle()
                }
                Spacer()
                Button("Save") {
                    if !fruitsName.isEmpty {
                        tasks.append(.init(fruitsName: fruitsName, isDone: false))
                    }
                    isShowModal.toggle()
                }
            }.padding()

            HStack {
                Text("名前")
                TextField("", text: $fruitsName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 100)
            }
            Spacer()
        }
    }
}


struct CheckViewRow: View {
    var task: Task

    var body: some View {
        if task.isDone {
            Image(systemName: "checkmark")
                .foregroundColor(.red)
        } else {
            Image(systemName: "checkmark")
                .hidden()
        }
        Text(task.fruitsName)
        Spacer()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
