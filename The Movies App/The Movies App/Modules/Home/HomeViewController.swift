//
//  HomeViewController.swift
//  The Movies Aapp
//
//  Created by Valentina Guarnizo on 29/03/22.
//

import UIKit
import ProgressHUD

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topTableCostraint: NSLayoutConstraint!
    
    private var listMovies = [Movie]()
    private var listFilterMovies = [Movie]()
    private let colorApp = UIColor(red: 1.0 / 255.0, green: 77.0 / 255.0, blue: 108.0 / 255.0, alpha: 2.0)
  
    lazy var searchController: UISearchController = ({
        let controller = UISearchController(searchResultsController: nil)
        controller.hidesNavigationBarDuringPresentation = true
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchResultsUpdater = self
        controller.searchBar.sizeToFit()
        controller.searchBar.barStyle = .default
        controller.searchBar.backgroundColor = .clear
        controller.searchBar.placeholder = "Buscar una película"
        controller.searchBar.barTintColor = UIColor(red: 1.0 / 255.0, green: 77.0 / 255.0, blue: 108.0 / 255.0, alpha: 2.0)
        
        controller.searchBar.compatibleSearchTextField.textColor = .white
        controller.searchBar.compatibleSearchTextField.backgroundColor = UIColor(red: 1.0 / 255.0, green: 113.0 / 255.0, blue: 159.0 / 255.0, alpha: 0.5)
        
        return controller
    })()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appearanceNavigationBar()
        setupTable()
        getListMovies()
        self.view.backgroundColor = colorApp
        manageSearchBarController()
        title = "The Movies App"
    }
    
    func appearanceNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = colorApp
        
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "MarkerFelt-Thin", size: 30)!
        ]
        appearance.titleTextAttributes = attrs
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
      
    
    private func setupTable() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = colorApp
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
    
    }
    
    private func manageSearchBarController(){
        let searchBar = searchController.searchBar
        tableView.tableHeaderView = searchBar
        searchController.delegate = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
    }
    
    private func clearFilter() {
        listFilterMovies = listMovies
    }
    
    private func getListMovies(){
        ProgressHUD.animationType = .horizontalCirclesPulse    
        ProgressHUD.show()
        
        Api.share.getListMovie { [weak self]  response in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
               // Excecute after 3 seconds
                self?.listMovies = response.listOfMovies
                self?.clearFilter()
                DispatchQueue.main.async {
                    ProgressHUD.dismiss()
                    self?.tableView.reloadData()
                }
            }
            
        }
    }
    
}

// MARK: UITableViewDataSource, UITableViewDelegate
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listFilterMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        let movie = listFilterMovies[indexPath.row]
        cell.setUp(movie: movie)
        
        return cell 
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = listFilterMovies[indexPath.row]
        
        let detail = RouterHome.share.showDetail(movie: movie)
        navigationController?.pushViewController(detail, animated: true)
    }
    
}

// MARK: UISearchControllerDelegate
extension HomeViewController: UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        searchController.isActive = false
        clearFilter()
        tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, text != "" else {
            clearFilter()
            return
        }
        listFilterMovies = listMovies.filter{ $0.title.contains(text) }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
}
