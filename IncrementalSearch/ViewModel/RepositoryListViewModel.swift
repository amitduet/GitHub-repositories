//
//  SearchViewModel.swift
//  IncrementalSearch
//
//  Created by Amit Chowdhury on 5/12/22.
//

import SwiftUI
import Combine

final class RepositoryListViewModel: ObservableObject {
    
    // MARK: Output
    @Published private(set) var repositories: [Repository] = []
    @Published var isErrorShown = false
    @Published var errorMessage = ""
    private var cancellables: [AnyCancellable] = []
    
    func serachRequest(searchKey:String, pagenumber:Int = 0) {
        print("pagenumber \(pagenumber)")
        let trimmedString = searchKey.trimmingCharacters(in: .whitespaces)
        if (trimmedString.count == 0) {
            repositories = []
            return
        }
        let request = SearchRequest(searchKey: trimmedString, pageNumber: "\(pagenumber)")
        Task {
            do {
                let result = try await APIManager().fetchGitRepoSerch(from: request)
                if (repositories.count > 0) {
                    repositories.append(contentsOf: result)
                }else {
                    repositories = result
                }
            } catch {
                print("Request failed with error: \(error)")
            }
            
        }
    }
}
