import SwiftUI

@available(iOS 15.0, *)

struct ButtonView: View {
    var body: some View {
        
        HStack {
            VStack {
                NavigationLink(destination: LogView(logs: LogEntry.data)) {
                    Text("\(Image(systemName: "map"))")
                    .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 50)
                    .foregroundColor(.white)
                    .background(Color(red: 0.498, green: 0.668, blue: 0.797))
                    .cornerRadius(10)
                }
            
                NavigationLink(destination: LogView(logs: LogEntry.data)) {
                    Text("\(Image(systemName: "tag"))")
                    .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 50)
                    .foregroundColor(.white)
                    .background(Color(red: 0.498, green: 0.668, blue: 0.797))
                    .cornerRadius(10)
                }
            }
            .frame(maxHeight: 80)
            
            NavigationLink(destination: LogView(logs: LogEntry.data)) {
                Text("\(Image(systemName: "list.star"))")
                .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 80)
                .foregroundColor(.white)
                .background(Color(red: 0.498, green: 0.668, blue: 0.797))
                .cornerRadius(20)
                .font(.title)
            }
            
            NavigationLink(destination: SearchView()) {
                Text("\(Image(systemName: "magnifyingglass"))")
                .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 80)
                .foregroundColor(.white)
                .background(Color(red: 0.498, green: 0.668, blue: 0.797))
                .cornerRadius(20)
                .font(.title)
            }
            
            NavigationLink(destination: LogView(logs: LogEntry.data)) {
                Text("\(Image(systemName: "plus"))")
                .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 80)
                .foregroundColor(.white)
                .background(Color(red: 0.498, green: 0.668, blue: 0.797))
                .cornerRadius(20)
                .font(.title)
            }
        }
        .padding()
    }
}

@available(iOS 15.0, *)
struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView()
            .previewLayout(.fixed(width: 400, height: 100))
    }
}
