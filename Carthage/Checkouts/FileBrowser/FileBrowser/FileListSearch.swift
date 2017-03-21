//
//  FileListSearch.swift
//  FileBrowser
//
//  Created by Roy Marmelstein on 14/02/2016.
//  Copyright © 2016 Roy Marmelstein. All rights reserved.
//

import Foundation

extension FileListViewController: UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating {
        
    // MARK: UISearchControllerDelegate
    func willPresentSearchController(_ searchController: UISearchController) {
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
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
