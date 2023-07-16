//
//  ContentView.swift
//  TimeLine
//
//  Created by Syed Raza on 7/15/23.
//

import SwiftUI
import AVKit


//struct TimelineItem: Identifiable {
//    let id = UUID()
//    let timestamp: Date
//    let content: String
//    let videoURL: URL?
//}
//
//class TimelineViewModel: ObservableObject {
//    @Published var timelineItems: [TimelineItem] = []
//
//    func addTimelineItem(content: String, videoURL: URL?) {
//        let newItem = TimelineItem(timestamp: Date(), content: content, videoURL: videoURL)
//        timelineItems.append(newItem)
//    }
//}
//
//struct ContentView: View {
//    @ObservedObject var timelineViewModel = TimelineViewModel()
//    @State private var newItemContent: String = ""
//
//    var body: some View {
//        VStack {
//            VStack(spacing: 0) {
//                ForEach(timelineViewModel.timelineItems.indices, id: \.self) { index in
//                    VStack {
//                        if index != 0 {
//                            Divider()
//                                .frame(height: lineLengthForIndex(index))
//                        }
//                        Text(timelineViewModel.timelineItems[index].content)
//                            .font(.headline)
//                            .padding()
//
//                        if let videoURL = timelineViewModel.timelineItems[index].videoURL {
//                            VideoPlayer(player: AVPlayer(url: videoURL))
//                                .frame(height: 200)
//                        }
//                    }
//                }
//            }
//
//            HStack {
//                TextField("Enter new item", text: $newItemContent)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding()
//
//                Button(action: {
//                    let newVideoURL: URL? = URL(string: "https://www.youtube.com/watch?v=3Qowg0ufUK0") // Provide a valid video URL
//                    timelineViewModel.addTimelineItem(content: newItemContent, videoURL: newVideoURL)
//                    newItemContent = ""
//                }) {
//                    Text("Add")
//                        .padding()
//                        .background(Color.blue)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                }
//            }
//            .padding()
//        }
//    }
//
//    func lineLengthForIndex(_ index: Int) -> CGFloat {
//        let minLineLength: CGFloat = 3
//        let maxLineLength: CGFloat = 7
//        let scaleFactor: CGFloat = 20
//        let lineLength = CGFloat(min(max(index - 1, 0), timelineViewModel.timelineItems.count - 1)) * scaleFactor
//        return min(max(lineLength, minLineLength), maxLineLength)
//    }
//}


struct TimelineItem: Identifiable {
    let id = UUID()
    let timestamp: Date
    let content: String
    let videoURL: URL?
}

class TimelineViewModel: ObservableObject {
    @Published var timelineItems: [TimelineItem] = []

    func addTimelineItem(content: String, videoURL: URL?, timestamp: Date) {
        let newItem = TimelineItem(timestamp: timestamp, content: content, videoURL: videoURL)
        timelineItems.append(newItem)
    }
}

struct ContentView: View {
    @ObservedObject var timelineViewModel = TimelineViewModel()
    @State private var newItemContent: String = ""
    @State private var newItemTimestamp = Date()
    @State private var newItemVideoURL: URL?

    var body: some View {
        VStack {
            VStack(spacing: 0) {
                ForEach(timelineViewModel.timelineItems.indices, id: \.self) { index in
                    VStack {
                        if index != 0 {
                            Divider()
                                .frame(height: lineLengthForIndex(index))
                        }
                        Text(timelineViewModel.timelineItems[index].content)
                            .font(.headline)
                            .padding()

                        if let videoURL = timelineViewModel.timelineItems[index].videoURL {
                            VideoPlayer(player: AVPlayer(url: videoURL))
                                .frame(height: 200)
                        }
                    }
                }
            }

            DatePicker("Item Date", selection: $newItemTimestamp, displayedComponents: .date)
                .datePickerStyle(WheelDatePickerStyle())
                .padding()

            TextField("Enter new item", text: $newItemContent)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Video URL", text: Binding(
                get: { newItemVideoURL?.absoluteString ?? "" },
                set: { newItemVideoURL = URL(string: $0) }
            ))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                timelineViewModel.addTimelineItem(content: newItemContent, videoURL: newItemVideoURL, timestamp: newItemTimestamp)
                newItemContent = ""
                newItemTimestamp = Date()
                newItemVideoURL = nil
            }) {
                Text("Add")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }

    func lineLengthForIndex(_ index: Int) -> CGFloat {
        let minLineLength: CGFloat = 5
        let maxLineLength: CGFloat = 10
        let scaleFactor: CGFloat = 20
        let lineLength = CGFloat(min(max(index - 1, 0), timelineViewModel.timelineItems.count - 1)) * scaleFactor
        return min(max(lineLength, minLineLength), maxLineLength)
    }
}

  

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
