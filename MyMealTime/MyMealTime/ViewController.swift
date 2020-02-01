//
//  ViewController.swift
//  MyMealTime
//
//  Created by Eric Grant on 31.01.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet var timeTableView: UITableView!
    
    // 11.
    var context: NSManagedObjectContext!
    // 11.
    
    // 1.
    var array = [Date]()
    // 1.
    // 13.
    var person: Person!
    // 13.
    
    // 3.
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    // 3.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 7.
        timeTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        // 7.
        // 14.
        let personName = "Eric"
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name = %@", personName)
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.isEmpty {
                person = Person(context: context)
                person.name = personName
                try context.save()
            } else {
                person = results.first
            }
        } catch let error as NSError {
            print(error.userInfo)
        }
        // 14.
    }
    
    // 5.
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "My happy meal time"
    }
    // 5.
    
    // 2.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 15.
        guard let meals = person.meals else { return 1 }
        // 15.
        return  meals.count // заменен array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        // 4.
        // let date = array[indexPath.row] - убираем
        // 16.
        guard let meal = person.meals?[indexPath.row] as? Meal, let mealDate = meal.date else { return cell! }
        // 16.
        cell!.textLabel!.text = dateFormatter.string(from: mealDate) // заменили date
        // 4.
        return cell!
    }
    // 2.

    @IBAction func addButton(_ sender: UIBarButtonItem) {
        // 6.
//        let date = Date()
//        array.append(date)
        // 17.
        let meal = Meal(context: context)
        meal.date = Date()
        
        let meals = person.meals?.mutableCopy() as? NSMutableOrderedSet
        meals?.add(meal)
        person.meals = meals
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Error \(error), userInfo \(error.userInfo)")
        }
        // 17.
        timeTableView.reloadData()
        // 6.
    }
    
    // 18. Удаление записей
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard let mealToDelete = person.meals?[indexPath.row] as? Meal, editingStyle == .delete else { return }
        
        context.delete(mealToDelete)
        
        do {
            try context.save()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } catch let error as NSError {
            print("Error \(error), description \(error.userInfo)")
        }
    }
    // 18.
}

