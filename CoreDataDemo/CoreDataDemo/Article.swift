//
//  Article.swift
//  CoreDataDemo
//
//  Created by Artur Rymarz on 03.08.2018.
//  Copyright © 2018 OpenSource. All rights reserved.
//

import UIKit
import CoreData

// 1
@objc(Article)
// 2
final class Article: NSManagedObject {
    var test: Int?
    // 3
    @NSManaged var title: String
    @NSManaged var content: String
}


extension Article {
    // 4
    @nonobjc class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article")
    }
}
