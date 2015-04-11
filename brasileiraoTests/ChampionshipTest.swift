//
//  ChampionshipTest.swift
//  brasileirao
//
//  Created by Felipe Benevides on 1/23/15.
//  Copyright (c) 2015 Globo. All rights reserved.
//

import XCTest
import brasileirao

class ChampionshipTest: XCTestCase {
    
    var json: JSON!
    
    override func setUp() {
        super.setUp()
        
        self.json = JSON([
            "matches": [
                [
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
                ],
                [
                    "dt_of_match": "2014-11-15T21:00:00",
                    "guest_team": [
                        "id": 11,
                        "name": "Botafogo",
                        "shield": "http://s.glbimg.com//es/sde/f/organizacoes/2014/04/14/botafogo_30x30.png"
                    ],
                    "guest_team_id": 11,
                    "guest_team_score": 0,
                    "home_team": [
                        "id": 1,
                        "name": "Fluminense",
                        "shield": "http://s.glbimg.com//es/sde/f/organizacoes/2014/04/14/fluminense_30x30.png"
                    ],
                    "home_team_id": 1,
                    "home_team_score": 1,
                    "id": 31,
                    "link_of_match": "http://globoesporte.globo.com/futebol/brasileirao-serie-a/temporeal/15-11-2014/fluminense-botafogo/",
                    "where": "maracanã"
                ]
            ]
        ])
        
        
    }
    
    func testShouldGet2MatchesForTheChampionship() {
        var championship:Championship = Championship(json: self.json)
        XCTAssertEqual(championship.count(), 2);
    }
    
    func testShouldListTeamsOfAllMatches() {
        var championship:Championship = Championship(json: self.json)
        let teams:[Team] = championship.teams()
        
        var teamNames:[String] = teams.map({ team in team.name })
        
        XCTAssertEqual(teamNames, ["Fluminense", "Cruzeiro", "Botafogo"])
    }
    
    func testShouldGetMatchesByATeamIfItExists() {
        var championship:Championship = Championship(json: self.json)
        let fluminense:Team = championship.teams()[0]
      
        let matches:[Match] = championship.getMatchesByTeam(fluminense);
        
        XCTAssertEqual(matches[0].guestTeamId, fluminense.id)
    }

}
