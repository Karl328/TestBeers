//
//  BeersTableViewCell.swift
//  Beers
//
//  Created by Линар Нигматзянов on 04/08/2022.
//

import UIKit

final class BeersTableViewCell: UITableViewCell {
    static let identifier = "Cell"
    private let viewContent = UIView()
    private let abvView = UIView()
    
    public let beerNameLabel = UILabel()
    public let imageBeer = UIImageView()
    public let brewedLabel = UILabel()
    public let foodPairingLabel = UILabel()
    public let abvLabel = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        labelConfig()
        viewContentConfig()
        createAbvView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        beerNameLabel.frame = CGRect(x: 100, y: 10, width: 100, height: contentView.bounds.height / 3)
        imageBeer.frame = CGRect(x: 20, y: viewContent.frame.height / 2 - 75, width: 50, height: 150)
        brewedLabel.frame = CGRect(x: 100, y: 50, width: 100, height: contentView.bounds.height / 3)
        foodPairingLabel.frame = CGRect(x: 100, y: 100, width: 100, height: contentView.bounds.height / 3)
        abvView.frame = CGRect(x: 230, y: contentView.bounds.height / 2 - 50, width: 100, height: 100)
    }
    
    private func viewContentConfig() {
        viewContent.frame = CGRect(x: 20, y: 0, width: UIScreen.main.bounds.width - 40, height: 180)
        viewContent.backgroundColor = .white
        viewContent.layer.cornerRadius = 50
        viewContent.addSubview(beerNameLabel)
        viewContent.addSubview(imageBeer)
        viewContent.addSubview(brewedLabel)
        viewContent.addSubview(foodPairingLabel)
        viewContent.addSubview(abvView)
        contentView.addSubview(viewContent)
    }
    
    private func createAbvView() {
        let label = UILabel()
        label.textColor = .white
        label.text = "ABV"
        label.frame = CGRect(x: 0, y: 9, width: 100, height: 20)
        label.textAlignment = .center
        abvLabel.textColor = .white
        abvLabel.textAlignment = .center
        abvLabel.frame = CGRect(x: 0, y: 40, width: 100, height: 30)
        abvLabel.font = .boldSystemFont(ofSize: 30)
        abvView.backgroundColor = .black
        abvView.layer.cornerRadius = 50
        
        abvView.addSubview(abvLabel)
        abvView.addSubview(label)
    }
    private func labelConfig() {
        //beerNameLabel label config
        beerNameLabel.textColor = .black
        beerNameLabel.textAlignment = .left
        beerNameLabel.adjustsFontSizeToFitWidth = true
        beerNameLabel.numberOfLines = 0
        //brewedLabel label config
        brewedLabel.textColor = .black
        brewedLabel.textAlignment = .left
        brewedLabel.adjustsFontSizeToFitWidth = true
        brewedLabel.numberOfLines = 0
        //foodPairingLabel config
        foodPairingLabel.textColor = .black
        foodPairingLabel.textAlignment = .left
        foodPairingLabel.adjustsFontSizeToFitWidth = true
        foodPairingLabel.numberOfLines = 0
    }
    private func imageConfig() {
        imageBeer.contentMode = .scaleAspectFill
        imageBeer.clipsToBounds = true
    }
}
