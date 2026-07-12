import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private let themeSwitch: UISwitch = {
        let toggle = UISwitch()
        toggle.onTintColor = .systemMint
        return toggle
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        view.backgroundColor = .systemGroupedBackground
        
        setupNavigationBar()
        setupTableView()
        setupThemeSwitchState()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ThemeCell")
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupThemeSwitchState() {
        themeSwitch.addTarget(self, action: #selector(themeChanged(_:)), for: .valueChanged)
        
        let isSystemDarkMode = traitCollection.userInterfaceStyle == .dark
        themeSwitch.isOn = isSystemDarkMode
    }
    
    @objc private func themeChanged(_ sender: UISwitch) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.forEach { window in
                UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve) {
                    window.overrideUserInterfaceStyle = sender.isOn ? .dark : .light
                }
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Aparência"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ThemeCell", for: indexPath)
        
        cell.textLabel?.text = "Modo Escuro"
        cell.imageView?.image = UIImage(systemName: "moon.fill")
        cell.imageView?.tintColor = .systemPurple
        
        cell.accessoryView = themeSwitch
        cell.selectionStyle = .none
        
        return cell
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Configurações"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.label]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationController?.isNavigationBarHidden = false
    }
}
