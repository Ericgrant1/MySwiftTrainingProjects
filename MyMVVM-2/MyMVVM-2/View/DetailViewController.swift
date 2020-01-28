//
//  DetailViewController.swift
//  MyMVVM-2
//
//  Created by Eric Grant on 27.01.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    
    // 19.
    var viewModel: DetailViewModelType?
    
    // метод используем для обновления ярлыка
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let viewModel = viewModel else { return }
        self.textLabel.text = viewModel.description
    }
    // 19.
    
    // 27.
    override func viewDidLoad() {
        super.viewDidLoad()
        // связали age с ярлыком
        viewModel?.age.bind{ [unowned self] in
            guard let string = $0 else { return }
            self.textLabel.text = string
        }
        
        gelay(delay: 5) { [unowned self] in
            self.viewModel?.age.value = "some new value"
        }
    }
    // 27.

    // 28. Метод отсрочки, перед выполнением closure
    private func gelay(delay: Double, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + delay) {
            closure()
        }
    }
    // 28.
    
}
