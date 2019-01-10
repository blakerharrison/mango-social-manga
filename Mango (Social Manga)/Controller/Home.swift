//
//  Home.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 8/17/18.
//  Copyright © 2018 Blake Harrison. All rights reserved.
//

import UIKit

class Home: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: - Outlets
    @IBOutlet weak var homeView: UIView!

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchTextField =  UITextField(frame: CGRect(x: 20, y: 100, width: 200, height: 100))
        searchTextField.placeholder = "search..."
        searchTextField.font = UIFont.init(name: "BigNoodleTitling", size: 50.0)
        searchTextField.backgroundColor = UIColor.clear
        searchTextField.borderStyle = UITextField.BorderStyle.none
        searchTextField.autocorrectionType = UITextAutocorrectionType.no
        searchTextField.keyboardType = UIKeyboardType.default
        searchTextField.returnKeyType = UIReturnKeyType.done
        searchTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        searchTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
//        sampleTextField.delegate = self
        searchTextField.becomeFirstResponder()
        self.view.addSubview(searchTextField)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    //MARK: - Actions
    @IBAction func menuTapped(_ sender: Any) {
    }
    
    //MARK: - CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return usersFavoriteMangas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCell", for: indexPath)
        if let image = cell.viewWithTag(100) as? UIImageView {
            image.image = usersFavoriteMangas[indexPath.row].mangaCover
            image.addShadow()
        }
        
        if let label = cell.viewWithTag(101) as? UILabel  {
            label.text = usersFavoriteMangas[indexPath.row].mangaTitles
            label.addLabelShadow()
        }
        return cell
    }
    
}

