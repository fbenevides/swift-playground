//
//  MatchTest.swift
//  brasileirao
//
//  Created by Felipe Benevides on 1/22/15.
//  Copyright (c) 2015 Globo. All rights reserved.
//

import UIKit
import XCTest
import brasileirao

class MatchTest: XCTestCase {
    
    var json: JSON!

    override func setUp() {
        super.setUp()
        
        self.json = JSON([
            "dt_of_match": "2014-12-07T19:00:00",
            "guest_team": [
                "id": 1,
                "name": "Fluminense",
                "shield": "http://s.glbimg.com//es/sde/f/organizacoes/2014/04/14/fluminense_30x30.png"
            ],
            "guest_team_id": 1,
            "guest_team_score": 1,
            "home_team": [
                "id": 2,
                "name": "Cruzeiro",
                "shield": "http://s.glbimg.com//es/sde/f/organizacoes/2014/04/14/cruzeiro_30x30.png"
            ],
            
            "home_team_id": 2,
            "home_team_score": 2,
            "id": 1,
            "link_of_match": "http://globoesporte.globo.com/futebol/brasileirao-serie-a/temporeal/07-12-2014/cruzeiro-fluminense/",
            "where": "mineirão"
            ])
    }

    func testShouldMapJSONToMatchCorrectly() {
        var match:Match = Match(json: self.json)
        
        XCTAssertEqual(match.identifier, 1)
        XCTAssertEqual(match.date, "2014-12-07T19:00:00")
        XCTAssertEqual(match.guestTeamId, 1)
        XCTAssertEqual(match.guestTeamScore, 1)
        XCTAssertEqual(match.homeTeamId, 2)
        XCTAssertEqual(match.homeTeamScore, 2)
        XCTAssertEqual(match.link, "http://globoesporte.globo.com/futebol/brasileirao-serie-a/temporeal/07-12-2014/cruzeiro-fluminense/")
        XCTAssertEqual(match.place, "mineirão")
        
        XCTAssertNotNil(match.guestTeam)
        XCTAssertNotNil(match.homeTeam)
    }
    
    func testFriendlyTimeOfAMatch() {
        var match:Match = Match(json: self.json)
        XCTAssertEqual(match.friendlyTime(), "19:00")
    }
    
    func testFriendlyTitleOfAMatch() {
        var match:Match = Match(json: self.json)
        XCTAssertEqual(match.title(), "Cruzeiro x Fluminense")
    }
    
}
