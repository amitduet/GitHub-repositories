//
//  RepositoryView.swift
//  IncrementalSearch
//
//  Created by Amit Chowdhury on 5/12/22.
//

import SwiftUI

struct RepositoryView: View {
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
