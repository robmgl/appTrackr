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
            VStack(alignment: .leading, spacing: 4) {
                Text(job.company)
                    .font(.body)
                    .foregroundColor(.primary)
                Text(job.title)
                    .font(.body)
                    .foregroundColor(.secondary)
                Text("Status: \(job.status.rawValue)")
                    .font(.footnote)
                    .foregroundColor(.gray)
                Text("Date Added: \(dateFormatter.string(from: job.dateAdded))")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .shadow(radius: 4)
            
            Spacer()
            
            Button(action: {
                viewModel.toggleLike(job: job)
            }) {
                Image(systemName: job.liked ? "heart.fill" : "heart")
                    .foregroundColor(job.liked ? Color("HeartColor") : .gray)
                    .font(.system(size: 24)) // Make the heart bigger
                    .scaleEffect(job.liked ? 1.2 : 1.0) // Slightly increase size when liked
                    .animation(.easeInOut(duration: 0.2)) // Add animation
            }
            .buttonStyle(PlainButtonStyle()) // Ensure Button style doesn't add any default behavior
        }
        .frame(maxWidth: .infinity) // Ensure the card takes up the full width of the List
    }
}





//#Preview {
//    JobCardView()
//}
