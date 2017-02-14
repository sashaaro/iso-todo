//
//  AddTodoViewController.swift
//  todo
//
//  Created by Alex Danilin on 2/13/17.
//  Copyright © 2017 Alex Danilin. All rights reserved.
//

import UIKit

class AddTodoViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var todoFormView: UITableView!
    @IBOutlet weak var todoText: UITextField!
    @IBOutlet weak var projectsPicker: UIPickerView!
    
    let repository: Repository = Repository();
    var projects = [Project]()
    
    var selectedProject: Project?;

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.projectsPicker.dataSource = self;
        self.projectsPicker.delegate = self;
        
        self.todoFormView.dataSource = self;
        self.todoFormView.delegate = self;
        
        if (self.projects.count == 0) {
            fatalError("There is not projects")
        }
        
        self.todoText.placeholder = "Введите задачу.."
    }
    
    @IBAction func add(_ sender: Any) {
        let todo = Todo()
        todo.text = self.todoText.text!
        todo.project = self.selectedProject
        //NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: nil)
        repository.persistTodo(todo: todo)
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func numberOfComponents(in: UIPickerView) -> Int
    {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return self.projects.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return self.projects[row].title;
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        self.selectedProject = self.projects[row]
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.projects.count;
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Категория"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 35;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath) as! ProjectSelectedCell
        self.selectedProject = self.projects[indexPath.row]
        
        selectedCell.updateViewElements();
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: ProjectSelectedCell;
        let cellIdentifier = "ProjectSelectedCell"
        cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ProjectSelectedCell
            
        // Fetches the appropriate meal for the data source layout.
        let project = self.projects[indexPath.row]
        cell.textLabel?.text = project.title
        cell.updateViewElements()
   
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
}
