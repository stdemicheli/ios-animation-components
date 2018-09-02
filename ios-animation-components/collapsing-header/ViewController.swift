//
//  ViewController.swift
//  ios-animation-components
//
//  Created by De MicheliStefano on 02.09.18.
//  Copyright © 2018 De MicheliStefano. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var tableView: UITableView!
    var headerView: CustomHeaderView!
    var headerHeightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
        setupTableView()
    }
    
    func setupHeader() {
        
        headerView = CustomHeaderView(frame: CGRect.zero, title: "Love is in the air")
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        
        headerHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: 150.0)
        headerHeightConstraint.isActive = true
        
        let constraints: [NSLayoutConstraint] = [
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
    
    func setupTableView() {
        
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        let constraints: [NSLayoutConstraint] = [
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        // Conform to scroll view delegate methods
        tableView.delegate = self
        
    }
    
    func animateHeader() {
        // Set and animate the height constraint back to 150
        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.headerHeightConstraint.constant = 150
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Row \(indexPath.row)"
        return cell
    }
    
}

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            self.headerHeightConstraint.constant += abs(scrollView.contentOffset.y)
            headerView.incrementColorAlpha(with: self.headerHeightConstraint.constant)
            headerView.incrementIconAlpha(with: self.headerHeightConstraint.constant)
        } else if scrollView.contentOffset.y > 0 && self.headerHeightConstraint.constant >= 65 {
            // We don't want the header to move up too quickly so we divide the y-offset by 100
            self.headerHeightConstraint.constant -= scrollView.contentOffset.y / 100
            headerView.decrementColorAlpha(with: scrollView.contentOffset.y)
            headerView.decrementIconAlpha(with: self.headerHeightConstraint.constant)
            
            if self.headerHeightConstraint.constant < 65 {
                self.headerHeightConstraint.constant = 65
            }
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if self.headerHeightConstraint.constant > 150 {
            animateHeader()
        }
    }
    
    // Gets called when the scroll comes to a halt
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if self.headerHeightConstraint.constant > 150 {
            animateHeader()
        }
    }
    
}
