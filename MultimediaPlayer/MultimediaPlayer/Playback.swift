//
//  Playback.swift
//  MultimediaPlayer
//
//  Created by admin on 6/12/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

struct Playback: Identifiable, Codable {
    var id: UUID = UUID()
    
    var filename: String
    var position: Double
    var duration: Double
}
