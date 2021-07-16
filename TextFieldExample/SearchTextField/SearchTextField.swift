//
//  SearchTextField.swift
//  TextFieldExample
//
//  Created by 김종권 on 2021/07/16.
//

import UIKit

class SearchTextField: BaseTextField {
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "btnSearchRight"), for: .normal)

        return button
    }()

    private lazy var clearButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "btnClearRight"), for: .normal)
        button.addTarget(self, action: #selector(didTapClearButton), for: .touchUpInside)

        return button
    }()

    override func configure() {
        super.configure()

        delegate = self
        borderStyle = .none
        textColor = .label
        font = .systemFont(ofSize: 16.0, weight: .bold)
        attributedPlaceholder = NSAttributedString(string: "검색 창",
                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholderText])

        layer.borderWidth = 1.0
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 4.0

        clearButtonMode = .never

        leftView = searchButton
        leftViewMode = .always

        rightView = clearButton
        rightViewMode = .whileEditing
    }

    // MARK: - Interaction

    @objc
    func didTapClearButton() {
        text?.removeAll()
        rightViewMode = .never
    }

    // MARK: - Rect padding

    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var padding = super.leftViewRect(forBounds: bounds)
        padding.origin.x += 12

        return padding
    }

    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var padding = super.rightViewRect(forBounds: bounds)
        padding.origin.x -= 12

        return padding
    }

    // MARK: - 입력 텍스트 inset 설정

    // editing 모드가 아닌 경우의 inset 값
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 14.0, left: 38.0, bottom: 14.0, right: 0.0))
    }

    // editing 모드인 경우의 inset 값
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 14.0, left: 38.0, bottom: 14.0, right: 36.0))
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 16.0, left: 38.0, bottom: 14.0, right: 36.0))
    }

}

extension SearchTextField: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        /// Focus mode

        /// 입력된 값이 없는 경우만 leftView(검색 이미지), rightView(클리어 버튼)를 보이지 않도록 설정
        if text?.isEmpty ?? true {
            rightViewMode = .never
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        /// Resign mode

        // leftViewMode, rightViewMode를 .never로 설정하여 사라지게끔 하는 작업 가능
    }

    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {

        /// newText: 새로 입력된 텍스트
        let newText = string.trimmingCharacters(in: .whitespacesAndNewlines)

        /// text: 기존에 입력되었던 text
        /// predictRange: 입력으로 예상되는 text의 range값 추측 > range값을 알면 기존 문자열에 새로운 문자를 위치에 알맞게 추가 가능
        guard let text = textField.text, let predictRange = Range(range, in: text) else { return true }

        /// predictedText: 기존에 입력되었던 text에 새로 입력된 newText를 붙여서, 현재까지 입력된 전체 텍스트
        let predictedText = text.replacingCharacters(in: predictRange, with: newText)
            .trimmingCharacters(in: .whitespacesAndNewlines)

        if predictedText.isEmpty {
            rightViewMode = .never
        } else {
            rightViewMode = .whileEditing
        }

        return true
    }
}
