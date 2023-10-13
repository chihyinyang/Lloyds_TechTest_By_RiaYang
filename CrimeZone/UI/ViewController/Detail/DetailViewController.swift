//
//  DetailViewController.swift
//  CrimeZone
//
//  Created by 楊智茵 on 09/10/2023.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.reuseIdentifier())
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.sectionHeaderTopPadding = 0
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var headerView: DetailHeaderView = {
        let view = DetailHeaderView(imageURLString: viewModel.displayImageURLString)
        return view
    }()
    
    private var viewModel: DetailViewModel
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        transitioningDelegate = self
        modalPresentationStyle = .overFullScreen
        view.setAccessibilityIdentifier(by: .detailViewController)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        observeToClosePage()
    }
    
    // MARK: - UI
    private func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    // MARK: - action
    private func observeToClosePage() {
        headerView.closeDetailPageByClickedArrowButton
            .sink { [weak self] _ in
                self?.dismiss(animated: true)
            }.store(in: &viewModel.cancellables)
    }
}

// MARK: - tableView delegate
extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 500
    }
}

// MARK: - tableView dataSource
extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.displayRow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.reuseIdentifier(), for: indexPath) as! DetailTableViewCell
        
        if let data = viewModel.getDisplayDataIfContainsIndex(at: indexPath.row) {
            cell.setupData(key: data.key, value: data.value)
        }
        return cell
    }
}

// MARK: - transition
extension DetailViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transition = DetailViewTransition(type: .present)
        transition.imageURLString = viewModel.displayImageURLString
        transition.currentImageViewFrame = viewModel.displayImageOriginFrame
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transition = DetailViewTransition(type: .dismiss)
        transition.imageURLString = viewModel.displayImageURLString
        transition.originImageViewFrame = viewModel.displayImageOriginFrame
        transition.currentImageViewFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: 500)
        return transition
    }
}
