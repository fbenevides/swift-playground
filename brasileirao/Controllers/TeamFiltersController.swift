//
//  TeamDetailController.swift
//  brasileirao
//
//  Created by Felipe Benevides on 1/24/15.
//  Copyright (c) 2015 Globo. All rights reserved.
//

import UIKit
import PKHUD
import Haneke

class TeamFiltersController: UITableViewController, UIBarPositioningDelegate {
    
    var teams:[Team] = [Team]()
    var selectionDelegate:TeamSelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func loadTeamsOfChampionship(championship: Championship) {
        self.teams = championship.teams()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.teams.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let teamCell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("TeamCell", forIndexPath: indexPath) as UITableViewCell
        
        let currentTeam:Team = self.teams[indexPath.row] as Team
        teamCell.textLabel?.text = currentTeam.name
        
        teamCell.imageView?.sizeToFit()
        teamCell.imageView?.hnk_setImageFromURL(currentTeam.shieldUrl())
        
        teamCell.layoutMargins = UIEdgeInsetsZero;
        teamCell.preservesSuperviewLayoutMargins = false
        
        return teamCell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let team:Team = self.teams[indexPath.row] as Team
        selectionDelegate?.onSelectTeam(team)
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.closeModal()
    }
    
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        return .TopAttached
    }
    
    @IBAction func closeModal() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
