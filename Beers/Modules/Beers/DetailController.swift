//
//  DetailController.swift
//  Beers
//
//  Created by Линар Нигматзянов on 07/08/2022.
//

import UIKit
import Kingfisher

class DetailController: UIViewController {
    
    private let imageBeer = UIImageView()
    private let beerNameLabel = UILabel()
    private let closeButton = UIButton()
    private let descriptionLabel = UILabel()

    public var indexRow: BeerElement?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        imageBeer.isHidden = false
        updateView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        labelsConfig()
        closeButtonConfig()
    
    }
    
 
    private func updateView() {
        beerNameLabel.text = indexRow?.name
        imageBeerConfig()
        descriptionLabel.text = indexRow?.beerDescription
        
    }
    
    private func closeButtonConfig () {
        closeButton.setTitle("Close", for: .normal)
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.setTitleColor(.red, for: .highlighted)
        closeButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        closeButton.frame = CGRect(x: 5, y: 5, width: 100, height: 50)
        closeButton.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
        view.addSubview(closeButton)
    }
    
    @objc func closeButtonAction () {
        indexRow = nil
        updateView()
        imageBeer.isHidden = true
        dismiss(animated: true)
    }
    
    private func imageBeerConfig() {
        guard let imageURL = indexRow?.imageURL else {return }
        imageBeer.kf.setImage(with: URL(string: imageURL))
        imageBeer.kf.indicatorType = .activity
        imageBeer.frame = CGRect(x: view.bounds.width / 2 - 50, y: 150, width: 100, height: 300)
        view.addSubview(imageBeer)
    }
    private func labelsConfig () {
        beerNameLabel.textColor = .white
        beerNameLabel.font = .boldSystemFont(ofSize: 30)
        beerNameLabel.textAlignment = .center
        beerNameLabel.adjustsFontSizeToFitWidth = true
        beerNameLabel.frame = CGRect(x: view.bounds.width / 2 - 150, y: 50, width: 300, height: 100)
        view.addSubview(beerNameLabel)
        
        descriptionLabel.textColor = .white
        descriptionLabel.textAlignment = .left
        descriptionLabel.numberOfLines = 0
        descriptionLabel.frame = CGRect(x: 5, y: 450, width: view.bounds.width, height: 200)
        view.addSubview(descriptionLabel)
    }
    

}
