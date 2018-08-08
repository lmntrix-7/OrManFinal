//
//  ViewController.swift
//  OrMan
//
//  Created by Rajat Jain on 27/07/18.
//  Copyright © 2018 Rajat Jain. All rights reserved.
//

import UIKit
import CoreData


class CustomerViewController: UITableViewController {
var customers = [Customer]()
    
       let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    override func viewDidLoad() {
        super.viewDidLoad()
         print( FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Info.plist"))
        loadCustomers()
        // Do any additional setup after loading the view, typically from a nib.
    }

    // Mark :- Tableview datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customerList",for : indexPath)
        cell.textLabel?.text = customers[indexPath.row].name
        
        
        return cell
        
    }
    
    // Mark :- Tableview delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToOrderList", sender: self)
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! OrderViewController
        
        
        
    }
            
    
    

    
    
    
    // Mark :- Data manipulation methods
    
    func saveCustomers(){
        do{
            try context.save()
        }
        catch{
            print("Error saving data,\(error)")
            
        }
        tableView.reloadData()
    }
    
        func loadCustomers(){
            let request : NSFetchRequest<Customer> = Customer.fetchRequest()
            do{
                customers = try context.fetch(request)
                
            }
            catch{
                print("Error loading data,\(error)")
            }
            tableView.reloadData()
            
        }
        
    
    
    //Mark:- Add new customer
    @IBAction func addCustomer(_ sender: UIBarButtonItem) {
        var nameField = UITextField()
        var numberField = UITextField()
        let alert = UIAlertController(title: "Add new customer details", message: "", preferredStyle: .alert)
        
         let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
       let alert1 = UIAlertController(title: "Add customer number", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            print(nameField.text!)
            print("Name added succesfully")
            let newCustomer = Customer(context: self.context)
            newCustomer.name = nameField.text!
            
            self.customers.append(newCustomer)
            self.saveCustomers()
            }
        
        alert.addAction(action)
        alert.addAction(cancelAction)

        alert.addTextField { (field) in
            nameField = field
            nameField.placeholder = "Add new customer name"
        }
        present(alert,animated: true,completion: nil)
        
       
        
        
       
        
        
        
        
}
    
    

}

