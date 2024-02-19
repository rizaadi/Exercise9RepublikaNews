//
//  CardNews.swift
//  Exercise9RepublikaNews
//
//  Created by Riza Adi Kurniawan on 18/02/24.
//

import SwiftUI

struct CardNews: View {
    let article: NewsArticle
    
    var formattedDate: String {
        let isoFormat = ISO8601DateFormatter()
        isoFormat.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        if let date = isoFormat.date(from: article.isoDate) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
            dateFormatter.locale = Locale(identifier: "id_ID")
            
            return dateFormatter.string(from: date)
        }
        return "-"
    }
    
    var body: some View {
        AsyncImage(url: URL(string: article.image.small)){ phase in
            switch phase {
            case .empty:
                EmptyView()
            case .success(let image):
                VStack(alignment: .leading) {
                    HStack(alignment:.top) {
                        image.resizable()
                            .scaledToFill()
                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        VStack(alignment: .leading) {
                            Text(formattedDate)
                                .font(.caption)
                                .padding(.top, 5)
                            
                            Text(article.title)
                                .font(.headline)
                                .fontWeight(.bold)
                                .lineLimit(2)
                                .foregroundStyle(.black)
                                .padding(.bottom, 15)
                        }
                    }
                }
            case .failure(let error):
                Text(error.localizedDescription)
            @unknown default:
                fatalError()
            }
        }
    }
}

#Preview {
    CardNews(article: NewsArticle(creator: "ahmad putri", title: "Geger temuan bebek ngepet di belanda", link: "https://example.com", categories: ["Technology"], isoDate: "2024-02-14", description: "This is a sample news article.", image:
                                    NewsImage(small: "https://static.republika.co.id/uploads/images/inpicture_slide/012267000-1707927798-830-556.jpg")))
    
}
