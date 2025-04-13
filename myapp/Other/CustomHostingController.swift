//  CustomHostingController.swift
//  Weather application_
//
//  Created by Michał Bogucki on 13/03/2025.
//

import SwiftUI

// navigationController - [CustomHostingController<A>, B, C]

class CustomHostingController<Content: View> : UIHostingController<Content> {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //navigationController?.navigationBar.prefersLargeTitles = true
    }
}
