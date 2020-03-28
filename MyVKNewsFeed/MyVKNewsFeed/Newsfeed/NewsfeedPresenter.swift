//
//  NewsfeedPresenter.swift
//  MyVKNewsFeed
//
//  Created by Eric Grant on 14.03.2020.
//  Copyright (c) 2020 Eric Grant. All rights reserved.
//

import UIKit

protocol NewsfeedPresentationLogic {
  func presentData(response: Newsfeed.Model.Response.ResponseType)
}

class NewsfeedPresenter: NewsfeedPresentationLogic {
  weak var viewController: NewsfeedDisplayLogic?
    
    // 97. Объект с помощью которого можно считать размеры для ячеек
    var cellLayoutCalculator: FeedCellLayoutCalculatorProtocol = FeedCellLayoutCalculator()
    // 97.
    
    // 76.
    let dateFormatter: DateFormatter = {
       let dt = DateFormatter()
        dt.locale = Locale(identifier: "ru_RU")
        dt.dateFormat = "d MMM 'в' HH:mm"
        return dt
    }()
    // 76.
  
  func presentData(response: Newsfeed.Model.Response.ResponseType) {
    // 48.
    switch response {
//    case .some:
//        print(".some Presenter")
//    case .presentNewsFeed:
//        print(".presentNewsFeed Presenter")
//        viewController?.displayData(viewModel: .displayNewsfeed)
    // 65.
    case .presentNewsFeed(let feed, let revealPostsIds): // + let revealPostsIds
        print(revealPostsIds)
        //viewController?.displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData.displayNewsfeed)
        // 67.
        let cells = feed.items.map { (feedItem) in
            // cellViewModel(from: feedItem)
            // 72.
            cellViewModel(from: feedItem, profiles: feed.profiles, groups: feed.groups, revealPostsIds: revealPostsIds)
            // 72.
        }
        // 67.
        
        // 275.
        let footerTitle = String.localizedStringWithFormat(NSLocalizedString("newsfeed cells count", comment: ""), cells.count)
        // 275.
        let feeedViewModel = FeedViewModel.init(cells: cells, footerTitle: footerTitle)
        viewController?.displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData.displayNewsfeed(feedViewModel: feeedViewModel))
    // 235.
    case .presentUserInfo(let user):
        let userViewModel = UserViewModel.init(photoUrlString: user?.photo100)
        viewController?.displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData.displayUser(userViewModel: userViewModel))
    // 270.
    case .presentFooterLoader:
        viewController?.displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData.displayFooterLoader)
    }
    // 270.
    // 235.
    // 65.
    // 48.
  }
    
    // 66.
    private func cellViewModel(from feedItem: FeedItem, profiles: [Profile], groups: [Group], revealPostsIds: [Int]) -> FeedViewModel.Cell {
        // 75.
        let profile = self.profile(for: feedItem.sourceId, profiles: profiles, groups: groups)
        // 75.
        
        // 90.
        let photoAttachments = self.photoAttachments(feedItem: feedItem)
        // 90.
        
        // 77.
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitle = dateFormatter.string(from: date)
        // 77.
        
        // 167.
        let isFullSized = revealPostsIds.contains { (postId) -> Bool in
            return postId == feedItem.postId
        }
        // 167.
        
        // let isFullsized = revealPostsIds.contains(feedItem.postId)
        
        // 98.
        let sizes = cellLayoutCalculator.sizes(postText: feedItem.text, photoAttachments: photoAttachments, isFullSizedPost: isFullSized)
        // 98.
        
        // 249.
        let postText = feedItem.text?.replacingOccurrences(of: "<br>", with: "\n")
        // 249.
        
        return FeedViewModel.Cell.init(postId: feedItem.postId,
                                       iconUrlString: profile.photo,
                                       name: profile.name,
                                       date: dateTitle,
                                       text: postText, //feedItem.text,
                                       likes: formattedCounter(feedItem.likes?.count), // String(feedItem.likes?.count ?? 0)
                                       comments: formattedCounter(feedItem.comments?.count), // String(feedItem.comments?.count ?? 0),
                                       shares: formattedCounter(feedItem.reposts?.count), // String(feedItem.reposts?.count ?? 0),
                                       views: formattedCounter(feedItem.views?.count), // String(feedItem.views?.count ?? 0),
                                       photoAttachments: photoAttachments,
                                       sizes: sizes)
    }
    // 66.
    
    // 244. 
    private func formattedCounter(_ counter: Int?) -> String? {
        guard let counter = counter, counter > 0 else { return nil }
        var counterString = String(counter)
        if 4...6 ~= counterString.count {
            counterString = String(counterString.dropLast(3)) + "K"
        } else if counterString.count > 6  {
            counterString = String(counterString.dropLast(6)) + "M"
        }
        return counterString
    }
    // 244.
  
    // 74.
    private func profile(for sourceId: Int, profiles: [Profile], groups: [Group]) -> ProfileRepresented {
        let profilesOrGroups: [ProfileRepresented] = sourceId >= 0 ? profiles : groups
        let normalSourceId = sourceId >= 0 ? sourceId : -sourceId
        let profileRepresented = profilesOrGroups.first { (myProfileRepresented) -> Bool in
            myProfileRepresented.id == normalSourceId
        }
        return profileRepresented!
    }
    // 74.
    
    // 89.
    private func photoAttachment(feedItem: FeedItem) -> FeedViewModel.FeedCellPhotoAttachment? {
        guard let photos = feedItem.attachments?.compactMap({ (attachment) in
            attachment.photo
        }), let firstPhoto = photos.first else {
            return nil
        }
        return FeedViewModel.FeedCellPhotoAttachment.init(photoUrlString: firstPhoto.scrBIG,
                                                          width: firstPhoto.width,
                                                          height: firstPhoto.height)
    }
    // 89.
    
    // 169.
    private func photoAttachments(feedItem: FeedItem) -> [FeedViewModel.FeedCellPhotoAttachment] {
        guard let attachments = feedItem.attachments else { return [] }
        
        return attachments.compactMap { (attachment) -> FeedViewModel.FeedCellPhotoAttachment? in
            guard let photo = attachment.photo else { return nil }
            return FeedViewModel.FeedCellPhotoAttachment.init(photoUrlString: photo.scrBIG,
                                                              width: photo.width,
                                                              height: photo.height)
        }
    }
    // 169.
}
