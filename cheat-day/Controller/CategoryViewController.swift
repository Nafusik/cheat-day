//
//  CategoryViewController.swift
//  todoey
//
//  Created by Francesca Koulikov on 9/11/19.
//  Copyright © 2019 Francesca Koulikov. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var categoryImageStringSelected = ""
    
    let arrayOfPics = ["breakfast", "fastfood", "icecream", "cakes", "chocolates"]

    let realm = try! Realm()
    
    var categories: Results<Category>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        tableView.separatorStyle = .none
    }
    
    //MARK - Picker View functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayOfPics.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrayOfPics[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(arrayOfPics[row])
        
        categoryImageStringSelected = arrayOfPics[row]
    }

    //Mark - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let category = categories?[indexPath.row]{
            guard let image : UIImage = UIImage(named: category.image) else {
                fatalError("no image to select, breaking")
            }
            cell.textLabel?.text  = category.name            
            
            guard let categoryColor = UIColor(hexString: category.color) else {fatalError()}
            cell.backgroundColor = categoryColor
            cell.textLabel?.textColor = ContrastColorOf(categoryColor, returnFlat: true)
            cell.imageView?.image = image
        }
        
       
    

        return cell
    }
    
    
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ItemViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    //MARK - Data Manupulation Methods
    func save(category: Category){
        do {
            try realm.write{
                realm.add(category)
            }
        }
        catch {
            print("ERror saving category \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategories(){
        
        categories = realm.objects(Category.self)
        
        tableView.reloadData()
        
    }
    
    // MARK - Delete data from swipe
    override func updateModel(at indexPath: IndexPath) {
        if let category = self.categories?[indexPath.row] {
            do {
                try self.realm.write{
                    self.realm.delete(category)
                }
            }
            catch {
                print("Error deleting category, \(error)")
            }

            //                tableView.reloadData()

        }
    }

    //MARK - Add category
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "category types", message: "\n\n\n\n\n\n", preferredStyle: .alert)
        alert.isModalInPopover = true
        
        let pickerFrame = UIPickerView(frame: CGRect(x: 5, y: 20, width: 250, height: 140))
        
        alert.view.addSubview(pickerFrame)
        pickerFrame.dataSource = self
        pickerFrame.delegate = self
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in

            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.color = UIColor.randomFlat.hexValue()
            newCategory.image = self.categoryImageStringSelected


            self.save(category: newCategory)
        }

        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Category"
            textField = alertTextField
        }
 
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(action)
        
        self.present(alert,animated: true, completion: nil )

    }
    
}

