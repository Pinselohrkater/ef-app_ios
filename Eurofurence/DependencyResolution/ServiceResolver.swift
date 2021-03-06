//
//  Service.swift
//  Eurofurence
//
//  Copyright © 2017 Eurofurence. All rights reserved.
//

import Foundation
import Dip

/**
Dependency container with registered instances for all services
*/
class ServiceResolver {

	private static let instance = ServiceResolver()
	/// Direct access to the wrapped DependencyContainer
	public static let container = ServiceResolver.instance._container

	private let _container = DependencyContainer()

	private init() {
		_container.register(.singleton) {
			TimeService()
		}
	}
}
