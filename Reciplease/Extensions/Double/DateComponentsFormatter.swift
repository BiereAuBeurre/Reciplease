//
//  DateComponentsFormatter.swift
//  Reciplease
//
//  Created by Manon Russo on 19/07/2021.
//

import Foundation

extension Double {
    
    func timeFormatter() -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .brief
        formatter.allowedUnits = [.hour,.minute]
        let dateTochange = self * 60
        let formattedString = formatter.string(from: dateTochange)!
        return formattedString
    }
}
