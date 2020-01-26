//
//  ListModel.swift
//  MyToDo
//
//  Created by Eric on 29.12.2019.
//  Copyright © 2019 Eric Grant. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit

// Вся логика приложения - Паттерн MVC

// var ItemsModel: [String] = ["Прочитать книгу", "Изучить алгоритм"]

// var ItemsModel: [[String: Any]] = [["Title": "Прочитать книгу", "isCompleted": true], ["Title": "Изучить алгоритм", "isCompleted": false], ["Title": "Нарисоавть иконку", "isCompleted": false]]

// Сохранение и загрузка данных
var ItemsModel: [[String: Any]] {
    set {
        UserDefaults.standard.set(newValue, forKey: "ModelDataKey")
        UserDefaults.standard.synchronize()
    }
    
    get {
        if let loadArray = UserDefaults.standard.array(forKey: "ModelDataKey") as? [[String: Any]] {
            return loadArray
        } else {
            return []
        }
    }
}

func addToDoItem(titleItem: String, isCompleted: Bool = false) {
    ItemsModel.append(["Title": titleItem, "isCompleted": isCompleted])
    installBadge()
    // saveToDoData()
}

func removeToDoItem(index: Int) {
    ItemsModel.remove(at: index)
    installBadge()
    // saveToDoData()
}

func moveItemInList(from: Int, to: Int) {
    let fromIndex = ItemsModel[from]
    ItemsModel.remove(at: from)
    ItemsModel.insert(fromIndex, at: to)
}

func changeToDoState(item: Int) -> Bool {
    ItemsModel[item]["isCompleted"] = !(ItemsModel[item]["isCompleted"] as! Bool)
    // saveToDoData()
    installBadge()
    return ItemsModel[item]["isCompleted"] as! Bool
}

// Запрос у пользователя разрешения на уведомления
func notificationRequest() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.badge]) { (isEnabled, error) in
        if isEnabled {
            print("Agreement recieved")
        } else {
            print("Access denied")
        }
    }
}

// Метод устанавливает бэйдж
func installBadge() {
    var amountBadgeNumber = 0
    for item in ItemsModel {
        if (item["isCompleted"] as? Bool) == false {
            amountBadgeNumber = amountBadgeNumber + 1
        }
    }
    
    // Устанавливаем бэйдж на иконку приложения
    UIApplication.shared.applicationIconBadgeNumber = amountBadgeNumber
}

//func saveToDoData() {
//
//}
//
//func loadToDoData() {
//
//}
