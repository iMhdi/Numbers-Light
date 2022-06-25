//
//  DetailsViewController.swift
//  Numbers Light
//
//  Created by El Mahdi Boukhris on 23/06/2022.
//

import UIKit
import AlamofireImage

class DetailsViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var pronounciationLabel: UILabel!
    
    // MARK: - Public properties
    
    private var viewModel:DetailsViewModelProtocol!
  
    // MARK: - Private properties
  
    // MARK: - View lifecycle

    init(viewModel: DetailsViewModelProtocol) {
        super.init(nibName: String(describing: DetailsViewController.self), bundle: nil)

        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigationBar()
        
        populateView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
  
    // MARK: - Display logic
    
    private func populateView() {
        if let selectedNumber = viewModel.getSelectedNumber() {
            valueLabel.text = selectedNumber.name
            pronounciationLabel.text = selectedNumber.text
            
            if let url = selectedNumber.image?.replacingOccurrences(of: "http://", with: "https://") {
                let imageURL = URL(string: url)!
                imageView.af.setImage(withURL: imageURL)
            }
        }
    }

    func initNavigationBar() {
        let backButton = UIBarButtonItem(title: "Fermer", style: UIBarButtonItem.Style.plain, target: self, action: #selector(didCloseButton))
        navigationItem.leftBarButtonItem = backButton
    }
  
    // MARK: - Actions
    
    @objc func didCloseButton() {
        dismiss(animated: true)
    }
  
    // MARK: - Overrides
    
    // MARK: - Private functions
}
