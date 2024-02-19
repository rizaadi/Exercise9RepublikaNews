//
//  RepublikaNews.swift
//  Exercise9RepublikaNews
//
//  Created by Riza Adi Kurniawan on 18/02/24.
//

import SwiftUI

struct RepublikaNews: View {
    @StateObject private var newsVM = NewsViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(newsVM.articles) {article in
                    NavigationLink(destination: BrowserView(url: URL(string: article.link)!)) {
                        CardNews(article: article)
                    }
                }
            }
            .navigationTitle(Constant.ViewTitles.newsTitle)
            .task {
                await newsVM.loadNews()
            }
            .overlay {
                switch newsVM.loadingOverlay {
                case .loading:
                    ProgressView().scaleEffect(2)
                case .error(let message):
                    Text(message)
                        .font(.caption)
                        .foregroundStyle(.red)
                case .none:
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    RepublikaNews()
}
