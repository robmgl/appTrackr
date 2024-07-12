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
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(job.company)
                        .font(.system(size: 25))
                        .bold()
                    Text(job.title)
                        .font(.subheadline)
                    Text("Status: \(job.status.rawValue)")
                        .font(.subheadline)
                    Text("Date Added: \(dateFormatter.string(from: job.dateAdded))")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Button(action: {
                    viewModel.toggleLike(job: job)
                }) {
                    Image(systemName: job.liked ? "heart.fill" : "heart")
                        .foregroundColor(job.liked ? .red : .gray)
                        .font(.title2)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 2)
        }
        .onChange(of: job.liked) { newValue in
            // Handle any additional changes if needed
        }
    }
}





//#Preview {
//    JobCardView()
//}
