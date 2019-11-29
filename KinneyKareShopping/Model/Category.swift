//
//  Category.swift
//  KinneyKareShopping
//
//  Created by Kinney Kare on 11/29/19.
//  Copyright © 2019 Kinney Kare. All rights reserved.
//

import Foundation
import UIKit

class Category {
    
    var id: String
    var name: String
    var image: UIImage?
    var imageName: String?
    
    init(_name: String, _imageName: String) {
        
        id = ""
        name = _name
        imageName  = _imageName
        image = UIImage(named: _imageName)
    }
    
    init(_dictionary: NSDictionary) {
        id = _dictionary[cOBJECTID] as! String
        name = _dictionary[cNAME] as! String
        image = UIImage(named: _dictionary[cIMAGENAME] as? String ?? "")
    }
}

//MARK: Download category from Firebase

func downloadCategoriesFromFirebase(completion: @escaping (_ categoryArray: [Category]) -> Void) {
   
    var categoryArray: [Category] = []
    
    FirebaseReference(.Category).getDocuments { (snapshot, error) in
        guard let snapshot = snapshot else {
            completion(categoryArray)
            return
        }
        if !snapshot.isEmpty {
            for categoryDict in snapshot.documents {
                print("Created new category with name")
                categoryArray.append(Category(_dictionary: categoryDict.data() as NSDictionary))
            }
        }
        completion(categoryArray)
    }
}

//MARK: Save category fuction

func saveCategoryToFirebase(_ category: Category) {
    
    //First we MUST create a unique userID
    let id = UUID().uuidString
    //Now we need to set the ID the the unique one we just created
    category.id = id
    
    FirebaseReference(.Category).document(id).setData(categoryDictionaryFrom(category) as! [String : Any])
}

//MARK: Helpers

func categoryDictionaryFrom(_ category: Category) -> NSDictionary {
    return NSDictionary(objects: [category.id, category.name, category.imageName], forKeys: [cOBJECTID as NSCopying, cNAME as NSCopying, cIMAGENAME as NSCopying])
}

//This func will be used only once
func createCategorySet() {
    
    let womenClothing = Category(_name: "Women's Clothing & Accessories", _imageName: "WomenClothing")
    let footWear = Category(_name: "Footwear", _imageName: "FootWear")
    let electronics = Category(_name: "Electronics", _imageName: "Electronics")
    let menClothing = Category(_name: "Men's Clothing & Accessories", _imageName: "MenClothing")
    let health = Category(_name: "Health & Beauty", _imageName: "Health")
    let baby = Category(_name: "Baby Stuff", _imageName: "Baby")
    let home = Category(_name: "For Your Home", _imageName: "Home")
    let car = Category(_name: "Automobiles & Mortorcycles", _imageName: "Car")
    let luggage = Category(_name: "Luggage & Bags", _imageName: "Luggage")
    let jewelery = Category(_name: "Jewelery", _imageName: "Jewelry")
    let hobby = Category(_name: "Hobby, Sport, Travel", _imageName: "Hobby")
    let pet = Category(_name: "Pet Supplies", _imageName: "Pet")
    let industry = Category(_name: "Industry & Business", _imageName: "Industry")
    let garden = Category(_name: "Lawn & Garden", _imageName: "Garden")
    let camera = Category(_name: "Cameras & Optics", _imageName: "Camera")

//Create an array of the categories above for us to save
    let arrayOfCategories = [womenClothing, footWear, electronics, menClothing, health, baby, home, car, luggage, jewelery, hobby, pet, industry, garden, camera]

    for category in arrayOfCategories {
        saveCategoryToFirebase(category)
    }
}
