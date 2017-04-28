//
//  ShopViewController.swift
//  solera
//
//  Created by Jakub Lawicki on 28.04.17.
//  Copyright © 2017 Jakub Lawicki. All rights reserved.
//

import UIKit

private let reuseIdentifier = "SHOP_CELL"

class ShopViewController: UICollectionViewController {
    
    var dataSource = Array<Item>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UINib(nibName: "ShopViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView!.backgroundColor = UIColor.white
        if let layout = self.collectionView!.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: 44, left: 10, bottom: 0, right: 10)
            
            let width = (UIScreen.main.bounds.width - layout.sectionInset.left - layout.sectionInset.right - layout.minimumInteritemSpacing) / 2
            layout.itemSize = CGSize(width: width, height: 160)
        }

        // Do any additional setup after loading the view.
        if let path = Bundle.main.path(forResource: "Items", ofType: "plist"), let dict = NSDictionary(contentsOfFile: path) {
            for (key, value) in dict {
                self.dataSource.append(Item(name: key as! String, price: (value as! NSNumber).decimalValue))
            }
        }
        
        self.title = "Shop"
        
        let basketButton = UIBarButtonItem(title: "My Basket", style: .done, target: self, action: #selector(ShopViewController.onBasketButtonTapped(sender:)))
        self.navigationItem.rightBarButtonItem = basketButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    
    func onBasketButtonTapped(sender: UIBarButtonItem) {
        let controller = BasketViewController(nibName: "BasketViewController", bundle: nil)
        self.navigationController?.pushViewController(controller, animated: true)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
        if let shopCell = cell as? ShopViewCell {
            shopCell.itemNameLabel.text = self.dataSource[indexPath.item].name
            shopCell.itemPriceLabel.text = USDCurrencyFormatter.string(from: self.dataSource[indexPath.item].price as NSDecimalNumber)
            shopCell.imageView.image = UIImage(named: self.dataSource[indexPath.item].name)
        }
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = self.dataSource[indexPath.item]
        Basket.sharedInstance.addItem(item: item)

        if let cell = self.collectionView?.cellForItem(at: indexPath) as? ShopViewCell {
            cell.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            UIView.animate(withDuration: 0.1, animations: {
                cell.transform = CGAffineTransform.identity
            })
        }
    }
}
