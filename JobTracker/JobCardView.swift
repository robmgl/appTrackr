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
    
    private var companyInitial: String {
        String(job.company.prefix(1)).lowercased()
    }
    
    private var companyIconName: String {
        "\(companyInitial).circle.fill"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(job.title)
                        .font(.system(size: 22))
                        .bold()
                    Text("@ \(job.company)")
                        .font(.system(size: 17))
                    HStack {
                        Text("Status: \(job.status.rawValue)")
                            .font(.subheadline)
                            .bold()
                    }
                    if let updatedDate = job.updatedDate {
                        Text("Updated: \(dateFormatter.string(from: updatedDate))")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                    Text("Date Added: \(dateFormatter.string(from: job.dateAdded))")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 3)
        }
    }
}


