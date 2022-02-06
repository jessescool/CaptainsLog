import SwiftUI


struct AdvancedButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Spacer()
            configuration.label.foregroundColor(.black)
            Spacer()
        }
        .padding()
        .background(Color.blue.cornerRadius(8))
        .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

struct OldButton: View {
    let image: String
    
    var body: some View {
        Image(systemName: image)
            .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 80)
            .foregroundColor(.white)
            .background(Color(red: 0.498, green: 0.668, blue: 0.797))
            .cornerRadius(10)
    }
}

struct ButtonView: View {
    var body: some View {
    
        HStack {
            VStack {
                NavigationLink(destination: BlackHoleView()) {
                    OldButton(image: "map")
                }
                NavigationLink(destination: BlackHoleView()) {
                    OldButton(image: "tag")
                }
            }
            .frame(maxHeight: 80)
            
            NavigationLink(destination: BlackHoleView()) {
                OldButton(image: "list.star")
                    .font(.title)
            }
            NavigationLink(destination: BlackHoleView()) {
                OldButton(image: "magnifyingglass")
                    .font(.title)
            }
            NavigationLink(destination: NewLogView()) {
                OldButton(image: "plus")
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
