import SwiftUI

protocol DoubleGradientDisplayable: View {
    var horizontal: Parameter { get }
    var vertical: Parameter { get }
    var horizontalGradient: Gradient { get }
    var verticalGradient: Gradient { get }
}

extension DoubleGradientDisplayable {
    var body: some View {
        ZStack {
            // Horizontal gradient
            // - Start at vertical colour
            // - End at blend of both
            LinearGradient(gradient: horizontalGradient, startPoint: .leading, endPoint: .trailing)
                .mask( // Mask top to bottom to make vertical gradient visible
                    LinearGradient(gradient: Gradient(colors: [.clear, .white]), startPoint: .top, endPoint: .bottom)
                )
            // Vertical gradient
            // - Start at horizontal colour
            // - End at blend of both
            LinearGradient(gradient: verticalGradient, startPoint: .top, endPoint: .bottom)
                .mask( // Mask left tor ight to make horizontal gradient visible
                    LinearGradient(gradient: Gradient(colors: [.clear, .white]), startPoint: .leading, endPoint: .trailing)
                )
        }
    }
}

struct DoubleGradientView: DoubleGradientDisplayable {
    let horizontal: Parameter
    let vertical: Parameter
    let horizontalGradient: Gradient
    let verticalGradient: Gradient
    init(horizontal: Parameter, vertical: Parameter) {
        horizontal.checkCompatibility(with: vertical)
        self.horizontal = horizontal
        self.vertical = vertical
      horizontalGradient = horizontal.isAlpha ? .blank : .canvasGradient(axis: .horizontal,  horizontal: horizontal, vertical: vertical)
      verticalGradient = vertical.isAlpha ? .blank : .canvasGradient(axis: .vertical,  horizontal: horizontal, vertical: vertical)
    }
}

struct DoubleGradientView_Previews: PreviewProvider {
    static var previews: some View {
        DoubleGradientView(horizontal: .hue, vertical: .saturation)
    }
}
