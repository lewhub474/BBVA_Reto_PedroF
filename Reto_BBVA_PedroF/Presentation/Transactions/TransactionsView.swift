//
//  TransactionsView.swift
//  Reto_BBVA_PedroF
//
//  Created by Macky on 21/07/25.
//

import UIKit

class TransactionsView: UIView {

    let tableView = UITableView(frame: .zero, style: .plain)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTableView()
    }

    private func setupTableView() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])

        tableView.register(TransactionCell.self, forCellReuseIdentifier: "TransactionCell")
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        backgroundColor = .black
    }
}

import UIKit

class TransactionsViewController: UIViewController {

    private let transactionsView = TransactionsView()
    private var transactions: [Transaction] = []
    private var groupedTransactions: [String: [Transaction]] = [:]
    private var sortedSectionTitles: [String] = []


    override func loadView() {
        view = transactionsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        title = "Movimientos"
        configureTable()
      
    }

    private func configureTable() {
        let tableView = transactionsView.tableView
        tableView.delegate = self
        tableView.dataSource = self
    }

 
    
}


extension TransactionsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        groupedTransactions.keys.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionKey = sortedSectionTitles[section]
        return groupedTransactions[sectionKey]?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath) as? TransactionCell else {
            return UITableViewCell()
        }

        let sectionKey = sortedSectionTitles[indexPath.section]
        if let transaction = groupedTransactions[sectionKey]?[indexPath.row] {
            cell.configure(with: transaction)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sortedSectionTitles[section]
    }
}

extension TransactionsViewController: UITableViewDelegate {
    // Aquí puedes implementar didSelectRow, heightForRow, etc.
}


