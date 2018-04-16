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
    var kind = ""
    var releaseDate : Date? = nil
}

class Author{
    var authorUri = ""
    var authorName = ""
}

class Link{
    var salf = ""
    var alternate = ""
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
    var updated : Date? = nil
}
