//
//  DashboardView.swift
//  Reto_BBVA_PedroF
//
//  Created by Macky on 21/07/25.
//

import UIKit

class DashboardView: UIView {
    
    // MARK: - Resumen Financiero
    let resumenStackView = UIStackView()
    let totalBalanceLabel = UILabel()
    let totalIngresosLabel = UILabel()
    let totalEgresosLabel = UILabel()

    
    // MARK: - Header
    let headerView = UIView()
    let balanceLabel = UILabel()
    let titleLabel = UILabel()

    // MARK: - Lista de Transacciones (UITableView)
    let tableView = UITableView(frame: .zero, style: .grouped)
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHeader()
        setupTable()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupHeader()
        setupTable()
    }
    
    // MARK: - Setup Header
    private func setupHeader() {
        addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = .black
        
        // Título del header
        headerView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        titleLabel.textColor = .lightGray
        titleLabel.text = "Dashboard"
        
        // Balance principal
        headerView.addSubview(balanceLabel)
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceLabel.font = .boldSystemFont(ofSize: 24)
        balanceLabel.textColor = .white
        
        // MARK: - Setup Resumen Stack
        headerView.addSubview(resumenStackView)
        resumenStackView.translatesAutoresizingMaskIntoConstraints = false
        resumenStackView.axis = .horizontal
        resumenStackView.distribution = .equalSpacing
        resumenStackView.alignment = .center

        // Configura los labels del resumen
        [totalBalanceLabel, totalIngresosLabel, totalEgresosLabel].forEach {
            $0.font = .systemFont(ofSize: 12, weight: .medium)
            $0.textColor = .lightGray
            resumenStackView.addArrangedSubview($0)
        }

        NSLayoutConstraint.activate([
            resumenStackView.topAnchor.constraint(equalTo: balanceLabel.bottomAnchor, constant: 8),
            resumenStackView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            resumenStackView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
        ])

        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 130),
            
            titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            
            balanceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            balanceLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16)
        ])
    }

    // MARK: - Setup TableView (Lista)
    private func setupTable() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: - Registro de Celdas
        tableView.register(TransactionCell.self, forCellReuseIdentifier: "TransactionCell")
        
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .black
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}

