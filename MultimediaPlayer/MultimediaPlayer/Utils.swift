//
//  Utils.swift
//  MultimediaPlayer
//
//  Created by admin on 6/12/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

func secondsToDuration(seconds: Double) -> String {
    let formatter = DateComponentsFormatter()
    formatter.unitsStyle = .positional
    formatter.allowedUnits = [ .hour, .minute, .second ]
    formatter.zeroFormattingBehavior = [ .pad ]

    return formatter.string(from: seconds)!
}
