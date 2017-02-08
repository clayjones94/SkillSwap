//
//  SSSessionLocation.swift
//  SkillSwap
//
//  Created by Clay Jones on 2/3/17.
//  Copyright © 2017 SkillSwap. All rights reserved.
//

import UIKit
import MapKit

class SSLocation {
    var name: String?
    var address: String?
    
    init(name: String, address: String) {
        self.name = name
        self.address = address
    }
}
