//
//  DetailTableViewCell.swift
//  CrimeZone
//
//  Created by 楊智茵 on 09/10/2023.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var keyLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 61, green: 61, blue: 61)
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 61, green: 61, blue: 61)
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        stackView.addArrangedSubview(keyLabel)
        stackView.addArrangedSubview(valueLabel)
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.lessThanOrEqualToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    func setupData(key: String, value: String) {
        keyLabel.text = key
        valueLabel.text = value
    }
}
