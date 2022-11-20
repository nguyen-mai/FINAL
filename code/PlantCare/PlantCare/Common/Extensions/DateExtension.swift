import Foundation
import UIKit

extension Date {
    
    func timeAgoDisplay() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        
        if secondsAgo == 0 {
            return Localization.Time.JustNow.localized()
        }
        if secondsAgo < minute {
            if secondsAgo == 1 {
                return "\(secondsAgo) " + Localization.Time.SecondAgo.localized()
            } else {
                return "\(secondsAgo) " + Localization.Time.SecondsAgo.localized()
            }
        } else if secondsAgo < hour {
            if secondsAgo / minute == 1 {
                return "\(secondsAgo / minute) " + Localization.Time.MinuteAgo.localized()
            } else {
                return "\(secondsAgo / minute) " + Localization.Time.MinutesAgo.localized()
            }
        } else if secondsAgo < day {
            if secondsAgo / hour == 1 {
                return "\(secondsAgo / hour) " + Localization.Time.HourAgo.localized()
            } else {
                return "\(secondsAgo / hour) " + Localization.Time.HoursAgo.localized()
            }
        } else if secondsAgo < week {
            if secondsAgo / day == 1 {
                return "\(secondsAgo / day) " + Localization.Time.DayAgo.localized()
            } else {
                return "\(secondsAgo / day) " + Localization.Time.DaysAgo.localized()
            }
        }
        
        if secondsAgo / week == 1 {
            return "\(secondsAgo / week) " + Localization.Time.WeekAgo.localized()
        } else {
            return "\(secondsAgo / week) " + Localization.Time.WeeksAgo.localized()
        }
    }
    
    func timeAgoDisplayShort() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        
        if secondsAgo == 0 {
            return Localization.Time.JustNow.localized()
        }
        if secondsAgo < minute {
            return "\(secondsAgo)s"
        } else if secondsAgo < hour {
            return "\(secondsAgo / minute)m"
        } else if secondsAgo < day {
            return "\(secondsAgo / hour)h"
        } else if secondsAgo < week {
            return "\(secondsAgo / day)d"
        }
        return "\(secondsAgo / week)wk"
    }
    
    func timeDayDisplay() -> String {
        let secondsAgo = Double(Date().timeIntervalSince(self))
        let date = Date(timeIntervalSinceNow: secondsAgo/1000.0)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = " hh:mm dd/MM/yyyy"
        return dateFormatter.string(from: date)
    }
}
