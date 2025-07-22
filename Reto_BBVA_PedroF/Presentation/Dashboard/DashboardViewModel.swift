//
//  DashboardViewModel.swift
//  Reto_BBVA_PedroF
//
//  Created by Macky on 21/07/25.
//

import UIKit

class DashboardViewController: UIViewController {

    private let dashboardView = DashboardView()
    private let viewModel: DashboardViewModel
    

    init(viewModel: DashboardViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = dashboardView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Dashboard"
        configureTable()
        setupToggleSwitch()

        Task {
            await viewModel.fetchData()
            updateUI()
        }
    }

    private func setupToggleSwitch() {
        let toggle = UISwitch()
        toggle.isOn = viewModel.shouldHideAmounts
        toggle.addTarget(self, action: #selector(toggleSwitchChanged(_:)), for: .valueChanged)

        let toggleItem = UIBarButtonItem(customView: toggle)
        let labelItem = UIBarButtonItem(title: "Ocultar Montos", style: .plain, target: nil, action: nil)
        labelItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 14)], for: .normal)
        
        navigationItem.rightBarButtonItems = [toggleItem, labelItem]
    }

    @objc private func toggleSwitchChanged(_ sender: UISwitch) {
        viewModel.toggleHideAmounts(sender.isOn)
        updateUI()
    }

    private func configureTable() {
        dashboardView.tableView.delegate = self
        dashboardView.tableView.dataSource = self
    }

    private func updateUI() {
        if viewModel.shouldHideAmounts {
            dashboardView.balanceLabel.text = "$ ****"
            dashboardView.totalBalanceLabel.text = "Saldo: ****"
            dashboardView.totalIngresosLabel.text = "Ingresos: ****"
            dashboardView.totalEgresosLabel.text = "Egresos: ****"
        } else {
            dashboardView.balanceLabel.text = "$\(String(format: "%.2f", viewModel.balance))"
            dashboardView.totalBalanceLabel.text = "Saldo: $\(String(format: "%.2f", viewModel.balance))"
            dashboardView.totalIngresosLabel.text = "Ingresos: $\(String(format: "%.2f", viewModel.ingresos))"
            dashboardView.totalEgresosLabel.text = "Egresos: $\(String(format: "%.2f", viewModel.egresos))"
        }

        dashboardView.tableView.reloadData()
    }


}



extension DashboardViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sections[section].transactions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath) as? TransactionCell else {
            return UITableViewCell()
        }

        let transaction = viewModel.sections[indexPath.section].transactions[indexPath.row]
        cell.configure(with: transaction)
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sections[section].date
    }
}

extension DashboardViewController: UITableViewDelegate {
    // Implementa si necesitas altura personalizada o interacción
}

import Foundation

@MainActor
final class DashboardViewModel: ObservableObject {
    @Published var balance: Double = 0.0
    @Published var ingresos: Double = 0.0
    @Published var egresos: Double = 0.0
    @Published var sections: [TransactionSection] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var shouldHideAmounts: Bool = false

    private let getTransactionsUseCase: GetTransactionsUseCase
   
       private let getShouldHideUseCase: GetShouldHideAmountsUseCase
       private let setShouldHideUseCase: SetShouldHideAmountsUseCase

    init(getTransactionsUseCase: GetTransactionsUseCase,
             getShouldHideUseCase: GetShouldHideAmountsUseCase,
             setShouldHideUseCase: SetShouldHideAmountsUseCase) {
            self.getTransactionsUseCase = getTransactionsUseCase
            self.getShouldHideUseCase = getShouldHideUseCase
            self.setShouldHideUseCase = setShouldHideUseCase
            self.shouldHideAmounts = getShouldHideUseCase.execute()
        }

    func toggleHideAmounts(_ value: Bool) {
           shouldHideAmounts = value
           setShouldHideUseCase.execute(value)
       }
    
    func fetchData() async {
        isLoading = true
        errorMessage = nil

        do {
            let record = try await getTransactionsUseCase.execute()
            balance = record.balance

            let allTransactions = record.transactions
            ingresos = allTransactions
                .filter { $0.type == "ingreso" }
                .map { $0.amount }
                .reduce(0, +)

            egresos = allTransactions
                .filter { $0.type == "egreso" }
                .map { abs($0.amount) }
                .reduce(0, +)


            sections = allTransactions.groupedByDate()
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}

