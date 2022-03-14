//
//  SummaryCapsule.swift
//  Captains Log
//
//  Created by Jesse Cool on 3/14/22.
//

import SwiftUI

struct SummaryInfo: View {
    private var date = Date.now.formatted(date: .complete, time: .omitted)
    private var time = Date.now.formatted(date: .omitted, time: .shortened)
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        VStack(alignment: .center) {
            SummaryCapsule(title: locationManager.lastPlacemark?.subLocality ?? "Unknown", image: Image(systemName: "mappin"))
            SummaryCapsule(title: date, image: Image(systemName: "calendar"))
            SummaryCapsule(title: time, image: Image(systemName: "clock"))
        }
    }
}

struct SummaryCapsule: View {
    var title: String
    var image: Image
    
    var body: some View {
        
        ZStack {
            
            Color.accentColor
                .cornerRadius(15)
            
            HStack {
                image
                Text(title).bold()
            }
            .font(.title2)
            .padding()
        }
        .fixedSize(horizontal: false, vertical: true)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
        
    }
}
