//
//  ContentView.swift
//  RealmVsSwiftData
//
//  Created by Jacob Bartlett on 02/04/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var viewModel: ContentViewModel = ContentViewModel(db: .realm)
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.users, id: \.id) {
                    UserCell(user: $0)
                }
            }
            .navigationTitle("Users")
        }
    }
}

struct UserCell: View {
    
    let user: any User
    
    var body: some View {
        HStack {
            Text("\(user.firstName) \(user.surname)")
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("^[\(user.age) \(String(localized: "year"))](inflect: true)")
                .font(.caption)
                .fontWeight(.medium)
                .foregroundStyle(.secondary)
        }
    }
}
