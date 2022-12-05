//
//  ContentView.swift
//  IncrementalSearch
//
//  Created by Amit Chowdhury on 2/12/22.
//

import SwiftUI

struct GitRepoSearchView: View {
    @State var searchText = ""
    @State var searching = false
    @ObservedObject var viewModel: RepositoryListViewModel
    @State var repositories:[Repository] = []
    @State var pageNumber = 0
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                SearchBar(searchText: $searchText, searching: $searching).onSubmit {
                    pageNumber = 0
                    viewModel.serachRequest(searchKey: searchText, pagenumber: pageNumber)
                }
                List (0..<viewModel.repositories.count, id: \.self) { i in
                    if (i == viewModel.repositories.count - 1) {
                        RepositoryView(repository: viewModel.repositories[i]).onAppear {
                            loadMoreData()
                        }
                    }else{
                        RepositoryView(repository: viewModel.repositories[i])
                    }
                }
                .listStyle(GroupedListStyle())
                 .navigationTitle(searching ? AppString.searching : AppString.searchHeaderTitle)
                 .toolbar {
                     if searching {
                        Button(AppString.cancelButtonTitle) {
                            searchText = ""
                            withAnimation {
                                searching = false
                                UIApplication.shared.dismissKeyboard()
                            }
                        }
                    }
                 }.gesture(DragGesture().onChanged({ _ in
                    UIApplication.shared.dismissKeyboard()
                })
                )
            }
        }
    }
    func loadMoreData(){
            pageNumber += 1
            viewModel.serachRequest(searchKey: searchText, pagenumber: pageNumber)
      }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GitRepoSearchView(viewModel: .init())
    }
}

extension UIApplication {
     func dismissKeyboard() {
         sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
     }
 }
