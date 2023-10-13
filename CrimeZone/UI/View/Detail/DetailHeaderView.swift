//
//  DetailHeaderView.swift
//  CrimeZone
//
//  Created by 楊智茵 on 10/10/2023.
//

import UIKit
import SDWebImage
import Combine

class DetailHeaderView: UIView {
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.applyBlurEffect(with: .dark)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var arrowButton: ArrowButton = {
        let button = ArrowButton()
        button.setAccessibilityIdentifier(by: .detailArrowButton)
        button.imageState = .down
        button.addTarget(self, action: #selector(didTapArrowButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var closeDetailPageByClickedArrowButton = PassthroughSubject<Void, Never>()
    
    private var imageURLString: String
    
    init(imageURLString: String) {
        self.imageURLString = imageURLString
        super.init(frame: .zero)
        setupUI()
        if let url = URL(string: imageURLString) {
            imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "shuffle_unavailableImage"))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        addSubview(arrowButton)
        arrowButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
            make.width.equalTo(45)
            make.height.equalTo(45)
        }
    }
    
    @objc
    private func didTapArrowButton() {
        closeDetailPageByClickedArrowButton.send()
    }
}
