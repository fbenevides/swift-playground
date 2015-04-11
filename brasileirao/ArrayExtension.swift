//
//  ArrayExtension.swift
//  brasileirao
//
//  Created by Felipe Benevides on 1/24/15.
//  Copyright (c) 2015 Globo. All rights reserved.
//

import Foundation

extension Array {
    func containsObject(obj: NSObject) -> Bool {
        if self.isEmpty {
            return false
        }
        
        let filtered = self.filter { ($0 as NSObject).isEqual(obj) }
        return !filtered.isEmpty
    }
    
    func uniqueObjects() -> Array {
        var result = [T]()
        
        for item in self {
           if !result.containsObject(item as NSObject) {
                result.append(item)
            }
        }
        
        return result
    }
}