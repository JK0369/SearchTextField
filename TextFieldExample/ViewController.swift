//
//  ViewController.swift
//  TextFieldExample
//
//  Created by 김종권 on 2021/07/16.
//

import UIKit

class ViewController: UIViewController {

    lazy var tf = SearchTextField()

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }

    private func configure() {
        view.addSubview(tf)

        tf.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tf.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tf.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            tf.widthAnchor.constraint(equalToConstant: view.frame.width - 20),
            tf.heightAnchor.constraint(equalToConstant: 60)
        ])

        let tapGesture = UITapGestureRecognizer()
        view.addGestureRecognizer(tapGesture)
        tapGesture.addTarget(self, action: #selector(didTapBackgroundView))
    }

    @objc
    private func didTapBackgroundView() {
        tf.resignFirstResponder()
    }

}
