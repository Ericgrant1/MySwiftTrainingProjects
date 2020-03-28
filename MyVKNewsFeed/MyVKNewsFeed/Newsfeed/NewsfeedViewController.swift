//
//  NewsfeedViewController.swift
//  MyVKNewsFeed
//
//  Created by Eric Grant on 14.03.2020.
//  Copyright (c) 2020 Eric Grant. All rights reserved.
//

import UIKit

protocol NewsfeedDisplayLogic: class {
  func displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData)
}

class NewsfeedViewController: UIViewController, NewsfeedDisplayLogic, NewsfeedCodeCellDelegate {
    
  var interactor: NewsfeedBusinessLogic?
  var router: (NSObjectProtocol & NewsfeedRoutingLogic)?
    
    // 59.
    private var feedViewModel = FeedViewModel.init(cells: [], footerTitle: nil) // + footerTitle: nil
    // 59.
    
    @IBOutlet weak var table: UITableView!
    
    // 216.
    private var titleView = TitleView()
    // 216.
    
    // 265.
    private lazy var footerView = FooterView() // lazy - чтобы объект инициализировался только когда мы его вызываем
    // 265.
    
    // 238.
    private var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    // 238.
  
  // MARK: Setup
  
  private func setup() {
    let viewController        = self
    let interactor            = NewsfeedInteractor()
    let presenter             = NewsfeedPresenter()
    let router                = NewsfeedRouter()
    viewController.interactor = interactor
    viewController.router     = router
    interactor.presenter      = presenter
    presenter.viewController  = viewController
    router.viewController     = viewController
  }
  
  // MARK: Routing
  

  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // 41.
    setup()
    // 41.
    // 241.
    setupTable()
    // 241.
    // 217.
    setupTopBars()
    // 217.
    
    // view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    
//    // 43.
//    table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//    // 43.

    // 61.
    interactor?.makeRequest(request: Newsfeed.Model.Request.RequestType.getNewsFeed)
    // 61.
    
    // 228.
    interactor?.makeRequest(request: Newsfeed.Model.Request.RequestType.getUser)
    // 228.
    }
    
    // 240.
    private func setupTable() {
        // 243. отступ постов от SearchBar
        let topInset: CGFloat = 8
        table.contentInset.top = topInset
        // 243.
        // 52.
        table.register(UINib(nibName: "NewsfeedCell", bundle: nil), forCellReuseIdentifier: NewsfeedCell.reuseId)
        // 52.
        // 116.
        table.register(NewsfeedCodeCell.self, forCellReuseIdentifier: NewsfeedCodeCell.reuseId)
        // 116.
        
        // 93.
        table.separatorStyle = .none
        table.backgroundColor = .clear
        // 93.
        table.addSubview(refreshControl)
        
        // 266.
        table.tableFooterView = footerView
        // 266.
    }
    // 240.
    
    // 215. Настройка NavigationBar
    private func setupTopBars() {
        // 276.
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let topBar = UIView(frame: window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
        topBar.backgroundColor = .white
        topBar.layer.shadowColor = UIColor.black.cgColor
        topBar.layer.shadowOpacity = 0.3
        topBar.layer.shadowOffset = CGSize.zero
        topBar.layer.shadowRadius = 8
        self.view.addSubview(topBar)
        // 276.
        
        self.navigationController?.hidesBarsOnSwipe = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.titleView = titleView
    }
    // 215.
    
    // 239.
    @objc private func refresh() {
        interactor?.makeRequest(request: Newsfeed.Model.Request.RequestType.getNewsFeed)
    }
    // 239.
    
    func displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData) {
    // 50.
    switch viewModel {
        //    case .some:
        //        print(".some ViewController")
        //    case .displayNewsfeed:
        //        print(".displayNewsfeed ViewController")
    // 68.
    case .displayNewsfeed(let feedViewModel):
        self.feedViewModel = feedViewModel
        // 274.
        footerView.setTitle(feedViewModel.footerTitle)
        // 274.
        table.reloadData()
    // 68.
        // 242.
        refreshControl.endRefreshing()
        // 242.
    // 237.
    case .displayUser(let userViewModel):
        titleView.set(userViewModel: userViewModel)
    // 272.
    case .displayFooterLoader:
        footerView.showLoader()
        }
    // 272.
    // 237.
    // 50.
    }
    
    // 251. фиксирует местоположение на экране
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y > scrollView.contentSize.height / 1.1 {
            // 255.
            interactor?.makeRequest(request: Newsfeed.Model.Request.RequestType.getNextBatch)
            // 255.
        }
    }
    // 251.
    
    // MARK: NewsfeedCodeCellDelegate
    // 159.
    func revealPost(for cell: NewsfeedCodeCell) {
        guard let indexPath = table.indexPath(for: cell) else { return }
        let cellViewModel = feedViewModel.cells[indexPath.row]
        
        interactor?.makeRequest(request: Newsfeed.Model.Request.RequestType.revealPostIds(postId: cellViewModel.postId))
    }
    // 159.
}

// 42.
extension NewsfeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedViewModel.cells.count // 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // переключение между двумя различными походами к созданию ячейки, оба работают одинаково
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCell
//        cell.textLabel?.text = "index: \(indexPath.row)"
//        return cell
        // 54.
//        let cell = tableView.dequeueReusableCell(withIdentifier: NewsfeedCell.reuseId, for: indexPath) as! NewsfeedCell
        
        // 117.
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsfeedCodeCell.reuseId, for: indexPath) as! NewsfeedCodeCell
        // 60.
        let cellViewModel = feedViewModel.cells[indexPath.row]
        cell.set(viewModel: cellViewModel)
        // 60.
        // cell.textLabel?.text = "index \(indexPath.row)"
        // 117.
        
        // 160.
        cell.delegate = self
        // 160.
        
        return cell
        // 54.
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("select row")
//        // 45.
//        interactor?.makeRequest(request: .getFeed)
//        // 45.
//    }
    // 55.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 103.
        let cellViewModel = feedViewModel.cells[indexPath.row]
        return cellViewModel.sizes.totalHeight
        // 103.
        // return 212
    }
    // 55.
    
    // 168.
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = feedViewModel.cells[indexPath.row]
        return cellViewModel.sizes.totalHeight
    }
    // 168.
    
}
// 42.
