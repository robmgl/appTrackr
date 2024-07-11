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
                Text(job.company)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(job.title)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(job.status.rawValue)
                    .font(.footnote)
                    .foregroundColor(.gray)
                Text("Date Added: \(dateFormatter.string(from: job.dateAdded))")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            Spacer()
            Button(action: {
                viewModel.toggleLike(job: job)
            }) {
                Image(systemName: job.liked ? "heart.fill" : "heart")
                    .foregroundColor(job.liked ? Color("HeartColor") : .gray)
                    .font(.system(size: 24)) // Adjust heart size
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 4)
        .frame(maxWidth: .infinity)  // Ensure it takes full width
    }
}





//#Preview {
//    JobCardView()
//}
