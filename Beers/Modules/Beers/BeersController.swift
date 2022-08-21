//
//  ViewController.swift
//  Beers
//
//  Created by Линар Нигматзянов on 04/08/2022.
//

import UIKit
import Kingfisher

final class  BeersController: UIViewController {
    private let mainTableView = UITableView()
    private var beersArray = [BeerElement]()
    private var filtredBeers = [BeerElement]()
    private let searchBar = UISearchController(searchResultsController: nil)
    private let detailVC = DetailController()
    private var searchBarIsEmpry: Bool {
        guard let text = searchBar.searchBar.text else {return false}
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return searchBar.isActive && !searchBarIsEmpry
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        setupNavControl()
        createTableView()
        serachBarConfig()
        request()

    }
    
    private func setupNavControl () {
        navigationItem.title = "Beers"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchBar
        
        guard let nc = self.navigationController else {return}
        setupAppearanceNavigationBar(with: nc)
    }
    
    private func request() {
        let decoder = JSONDecoder()
        guard let url = URL(string: ApiUrl.urlBeer.rawValue) else { fatalError("nil") }
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { data, response, error in
            guard let beer = try? decoder.decode([BeerElement].self, from: data ?? Data()) else {return}
            self.beersArray = beer
            DispatchQueue.main.async {
                self.mainTableView.reloadData()

            }
        }.resume()
    }
    private func serachBarConfig () {
        searchBar.searchBar.placeholder = "Search beer"
        searchBar.searchResultsUpdater = self
        searchBar.obscuresBackgroundDuringPresentation = false
        searchBar.definesPresentationContext = true
        
        
    }
    private func createTableView () {
        mainTableView.backgroundColor = .black
        mainTableView.register(BeersTableViewCell.self, forCellReuseIdentifier: BeersTableViewCell.identifier)
        mainTableView.frame = view.bounds
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.showsVerticalScrollIndicator = false
        mainTableView.separatorStyle = .none
   
        view.addSubview(mainTableView)
        
    }

    
   
}
extension BeersController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {return }
        filterContent(text)
    }
    
    private func filterContent(_ searchText: String) {
        filtredBeers = beersArray.filter({ BeerElement in
            return BeerElement.name.lowercased().contains(searchText.lowercased())
        })
        mainTableView.reloadData()
    }
    
}
extension BeersController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filtredBeers.count
        }
        return beersArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BeersTableViewCell
        cell.selectionStyle = .none
        
        var result: BeerElement
        
        if isFiltering {
            result = filtredBeers[indexPath.row]
        } else {
            result = beersArray[indexPath.row]
        }
        
        let view = UIView()
        let arrowImage = UIImageView(image: UIImage( named: "arrow"))
        arrowImage.frame = CGRect(x: 370, y: cell.contentView.bounds.height / 2 - 15, width: 30, height: 30)
        view.addSubview(arrowImage)
        cell.accessoryView = view
        let imageUrl = result.imageURL
        cell.beerNameLabel.text = result.name
        cell.brewedLabel.text = result.firstBrewed
        cell.foodPairingLabel.text = result.foodPairing.first
        cell.abvLabel.text = String(result.abv)
        cell.imageBeer.kf.indicatorType = .activity
        cell.imageBeer.kf.setImage(with: URL(string: imageUrl))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let result: BeerElement
        
        if isFiltering {
            result = filtredBeers[indexPath.row]
        } else {
            result = beersArray[indexPath.row]
        }
        
        
        detailVC.indexRow = result
        present(detailVC, animated: true)
      
    }
    
    
}
