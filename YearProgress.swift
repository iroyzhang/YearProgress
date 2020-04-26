//
//  YearProgress.swift
//  YearProgress
//
//  Created by Roy Zhang on 2020/1/11.
//  Copyright © 2020 Roy Zhang. All rights reserved.
//

import Foundation

public class YearProgress {
    
    public enum Format: Int {
        case percentage = 0
        case fraction
    }
    
    public enum Accuracy: Int {
        case day = 0
        case hour
        case minute
        case second
    }
    
    // MARK: - Private Properties
    
    static private var calendar: Calendar {
        return Calendar.current
    }
    
    static private var now: Date {
        return Date()
    }
    
    static private let dateFormatter: DateFormatter = {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy"
        return dateformatter
    }()
    
    // MARK: - Public Properties
    
    static public var currentYear: Int {
        let currentYearText = YearProgress.dateFormatter.string(from: YearProgress.now)
        return Int(currentYearText) ?? 0
    }
    
    static public var totalDays: Int {
        var start = Date()
        var interval: TimeInterval = 0.0
        _ = YearProgress.calendar.dateInterval(of: .year, start: &start, interval: &interval, for: YearProgress.now)
        return YearProgress.calendar.dateComponents([.day], from: start, to: start.addingTimeInterval(interval)).day ?? 0
    }
    static public var pastDays: Int {
        guard let daysCount = YearProgress.calendar.ordinality(of: .day, in: .year, for: YearProgress.now) else { return 0 }
        return daysCount - 1
    }
    
    static public var totalHours: Int {
        return YearProgress.totalDays * 24
    }
    static public var pastHours: Int {
        guard let hoursCount = YearProgress.calendar.ordinality(of: .hour, in: .year, for: YearProgress.now) else { return 0 }
        return hoursCount - 1
    }
    
    static public var totalMinutes: Int {
        return YearProgress.totalDays * 24 * 60
    }
    static public var pastMinutes: Int {
        guard let minutesCount = YearProgress.calendar.ordinality(of: .minute, in: .year, for: YearProgress.now) else { return 0 }
        return minutesCount - 1
    }
    
    static public var totalSeconds: Int {
        return YearProgress.totalDays * 24 * 60 * 60
    }
    static public var pastSeconds: Int {
        guard let secondsCount = YearProgress.calendar.ordinality(of: .second, in: .year, for: YearProgress.now) else { return 0 }
        return secondsCount - 1
    }
    
    // MARK: - Public Methods
    
    static func description(inFormat format: Format, atAccuracy accuracy:Accuracy = .day, shouldDisplayDecimal: Bool = false) -> String {
        let percentageDescription = YearProgress.getPercentageDescription(atAccuracy: accuracy, shouldDisplayDecimal: shouldDisplayDecimal)
        let fractionDescription = YearProgress.getFractionDescription(atAccuracy: accuracy)
        
        switch format {
        case .percentage:
            return percentageDescription
        case .fraction:
            return fractionDescription
        }
    }
    
    // MARK: - Private Methods
    
    static private func getPercentageDescription(atAccuracy accuracy: Accuracy, shouldDisplayDecimal: Bool) -> String {
        let percentage: Double
        switch accuracy {
        case .day:
            percentage = Double(YearProgress.pastDays) / Double(YearProgress.totalDays) * 100
        case .hour:
            percentage = Double(YearProgress.pastHours) / Double(YearProgress.totalHours) * 100
        case .minute:
            percentage = Double(YearProgress.pastMinutes) / Double(YearProgress.totalMinutes) * 100
        case .second:
            percentage = Double(YearProgress.pastSeconds) / Double(YearProgress.totalSeconds) * 100
        }
        
        let percentageWithoutDecimalDescription = NumberFormatter.localizedString(from: (round(percentage) / 100) as NSNumber, number: .percent)
        if shouldDisplayDecimal {
            let percentageNumber = Double(String(format: "%.2f", percentage))
            if (percentageNumber != nil) {
                return "\(percentageNumber!)%"
            } else {
                return percentageWithoutDecimalDescription
            }
        } else {
            return percentageWithoutDecimalDescription
        }
    }
    
    static private func getFractionDescription(atAccuracy accuracy: Accuracy) -> String {
        switch accuracy {
        case .day:
            return "\(YearProgress.pastDays)/\(YearProgress.totalDays)"
        case .hour:
            return "\(YearProgress.pastHours)/\(YearProgress.totalHours)"
        case .minute:
            return "\(YearProgress.pastMinutes)/\(YearProgress.totalMinutes)"
        case .second:
            return "\(YearProgress.pastSeconds)/\(YearProgress.totalSeconds)"
        }
    }
    
}
