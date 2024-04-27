//
//  ChannelView.swift
//  News-Hub
//
//  Created by Vinamra Kaushal on 17/04/24.
//

import SwiftUI

struct Channel: Identifiable {
    let id = UUID()
    let channelName: String
    let domain: String
    let imageName: String
}

struct ChannelView: View {
    let channels = [
        Channel(channelName: "Livemint", domain: "livemint.com",imageName: "livemint"),
        Channel(channelName: "News18", domain: "news18.com", imageName: "news18"),
        Channel(channelName: "NDTV", domain: "ndtv.com", imageName: "ndtv"),
        Channel(channelName: "Hindustan Times", domain: "hindustantimes.com", imageName: "hindustantimes"),
        Channel(channelName: "The Indian Express", domain: "indianexpress.com", imageName: "indianexpress"),
        Channel(channelName: "Firstpost", domain: "firstpost.com", imageName: "firstpost"),
        Channel(channelName: "Money Control", domain: "moneycontrol.com", imageName: "moneycontrol"),
        Channel(channelName: "Bar & Bench", domain: "barandbench.com", imageName: "barbench")
    ]
    var body: some View {
        VStack {
            HStack {
                Text("Channels")
                    .underline()
            }
            .bold()
            .foregroundStyle(Color(.systemRed))
            .font(.largeTitle)
            List(channels) { channel in
                NavigationLink(destination: ChannelNewsList(domain: channel.domain, title: channel.channelName)) {
                    VStack(alignment: .center, spacing: 10) {
                        ZStack() {
                            RoundedRectangle(cornerRadius: 12)
                                .frame(width: 340, height: 100)
                                .overlay(
                                    Image(channel.imageName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 340, height: 100)
                                        .cornerRadius(12)
                                        .clipped()
                                )
                        }
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    ChannelView()
}
