import UIKit

enum Day {
    case sunday, monday, tuesday, wednesday, thursday, friday, saturday
}

func isWeekend(day: Day) -> Bool {
    switch day {
    case .saturday, .sunday:
        return true
    case .monday, .tuesday, .wednesday, .thursday, .friday:
        return false
    }
}

var today = Day.monday
var yesterday: Day = .sunday

isWeekend(day: today)
isWeekend(day: yesterday)

