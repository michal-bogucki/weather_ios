//
//  ProfileScreen.swift
//  Weather application_
//
//  Created by Michał Bogucki on 13/03/2025.
//

import Foundation
import SwiftUI

struct ProfileScreen: View {
    
    @ObservedObject var presenter: ProfilePresenter
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Profile")
                .font(.title)
            
            Button(action: {
                print("Edit Profile tapped in View")
                presenter.didTapEditProfile.send(())
            }) {
                Text("Edit Profile")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
//            if let output = presenter.currentOutput {
//                Text("Current Output: \(String(describing: output))")
//                    .font(.caption)
//                    .padding()
//            }
        }
    }
}
