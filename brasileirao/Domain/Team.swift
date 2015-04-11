//
//  Team.swift
//  brasileirao
//
//  Created by Felipe Benevides on 1/23/15.
//  Copyright (c) 2015 Globo. All rights reserved.
//

import Foundation

public class Team : NSObject {
    
    public var id: Int
    public var name: String
    public var shield: String
    
    enum Keys: String {
        case ID = "id"
        case Name = "name"
        case Shield = "shield"
    }
    
    public init(json: JSON) {
        self.id = json[Keys.ID.rawValue].intValue
        self.name = json[Keys.Name.rawValue].stringValue
        self.shield = json[Keys.Shield.rawValue].stringValue
    }
    
    public override var hash: Int {
        return id.hashValue
    }
    
    public override func isEqual(object: AnyObject?) -> Bool {
        if let object = object as? Team {
            return self.name == object.name
        }
        
        return false
    }
    
    public func shieldUrl() -> NSURL {
        return NSURL(string: self.shield)!
    }
}