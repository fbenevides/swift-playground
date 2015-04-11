//
//  MatchCell.swift
//  brasileirao
//
//  Created by Felipe Benevides on 1/23/15.
//  Copyright (c) 2015 Globo. All rights reserved.
//

import UIKit
import Haneke

class MatchCell: UITableViewCell {
    
    @IBOutlet weak var homeTeam: UILabel!
    @IBOutlet weak var homeTeamScore: UILabel!
    
    @IBOutlet weak var guestTeam: UILabel!
    @IBOutlet weak var guestTeamScore: UILabel!
    
    @IBOutlet weak var place: UILabel!
    
    @IBOutlet weak var homeShield: UIImageView!
    @IBOutlet weak var guestShield: UIImageView!
    
    func setMatch(match: Match) {
        self.homeTeam.text = match.homeTeam.name
        self.homeTeamScore.text = String(match.homeTeamScore)
        
        self.guestTeam.text = match.guestTeam.name
        self.guestTeamScore.text = String(match.guestTeamScore)
        
        self.place.text = match.place.uppercaseString + " " + match.friendlyTime()
        
        self.homeShield.hnk_setImageFromURL(match.homeTeam.shieldUrl())
        self.guestShield.hnk_setImageFromURL(match.guestTeam.shieldUrl())
    }

}