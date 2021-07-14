//
//  CellDetailsView.swift
//  Reciplease
//
//  Created by Manon Russo on 29/06/2021.
//

import UIKit

class ExtraInfoView: UIView {
    var recipe: Recipe? {
        didSet {
            refreshData()
        }
    }
    
    var parentStackView = UIStackView()
    var prepTimeStackView = UIStackView()
    var numbOfGuestStackView = UIStackView()
    var preparationTime = UILabel()
    var numberOfGuests = UILabel()
    var preparationTimeIcon = UIImageView()
    var numberOfGuestsIcon = UIImageView()
    
    func refreshData()  {
        // TODO: date formatter à checker, pas min
        if let numberOfGuests = recipe?.yield {
            self.numberOfGuests.text = " \(Int(numberOfGuests))"
            self.numberOfGuestsIcon.image = UIImage(systemName: "person.2.fill")
        } else {
            self.numberOfGuestsIcon.isHidden = true
            self.numberOfGuests.isHidden = true
        }
        if let preparationTime = recipe?.totalTime {
            let formatter = DateComponentsFormatter()
            formatter.unitsStyle = .brief
            let dateTochange = preparationTime * 60
            let formattedString = formatter.string(from: dateTochange)!//formatter.string(from:
            self.preparationTime.text = " \(formattedString)"
             print(formattedString)
            self.preparationTimeIcon.image = UIImage(systemName: "alarm.fill")
        } else {
            self.preparationTime.isHidden = true
            self.preparationTimeIcon.isHidden = true
        }
    }
    
    func configureView() {
        preparationTime.textAlignment = .natural
//        preparationTime.adjustsFontSizeToFitWidth = true
        preparationTime.font = UIFont.preferredFont(forTextStyle: .caption1)
        numberOfGuests.font = UIFont.preferredFont(forTextStyle: .caption1)
        numberOfGuests.textAlignment = .natural
        //        backgroundColor = .myPink
        parentStackView.translatesAutoresizingMaskIntoConstraints = false
        parentStackView.layer.masksToBounds = true
        //        parentStackView.layer.cornerRadius = 5
        parentStackView.spacing = 0
        parentStackView.distribution = .fillEqually
        parentStackView.axis = .vertical
        preparationTime.lineBreakMode = .byWordWrapping
        numbOfGuestStackView.translatesAutoresizingMaskIntoConstraints = false
        prepTimeStackView.translatesAutoresizingMaskIntoConstraints = false
        numbOfGuestStackView.axis = .horizontal
        numbOfGuestStackView.distribution = .fillProportionally
        prepTimeStackView.distribution = .fillProportionally
        preparationTimeIcon.tintColor = .label
        numberOfGuestsIcon.tintColor = .label
        prepTimeStackView.axis = .horizontal
        numbOfGuestStackView.addArrangedSubview(numberOfGuestsIcon)
        numbOfGuestStackView.addArrangedSubview(numberOfGuests)
        prepTimeStackView.addArrangedSubview(preparationTimeIcon)
        prepTimeStackView.addArrangedSubview(preparationTime)
        parentStackView.addArrangedSubview(prepTimeStackView)
        parentStackView.addArrangedSubview(numbOfGuestStackView)
        addSubview(parentStackView)
        
        // MARK: - Constraints
        NSLayoutConstraint.activate([
            preparationTimeIcon.heightAnchor.constraint(equalToConstant: 20),
            preparationTimeIcon.widthAnchor.constraint(equalToConstant: 20),
            numberOfGuestsIcon.heightAnchor.constraint(equalToConstant: 20),
            numberOfGuestsIcon.widthAnchor.constraint(equalToConstant: 20),
            
            parentStackView.widthAnchor.constraint(equalToConstant: 80),
            parentStackView.topAnchor.constraint(equalTo: topAnchor, constant: 2),
//            parentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
            self.bottomAnchor.constraint(equalTo: parentStackView.bottomAnchor, constant: 2),
            self.trailingAnchor.constraint(equalTo: parentStackView.trailingAnchor, constant: 2),
        ])
    }
}
