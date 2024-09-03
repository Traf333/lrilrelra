//
//  RoleSelectorView.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 03.09.2024.
//

import SwiftUI

struct RoleSelectorView: View {
    @Binding var selectedRole: Role?
    var roles: [Role]
    var onChange: () -> Void
    
    var body: some View {
        NavigationView {
            List {
                ForEach(roles, id: \.name) { role in
                    Button(action: {
                        if selectedRole?.name == role.name {
                            selectedRole = nil // Deselect if the same role is selected again
                        } else {
                            selectedRole = role // Select the new role
                        }
                        onChange()
                    }) {
                        HStack {
                            Text(role.name)
                            if selectedRole?.name == role.name {
                                Spacer()
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Select Role")
        }
    }
}

#Preview {
    var role: Role? = Role(name: "Role 1", aliases: [])
    
    return RoleSelectorView(selectedRole: Binding(get: {role}, set: {value in role = value }), roles: [Role(name: "Role 1", aliases: []), Role(name: "Role 2", aliases: []), Role(name: "Role 3", aliases: [])]) {
        print("triggered change")
    }
}
