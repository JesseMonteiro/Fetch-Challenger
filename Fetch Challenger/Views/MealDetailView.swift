//
//  MealDetailView.swift
//  Fetch Challenger
//
//  Created by Jesse Monteiro Ferreira on 05/09/24.
//
import SwiftUI
import WebKit

struct YouTubeView: UIViewRepresentable {
    let video: String
    func makeUIView(context: Context) ->  WKWebView {
        return WKWebView()
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let demoURL = URL(string: video) else { return }
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: demoURL))
    }
}

struct MealDetailView: View {
    let mealId: String
    @State private var mealDetail: MealDetail?
    @State private var isLoading = true
    
    var body: some View {
        ScrollView {
            if isLoading {
                ProgressView("Loading meal details...")
            } else if let mealDetail = mealDetail {
                VStack(alignment: .leading, spacing: 10) {
                    // Embed YouTube video if available
                    if let youtubeLink = mealDetail.strYoutube {
                        Text("Watch on YouTube")
                            .font(.headline)
                            .padding(.top)
                        
                        YouTubeView(video: youtubeLink)
                            .frame(height: 300)
                            .cornerRadius(10)
                    }
                    Text("Ingredients")
                        .font(.headline)
                        .padding(.vertical)
                    
                    ForEach(mealDetail.ingredients, id: \.self) { ingredient in
                        Text(ingredient)
                    }
                    
                    Text("Instructions")
                        .font(.headline)
                        .padding(.vertical)

                    Text(mealDetail.strInstructions)
                    
                    Spacer()
                }
                .padding()
                .navigationTitle(mealDetail.strMeal)
            } else {
                Text("Failed to load details.")
            }
        }
        .task {
            do {
                mealDetail = try await MealAPI.shared.fetchMealDetails(id: mealId)
                isLoading = false
            } catch {
                print("Failed to load meal details: \(error)")
            }
        }
    }
}
