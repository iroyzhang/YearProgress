# YearProgress
A tool for calculating the progress of year

## Usage
Information can be obtained through static access
```
// current year, for example 2020
let year = YearProgress.currentYear

// total days count
let totalDays = YearProgress.totalDays

// past days count
let pastDays = YearProgress.pastDays

// description for year progress
let description = YearProgress.description(inFormat: .percentage, atAccuracy: .day, shouldDisplayDecimal: true)
```

