//
//  Location.swift
//  SpotCheck
//
//  Created by Andrew Chen on 10/13/16.
//  Copyright © 2016 Spot Check. All rights reserved.
//

import UIKit

struct Location {
    var name: String?
    var occupancy: Int?
    
    init(name: String?, occupancy: Int?) {
        self.name = name
        self.occupancy = occupancy
    }
}
