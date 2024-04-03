//
//  HeaderView.swift
//  News-Hub
//
//  Created by Vinamra Kaushal on 27/03/24.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("NH")
                    .underline()
                Text("News Hub")
                Spacer()
            }
            .bold()
            .foregroundStyle(Color(.systemRed))
            .font(.largeTitle)
            Text("Top Headlines")
                .foregroundStyle(.gray)
                .font(.title2)
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
    }
}

#Preview {
    HeaderView()
}
