//
//  SilkTestView.swift
//  offline-only
//
//  Created by Los Mayers on 4/21/25.
//

import SwiftUI
import Combine

enum PostType {
    case image
    case text
}

struct ContentCard: View {
    let username: String?
    let imageName: String
    
    private static let availableImages = ["michelle", "nyc", "twombly"]
    
    init(username: String? = nil, imageName: String? = nil) {
        self.username = username
        self.imageName = imageName ?? ContentCard.getRandomImageName()
    }
    
    private static func getRandomImageName() -> String {
        return availableImages.randomElement() ?? "michelle"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 120)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            if let username = username {
                HStack(spacing: 6) {
                    Circle()
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 24, height: 24)
                    
                    Text(username)
                        .font(.caption)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .padding(.top, 4)
            }
        }
    }
}

struct TextPostCard: View {
    let username: String
    let content: String
    let severity: Int
	
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 6) {
                Circle()
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 28, height: 28)
                
                Text(username)
                    .font(.subheadline)
                    .fontWeight(.medium)
					.foregroundColor(.black)
                
                Spacer()
                
                HStack(spacing: 2) {
                    Text("\(severity)")
                        .font(.caption)
                        .fontWeight(.bold)
                    
                    Text("/100")
                        .font(.caption)
						.foregroundColor(.purple)
                }
            }
            
            Text(content)
                .font(.body)
				.foregroundColor(.green)
                .multilineTextAlignment(.leading)
                .lineLimit(6)
                .padding(.vertical, 4)
            
            HStack(spacing: 16) {
                Button(action: {}) {
                    Image(systemName: "heart")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Button(action: {}) {
                    Image(systemName: "bubble.right")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Button(action: {}) {
                    Image(systemName: "arrowshape.turn.up.right")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer()
            }
            .padding(.top, 4)
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
    }
	
	func test(){
		
	}
}

struct TabButton: View {
    let title: String
    let isSelected: Bool
    
    var body: some View {
        Text(title)
            .font(.subheadline)
            .fontWeight(isSelected ? .semibold : .regular)
            .foregroundColor(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(
                isSelected ?
                Capsule()
                    .fill(Color.white.opacity(0.2)) :
                Capsule()
                    .fill(Color.clear)
            )
    }
}

struct SilkTestView: View {
    @State private var selectedTab = 0
    @State private var textPosts: [SinResponse] = []
    @State private var isLoading = false
    @State private var errorMessage: String? = nil
    let tabs = ["Following", "Staff Picks", "Recent"]
    
    private let possiblePrompts = [
        "I stole some artwork",
        "I lied to my friend",
        "I cheated on my exam",
        "I skipped church on Sunday",
        "I had impure thoughts"
    ]
    
    var body: some View {
        ZStack {
            Color(red: 0.85, green: 0.3, blue: 0.5)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // App header
                HStack {
                    Circle()
                        .strokeBorder(Color.white, lineWidth: 1.5)
                        .background(Circle().fill(Color.white.opacity(0.4)))
                        .frame(width: 40, height: 40)
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image(systemName: "sparkles")
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 8)
                    
                    Button(action: {}) {
                        Image(systemName: "heart")
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 8)
                
                // Tab buttons
                HStack {
                    ForEach(0..<tabs.count, id: \.self) { index in
                        Button(action: {
                            selectedTab = index
                        }) {
                            TabButton(title: tabs[index], isSelected: selectedTab == index)
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal, 12)
                .padding(.top, 8)
                
                // Content grid
                ScrollView {
                    if isLoading && textPosts.isEmpty {
                        ProgressView()
                            .frame(maxWidth: .infinity, minHeight: 100)
                            .padding()
                    } else if let error = errorMessage, textPosts.isEmpty {
                        Text(error)
                            .foregroundColor(.red)
                            .padding()
                    } else {
                        LazyVGrid(columns: [
                            GridItem(.flexible(), spacing: 12),
                            GridItem(.flexible(), spacing: 12)
                        ], spacing: 16) {
                            // First row: Text post spanning full width
                            if !textPosts.isEmpty {
                                TextPostCard(username: "father_confessor", 
                                            content: textPosts[0].sinResponse, 
                                            severity: textPosts[0].sinSeverity)
                                    .gridCellColumns(2)
                            }
                            
                            // Image cards
                            ContentCard(username: "wali", imageName: "michelle")
                            ContentCard(username: nil)
                            
                            // Another text post if available
                            if textPosts.count > 1 {
                                TextPostCard(username: "priest_john", 
                                            content: textPosts[1].sinResponse, 
                                            severity: textPosts[1].sinSeverity)
                                    .gridCellColumns(2)
                            }
                            
                            ContentCard(username: "novia")
                            ContentCard(username: "1wiccadelic1")
                            
                            // Another text post if available
                            if textPosts.count > 2 {
                                TextPostCard(username: "cardinal_smith", 
                                            content: textPosts[2].penance, 
                                            severity: textPosts[2].sinSeverity)
                                    .gridCellColumns(2)
                            }
                            
                            ContentCard(username: "novia")
                            ContentCard(username: "novia")
                        }
                        .padding()
                    }
                }
                
                // Bottom navigation
                HStack(spacing: 0) {
                    Spacer()
                    ForEach(["house", "person.crop.rectangle", "plus", "folder", "person.circle"], id: \.self) { icon in
                        Button(action: {}) {
                            Image(systemName: icon)
                                .font(.title3)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    Spacer()
                }
                .padding(.vertical, 12)
                .background(Color(red: 0.85, green: 0.3, blue: 0.5))
            }
        }
        .statusBar(hidden: false)
        .preferredColorScheme(.dark)
        .onAppear {
            Task {
                await fetchTextPosts()
            }
        }
    }
    
    private func fetchTextPosts() async {
        isLoading = true
        errorMessage = nil
        textPosts = []
        
        // Attempt to fetch 3 posts
        for _ in 0..<3 {
            do {
                if let randomPrompt = possiblePrompts.randomElement() {
                    let response = try await SinService.shared.fetchSinResponse(with: randomPrompt)
                    DispatchQueue.main.async {
                        textPosts.append(response)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    errorMessage = "Failed to load posts: \(error.localizedDescription)"
                }
                break
            }
        }
        
        DispatchQueue.main.async {
            isLoading = false
        }
    }
}

#Preview {
    SilkTestView()
}
