//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Artur Rymarz on 03.08.2018.
//  Copyright © 2018 OpenSource. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBAction func saveArticles(_ sender: Any) {
        saveSomeArticles()
    }

    @IBAction func showArticles(_ sender: Any) {
        _ = loadArticles()
    }

    @IBAction func removeArticles(_ sender: Any) {
        deleteAllArticles()
    }

    private func saveSomeArticles() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        // 1
        let context = appDelegate.persistentContainer.viewContext

        // 2
        let mediumArticle = Article(context: context)

        // 3
        mediumArticle.title = randomString(length: 10)
        mediumArticle.content = randomString(length: 50)

        // 4
        appDelegate.saveContext()
    }

    private func loadArticles() -> [Article] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }

        let context = appDelegate.persistentContainer.viewContext

        // 1
        let request: NSFetchRequest<Article> = Article.fetchRequest()

        // 2
//        request.predicate = NSPredicate(format: "title = %@", "MEDIUM")

        do {
            // 3
            let articles = try context.fetch(request)

            // 4
            articles.forEach { article in
                print(article.title)
            }

            return articles
        }  catch {
            fatalError("This was not supposed to happen")
        }

        return []
    }

    private func deleteAllArticles() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let context = appDelegate.persistentContainer.viewContext

        // 1
        let articles = loadArticles()

        // 2
        articles.forEach { article in
            context.delete(article)
        }
    }

    private func randomString(length: Int) -> String {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)

        var randomString = ""

        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }

        return randomString
    }
}

