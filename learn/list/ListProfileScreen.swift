//
//  ListProfileScreen.swift
//  Weather application_
//
//  Created by Michał Bogucki on 17/03/2025.
//

import Foundation
import SwiftUI

struct ListProfileScreen: View {
    
    @ObservedObject var presenter: ListProfilePresenter
       
       var body: some View {
           VStack {
               Text("List Profile")
               
               Button("Select Profile") {
                   presenter.didSelectProfile.send(())
               }
           }
       }
}
