//
//  Section.swift
//  Foodzo
//
//  Created by Sagar on 25/10/1939 Saka.
//  Copyright © 1939 Sadyogi. All rights reserved.
//

import Foundation
struct Section {
    var genre : String!
    var movies  : [String]!
    var picture : [String]!
    var expanded : Bool!

    init(genre:String , movies:[String] ,picture:[String], expanded :Bool) {
        self.genre = genre
        self.movies = movies
        self.picture = picture
        self.expanded = expanded
    }
}
