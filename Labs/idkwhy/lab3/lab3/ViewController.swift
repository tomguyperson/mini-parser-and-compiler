//
//  ViewController.swift
//  lab3
//
//  Created by Tommy Mesquita on 2/14/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var saleField: UITextField!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var genreField: UITextField!
    
    // create an infoDictionary object that stores the person info
    var movieInfoDictionary:movieInfo = movieInfo()
    
    
    @IBOutlet weak var searchedTitle: UITextField!
    @IBOutlet weak var searchedSale: UITextField!
    @IBOutlet weak var searchedGenre: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    // calling the search function
    @IBAction func search(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "Search Record", message: "", preferredStyle: .alert)
        
        let searchAction = UIAlertAction(title: "Search", style: .default) { (aciton) in
            
            let text = alertController.textFields!.first!.text!
            
            if !text.isEmpty
            {
                let title = text
                let p =  self.movieInfoDictionary.search(t: title)
                if let x = p
                {
                    self.searchedGenre.text = x.genre!
                    self.searchedTitle.text = x.title!
                    self.searchedSale.text = String(x.sale!)
                    print("In search")
                }
                else{
                    self.searchedTitle.text = ""
                    self.searchedSale.text = ""
                    self.searchedGenre.text = ""
                    
                    let alert = UIAlertController(title: "Movie Not Found", message: "Movie not found in database. Please try again", preferredStyle: .alert)
                     
                     alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                     self.present(alert, animated: true)
                }
             }
             else {
                   // Alert message will be displayed to th user if there is no input
                   let alert = UIAlertController(title: "Data Input Error", message: "enter title to search", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    
                 self.searchedTitle.text = ""
                 self.searchedSale.text = ""
                 self.searchedGenre.text = ""
                 
                }
                
            }
        //}
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "enter title here"
        }
        
        alertController.addAction(searchAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // adding a new record
    @IBAction func addRec(_ sender: UIBarButtonItem) {
        // check if input fields are empty
        if let title = titleField.text,
            let genre = genreField.text,
            let sale = Int64(saleField.text!)
            {
            // create a person record
            //let pRecord =  personRecord(n: name, s:ssn, a: age)
            
            movieInfoDictionary.add(title,genre, sale)
            
            // remove data from the text fields
            self.titleField.text = ""
            self.genreField.text = ""
            self.saleField.text = ""
            
            }else
            {
               // Alert message will be displayed to th user if there is no input
               let alert = UIAlertController(title: "Data Input Error", message: "Data Inputs are either empty or incorrect types", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                self.searchedTitle.text = ""
                self.searchedSale.text = ""
                self.searchedGenre.text = ""
            }
    
        }
    
    
    @IBAction func deleteRecord(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Delete", message: "", preferredStyle: .alert)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .default) { (aciton) in
            
            let text = alertController.textFields!.first!.text!
            
            if !text.isEmpty {
                let title = text
                let p =  self.movieInfoDictionary.infoRepository.removeValue(forKey: title)
                
                }
             
             else {
                   // Alert message will be displayed to th user if there is no input
                   let alert = UIAlertController(title: "Data Input Error", message: "enter title to search", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    
                }
                
            }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "enter title here"
        }
        
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
        self.searchedSale.text = ""
        self.searchedGenre.text = ""
        self.searchedTitle.text = ""
    }
    
    
    @IBAction func editEntry(_ sender: Any) {
                
        if let title = searchedTitle.text,
           let newSale = Int64(searchedSale.text!)
        {
            let alertController = UIAlertController(title: "Edit Record", message: "", preferredStyle: .alert)
            
            let searchAction = UIAlertAction(title: "Edit", style: .default)
            { (action) in
                
                let text = alertController.textFields!.first!.text!
                
                if !text.isEmpty
                {
                    
                    self.movieInfoDictionary.search(t: title)!.change_sale(newSale: Int64(text)!)
                }
                else
                    
                {
                    let alert = UIAlertController(title: "Invalid Input", message: "Please input a valid number", preferredStyle: .alert)
                     
                     alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                     self.present(alert, animated: true)
                }
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            }
            
            alertController.addTextField { (textField) in
                textField.placeholder = "enter new sales number here"
            }
            
            alertController.addAction(searchAction)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        else
        {
           // Alert message will be displayed to th user if there is no input
           let alert = UIAlertController(title: "Data Input Error", message: "Data Inputs are either empty or incorrect types. Try searching again for a movie to edit", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        
        self.searchedTitle.text = ""
        self.searchedSale.text = ""
        self.searchedGenre.text = ""
    }
    
    
    @IBAction func previous(_ sender: Any) {
        
        var findTitle: [String] = []
        
        for k in self.movieInfoDictionary.infoRepository
        {
            findTitle.append(k.key)
        }
        
        let title = searchedTitle.text!
        
        
        if findTitle.count == 0
        {
            let alert = UIAlertController(title: "Database is currently empty", message: "", preferredStyle: .alert)
             
             alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
             self.present(alert, animated: true)
        }
        else if title.isEmpty
        {
            let curMovie = self.movieInfoDictionary.search(t: findTitle[0])!
            
            searchedTitle.text = curMovie.title!
            searchedGenre.text = curMovie.genre!
            searchedSale.text = String(curMovie.sale!)
        }
        else
        {
            var curIndex = findTitle.index(of: title)!
            curIndex = curIndex - 1
            
            if(curIndex < 0)
            {
                let alert = UIAlertController(title: "Showing the First Record", message: "There are no entries prior to this one", preferredStyle: .alert)
                 
                 alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                 self.present(alert, animated: true)
            }
            else
            {
                let curMovie = self.movieInfoDictionary.search(t: findTitle[curIndex])!
                
                searchedTitle.text = curMovie.title!
                searchedGenre.text = curMovie.genre!
                searchedSale.text = String(curMovie.sale!)
            }
        }
    }
    
    @IBAction func next(_ sender: Any) {
        
        var findTitle: [String] = []
        
        for k in self.movieInfoDictionary.infoRepository
        {
            findTitle.append(k.key)
        }
        
        let title = searchedTitle.text!
        
        if findTitle.count == 0
        {
            let alert = UIAlertController(title: "Database is currently empty", message: "", preferredStyle: .alert)
             
             alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
             self.present(alert, animated: true)
        }
        else if title.isEmpty
        {
            let curMovie = self.movieInfoDictionary.search(t: findTitle[0])!
            
            searchedTitle.text = curMovie.title!
            searchedGenre.text = curMovie.genre!
            searchedSale.text = String(curMovie.sale!)
        }
        else
        {
            var curIndex = findTitle.index(of: title)!
            curIndex = curIndex + 1
            
            if(curIndex >= findTitle.count)
            {
                let alert = UIAlertController(title: "No More Records", message: "There are no entries after this one", preferredStyle: .alert)
                 
                 alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                 self.present(alert, animated: true)
            }
            else
            {
                let curMovie = self.movieInfoDictionary.search(t: findTitle[curIndex])!
                
                searchedTitle.text = curMovie.title!
                searchedGenre.text = curMovie.genre!
                searchedSale.text = String(curMovie.sale!)
            }
        }
    }
    
    
    
}

