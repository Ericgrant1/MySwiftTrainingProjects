//
//  LanguagesFounders.swift
//  MyTableViewWithoutStoryboard
//
//  Created by Eric Grant on 01.03.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import Foundation

class LanguagesFounders {
    
    // 23.
    var name: String
    var fetchData: [DataInfo]     
    // 23.
    
    // 24.
    init(named: String, includeData: [DataInfo])
    {
        name = named
        fetchData = includeData
    }
    // 24.
    
    // 26.
    class func languageFounder() -> [LanguagesFounders]
    {
        return [self.fetchLanguagesData(), self.fetchFoundersData()]
    }
    // 26.
    
    // 25.
    private class func fetchLanguagesData() -> LanguagesFounders {
        
        var fetchData = [DataInfo]()
        fetchData.append(DataInfo(image: ImagesLanguages.java, title: "Java appeared in 1995"))
        fetchData.append(DataInfo(image: ImagesLanguages.swift, title: "Swift appeared in 2014"))
        fetchData.append(DataInfo(image: ImagesLanguages.ci, title: "C appeared in 1972"))
        fetchData.append(DataInfo(image: ImagesLanguages.cplus, title: "C++ appeared in 1983"))
        fetchData.append(DataInfo(image: ImagesLanguages.python, title: "Python appeared in 1991"))
        fetchData.append(DataInfo(image: ImagesLanguages.javascript, title: "JavaScript appeared in 1995"))
        fetchData.append(DataInfo(image: ImagesLanguages.ruby, title: "Ruby appeared in 1995"))
        fetchData.append(DataInfo(image: ImagesLanguages.php, title: "PHP appeared in 1995"))
        
        return LanguagesFounders(named: "Languages", includeData: fetchData)
    }
    
    private class func fetchFoundersData() -> LanguagesFounders {
        
        var fetchData = [DataInfo]()
        fetchData.append(DataInfo(image: ImagesFounders.gosling, title: "James Gosling - Java"))
        fetchData.append(DataInfo(image: ImagesFounders.lattner, title: "Chris Lattner - Swift"))
        fetchData.append(DataInfo(image: ImagesFounders.ritchie, title: "Dennis Ritchie - C"))
        fetchData.append(DataInfo(image: ImagesFounders.stroustrup, title: "Bjarne Stroustrup - C++"))
        fetchData.append(DataInfo(image: ImagesFounders.vanRossum, title: "Guido van Rossum - Python"))
        fetchData.append(DataInfo(image: ImagesFounders.eich, title: "Brendan Eich - JavaScript"))
        fetchData.append(DataInfo(image: ImagesFounders.matsumoto, title: "Yukihiro Matsumoto - Ruby"))
        fetchData.append(DataInfo(image: ImagesFounders.lerdorf, title: "Rasmus Lerdorf - PHP"))
        
        return LanguagesFounders(named: "Founders", includeData: fetchData)
        
    }
    // 25.
}
