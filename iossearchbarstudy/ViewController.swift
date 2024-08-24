//
//  ViewController.swift
//  iossearchbarstudy
//
//  Created by kenan on 24.08.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var customTableView: UITableView!
    
    var countries:[String] = [String]()
    var searchResultCountries:[String] = [String]()
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBar.delegate = self
        //searchBar.scopeButtonTitles = ["First","Second"]
        
        customTableView.delegate = self
        customTableView.dataSource = self
        
        countries = ["Türkiye","Almanya","İngiltere","Fransa","Japonya","İran","Kore","Japonya"]
    }


}

extension ViewController:UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching{
            return searchResultCountries.count
        }else{
            return countries.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellname", for: indexPath)
        if isSearching{
            cell.textLabel?.text = searchResultCountries[indexPath.row]
        }else{
            cell.textLabel?.text = countries[indexPath.row]
        }
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSearching{
            print("Selected country \(searchResultCountries[indexPath.row])")
        }else{
            print("Selected country \(countries[indexPath.row])")
        }
      
    }
}

extension ViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Search Result \(searchText)")
        
        if searchText == "" {//Arama yapılmıyor
            isSearching = false
        }else{
            isSearching = true
            
            searchResultCountries = countries.filter({$0.lowercased().contains(searchText.lowercased())})
        }
        
        customTableView.reloadData()
     
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("Cancel clicked")
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        if selectedScope == 0{
            print("First one selected")
        }else{
            print("Second one selected")
        }
    }
}
