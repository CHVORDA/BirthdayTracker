//
//  Birthday.swift
//  BirthdayTracker
//
//  Created by chvorda on 4/5/19.
//  Copyright © 2019 chvorda. All rights reserved.
//

import Foundation

class Birthday {
    let firstName: String
    let lastName: String
    let birthdate: Date
    
    init(firstName: String, lastName: String, birthdate: Date) {
        self.firstName = firstName
        self.lastName = lastName
        self.birthdate = birthdate
    }
    
}
