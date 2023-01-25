//
//  DateConverter.swift
//  SwiftUI-News-App
//
//  Created by Ruslan Spirkin on 1/24/23.
//

import Foundation

func dateConverter(initialDate: String) -> String{      //Takes in intialDate string and returns timestamp string
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX" //Sets dateformat to RFC3339
    formatter.timeZone = .current                       //Current time zone
    var timeStamp = ""
    
    let relativeFormatter = RelativeDateTimeFormatter() //RelativeDate formatter
    relativeFormatter.locale = .current                 //Current time zone
    
    if let date = formatter.date(from: initialDate) {   //Unwraps date given into func
//        print(date)
        let relativeDate = relativeFormatter.localizedString(for: date, relativeTo: Date()) //creates relative date from unwrapped date
        print(relativeDate)
        timeStamp = relativeDate                       //Sets return variable to relativeDate
    }
    return timeStamp                                   //Returns timestamp
}
