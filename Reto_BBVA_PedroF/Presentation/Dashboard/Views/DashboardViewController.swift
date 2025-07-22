//
//  DashboardViewController.swift
//  Reto_BBVA_PedroF
//
//  Created by Macky on 21/07/25.
//

import UIKit

class DashboardViewController: UIViewController {
    private let transactionListView = TransactionListView()
    private let viewModel: DashboardViewModel

    init(viewModel: DashboardViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        transactionListView.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = transactionListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Dashboard"
        configureTable()
        setupToggleSwitch()

        Task {
            await viewModel.fetchData()
            updateUI()
            transactionListView.dataUpdated()
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

    }

    private func updateUI() {
        if viewModel.shouldHideAmounts {
            transactionListView.balanceLabel.text = "$ ****"
            transactionListView.totalBalanceLabel.text = "Saldo: ****"
            transactionListView.totalIngresosLabel.text = "Ingresos: ****"
            transactionListView.totalEgresosLabel.text = "Egresos: ****"
        } else {
            transactionListView.balanceLabel.text = "$\(String(format: "%.2f", viewModel.balance))"
            transactionListView.totalBalanceLabel.text = "Saldo: $\(String(format: "%.2f", viewModel.balance))"
            transactionListView.totalIngresosLabel.text = "Ingresos: $\(String(format: "%.2f", viewModel.ingresos))"
            transactionListView.totalEgresosLabel.text = "Egresos: $\(String(format: "%.2f", viewModel.egresos))"
        }
    }
}

extension DashboardViewController: TransactionListViewDelegate {
    func getTransactionSections() -> [TransactionSection] {
        viewModel.sections
    }
    
    func isTranctationBookmarked(by id: Int) -> Bool {
        viewModel.isBookmarked(id)
    }
    
    func bookmarkPressed(by id: Int) {
        viewModel.toggleBookmark(for: id)
    }
    
    func isAmountHide() -> Bool {
        viewModel.shouldHideAmounts
    }
}
