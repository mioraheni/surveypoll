//
//  Model.swift
//  TestURL
//
//  Created by admin on 12/12/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation

class Genre{
    var id = 0
    var name = ""
    var url = ""
    func toString(){
        print("id genre : \(id), nom du genre : \(name), url du genre: \(url)")
    }
}

class Book{
    var url = ""
    var url100 = ""
    var artistUrl = ""
    var id = 0
    var name = ""
    var artistId = 0
    var artistName = ""
    var genres = [ Genre ]()
//    Impossible de transformer en format date donc laisser en string
//    var releaseDate : Date? = nil
    var releaseDate = ""
    func toString(){
        print("id = \(id), nom = \(name), id artiste : \(artistId), url : \(url), url100 :\(url100), artistUrl = \(artistUrl), nom artiste : \(artistName), date de réalisation : \(releaseDate)")
    }
}

class Author{
    var authorUri = ""
    var authorName = ""
    func toString(){
        print("auteur URI :\(authorUri), nom auteur : \(authorName)")
    }
}

class Link{
    var salf = ""
    var alternate = ""
    func toString(){
        print("salf :\(salf), alternate : \(alternate)")
    }
}

class ItunesAPIResults{
    var title = ""
    var books = [ Book ]()
    var authors = [ Author ]()
    var links = [ Link ]()
    var id = 0
    var copyright = ""
    var country = ""
    var icon = ""
//    Impossible de transformer en format date donc laisser en string
//    var updated : Date? = nil
    var updated = ""
    
    func toString(){
        print("id : \(id), titre :\(title), copyright : \(copyright), country : \(country), icon : \(icon), updated : \(updated)")
    }
}
