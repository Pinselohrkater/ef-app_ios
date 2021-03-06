//
//  Iso8601DateFormatter.swift
//  Eurofurence
//
//  Copyright © 2017 Eurofurence. All rights reserved.
//

import Foundation

/**
Simple, hacky fix to support creating Dates from ISO8601 timestamps with and
without fractional seconds.
*/
class Iso8601DateFormatter : DateFormatter {
	static let instance = Iso8601DateFormatter()
	let noFractionsDateFormatter = DateFormatter()
	
	override init() {
		super.init()
		
		locale = Locale(identifier: "en_US_POSIX")
		timeZone = TimeZone(secondsFromGMT: 0)
		dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSS'Z'"
		
		noFractionsDateFormatter.locale = Locale(identifier: "en_US_POSIX")
		noFractionsDateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
		noFractionsDateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override func date(from string: String) -> Date? {
		if let date = noFractionsDateFormatter.date(from: string) {
			return date
		}
		
		return super.date(from: string)
	}
	
	override func string(from date: Date) -> String {
		return super.string(from: date)
	}
}
