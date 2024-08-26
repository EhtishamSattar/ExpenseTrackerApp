import SwiftUI

struct CircularPlusButton: View {
    var body: some View {
        
        Image(systemName: "plus")
            .resizable()
            .frame(width: 24, height: 24)
            .padding()
            .background(Color("ThemeColor"))
            .foregroundColor(.white)
            .clipShape(Circle())
            .shadow(radius: 5)
    }
}

#Preview{
    CircularPlusButton()
}
