//
//  EntityBase.swift
//  Eurofurence
//
//  Copyright © 2017 Eurofurence. All rights reserved.
//

import Foundation
import EVReflection

/**
Base type for allv unique entities supplied by the API.
Provides basic comparability by Id. Override in subclasses when proper
sortability is required and implement Sortable protocol!
*/
class EntityBase : EVObject, Comparable {
    var Id : String = ""
    var LastChangeDateTimeUtc : Date = Date()
	
	var IsDeleted : Bool = false
	
	static func == (lhs: EntityBase, rhs: EntityBase) -> Bool {
		return lhs.equalTo(rhs)
	}
	
	public dynamic func equalTo(_ rhs: EntityBase) -> Bool {
		return self.Id == rhs.Id
	}
	
	static func < (lhs: EntityBase, rhs: EntityBase) -> Bool {
		return lhs.lessThan(rhs)
	}
	
	public dynamic func lessThan(_ rhs: EntityBase) -> Bool {
		return self.Id < rhs.Id
	}

	override public func propertyMapping() -> [(keyInObject: String?,
	                                            keyInResource: String?)] {
		return [(keyInObject: "IsDeleted", keyInResource: nil)]
	}
}

/**
Marker protocol signifying that the entity provides a proper implementation
of the Comparable protocol and should be sorted where necessary.
*/
protocol Sortable {}
