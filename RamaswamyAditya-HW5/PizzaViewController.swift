//
//  PizzaViewController.swift
//  RamaswamyAditya-HW5
//
//  Created by Aditya Ramaswamy on 6/30/25.
//

import UIKit

class PizzaViewController: UIViewController {

    var createPizza: Pizza!
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
            print("Thin Crust")
        }
        let thickAction = UIAlertAction(title: "Thick crust", style: .default) {
            (action) in
            self.createPizza.crust = "Thick crust"
            print("Thick Crust")
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
            print("Regular Cheese")
        }
        let no = UIAlertAction(title: "No cheese", style: .default) {
            (action) in
            self.createPizza.cheese = "No cheese"
            print("No Cheese")
        }
        let double = UIAlertAction(title: "Double cheese", style: .default) {
            (action) in
            self.createPizza.cheese = "Double cheese"
            print("Double Cheese")
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
            print("Pepperoni")
        }
        let saus = UIAlertAction(title: "Sausage", style: .default) {
            (action) in
            self.createPizza.meat = "Sausage"
            print("Sausage")
        }
        let bacon = UIAlertAction(title: "Canadian Bacon", style: .default) {
            (action) in
            self.createPizza.meat = "Canadian Bacon"
            print("Canadian Bacon")
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
            print("Mushrooms")
        }
        let onion = UIAlertAction(title: "Onions", style: .default) {
            (action) in
            self.createPizza.veggie = "Onions"
            print("Onions")
        }
        let green = UIAlertAction(title: "Green Olives", style: .default) {
            (action) in
            self.createPizza.veggie = "Green Olives"
            print("Green Olives")
        }
        let black = UIAlertAction(title: "Black Olives", style: .default) {
            (action) in
            self.createPizza.veggie = "Black Olives"
            print("Black Olives")
        }
        let none = UIAlertAction(title: "None", style: .default) {
            (action) in
            self.createPizza.veggie = "None"
            print("None")
        }
        
        sheet.addAction(mush)
        sheet.addAction(onion)
        sheet.addAction(green)
        sheet.addAction(black)
        sheet.addAction(none)
        present(sheet, animated: true)
    }
    
    @IBAction func orderPlaced(_ sender: Any) {
        let size = sizeSelect.titleForSegment(at: sizeSelect.selectedSegmentIndex)
        sizeText.text = "One \(size!) pizza with:"
        crustText.text = createPizza.crust
        cheeseText.text = createPizza.cheese
        meatText.text = createPizza.meat
        veggieText.text = createPizza.veggie
    }
    
}
