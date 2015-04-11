
//
//  Championship.swift
//  brasileirao
//
//  Created by Felipe Benevides on 1/22/15.
//  Copyright (c) 2015 Globo. All rights reserved.
//

import Foundation

public typealias ChampionshipResponse = (Championship, NSError?) -> Void

public class Championship {
    
    class var endpoint:String { return "http://matchesjson.herokuapp.com" }
    
    public var matches:NSMutableArray = NSMutableArray()
    
    private var cachedTeams:[Team]
    
    enum Keys: String {
        case Matches = "matches"
    }
    
    public init(json: JSON) {
        for (key: String, subJson: JSON) in json[Keys.Matches.rawValue] {
            self.matches.addObject(Match(json: subJson))
        }
        
        self.cachedTeams = [Team]()
    }
    
    public func count() -> Int {
        return self.matches.count
    }
    
    public func getMatchesByTeam(team: Team) -> [Match] {
        var matches:[Match] = self.matches as AnyObject as [Match]
        
        return matches.filter({ $0.homeTeamId == team.id || $0.guestTeamId == team.id })
    }

    public func teams() -> [Team] {
        var teams:[Team] = [Team]()
        
        if self.cachedTeams.count == 0 {
            for obj in self.matches  {
                let match = obj as Match
                
                teams.append(match.guestTeam)
                teams.append(match.homeTeam)
            }
            
            self.cachedTeams = teams.uniqueObjects();
        }
        
        return self.cachedTeams
    }
    
    public class func load(onLoad: ChampionshipResponse) {
        let url = NSURL(string: endpoint + "/matches.json")
        let request = NSURLRequest(URL: url!)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{(response:NSURLResponse!, responseData:NSData!, error: NSError!) -> Void in
            let statusCode:Int = (response as NSHTTPURLResponse).statusCode
            var errorCode:NSError? = nil
            
            if statusCode == 404 {
                errorCode = NSError(domain: "NotFound", code: statusCode, userInfo: nil)
            }
            
            onLoad(Championship(json: JSON(data: responseData)), errorCode)
        });
    }
}