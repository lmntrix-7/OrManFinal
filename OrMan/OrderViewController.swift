//
//  OrderViewController.swift
//  OrMan
//
//  Created by Rajat Jain on 30/07/18.
//  Copyright © 2018 Rajat Jain. All rights reserved.
//

import UIKit

class OrderViewController: UITableViewController {
    var products = [Product]()
    
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
         print( FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Info.plist"))

        
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
        return cell!
        }
    
    //Mark :- Adding new products
    
    @IBAction func addNewProduct(_ sender: UIBarButtonItem) {
        
    }
    
    
    
    

}
