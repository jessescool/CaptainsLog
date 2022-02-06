import SwiftUI

struct BlueButton: View {
    let image: String
    
    var body: some View {
        Image(systemName: image)
            .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 80)
            .foregroundColor(.white)
            .background(Color(red: 0.498, green: 0.668, blue: 0.797))
            .cornerRadius(20)
    }
}

struct ButtonView: View {
    var body: some View {
    
        HStack {
            VStack {
                NavigationLink(destination: LogViewList(logs: LogEntry.tempData)) {
                    BlueButton(image: "map")
                }
                NavigationLink(destination: LogViewList(logs: LogEntry.tempData)) {
                    BlueButton(image: "tag")
                }
            }
            .frame(maxHeight: 80)
            
            NavigationLink(destination: LogViewList(logs: LogEntry.tempData)) {
                BlueButton(image: "list.star")
                    .font(.title)
            }
            NavigationLink(destination: LogViewList(logs: LogEntry.tempData)) {
                BlueButton(image: "magnifyingglass")
                    .font(.title)
            }
            NavigationLink(destination: LogViewList(logs: LogEntry.tempData)) {
                BlueButton(image: "plus")
                    .font(.title)
            }
        }
        .padding()
    }
}


struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView()
            .previewLayout(.fixed(width: 400, height: 100))
    }
}
