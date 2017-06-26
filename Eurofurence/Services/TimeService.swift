//
//  TimeService.swift
//  Eurofurence
//
//  Copyright © 2017 Eurofurence. All rights reserved.
//

import Foundation
import ReactiveSwift

class TimeService {
	let currentTime = MutableProperty(Date())
	var offset: TimeInterval {
		get {
			return _offset
		}
		set(offset) {
			_offset = offset
			if timer != nil {
				tick()
			}
		}
	}

	private var lastTime = Date()
	private var _offset = TimeInterval(-365*24*60*60)
	private var timer: Timer? = nil

	init() {
		resume()
	}

	@objc
	func tick() {
		currentTime.swap(Date().addingTimeInterval(_offset))
	}

	func stop() {
		timer?.invalidate()
		timer = nil
	}

	func resume() {
		if timer == nil {
			timer = Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: #selector(TimeService.tick), userInfo: nil, repeats: true)
		}
	}
}