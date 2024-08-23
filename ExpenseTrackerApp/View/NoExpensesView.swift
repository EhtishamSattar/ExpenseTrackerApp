import SwiftUI

struct NoExpensesView: View {
    var body: some View {
        VStack {
            Spacer()
            
            // Symbol and message
            VStack(spacing: 20) {
                Image(systemName: "exclamationmark.triangle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.yellow)
                    .padding()
                    .background(Color("ThemeColor"))
                    .clipShape(Circle())
                    .padding()
                    .shadow(radius: 10)
                    .scaleEffect(1.2)
                    .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: UUID()) // Animation

                Text("No Expenses took place yet")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding()
            }
            
            Spacer()
    
        }
        .padding()
    }
}

struct NoExpensesView_Previews: PreviewProvider {
    static var previews: some View {
        NoExpensesView()
    }
}
