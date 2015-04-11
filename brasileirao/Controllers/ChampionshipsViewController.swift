//
//  ViewController.swift
//  brasileirao
//
//  Created by Felipe Benevides on 1/22/15.
//  Copyright (c) 2015 Globo. All rights reserved.
//

import UIKit
import PKHUD
import Darwin

protocol TeamSelectionDelegate {
    func onSelectTeam(team: Team)
}

class ChampionshipsViewController: UITableViewController, TeamSelectionDelegate {
    
    var matches:NSMutableArray = NSMutableArray()
    var filteredMatches:NSMutableArray = NSMutableArray()
    
    var championship:Championship?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadChampionship()
    }
    
    @IBAction func loadChampionship() {
        HUDController.sharedController.contentView = HUDContentView.ProgressView()
        HUDController.sharedController.show()
        self.tableView.hidden = true
        self.tableView.layoutMargins = UIEdgeInsetsZero
        
        self.navigationItem.prompt = nil
        
        self.matches = NSMutableArray()
        self.filteredMatches = NSMutableArray()
        
        Championship.load { (championship, error) -> Void in
            HUDController.sharedController.hide(animated: true)
            
            if error != nil {
                self.showErrorMessage()
            } else {
                self.championship = championship
                for match in championship.matches as NSArray {
                    self.matches.addObject(match)
                }
                
                self.tableView.reloadData()
                self.tableView.hidden = false
                
            }
        }
    }
    
    func showErrorMessage() {
        let alertController = UIAlertController(title: "Erro",
            message: "Error ao carregar os jogos. Tente novamente.", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .Destructive) { (action) in
            exit(0)
        }
        
        let retryAction = UIAlertAction(title: "Tentar Novamente", style: .Default) { (action) in
            self.loadChampionship()
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(retryAction)
        
        self.presentViewController(alertController, animated: true) {
            
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getCurrentDataSource().count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let matchCell:MatchCell = tableView.dequeueReusableCellWithIdentifier("MatchCell", forIndexPath: indexPath) as MatchCell
        
        matchCell.layoutMargins = UIEdgeInsetsZero;
        matchCell.preservesSuperviewLayoutMargins = false
        
        let match:Match = getCurrentMatch(indexPath)
        matchCell.setMatch(match)
        
        return matchCell
    }
    
    func getCurrentDataSource() -> NSMutableArray {
        var matches:NSMutableArray = self.matches
        
        if (filteredMatches.count > 0) {
            matches = self.filteredMatches
        }
        
        return matches
    }
    
    func getCurrentMatch(indexPath: NSIndexPath) -> Match {
        return getCurrentDataSource()[indexPath.row] as Match
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "MatchDetail") {
            
            var path: NSIndexPath = self.tableView.indexPathForSelectedRow()!
            let selectedMatch = getCurrentMatch(path)
            
            var detailView: MatchDetailController = segue.destinationViewController as MatchDetailController
            
            detailView.loadMatch(selectedMatch)
        } else if (segue.identifier == "TeamFilters") {
            var teamFiltersController: TeamFiltersController = segue.destinationViewController as TeamFiltersController
            teamFiltersController.selectionDelegate = self
            
            if self.championship != nil {
                teamFiltersController.loadTeamsOfChampionship(self.championship!)
            }
        }
    }

    func onSelectTeam(team: Team) {
        self.filteredMatches = NSMutableArray()
        
        var matches:[Match] = self.championship!.getMatchesByTeam(team)
        
        for match in matches as NSArray {
            self.filteredMatches.addObject(match)
        }
        
        self.navigationItem.prompt = team.name
        self.tableView.reloadData()
    }

}

