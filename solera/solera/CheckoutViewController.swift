//
//  CheckoutViewController.swift
//  solera
//
//  Created by Jakub Lawicki on 28.04.17.
//  Copyright © 2017 Jakub Lawicki. All rights reserved.
//

import UIKit

let url = URL(string: "http://www.apilayer.net/api/live?access_key=b3e85acd9d86716bbf8f96a70918816f&format=1&source=USD&currencies=USD,EUR,CHF,GBP,PLN")

class CheckoutViewController: UIViewController {
    
    @IBOutlet var originalPriceLabel: UILabel!
    @IBOutlet var currencyControl: UISegmentedControl!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    private var quotesDictionary = Dictionary<String, AnyObject>()
    private var sum = NSDecimalNumber.zero

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isTranslucent = false
        
        // calculate the basket value in USD
        self.sum = NSDecimalNumber.zero
        for item in Basket.sharedInstance.items {
            let itemCost = NSDecimalNumber(decimal: item.1)
            let itemAmount = NSDecimalNumber(decimal: NSNumber(integerLiteral: item.2).decimalValue)
            let amountToadd = itemCost.multiplying(by: itemAmount)
            self.sum = self.sum.adding(amountToadd)
        }
        
        self.originalPriceLabel.text = USDCurrencyFormatter.string(from: self.sum)
        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            self.handleCurrencyCallback(data: data, response: response, error: error)
        }
        task.resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func handleCurrencyCallback(data: Data?, response: URLResponse?, error: Error?) {
        guard error == nil else {
            print(error!)
            return
        }
        guard let data = data else {
            print("Data is empty")
            return
        }
        
        let json = try! JSONSerialization.jsonObject(with: data, options: [])
        //            print(json)
        
        if let jsonAsDict = json as? NSDictionary {
            if let quotes = jsonAsDict["quotes"] {
                self.quotesDictionary = quotes as! Dictionary<String, AnyObject>
            }
        }
        
        let idx = self.currencyControl.selectedSegmentIndex
        let key = "USD" + self.currencyControl.titleForSegment(at: idx)!
        
        let rate = NSDecimalNumber(decimal:((self.quotesDictionary[key] as? NSNumber)?.decimalValue)!)
        
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            
            let sumInCurrency = self.sum.multiplying(by: rate)
            
            var localeIdentifier = "en_US"
            switch self.currencyControl.selectedSegmentIndex {
            case 0:
                localeIdentifier = "en_US"
            case 1:
                localeIdentifier = "en_EU"
            case 2:
                localeIdentifier = "de_CH"
            case 3:
                localeIdentifier = "en_UK"
            case 4:
                localeIdentifier = "pl_PL"
            default:
                localeIdentifier = "en_US"
            }
            GlobalCurrencyFormatter.locale = Locale(identifier: localeIdentifier)
            
            self.priceLabel.text = GlobalCurrencyFormatter.string(from: sumInCurrency)
        }
    }

    @IBAction func onCurrencyChanged(sender: UISegmentedControl) {
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            self.handleCurrencyCallback(data: data, response: response, error: error)
        }
        
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        task.resume()
    }
}
