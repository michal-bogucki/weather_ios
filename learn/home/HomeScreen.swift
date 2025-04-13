//
//  HomeScreen.swift
//  Weather application_
//
//  Created by Michał Bogucki on 04/03/2025.
//

import Foundation
import SwiftUI

struct HomeScreen: View {
    
    @ObservedObject var presenter: HomePresenter
    
    var body: some View {
        VStack {
            Text("hello")
            
            Button("Tap") {
                presenter.didTapButton.send(())
            }
            
            Text(presenter.text)
        }
    }
}
