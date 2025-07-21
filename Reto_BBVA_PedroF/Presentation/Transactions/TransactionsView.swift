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


import Foundation

enum TransactionServiceError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed
}

final class TransactionService {
    
    static let shared = TransactionService()
    
    private init() { }
    
    func fetchTransactions(completion: @escaping (Result<Record, TransactionServiceError>) -> Void) {
        guard let url = URL(string: "https://api.jsonbin.io/v3/b/687e9f36f7e7a370d1eb9ee0") else {
            completion(.failure(.invalidURL))
            return
        }

        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, response, error in
            // Manejo de errores de red
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(.requestFailed(error)))
                }
                return
            }

            // Validar código de respuesta HTTP
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode),
                  let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(.invalidResponse))
                }
                return
            }

            // Decodificar
            do {
                let decoded = try JSONDecoder().decode(TransactionResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decoded.record))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.decodingFailed))
                }
            }
        }.resume()
    }
}
