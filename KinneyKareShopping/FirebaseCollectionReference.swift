//
//  FirebaseCollectionReference.swift
//  KinneyKareShopping
//
//  Created by Kinney Kare on 11/29/19.
//  Copyright © 2019 Kinney Kare. All rights reserved.
//

import Foundation
import FirebaseFirestore


enum FCollectionReference: String {
    case User
    case Category
    case Items
    case Basket
}

func FirebaseReference(_ collectionReference: FCollectionReference) -> CollectionReference {
    
    return Firestore.firestore().collection(collectionReference.rawValue)
}
