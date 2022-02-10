//
//  WrappingView.swift
//  Captains Log
//
//  Created by Jesse Cool on 2/9/22.
//

import SwiftUI

struct WrapperView: View {
    var body: some View {
        NavigationView {
            TabView {
                TitleView()
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("Record")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            NavigationLink(destination: ProfileView()) {
                                Image(systemName: "person")
                                    .padding(.leading, 15)
                            }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            NavigationLink(destination: SettingsView()) {
                                Image(systemName: "gear")
                                    .padding(.trailing, 15)
                            }
                        }
                    }
                LogbookView(logs: LogEntry.tempData)
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("Logbook")
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
}

struct WrappingView_Previews: PreviewProvider {
    static var previews: some View {
        WrapperView()
    }
}
