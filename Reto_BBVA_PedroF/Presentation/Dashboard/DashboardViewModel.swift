//
//  DashboardViewModel.swift
//  Reto_BBVA_PedroF
//
//  Created by Macky on 21/07/25.
//

import UIKit

class DashboardViewController: UIViewController {

    private let dashboardView = DashboardView()
    private var sections: [TransactionSection] = []
    private var balance: Double = 0

    override func loadView() {
        view = dashboardView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()
        fetchData()
    }

    private func configureTable() {
        let table = dashboardView.tableView
        table.delegate = self
        table.dataSource = self
    }

    private func fetchData() {
        TransactionService.shared.fetchTransactions { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let record):
                self.balance = record.balance
                self.sections = record.transactions.groupedByDate()
                self.updateUI()
            case .failure(let error):
                print("Error:", error)
                // Aquí puedes mostrar alerta de error
            }
        }
    }

    private func updateUI() {
        dashboardView.balanceLabel.text = String(
            format: "Balance: $%.2f", abs(balance)
        )
        dashboardView.tableView.reloadData()
    }
}

extension DashboardViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].transactions.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let transaction = sections[indexPath.section].transactions[indexPath.row]
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "TransactionCell", for: indexPath
        ) as! TransactionCell
        cell.configure(with: transaction, showAmounts: true)
        return cell
    }

    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        sections[section].date
    }
}

extension DashboardViewController: UITableViewDelegate {
    // Personaliza altura de cabecera, selección, etc., si lo deseas
}
