// Project: RamaswamyAditya-HW5
// EID: asr3766
// Course: CS371L

import UIKit
import FirebaseFirestore

class PizzaViewController: UIViewController {

    var createPizza: Pizza!
    let db = Firestore.firestore()
    var delegate: UIViewController!
    @IBOutlet weak var sizeSelect: UISegmentedControl!
    @IBOutlet weak var sizeText: UILabel!
    @IBOutlet weak var crustText: UILabel!
    @IBOutlet weak var cheeseText: UILabel!
    @IBOutlet weak var meatText: UILabel!
    @IBOutlet weak var veggieText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        createPizza = Pizza()
        sizeText.text = ""
        crustText.text = ""
        cheeseText.text = ""
        meatText.text = ""
        veggieText.text = ""
    }
    
    @IBAction func crustSelect(_ sender: Any) {
        let alert = UIAlertController(title: "Select crust", message: "Choose a crust type:", preferredStyle: .alert)
        let thinAction = UIAlertAction(title: "Thin crust", style: .default) {
            (action) in
            self.createPizza.crust = "Thin crust"
        }
        let thickAction = UIAlertAction(title: "Thick crust", style: .default) {
            (action) in
            self.createPizza.crust = "Thick crust"
        }
        alert.addAction(thinAction)
        alert.addAction(thickAction)
        present(alert, animated: true)
    }
    
    @IBAction func cheeseSelect(_ sender: Any) {
        let sheet = UIAlertController(title: "Select cheese", message: "Choose a cheese type:", preferredStyle: .actionSheet)
        let regular = UIAlertAction(title: "Regular cheese", style: .default) {
            (action) in
            self.createPizza.cheese = "Regular cheese"
        }
        let no = UIAlertAction(title: "No cheese", style: .default) {
            (action) in
            self.createPizza.cheese = "No cheese"
        }
        let double = UIAlertAction(title: "Double cheese", style: .default) {
            (action) in
            self.createPizza.cheese = "Double cheese"
        }
        sheet.addAction(regular)
        sheet.addAction(no)
        sheet.addAction(double)
        present(sheet, animated: true)
    }
    
    @IBAction func meatSelect(_ sender: Any) {
        let sheet = UIAlertController(title: "Select meat", message: "Choose a meat type:", preferredStyle: .actionSheet)
        let pep = UIAlertAction(title: "Pepperoni", style: .default) {
            (action) in
            self.createPizza.meat = "Pepperoni"
        }
        let saus = UIAlertAction(title: "Sausage", style: .default) {
            (action) in
            self.createPizza.meat = "Sausage"
        }
        let bacon = UIAlertAction(title: "Canadian Bacon", style: .default) {
            (action) in
            self.createPizza.meat = "Canadian Bacon"
        }
        sheet.addAction(pep)
        sheet.addAction(saus)
        sheet.addAction(bacon)
        present(sheet, animated: true)
    }
    
    @IBAction func veggieSelect(_ sender: Any) {
        let sheet = UIAlertController(title: "Select veggies", message: "Choose a veggie type:", preferredStyle: .actionSheet)
        let mush = UIAlertAction(title: "Mushrooms", style: .default) {
            (action) in
            self.createPizza.veggie = "Mushrooms"
        }
        let onion = UIAlertAction(title: "Onions", style: .default) {
            (action) in
            self.createPizza.veggie = "Onions"
        }
        let green = UIAlertAction(title: "Green Olives", style: .default) {
            (action) in
            self.createPizza.veggie = "Green Olives"
        }
        let black = UIAlertAction(title: "Black Olives", style: .default) {
            (action) in
            self.createPizza.veggie = "Black Olives"
        }
        let none = UIAlertAction(title: "None", style: .default) {
            (action) in
            self.createPizza.veggie = "None"
        }
        sheet.addAction(mush)
        sheet.addAction(onion)
        sheet.addAction(green)
        sheet.addAction(black)
        sheet.addAction(none)
        present(sheet, animated: true)
    }
    
    @IBAction func orderPlaced(_ sender: Any) {
        //Validate before placing an order
        if(createPizza.crust == "") {
            errorAlert(error: "crust type")
        } else if(createPizza.cheese == "") {
            errorAlert(error: "cheese type")
        } else if(createPizza.meat == "") {
            errorAlert(error: "meat type")
        } else if(createPizza.veggie == "") {
            errorAlert(error: "veggies")
        } else {
            //Update order and reload table
            let size = sizeSelect.titleForSegment(at: sizeSelect.selectedSegmentIndex)
            createPizza.size = size!
            sizeText.text = "One \(size!) pizza with:"
            crustText.text = createPizza.crust
            cheeseText.text = createPizza.cheese
            meatText.text = createPizza.meat
            veggieText.text = createPizza.veggie
            
            let order = ["size": createPizza.size, "crust": createPizza.crust, "cheese": createPizza.cheese, "meat": createPizza.meat, "veggie": createPizza.veggie]
            
            db.collection("PizzaOrders").addDocument(data: order) {
                (err) in
                if let err = err {
                    let alert = UIAlertController(title: "Creation Error", message: "An error occured when creating the pizza", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "Ok", style: .default)
                    alert.addAction(ok)
                    self.present(alert, animated: true)
                }
            }
            let tableVC = delegate as! PizzaReloader
            tableVC.reloadData()
        }
    }
    
    //Helper method to generate error alerts based on missing ingredients
    func errorAlert(error:String) {
        let alert = UIAlertController(title: "Missing ingredient", message: "Please select a \(error)", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
}
