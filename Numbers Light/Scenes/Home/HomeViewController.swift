//
//  HomeViewController.swift
//  Numbers Light
//
//  Created by El Mahdi Boukhris on 25/06/2022.
//

import UIKit
import Network

protocol HomeViewProtocol: AnyObject {
    func didLoadNumbersList(list: Numbers)
    func didFailToLoadNumbersList(withError error: NSError?)
    
    func didLoadNumberDetails(number: NumberBO)
    func didFailToLoadNumberDetails(withError error: NSError?)
    
    func startLoading()
    func stopLoading()
}

class HomeViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var numbersTableView: UITableView!
    
    // MARK: - Public properties
    
    private var viewModel: HomeViewModelProtocol!
  
    // MARK: - Private properties
  
    // MARK: - View lifecycle

    init(viewModel: HomeViewModelProtocol) {
        super.init(nibName: String(describing: HomeViewController.self), bundle: nil)

        self.viewModel = viewModel
        self.viewModel.bindToView(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Home"
        resetNavigationBar()
        setupTableView()
        
        loadNumbersList()
    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.startMonitoringNetworkChanges()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
  
    // MARK: - Display logic
    
    func setupTableView() {
        numbersTableView.register(UINib(nibName: "NumberCell", bundle: nil), forCellReuseIdentifier: "NumberCell")
    }
    
    func reloadTableView() {
        if let numbers = viewModel.getNumbersList(), numbers.count > 0 {
            numbersTableView.isHidden = false
            emptyView.isHidden = true
        } else {
            numbersTableView.isHidden = true
            emptyView.isHidden = false
        }
        
        numbersTableView.reloadData()
    }
  
    // MARK: - Actions
    
    @objc func didSelectRefreshButton() {
        loadNumbersList()
    }

  
    // MARK: - Overrides
    
    // MARK: - Private functions
    private func loadNumbersList() {
        startLoading()
        
        viewModel.loadNumbersList()
    }
    
    private func resetNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .refresh, target: self, action: #selector(didSelectRefreshButton))
    }
}

extension HomeViewController: HomeViewProtocol {
    
    func didLoadNumbersList(list: Numbers) {
        stopLoading()
        reloadTableView()
    }
    
    func didFailToLoadNumbersList(withError error: NSError?) {
        stopLoading()
        reloadTableView()
    }
    
    func didLoadNumberDetails(number: NumberBO) {
        stopLoading()

        let navigationMode: ViewControllerPresentationStyle = (UIDevice.current.userInterfaceIdiom == .phone) ? .present : .show
        let additionalData = ["selectedNumber": number] as [String : Any?]
        navController.navigate(to: .details, withStyle: navigationMode, andData: additionalData)
    }
    
    func didFailToLoadNumberDetails(withError error: NSError?) {
        stopLoading()
        
        let alert = UIAlertController(title: "Attention", message: "Impossible de charger le contenu demandé", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Fermer", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    func startLoading() {
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        activityIndicator.color = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        resetNavigationBar()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumbersList()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NumberCell", for: indexPath) as! NumberCell

        let number = viewModel.getNumbersList()?[indexPath.row]
        cell.populateView(withData: number)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedNumber = viewModel.getNumbersList()?[indexPath.row], let selectedName = selectedNumber.name {
            startLoading()
            viewModel.getNumberDetails(withName: selectedName)
        }
    }
}
