//
//  ListContentState.swift
//  CashStats
//
//  Created by GGsrvg on 04.08.2021.
//

import UIKit

class ListContentState: UIView {
    private var _type: TypeState = .content
    
    var type: TypeState { get { _type }}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    func change(to type: TypeState) {
        if _type == type {
            return
        }
        
        _type = type
        
        switch type {
        case .load:
            self.setState(viewState: createLoadView())
        case .content:
            self.clearSubviews()
        case .error(title: let title,
                    description: let description):
            self.setState(viewState: createErrorView(
                title: title,
                description: description
            ))
        }
    }
    
    private func commonInit() {
        layer.cornerRadius = 10
        self.backgroundColor = .systemGray5
        self.isUserInteractionEnabled = false
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(lessThanOrEqualToConstant: 320)
        ])
    }
    
    private func setState(viewState: UIView) {
        self.clearSubviews()
        
        addSubview(viewState)
        
        NSLayoutConstraint.activate([
            viewState.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            viewState.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            self.trailingAnchor.constraint(equalTo: viewState.trailingAnchor, constant: 12),
            self.bottomAnchor.constraint(equalTo: viewState.bottomAnchor, constant: 12),
        ])
    }
    
    private func clearSubviews() {
        self.subviews.forEach { $0.removeFromSuperview() }
    }
    
    private func createLoadView() -> UIView {
        let indicator = UIActivityIndicatorView()
        indicator.startAnimating()
        indicator.style = .large
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }
    
    private func createErrorView(title: String, description: String? ) -> UIView {
        let titleLabel: UILabel = .init()
        titleLabel.text = title
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        
        let descriptionLabel: UILabel = .init()
        descriptionLabel.text = description
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = .systemFont(ofSize: 16, weight: .regular)
        
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            descriptionLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
}

extension ListContentState {
    enum TypeState: Equatable {
        case load
        case content
        case error(title: String, description: String?)
    }
}
