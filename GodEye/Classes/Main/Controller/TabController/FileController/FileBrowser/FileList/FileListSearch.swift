//
//  FileListSearch.swift
//  FileBrowser
//
//  Created by Roy Marmelstein on 14/02/2016.
//  Copyright © 2016 Roy Marmelstein. All rights reserved.
//

import UIKit

extension FileListViewController: UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating {
        
    // MARK: UISearchControllerDelegate
    func willPresentSearchController(_ searchController: UISearchController) {
        self.tableView.contentInset = UIEdgeInsets.init(top: 20, left: 0, bottom: 0, right: 0)
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        self.tableView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    // MARK: UISearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterContentForSearchText(searchBar.text!)
    }
    
    // MARK: UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
