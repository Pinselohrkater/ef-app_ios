//
//  ContextResolver.swift
//  Eurofurence
//
//  Copyright © 2017 Eurofurence. All rights reserved.
//

import Foundation
import Dip

/**
Dependency container with registered instances for all data contexts and related classes
*/
class ContextResolver {

	private static let instance = ContextResolver()
	/// Direct access to the wrapped DependencyContainer
	public static let container = ContextResolver.instance._container

	private let _container = DependencyContainer()

	private init() {
		#if OFFLINE
			_container.register(.singleton) { apiUrl in
				MockApiConnection("mock://api")! as IApiConnection
			}
		#else
			_container.register(.singleton) { apiUrl in
				WebApiConnection(URL(string: "https://app.eurofurence.org/api/v2/")!) as IApiConnection
			}
		#endif

		_container.register(.singleton) {
			JsonDataStore() as IDataStore
		}
		_container.register(.singleton) {
			NavigationResolver() as INavigationResolver
		}

		_container.register(.singleton) {
			ReactiveDataContext(dataStore: $0, navigationResolver: $1) as IDataContext
		}

		_container.register(.singleton) {
			try ContextManager(apiConnection: $0, dataContext: self._container.resolve() as IDataContext,
					dataStore: self._container.resolve() as IDataStore)
		}
	}
}
