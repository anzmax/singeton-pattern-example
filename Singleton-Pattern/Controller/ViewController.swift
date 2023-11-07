import UIKit

class ViewController: UIViewController {
    
    lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.borderStyle = .roundedRect
        textField.tintColor = .gray
        textField.textAlignment = .center
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.tintColor = .gray
        textField.textAlignment = .center
        return textField
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 12
        return stack
    }()
    
    lazy var passwordVisibleSwitch: UISwitch = {
        let passwordSwitch = UISwitch()
        passwordSwitch.onTintColor = .systemBlue
        passwordSwitch.addTarget(self, action: #selector(switchToggled), for: .touchUpInside)
        return passwordSwitch
    }()
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "See password?"
        label.textColor = .systemBlue
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        
        if UserPreferences.shared.isPasswordVisible() {
            passwordVisibleSwitch.isOn = true
            passwordTextField.isSecureTextEntry = false
        } else {
            passwordVisibleSwitch.isOn = false
            passwordTextField.isSecureTextEntry = true
        }
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(stackView)
        stackView.addArrangedSubview(usernameTextField)
        stackView.addArrangedSubview(passwordTextField)
        view.addSubview(passwordVisibleSwitch)
        view.addSubview(textLabel)
    }

    private func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        passwordVisibleSwitch.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 200),
            
            passwordVisibleSwitch.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            passwordVisibleSwitch.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            textLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            textLabel.centerYAnchor.constraint(equalTo: passwordVisibleSwitch.centerYAnchor)
        ])
    }
    
    @objc func switchToggled() {
        if passwordVisibleSwitch.isOn {
            passwordTextField.isSecureTextEntry = false
            UserPreferences.shared.setPasswordVisibility(true)
        } else {
            passwordTextField.isSecureTextEntry = true
            UserPreferences.shared.setPasswordVisibility(false)
        }
    }
}

