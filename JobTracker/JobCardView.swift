//
//  JobCardView.swift
//  JobTracker
//
//  Created by Rob Miguel on 7/10/24.
//

import SwiftUI

struct JobCardView: View {
    @ObservedObject var viewModel: JobListViewModel
    var job: Job
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(job.company) // Company name displayed first
                    .font(.headline)
                Text(job.title) // Job title displayed second
                Text("Status: \(job.status.rawValue)")
                Text("Date Added: \(dateFormatter.string(from: job.dateAdded))") // New line
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Spacer()

            Button(action: {
                viewModel.toggleLike(job: job)
            }) {
                Image(systemName: job.liked ? "heart.fill" : "heart")
                    .foregroundColor(job.liked ? .red : .gray)
                    .font(.system(size: 28)) // Make the heart bigger
                    .scaleEffect(job.liked ? 1.2 : 1.0) // Slightly increase size when liked
                    .animation(.easeInOut(duration: 0.2)) // Add animation
            }
            .buttonStyle(PlainButtonStyle()) // Ensure Button style doesn't add any default behavior
        }
        .contentShape(Rectangle())
    }
}


//#Preview {
//    JobCardView()
//}
