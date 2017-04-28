//
//  BasketViewController.swift
//  solera
//
//  Created by Jakub Lawicki on 28.04.17.
//  Copyright © 2017 Jakub Lawicki. All rights reserved.
//

import UIKit

private let reuseIdentifier = "BASKET_CELL"

class BasketViewController: UITableViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        self.tableView.register(UINib(nibName:"BasketCell", bundle:nil), forCellReuseIdentifier: reuseIdentifier)
        
        self.title = "Basket"
        
        let checkoutButton = UIBarButtonItem(title: "Checkout", style: .done, target: self, action: #selector(BasketViewController.onCheckoutButtonTapped(sender:)))
        self.navigationItem.rightBarButtonItem = checkoutButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onCheckoutButtonTapped(sender: UIBarButtonItem) {
        let controller = CheckoutViewController(nibName: "CheckoutViewController", bundle: nil)
        self.navigationController?.pushViewController(controller, animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Basket.sharedInstance.items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        if let c = cell as? BasketCell {
            let item = Basket.sharedInstance.items[indexPath.row]
            
            c.textLabel?.text = item.0
            c.detailTextLabel?.text = String(item.2) + " x " + USDCurrencyFormatter.string(from: item.1 as NSDecimalNumber)!
            c.plusButtonCallback = {
                var item = Basket.sharedInstance.items[indexPath.row]
                item.2 += 1
                Basket.sharedInstance.items[indexPath.row] = item
                c.detailTextLabel?.text = String(item.2) + " x " + USDCurrencyFormatter.string(from: item.1 as NSDecimalNumber)!
            }
            
            c.minusButtonCallback = {
                var item = Basket.sharedInstance.items[indexPath.row]
                item.2 = max(0, item.2 - 1)
                Basket.sharedInstance.items[indexPath.row] = item
                c.detailTextLabel?.text = String(item.2) + " x " + USDCurrencyFormatter.string(from: item.1 as NSDecimalNumber)!
            }
        }

        return cell
    }

    override func tableView(_ tableView: UITableView,
                   shouldHighlightRowAt indexPath: IndexPath) -> Bool{
        return false
    }
    
}
