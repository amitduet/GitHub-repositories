//
//  ContentView.swift
//  IncrementalSearch
//
//  Created by Amit Chowdhury on 2/12/22.
//

import SwiftUI


struct ContentView: View {
    @State var searchText = ""
    @State var searching = false

    let repositories = DummyData().repositories
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                SearchBar(searchText: $searchText, searching: $searching)
                List {
                    ForEach(repositories) { repository in
                        RepositoryView(repository: repository)
                       
                    }}
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
                    }
                    .gesture(DragGesture()
                                .onChanged({ _ in
                        UIApplication.shared.dismissKeyboard()
                                })
                    )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SearchBar: View {
    
    @Binding var searchText: String
    @Binding var searching: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.gray.opacity(0.1))
            HStack {
                Image(systemName: "magnifyingglass")
                TextField(AppString.searchPlaceholder, text: $searchText) { startedEditing in
                    if startedEditing {
                        withAnimation {
                            searching = true
                        }
                    }
                } onCommit: {
                    withAnimation {
                        searching = false
                    }
                }
            }
            .foregroundColor(.gray)
            .padding(.leading, 13)
        }
            .frame(height: 40)
            .cornerRadius(13)
            .padding()
    }
}


private struct RepositoryView: View {
    let repository: Repository
    
    var body: some View {
        VStack{
            Spacer(minLength: 5)
            HStack(alignment: .top, spacing: 10) {
                AsyncImage(url: URL(string: repository.owner?.profilePhotoUrl ?? ""), content: { image in
                            image.resizable()
                        }, placeholder: {
                            ProgressView()
                        })
                    .frame(width:50, height: 50)
                    .clipShape(Circle())
                    
                
            VStack(alignment:.leading, spacing: 5) {
                    Text(repository.name ?? "" )
                        .frame(alignment: .leading)
                    .bold()
                    
                    Spacer(minLength: 2
                    )
                    Text(repository.repositoryDescription ?? "" )
                        .frame(alignment: .leading)
                    Spacer(minLength: 2)
                
                HStack {
                    Text(AppString.language ).bold()
                    Text(repository.programingLanguage ?? "" )
                }
                    Spacer()
                }

                
            }
            Spacer(minLength: 5)

        }.foregroundColor(.gray)
    }
    
}

extension UIApplication {
     func dismissKeyboard() {
         sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
     }
 }
