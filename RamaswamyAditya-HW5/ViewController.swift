// Project: RamaswamyAditya-HW5
// EID: asr3766
// Course: CS371L

import UIKit

protocol PizzaReloader {
    func reloadData()
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PizzaReloader {
    
    @IBOutlet weak var tableView: UITableView!
    let ordersId = "ordersIdentifier"
    let pizzaSegueId = "pizzaSegue"
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PizzaOrders.pizzaOrders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ordersId, for: indexPath)
        let title = PizzaOrders.pizzaOrders[indexPath.row].size
        //String formatting to get ingredients indented and on new line
        let subtitle = "\t\(PizzaOrders.pizzaOrders[indexPath.row].crust)\n\t\(PizzaOrders.pizzaOrders[indexPath.row].cheese)\n\t\(PizzaOrders.pizzaOrders[indexPath.row].meat)\n\t\(PizzaOrders.pizzaOrders[indexPath.row].veggie)"
        cell.textLabel!.text = title
        cell.detailTextLabel!.text = subtitle
        return cell
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == pizzaSegueId, let dest = segue.destination as? PizzaViewController {
            dest.delegate = self
        }
    }

}

