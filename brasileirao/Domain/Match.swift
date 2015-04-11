//
//  Match.swift
//  brasileirao
//
//  Created by Felipe Benevides on 1/22/15.
//  Copyright (c) 2015 Globo. All rights reserved.
//

import Foundation

public class Match {
    
    public var identifier: Int
    public var date : String
    public var guestTeamId: Int
    public var guestTeamScore: Int
    public var homeTeamId: Int
    public var homeTeamScore: Int
    public var link: String
    public var place: String
    
    public var guestTeam: Team
    public var homeTeam: Team

    enum Keys: String {
        case ID = "id"
        case Date = "dt_of_match"
        case GuestTeam = "guest_team"
        case GuestTeamId = "guest_team_id"
        case GuestTeamScore = "guest_team_score"
        case homeTeam = "home_team"
        case HomeTeamId = "home_team_id"
        case HomeTeamScore = "home_team_score"
        case Link = "link_of_match"
        case Place = "where"
    }
    
    public init(json: JSON) {
        self.identifier = json[Keys.ID.rawValue].intValue
        self.date = json[Keys.Date.rawValue].stringValue
        
        self.guestTeamId = json[Keys.GuestTeamId.rawValue].intValue
        self.guestTeamScore = json[Keys.GuestTeamScore.rawValue].intValue
        
        self.homeTeamId = json[Keys.HomeTeamId.rawValue].intValue
        self.homeTeamScore = json[Keys.HomeTeamScore.rawValue].intValue
        
        self.link = json[Keys.Link.rawValue].stringValue
        self.place = json[Keys.Place.rawValue].stringValue
        
        self.guestTeam = Team(json: json[Keys.GuestTeam.rawValue])
        self.homeTeam = Team(json: json[Keys.homeTeam.rawValue])
    }
    
    public func friendlyTime() -> String {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        
        let formattedDate:NSDate = dateFormatter.dateFromString(self.date)!
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.stringFromDate(formattedDate)
    }
    
    public func title() -> String {
        return self.homeTeam.name + " x " + self.guestTeam.name
    }
    
}
