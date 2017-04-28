//
//  Basket.swift
//  solera
//
//  Created by Jakub Lawicki on 28.04.17.
//  Copyright © 2017 Jakub Lawicki. All rights reserved.
//

import UIKit

struct Item {
    var name: String
    var price: Decimal
}

final class Basket {
    var items = Array<(String, Decimal, Int)>()
    
    private init() {}
    
    static let sharedInstance = Basket()
    
    func addItem(item: Item) {
        let index = self.items.index {
            $0.0 == item.name
        }
        
        if let idx = index {
            var obj = self.items[idx]
            obj.2 += 1
            self.items[idx] = obj
        } else {
            let obj = (item.name, item.price, 1)
            self.items.append(obj)
        }
    }
}

let USDCurrencyFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.locale = Locale(identifier: "en_US")
    formatter.numberStyle = .currency
    return formatter
}()

let GlobalCurrencyFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    return formatter
}()
