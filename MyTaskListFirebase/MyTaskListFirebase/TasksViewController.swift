//
//  TasksViewController.swift
//  MyTaskListFirebase
//
//  Created by Eric Grant on 28.01.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import UIKit
import Firebase

class TasksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    // 16.
    var user: UserList!
    var ref: DatabaseReference!
    var tasks = Array<Task>()
    // 16.
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 17.
        guard let currentUser = Auth.auth().currentUser else { return }
        user = UserList(authUser: currentUser)
        ref = Database.database().reference(withPath: "users").child(String(user.uid)).child("tasks")
        // 17.
    }
    
    // 22. Создали наблюдателя и получили значение
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.ref.observe(.value) { [weak self] (snapshot) in
            var _tasks = Array<Task>()
            for item in snapshot.children {
                let task = Task(snapshot: item as! DataSnapshot)
                _tasks.append(task)
            }
            
            self?.tasks = _tasks
            self?.tableView.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ref.removeAllObservers()
    }
    // 22.
    
    // 1.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count // 22.1 меняем 1 на
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // 2.
        cell.backgroundColor = .clear
        // cell.textLabel?.text = "This is cell number \(indexPath.row)" // удаляем
        // 22.2 Отобразили полученные значения
        let task = tasks[indexPath.row] // 24.
        let taskTitle = task.title
        // let taskTitle = tasks[indexPath.row].title - удалили
        let isCompleted = task.completed
        cell.textLabel?.text = taskTitle // 24.1
        cell.textLabel?.textColor = .white
        // 22.2
        toggleCompletion(cell, isCompleted: isCompleted)
        
        return cell
    }
    // 2.
    // 1.

    // 23. Базовый функционал для удаления ячеек
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    // добовление кнопки удаления
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = tasks[indexPath.row]
            task.ref?.removeValue()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        let task = tasks[indexPath.row]
        let isCompleted = !task.completed
        
        toggleCompletion(cell, isCompleted: isCompleted)
        task.ref?.updateChildValues(["completed": isCompleted])
    }
    // отрисовка галочки
    func toggleCompletion(_ cell: UITableViewCell, isCompleted: Bool) {
        cell.accessoryType = UITableViewCell.AccessoryType.checkmark
        cell.tintColor = UIColor.red
        cell.accessoryType = isCompleted ? .checkmark : .none
    }
    
    // 23.
    
    @IBAction func addAction(_ sender: UIBarButtonItem) {
        // 13.
        let alertController = UIAlertController(title: "New Task", message: "Add new task", preferredStyle: .alert)
        alertController.addTextField()
        let saveButton = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            
            guard let textField = alertController.textFields?.first, textField.text != "" else { return }
            // 18.
            let task = Task(title: textField.text!, userID: (self?.user.uid)!)
            let taskRef = self?.ref.child(task.title.lowercased())
            taskRef?.setValue(task.convertToDictionary()) // создали метод в Task
            // 18.

        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(saveButton)
        alertController.addAction(cancelButton)
        
        present(alertController, animated: true, completion: nil)
        // 13.
    }
    
    @IBAction func signOutAction(_ sender: UIBarButtonItem) {
        // 11.
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
        dismiss(animated: true, completion: nil)
        // 11.
    }
    
}
