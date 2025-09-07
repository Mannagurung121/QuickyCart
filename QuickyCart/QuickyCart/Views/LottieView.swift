import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    var filename: String? = nil
    var asset: String? = nil
    var loopMode: LottieLoopMode = .loop

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        let animationView = LottieAnimationView()

        if let filename = filename {
            animationView.animation = LottieAnimation.named(filename)
        } else if let asset = asset {
            animationView.animation = LottieAnimation.named(asset, bundle: .main)
        }

        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.play()

        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)

        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}
