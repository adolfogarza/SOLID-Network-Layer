//
//  ViewController.swift
//  MarvelCharacters
//
//  Created by Adolfo Garza on 10/8/17.
//  Copyright © 2017 Adolfo Garza. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var activityBackground: UIView!
    fileprivate var APINetworkRequest: Any?
    var heroes: [MarvelCharacter] = []
    
    fileprivate func requestCharacters() {
        let charactersRequest = APIRequest(resource: CharactersResource())
        APINetworkRequest = charactersRequest
        charactersRequest.load { [weak self] (characters: [MarvelCharacter]?) in
            guard let data =  characters else { return }
            self?.heroes = data
            self?.tableView.reloadData()
            self?.activityIndicator.stopAnimating()
            self?.activityBackground.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        configureTableView()
        requestCharacters()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ViewController: UITableViewDataSource {
    
    fileprivate func configureTableView() {
        tableView.estimatedRowHeight = 30
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(UINib(nibName: SuperHeroCell.nibName , bundle: nil), forCellReuseIdentifier: SuperHeroCell.nibName)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SuperHeroCell.nibName, for: indexPath) as! SuperHeroCell
        cell.bind(hero: heroes[indexPath.row])
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
}
