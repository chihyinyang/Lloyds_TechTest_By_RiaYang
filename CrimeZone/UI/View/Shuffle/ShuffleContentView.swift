//
//  ShuffleContentView.swift
//  CrimeZone
//
//  Created by 楊智茵 on 08/10/2023.
//

import UIKit
import SDWebImage
import Combine

class ShuffleContentView: UIView {
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.applyBlurEffect(with: .dark)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
        
    private lazy var arrowButton: ArrowButton = {
        let button = ArrowButton()
        button.imageState = .up
        button.addTarget(self, action: #selector(didTapArrowButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tagStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    weak var showDetailPageByIndex: PassthroughSubject<Int, Never>?
    
    private var index: Int?
                    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    private func setupUI() {
        clipsToBounds = true
        layer.cornerRadius = 20
        layer.cornerCurve = .continuous
        addBackgroundView()
        addImageView()
        addArrowButton()
    }
    
    private func addBackgroundView() {
        addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
    
    private func addImageView() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
    
    private func addArrowButton() {
        addSubview(arrowButton)
        arrowButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
            make.width.equalTo(45)
            make.height.equalTo(45)
        }
    }
    
    func setupAccessibilityIdentifier(by index: Int) {
        // set arrow button accessibility id
        arrowButton.setAccessibilityIdentifier(by: .shuffleArrowButton(index: index))
        // set shuffle content view
        setAccessibilityIdentifier(by: .shuffleContentView(index: index))
    }
    
    // MARK: - data
    func setupData(urlString: String, index: Int) {
        self.index = index
        if let url = URL(string: urlString) {
            imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "shuffle_unavailableImage"))
        }
    }
    
    // MARK: - action
    @objc
    private func didTapArrowButton() {
        if let index = index {
            showDetailPageByIndex?.send(index)
        }
    }
}
