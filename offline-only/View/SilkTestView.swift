//
//  SilkTestView.swift
//  offline-only
//
//  Created by Los Mayers on 4/21/25.
//

import SwiftUI

struct ContentCard: View {
    let username: String?
    let color: Color
    
    init(username: String? = nil, color: Color? = nil) {
        self.username = username
        self.color = color ?? Color(red: Double.random(in: 0...1), 
                                   green: Double.random(in: 0...1), 
                                   blue: Double.random(in: 0...1))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            color.frame(height: 120)
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
    let tabs = ["Following", "Staff Picks", "Recent"]
    
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
                    LazyVGrid(columns: [
                        GridItem(.flexible(), spacing: 12),
                        GridItem(.flexible(), spacing: 12)
                    ], spacing: 16) {
                        ContentCard(username: "wali", color: .orange)
                        ContentCard(username: nil)
                        ContentCard(username: "novia")
                        ContentCard(username: "1wiccadelic1")
                        ContentCard(username: "novia")
                        ContentCard(username: "novia")
                    }
                    .padding()
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
    }
}

#Preview {
    SilkTestView()
}
