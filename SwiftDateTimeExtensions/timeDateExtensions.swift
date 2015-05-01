//
// timeDateExtensions.swift
// Created by Axel Schlueter on 4.6.14.
// Updated for Swift 1.2 by Tim Ellis @ 1-MAY-2015
//
// The MIT License (MIT)
// Copyright (c) 2014 Axel Schlueter
// Copyright (c) 2015 Tim Ellis
//
// Help from: https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/AdvancedOperators.html


import Foundation


extension NSDateComponents {
	/** returns the current date plus the receiver's interval */
	var fromNow: NSDate {
		let cal = NSCalendar.currentCalendar()
		return cal.dateByAddingComponents(self, toDate: NSDate(), options: nil)!
	}
	
	/** returns the current date minus the receiver's interval */
	var ago: NSDate {
		let cal = NSCalendar.currentCalendar()
		return cal.dateByAddingComponents(-self, toDate: NSDate(), options: nil)!
	}
}

/** helper method to DRY the code a little, adds or subtracts two sets of date components */
func combineComponents(left: NSDateComponents,
	right: NSDateComponents,
	multiplier: Int) -> NSDateComponents
{
	let comps = NSDateComponents()
	comps.second = ((left.second != Int(Int(NSDateComponentUndefined)) ? left.second : 0) +
		(right.second != Int(Int(NSDateComponentUndefined)) ? right.second : 0) * multiplier)
	comps.minute = ((left.minute != Int(Int(NSDateComponentUndefined)) ? left.minute : 0) +
		(right.minute != Int(Int(NSDateComponentUndefined)) ? right.minute : 0) * multiplier)
	comps.hour = ((left.hour != Int(Int(NSDateComponentUndefined)) ? left.hour : 0) +
		(right.hour != Int(Int(NSDateComponentUndefined)) ? right.hour : 0) * multiplier)
	comps.day = ((left.day != Int(Int(NSDateComponentUndefined)) ? left.day : 0) +
		(right.day != Int(Int(NSDateComponentUndefined)) ? right.day : 0) * multiplier)
	comps.month = ((left.month != Int(Int(NSDateComponentUndefined)) ? left.month : 0) +
		(right.month != Int(Int(NSDateComponentUndefined)) ? right.month : 0) * multiplier)
	comps.year = ((left.year != Int(Int(NSDateComponentUndefined)) ? left.year : 0) +
		(right.year != Int(Int(NSDateComponentUndefined)) ? right.year : 0) * multiplier)
	return comps}

/** adds the two sets of date components */
func +(left: NSDateComponents, right: NSDateComponents) -> NSDateComponents {
	return combineComponents(left, right, 1)
}

/** subtracts the two sets of date components */
func -(left: NSDateComponents, right: NSDateComponents) -> NSDateComponents {
	return combineComponents(left, right, -1)
}

/** negates the two sets of date components */
prefix func -(comps: NSDateComponents) -> NSDateComponents {
	let result = NSDateComponents()
	if(comps.second != Int(NSDateComponentUndefined)) { result.second = -comps.second }
	if(comps.minute != Int(NSDateComponentUndefined)) { result.minute = -comps.minute }
	if(comps.hour != Int(NSDateComponentUndefined)) { result.hour = -comps.hour }
	if(comps.day != Int(NSDateComponentUndefined)) { result.day = -comps.day }
	if(comps.month != Int(NSDateComponentUndefined)) { result.month = -comps.month }
	if(comps.year != Int(NSDateComponentUndefined)) { result.year = -comps.year }
	return result
}

/** Compound Assignment Addition Operator */
func +=(inout left: NSDateComponents, right: NSDateComponents) {
	left = left + right
}

func -=(inout left: NSDateComponents, right: NSDateComponents) {
	left = left - right
}

/** functions to convert integers into various time intervals */
extension Int {
	var minutes: NSDateComponents {
		let comps = NSDateComponents()
		comps.minute = self;
		return comps
	}
	
	var hours: NSDateComponents {
		let comps = NSDateComponents()
		comps.hour = self;
		return comps
	}
	
	var days: NSDateComponents {
		let comps = NSDateComponents()
		comps.day = self;
		return comps
	}
	
	var weeks: NSDateComponents {
		let comps = NSDateComponents()
		comps.day = 7 * self;
		return comps
	}
	
	var months: NSDateComponents {
		let comps = NSDateComponents()
		comps.month = self;
		return comps
	}
	
	var years: NSDateComponents {
		let comps = NSDateComponents()
		comps.year = self;
		return comps
	}
}

/** examples on how to use the library */
func tests() {
	println("now:                   \(NSDate())")
	println("8 days later:          \(8.days.fromNow)")
	println("2 weeks before:        \(2.weeks.ago)")
	println("5 days, 3 month later: \((5.days + 3.months).fromNow)")
}