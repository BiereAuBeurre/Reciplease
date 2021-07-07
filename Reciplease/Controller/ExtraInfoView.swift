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
    
    var preparationTime = UILabel()
    var numberOfGuests = UILabel()
    
    
    func refreshData()  {
        // faire if let si on connait pas ces valeurs, ne pas afficher ou unknown
        // date formatter à checker, pas min
        
        
        if let numberOfGuests = recipe?.yield {
            self.numberOfGuests.attributedText = textWithAttachedIcon("person.2.fill", " \(Int(numberOfGuests))")
        } else {
//            self.numberOfGuests.attributedText = textWithAttachedIcon("person.2.fill", " -")
            self.numberOfGuests.isHidden = true

        }
        
        if let preparationTime = recipe?.totalTime {
            self.preparationTime.attributedText = textWithAttachedIcon("alarm.fill", " \(Int(preparationTime))")
        } else {
//            self.preparationTime.attributedText = textWithAttachedIcon("alarm.fill"," -")
            self.preparationTime.isHidden = true

        }
    }
    
    func textWithAttachedIcon(_ imageName: String, _ text: String) -> NSMutableAttributedString {
        //create attachmment
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: imageName)?.withTintColor(.label, renderingMode: .alwaysOriginal)
        
        imageAttachment.bounds = CGRect(x: 0, y: -3, width: imageAttachment.image!.size.width, height: (imageAttachment.image?.size.height)!)
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        let completeText = NSMutableAttributedString(string: "")
        completeText.append(attachmentString)
        let textAfterIcon = NSAttributedString(string: text)
        completeText.append(textAfterIcon)
        imageAttachment.adjustsImageSizeForAccessibilityContentSizeCategory = true

        return completeText
    }
    
    
    func configureView() {
        
        preparationTime.textAlignment = .natural
        preparationTime.font = UIFont.preferredFont(forTextStyle: .caption1)
        numberOfGuests.font = UIFont.preferredFont(forTextStyle: .caption1)
        numberOfGuests.textAlignment = .natural
        //        backgroundColor = .purple
        parentStackView.translatesAutoresizingMaskIntoConstraints = false
        parentStackView.layer.masksToBounds = true
        //        parentStackView.layer.cornerRadius = 5
        parentStackView.spacing = 0
        parentStackView.distribution = .fillEqually
        parentStackView.axis = .vertical
        parentStackView.addArrangedSubview(numberOfGuests)
        parentStackView.addArrangedSubview(preparationTime)
        addSubview(parentStackView)
        
        // MARK: - Constraints
        NSLayoutConstraint.activate([
            parentStackView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            
            parentStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            parentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            parentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4)
        ])
        
    }
}

