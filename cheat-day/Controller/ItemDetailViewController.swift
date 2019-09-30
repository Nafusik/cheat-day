//
//  ItemViewController.swift
//  cheat-day
//
//  Created by Francesca Koulikov on 9/30/19.
//  Copyright © 2019 Francesca Koulikov. All rights reserved.
//

import UIKit
import ChameleonFramework

class ItemDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var itemLabel: UILabel!
    
    
    @IBOutlet weak var itemImage: UIImageView!
    
    
    @IBOutlet weak var itemTableView: UITableView!
    
    @IBOutlet weak var nutritionLabel: UILabel!
    
    var selectedItem : Item?
    
    var nutritionalArray = [Float]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItemDetail()
    }
    
    func loadItemDetail(){
        if let currentItem = selectedItem {
            guard let image : UIImage = UIImage(named: "food") else {
                fatalError("no image to select, breaking")
        }
        nutritionalArray = [currentItem.calories, 1.0]
        itemLabel.text = currentItem.title
        itemImage.image = image
        nutritionLabel.text = "Nutritional Fact for \(currentItem.title)"
    
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nutritionalArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cellForRow(at: indexPath)!
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = selectedItem?.title
        loadItemDetail()
        
//        guard let colorHex = selectedItem?.parentCategory. else {fatalError("error getting color")}
        updateNavBar(withHexCode: "1D9BF6")
        
        updateNavBar(withHexCode: "1D9BF6")
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        updateNavBar(withHexCode: "1D9BF6")
    }
    
    //MARK: - Nav Bar SEtup Methods
    func updateNavBar(withHexCode colorHexCode: String){
        guard let navBar = navigationController?.navigationBar else {fatalError("Navigation controller does not exist")}
        guard let navBarColor = UIColor(hexString: colorHexCode) else {fatalError("error setting nav color")}
        navBar.barTintColor = navBarColor
        navBar.tintColor = ContrastColorOf(navBarColor, returnFlat: true)
        navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : ContrastColorOf(navBarColor, returnFlat: true)]
    }
    
    
}
