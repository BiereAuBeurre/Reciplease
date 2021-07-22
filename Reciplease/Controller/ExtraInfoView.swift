//
//  CellDetailsView.swift
//  Reciplease
//
//  Created by Manon Russo on 29/06/2021.
//

import UIKit

final class ExtraInfoView: UIView {
    var recipe: Recipe? {
        didSet {
            refreshExtraViewData()
        }
    }
    private var dateComponentFormatter: DateComponentsFormatter {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .brief
        formatter.allowedUnits = [.hour,.minute]
        return formatter
    }
    private var parentStackView = UIStackView()
    private var prepTimeStackView = UIStackView()
    private var numbOfGuestStackView = UIStackView()
    private var preparationTime = UILabel()
    private  var numberOfGuests = UILabel()
    private var preparationTimeIcon = UIImageView()
    private var numberOfGuestsIcon = UIImageView()
    
    private func refreshExtraViewData()  {
        
        if let numberOfGuests = recipe?.yield {
            self.numberOfGuests.text = " \(Int(numberOfGuests))"
        }
        
        if let preparationTime = recipe?.totalTime, recipe?.totalTime != 0.0 {
            let duration = dateComponentFormatter.string(from: Double(preparationTime * 60))
            self.preparationTime.text = duration
        } else {
            self.preparationTime.text = "  - "
        }
    }
    
    func configureView() {
        preparationTime.textAlignment = .natural
        preparationTime.adjustsFontSizeToFitWidth = true
        preparationTime.font = UIFont.preferredFont(forTextStyle: .caption1)
        preparationTime.lineBreakMode = .byWordWrapping
        numberOfGuests.adjustsFontForContentSizeCategory = true
        numberOfGuests.font = UIFont.preferredFont(forTextStyle: .caption1)
        numberOfGuests.textAlignment = .natural
        
        parentStackView.translatesAutoresizingMaskIntoConstraints = false
        parentStackView.layer.masksToBounds = true
        parentStackView.spacing = 0
        parentStackView.distribution = .fillEqually
        parentStackView.axis = .vertical
        
        numbOfGuestStackView.translatesAutoresizingMaskIntoConstraints = false
        numbOfGuestStackView.axis = .horizontal
        numbOfGuestStackView.distribution = .fillProportionally
        
        prepTimeStackView.translatesAutoresizingMaskIntoConstraints = false
        prepTimeStackView.distribution = .fillProportionally
        prepTimeStackView.axis = .horizontal
        
        preparationTimeIcon.image = UIImage(systemName: "alarm.fill")
        numberOfGuestsIcon.image = UIImage(systemName: "person.2.fill")
        preparationTimeIcon.tintColor = .label
        numberOfGuestsIcon.tintColor = .label

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
            parentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
            self.bottomAnchor.constraint(equalTo: parentStackView.bottomAnchor, constant: 2),
            self.trailingAnchor.constraint(equalTo: parentStackView.trailingAnchor, constant: 2),
        ])
    }
}
