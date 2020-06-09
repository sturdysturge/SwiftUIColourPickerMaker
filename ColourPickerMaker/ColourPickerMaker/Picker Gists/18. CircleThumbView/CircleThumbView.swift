import SwiftUI

struct CircleThumbView {
    let size: CGFloat
}

extension CircleThumbView: View {
    var body: some View {
        ZStack {
            Group {
                Circle()
                    .stroke(lineWidth: 10)
                    .foregroundColor(.white)
                Circle()
                    .stroke(lineWidth: 5)
                    .foregroundColor(.black)
            }
            .frame(width: self.size, height: self.size)
        }
    }
}

struct CircleThumbView_Previews: PreviewProvider {
    static var previews: some View {
        CircleThumbView(size: 25)
    }
}
