import UIKit

class ViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let url = Bundle.main.url(forResource: "VIIRS_3Feb2012_lrg",
                                        withExtension: "jpg")
        else {
            fatalError("Missing image resource")
        }
        
        let scaleFactor = UIScreen.main.scale
        let scale = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
        let size = self.imageView.bounds.size.applying(scale)
        
        DispatchQueue.global(qos: .userInitiated).async {
            let start = CACurrentMediaTime()
            
//            let image = UIImage(contentsOfFile: url.path)
//            let image = CoreGraphics.resizedImage(at: url, for: size)
//            let image = CoreImage.resizedImage(at: url, for: size)
//            let image = ImageIO.resizedImage(at: url, for: size)
            let image = ImageIO.resizedImageWithHintingAndSubsampling(at: url, for: size)
//            let image = UIKit.resizedImage(at: url, for: size)
//            let image = vImage.resizedImage(at: url, for: size)
            
            DispatchQueue.main.sync {
                let duration = 1.0
                UIView.transition(with: self.imageView, duration: duration, options: [.curveEaseOut, .transitionCrossDissolve], animations: {
                    self.imageView.image = image
                }, completion: { _ in
                    let end = CACurrentMediaTime()
                    print(end - start - duration)
                })
            }
        }
    }
}

