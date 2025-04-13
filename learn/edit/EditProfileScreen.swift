//
//  EditProfileScreen.swift
//  Weather application_
//
//  Created by Michał Bogucki on 17/03/2025.
//

import Foundation
import SwiftUI

struct EditProfileScreen: View {
    
    @ObservedObject var presenter: EditProfilePresenter
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Edit Profile")
                .font(.title)
            
            Button("Save Changes") {
                presenter.didTapSaveChanges.send(())
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
    }
}
