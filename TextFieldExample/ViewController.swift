//
//  ViewController.swift
//  TextFieldExample
//
//  Created by 김종권 on 2021/07/16.
//

import UIKit

class ViewController: UIViewController {

    lazy var tf = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tf)

        tf.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tf.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tf.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tf.widthAnchor.constraint(equalToConstant: 120),
            tf.heightAnchor.constraint(equalToConstant: 80)
        ])

        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.black.cgColor
        tf.delegate = self

        let a = " 123 456 \n"
        print("before trimmingCharacters: \(a.count) ")
        print("after trimmingCharacters: \(a.trimmingCharacters(in: .whitespacesAndNewlines).count) ")
    }


}

extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Focus mode
        textField.leftViewMode = .never
        textField.rightViewMode = .always
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        // Resign mode
        textField.leftViewMode = .unlessEditing
        textField.rightViewMode = .never
    }

    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        // Writing mode

        /// trimmingCharacters(in:): 텍스트 좌측, 우측의 whitespace, newlines 문자열을 삭제하는 메서드
        /// let a = " 123 456 \n"
        /// print("before trimmingCharacters: \(a.count) ") // 10
        /// print("after trimmingCharacters: \(a.trimmingCharacters(in: .whitespacesAndNewlines).count) ") // 7

        /// newText: 새로 입력된 텍스트
        /// .trimmingCharacters(in: .whitespacesAndNewlines): 문자열 앞뒤 공백 제거 (" abc def " > "abcdef")
        let newText = string.trimmingCharacters(in: .whitespacesAndNewlines)

        /// text: 기존에 입력되었던 text
        /// predictRange: 입력으로 예상되는 text의 range값 추측 > range값을 알면 기존 문자열에 새로운 문자를 위치에 알맞게 추가 가능
        guard let text = textField.text, let predictRange = Range(range, in: text) else { return true }

        /// predictedText: 기존에 입력되었던 text에 새로 입력된 newText를 붙여서, 현재까지 입력된 전체 텍스트
        let predictedText = text.replacingCharacters(in: predictRange, with: newText)
            .trimmingCharacters(in: .whitespacesAndNewlines)

        return true
    }
}
