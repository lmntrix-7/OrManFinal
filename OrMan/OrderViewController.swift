//
//  OrderViewController.swift
//  OrMan
//
//  Created by Rajat Jain on 30/07/18.
//  Copyright © 2018 Rajat Jain. All rights reserved.
//

import UIKit
import CoreData

class OrderViewController: UITableViewController,scannedCode  {
   var products = [Product]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
override func viewDidLoad() {
        super.viewDidLoad()
         print( FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Info.plist"))

    loadOrders()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Mark:- Tableview datasource method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderListCell")
        let product = products[indexPath.row]
        cell?.textLabel?.text = product.order
        print(product)
        return cell!
        }
    
    
    
    //Mark :- Adding new products
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            if segue.identifier=="goToScanner"{
                let destinationVC = segue.destination as! ScannerViewController
                
               destinationVC.delegate = self
                
            }
        
    }
    
    @IBAction func scannerButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goToScanner", sender: self)
    }
    
    
    

    func userScannedData(data: String) {
        print("Displayed \(data)")
        let newProduct = Product(context: self.context)
        newProduct.order = data
        self.products.append(newProduct)
        self.saveOrders()
        
        
        
        
    }
    
    
    
    func saveOrders(){
        do{
            try context.save()
        }
        catch{
            print("Error saving data,\(error)")
            
        }
        tableView.reloadData()
    }
    
    func loadOrders(){
        let request : NSFetchRequest<Product> = Product.fetchRequest()
        do{
            products = try context.fetch(request)
            
        }
        catch{
            print("Error loading data,\(error)")
        }
        tableView.reloadData()
        
    }
    

}

    


