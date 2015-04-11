//
//  TeamTest.swift
//  brasileirao
//
//  Created by Felipe Benevides on 1/23/15.
//  Copyright (c) 2015 Globo. All rights reserved.
//

import XCTest
import brasileirao

class TeamTest: XCTestCase {
    
    var json: JSON!

    override func setUp() {
        super.setUp()
        
        self.json = JSON([
            "id": 1,
                "name": "Fluminense",
                "shield": "http://s.glbimg.com//es/sde/f/organizacoes/2014/04/14/fluminense_30x30.png"
            ])
    }

    func testMapJSONToTeamCorrectly() {
        var team:Team = Team(json: self.json)
        
        XCTAssertEqual(team.id, 1)
        XCTAssertEqual(team.name, "Fluminense")
        XCTAssertEqual(team.shield, "http://s.glbimg.com//es/sde/f/organizacoes/2014/04/14/fluminense_30x30.png")
    }

}
