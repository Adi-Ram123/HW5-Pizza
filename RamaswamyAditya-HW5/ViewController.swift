// Project: RamaswamyAditya-HW5
// EID: asr3766
// Course: CS371L

import UIKit
import FirebaseAuth
import FirebaseFirestore

protocol PizzaReloader {
    func reloadData()
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PizzaReloader {
    
    @IBOutlet weak var tableView: UITableView!
    var orders = [Pizza]()
    let db = Firestore.firestore()
    let ordersId = "ordersIdentifier"
    let pizzaSegueId = "pizzaSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        reloadData()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ordersId, for: indexPath)
        let title = orders[indexPath.row].size
        //String formatting to get ingredients indented and on new line
        let subtitle = "\t\(orders[indexPath.row].crust)\n\t\(orders[indexPath.row].cheese)\n\t\(orders[indexPath.row].meat)\n\t\(orders[indexPath.row].veggie)"
        cell.textLabel!.text = title
        cell.detailTextLabel!.text = subtitle
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let order = orders[indexPath.row]
            
            
            //Query (auto-id so have to manually search)
            db.collection("PizzaOrders").whereField("cheese", isEqualTo: order.cheese).whereField("crust", isEqualTo: order.crust).whereField("meat", isEqualTo: order.meat).whereField("size", isEqualTo: order.size).whereField("veggie", isEqualTo: order.veggie).getDocuments() {
                (querySnapshot, err) in
                if let err = err {
                    print("Error getting document: \(err)")
                }
                
                //Even if entry is not unique simply delete one and show the other
                else if let docId = querySnapshot?.documents.first?.documentID {
                    //Deletion
                    self.db.collection("PizzaOrders").document(docId).delete() {
                        (err) in
                        if let err = err {
                            let alert = UIAlertController(title: "Deletion Error", message: "An error occured when deleting order", preferredStyle: .alert)
                            let ok = UIAlertAction(title: "Ok", style: .default)
                            alert.addAction(ok)
                            self.present(alert, animated: true)
                        } else {
                            self.orders.remove(at: indexPath.row)
                            tableView.deleteRows(at: [indexPath], with: .fade)
                        }
                    }
                }
                
            }
            
        }
    }
    
    func reloadData() {
        orders = [Pizza]()
        
        db.collection("PizzaOrders").getDocuments() {
            (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let order = Pizza()
                    
                    if let size = document.data()["size"] as? String {
                        order.size = size
                    }
                    
                    if let crust = document.data()["crust"] as? String {
                        order.crust = crust
                    }
                    
                    if let cheese = document.data()["cheese"] as? String {
                        order.cheese = cheese
                    }
                    
                    if let meat = document.data()["meat"] as? String {
                        order.meat = meat
                    }
                    
                    if let veggie = document.data()["veggie"] as? String {
                        order.veggie = veggie
                    }
                    self.orders.append(order)
                }
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == pizzaSegueId, let dest = segue.destination as? PizzaViewController {
            dest.delegate = self
        }
    }
    
    @IBAction func signOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.dismiss(animated:true)
        } catch {
            let alert = UIAlertController(title: "Sign Out Error", message: "An error occured during sign out", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(ok)
            present(alert, animated: true)
        }
    }
    
}

