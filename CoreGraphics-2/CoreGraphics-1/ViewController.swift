//
//  ViewController.swift
//  CoreGraphics-1
//
//  Created by ad on 2021/9/3.
//
//  详细介绍：https://github.com/pro648/tips/blob/master/sources/CoreGraphics%E7%B3%BB%E5%88%97%E4%BA%8C%EF%BC%9Agradient%E5%92%8Ccontext.md

import UIKit

class ViewController: UIViewController {
    
    private var isGraphViewShowing = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        addAllSubviews()
        makeAllConstraints()
        binding()
        updateAppearance()
    }

    private lazy var addButton: PushButton = {
        let button = PushButton()
        button.fillColor = UIColor(red: 87.0 / 255.0, green: 218.0 / 255.0, blue: 213.0 / 255.0, alpha: 1.0)
        button.addTarget(self, action: #selector(pushButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var minusButton: UIButton = {
        let button = PushButton()
        button.isAddButton = false
        button.fillColor = UIColor(red: 238.0 / 255.0, green: 77.0 / 255.0, blue: 77.0 / 255.0, alpha: 1.0)
        button.addTarget(self, action: #selector(pushButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var counterView: CounterView = {
        let view = CounterView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
//        view.backgroundColor = UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 102.0 / 255.0, alpha: 1.0)
//        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var graphView: GraphView = {
        let view = GraphView()
        view.backgroundColor = .white
        view.isHidden = true
        return view
    }()
}

extension ViewController {
    private func addAllSubviews() {
        view.addSubview(addButton)
        view.addSubview(minusButton)
        view.addSubview(containerView)
        containerView.addSubview(counterView)
        containerView.addSubview(graphView)
    }
    
    private func makeAllConstraints() {
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.widthAnchor.constraint(equalToConstant: 100),
            addButton.heightAnchor.constraint(equalToConstant: 100),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100),
        ])
        
        minusButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            minusButton.widthAnchor.constraint(equalToConstant: 50),
            minusButton.heightAnchor.constraint(equalToConstant: 50),
            minusButton.centerXAnchor.constraint(equalTo: addButton.centerXAnchor),
            minusButton.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 20)
        ])
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalToConstant: 300),
            containerView.heightAnchor.constraint(equalToConstant: 300),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 130),
        ])
        
        graphView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            graphView.widthAnchor.constraint(equalToConstant: 300),
            graphView.heightAnchor.constraint(equalToConstant: 250),
            graphView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            graphView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        ])
        
        counterView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            counterView.widthAnchor.constraint(equalToConstant: 230),
            counterView.heightAnchor.constraint(equalToConstant: 230),
            counterView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            counterView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
        ])
    }
    
    private func binding() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleCounterViewTap(_:)))
        containerView.addGestureRecognizer(tapGesture)
    }
    
    private func updateAppearance() {
//        view.backgroundColor = .white
        counterView.counterLabel.text = String(counterView.counter)
    }
    
    @objc private func pushButtonPressed(_ button: PushButton) {
        if button.isAddButton {
            counterView.counter += 1
        } else {
            if counterView.counter > 0 {
                counterView.counter -= 1
            }
        }
        
        counterView.counterLabel.text = String(counterView.counter)
        if isGraphViewShowing {
            handleCounterViewTap(nil)
        }
    }
    
    @objc func handleCounterViewTap(_ gesture: UITapGestureRecognizer?) {
        if isGraphViewShowing { // Hide Graph
            UIView.transition(from: graphView, to: counterView, duration: 1.0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        } else {    // Show Graph
            UIView.transition(from: counterView, to: graphView, duration: 1.0, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        }
        
        isGraphViewShowing.toggle()
    }
}
