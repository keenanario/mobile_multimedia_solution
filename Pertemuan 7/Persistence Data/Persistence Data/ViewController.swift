//
//  ViewController.swift
//  Persistence Data
//
//  Created by Ario on 05/12/22.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    // button add
        let btnAdd: UIButton = {
            let view = UIButton(type: .system)
            view.setTitle("+", for: .normal)
            view.setTitleColor(.white, for: .normal)
            view.backgroundColor = .blue
            DispatchQueue.main.async {
                view.layer.cornerRadius = view.frame.width / 2
            }
            view.addTarget(self, action: #selector(showCreateForm), for: .touchDown)
            return view
        }()
        
        // tableview untuk menampilkan data
        let tableUser: UITableView = {
            let view = UITableView()
            view.register(UITableViewCell.self, forCellReuseIdentifier: "UserCell")
            return view
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
                
        // set tableUser delegate and data source
        tableUser.delegate = self
        tableUser.dataSource = self
    }
    
    // func buat setup view programmtically
        func setupView(){
            
            // root
            view.addSubview(tableUser)
            view.addSubview(btnAdd)
            
            // btnAdd
            btnAdd.translatesAutoresizingMaskIntoConstraints = false
            btnAdd.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
            btnAdd.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
            
            // tableUser
            tableUser.translatesAutoresizingMaskIntoConstraints = false
            tableUser.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            tableUser.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            tableUser.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            tableUser.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            
        }
    
    // aksi button dari btnAdd
        @objc func showCreateForm(){
            
            // membuat alert untuk menampilkan form
            let alert = UIAlertController(title: "New", message: "Fill the form below to add new user", preferredStyle: .alert)
            
            // membuat 3 textfield ke dalam alert
            alert.addTextField(configurationHandler: {tf in
                tf.placeholder = "First Name"
            })
            
            alert.addTextField(configurationHandler: {tf in
                tf.placeholder = "Last Name"
            })
            
            alert.addTextField(configurationHandler: {tf in
                tf.placeholder = "Email"
            })
            
            alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { action in
                
                // check if the textfield is empty
                if alert.textFields![0].text!.isEmpty || alert.textFields![1].text!.isEmpty || alert.textFields![2].text!.isEmpty {
                    let warning = UIAlertController(title: "Warning", message: "Fill all the textfields", preferredStyle: .alert)
                    warning.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                    self.present(warning, animated: true)
                }else{
                    // call create method that i've created before
                    self.create(alert.textFields![0].text!, alert.textFields![1].text!, alert.textFields![2].text!)
                    
                    let success = UIAlertController(title: "Success", message: "Data user added", preferredStyle: .alert)
                    success.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                    self.present(success, animated: true)
                    
                    // refresh data on tableUser
                    self.tableUser.reloadData()
                }
                
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
        }
        
        // aksi click dari tableUserRow
        @objc func showUpdateForm(_ firstName:String, _ lastName:String, _ email:String){
            
            // membuat alert untuk menampilkan form
            let alert = UIAlertController(title: "Update", message: "Fill the form below to add update user", preferredStyle: .alert)
            
            // membuat 3 textfield ke dalam alert
            alert.addTextField(configurationHandler: {tf in
                tf.placeholder = "First Name"
                tf.text = firstName
            })
            
            alert.addTextField(configurationHandler: {tf in
                tf.placeholder = "Last Name"
                tf.text = lastName
            })
            
            alert.addTextField(configurationHandler: {tf in
                tf.placeholder = "Email"
                tf.text = email
                tf.isEnabled = false
            })
            
            alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { action in
                
                // check if the textfield is empty
                if alert.textFields![0].text!.isEmpty || alert.textFields![1].text!.isEmpty || alert.textFields![2].text!.isEmpty {
                    let warning = UIAlertController(title: "Warning", message: "Fill all the textfields", preferredStyle: .alert)
                    warning.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                    self.present(warning, animated: true)
                }else{
                    // call update method that i've created before
                    self.update(alert.textFields![0].text!, alert.textFields![1].text!, alert.textFields![2].text!)
                    
                    let success = UIAlertController(title: "Success", message: "Data user updated", preferredStyle: .alert)
                    success.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                    self.present(success, animated: true)
                    
                    // refresh data on tableUser
                    self.tableUser.reloadData()
                }
                
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
        }


    
    //insert data
    func create(_ firstName:String, _ lastName: String, _ email:String){
        
        //referensi ke AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //managed context
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //referensi entity yang telah dibuat sebelumnya
        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)
        
        //entity body
        let insert = NSManagedObject(entity: userEntity!, insertInto: managedContext)
        insert.setValue(firstName, forKey: "firstName")
        insert.setValue(lastName, forKey: "lastName")
        insert.setValue(email, forKey: "email")
        
        do{
            //save data ke entity user core data
            try managedContext.save()
        }catch let err{
            print(err)
        }
    }
    
    //fungsi get data
    func retrieve() -> [UserModel]{
        var users = [UserModel]()
        
        //referensi ke AppDelegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //managed context
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //fetch data
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        do{
            let result = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            
            result.forEach{user in users.append(UserModel(
                firstName: user.value(forKey: "firstName") as! String,
                lastName: user.value(forKey: "lastName") as! String,
                email: user.value(forKey: "email") as! String))}
        }catch let err{
            print(err)
        }
        
        return users
    }
    
    func update(_ firstName:String,_ lastName:String, _ email: String){
        //referensi ke AppDelegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //managed context
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //fetchdata
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "User")
        
        fetchRequest.predicate = NSPredicate(format: "email = %@", email)
        
        //TODO:
        //get relationship
        //condition like, more than, less than
        do{
            let fetch = try managedContext.fetch(fetchRequest)
            let dataToUpdate = fetch[0] as! NSManagedObject
            dataToUpdate.setValue(firstName, forKey: "firstName")
            dataToUpdate.setValue(lastName, forKey: "lastName")
            dataToUpdate.setValue(email, forKey: "email")
            
            try managedContext.save()
        }catch let err{
            print(err)
        }
    }
    
    func delete(_ email:String){
        //referensi ke AppDelegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //managed context
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //fetch data to delete
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "User")
        
        fetchRequest.predicate = NSPredicate(format: "email = %@", email)
        
        do{
            let dataToDelete = try managedContext.fetch(fetchRequest)[0] as! NSManagedObject
            managedContext.delete(dataToDelete)
            
            try managedContext.save()
        }catch let err{
            print(err)
        }
    }
}

struct UserModel{
    let firstName: String
    let lastName: String
    let email: String
}

// ext untuk tableUser delegate and datasource
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return retrieve().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell")
        
        // set data from retrieve to default label of the tableUser Cell
        cell?.textLabel?.text = "\(retrieve()[indexPath.row].firstName), \(retrieve()[indexPath.row].lastName) (\(retrieve()[indexPath.row].email))"
        
        return cell!
    }
    
    // handler tap action in cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showUpdateForm(retrieve()[indexPath.row].firstName,retrieve()[indexPath.row].lastName,retrieve()[indexPath.row].email)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // call delete method that i've created before
            delete(retrieve()[indexPath.row].email)
            
            // reload table data
            tableUser.reloadData()
        }
    }
}

