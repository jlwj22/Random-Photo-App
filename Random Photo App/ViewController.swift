import UIKit

class ViewController: UIViewController {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        return imageView
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Random Photo", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let colors: [UIColor] = [
        .systemRed,
        .systemOrange,
        .systemYellow,
        .systemTeal,
        .systemPink,
        .systemRed,
        .systemBlue,
        .systemGreen,
        .systemPurple]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemOrange
        view.addSubview(imageView)
        imageView.frame = CGRect(x: 0,
                                 y: 0,
                                 width: 300,
                                 height: 300)
        imageView.center = view.center
        
        view.addSubview(button)
        
        
        getRandomPhoto()
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc func didTapButton(){
        getRandomPhoto()
        
        view.backgroundColor = colors.randomElement()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.frame = CGRect(x: 30,
                              y: view.frame.size.height-150-view.safeAreaInsets.bottom,
                              width: view.frame.size.width-60,
                              height: 55)
    }

    func getRandomPhoto() {
        let urlString = "https://picsum.photos/200/300"
        guard let url = URL(string: urlString) else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let error = error {
                print("Error fetching image: \(error)")
                return
            }
            
            if let data = data {
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(data: data)
                }
            }
        }
        
        task.resume()
    }

}
