//
//  DataBaseController.swift
//  testURL
//
//  Created by Henintsoa Miora on 22/01/2018.
//  Copyright © 2018 Henintsoa Miora. All rights reserved.
//

import UIKit

protocol DBDelegate
{
    func dataLoaded( datas : ItunesAPIResults? )
}

class DataBaseController: NSObject {

    var delegate : DBDelegate? = nil
    
    var datas = ItunesAPIResults()
    
    func loadData()
    {
        //https://rss.itunes.apple.com/api/v1/fr/books/top-free/all/10/explicit.json
        
       
        
        if let url = URL(string : "https://rss.itunes.apple.com/api/v1/fr/books/top-free/all/10/explicit.json"){
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                // téléchargement OK/FAIL ici
                guard let data = data , error == nil else {
                    DispatchQueue.main.async {
                        self.delegate!.dataLoaded(datas: nil)
                    }
                    
                    return
                }
                
                // ici, data est valide et non optionnal
                do{
                    let root = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments )
                    if let rootDict = root as? [String : Any] {
                        if let feed = rootDict["feed"] as? [String : Any]
                        {
                            //Affiche le titre du classement des livres
                            if let title = feed["title"] as? String
                            {
                                self.datas.title = title
                            }
                            //Affiche l'id du classement des livres (url)
                            if let idClass = feed["id"] as? String
                            {
                                print("id : \(idClass)")
                                if let idClassement = Int(idClass){
                                    self.datas.id = idClassement
                                }
                            }
                            //Rentre dans Author pour prendre le nom et uri
                            if let author = feed["author"] as? [String : Any] {
                                let auteur = Author()
                                //Affiche le nom de l'auteur
                                if let nameAuthor = author["name"] as? String{
                                    print("nom Auteur : \(nameAuthor)")
                                    auteur.authorName = nameAuthor
                                    
                                }
                                //Affiche l'uri
                                if let uri = author["uri"] as? String{
                                    print("uri : \(uri)")
                                    auteur.authorUri = uri
                                }
                                self.datas.authors.append(auteur)
                            }
                            
                            //Rentre dans le link du lien
                            if let links = feed["links"] as? [[String : Any]] {
                                for link in links {
                                    //Affiche le link
                                    let linkLien = Link()
                                    if let selfs = link["self"] as? String {
                                        print("link self: \(selfs)")
                                        linkLien.salf = selfs
                                    }
                                    //Affiche l'alternate
                                    if let alternate = link["alternate"] as? String {
                                        print("alternate: \(alternate)")
                                        linkLien.alternate = alternate
                                    }
                                    self.datas.links.append(linkLien)
                                }
                            }
                            
                            //Affiche le copyright
                            if let copyright = feed["copyright"] as? String {
                                print("copyright: \(copyright)")
                                self.datas.copyright = copyright
                            }
                            
                            //Affiche le pays
                            if let country = feed["country"] as? String {
                                print("country: \(country)")
                                self.datas.country = country
                            }
                            
                            //Affiche l'icone
                            if let icon = feed["icon"] as? String {
                                print("icone: \(icon)")
                                self.datas.icon = icon
                            }
                            
                            //Affiche la date de la mise à jour
                            if let update = feed["update"] as? String {
                                print("update: \(update)")
                                let dateFormatter = DateFormatter()
                                self.datas.updated = dateFormatter.date(from : update)
                            }
                            
                            //On rentre dans les résultats trouvés
                            if let results = feed["results"] as? [ [String : Any] ]{
                                for  result in results {
                                    
                                    var book = Book()
                                    
                                    //Nom de l'artiste
                                    if let artistName = result["artistName"] as? String
                                    {
                                        print("Artiste : \(artistName)")
                                        book.artistName = artistName
                                    }
                                    
                                    //ID du livre
                                    if let id = result["id"] as? String
                                    {
                                        print("ID : \(id)")
                                        if let idLivre = Int(id){
                                            book.id = idLivre
                                        }
                                        
                                        
                                    }
                                    
                                    //release du livre
                                    if let releaseDate = result["releaseDate"] as? String
                                    {
                                        print("releaseDate : \(releaseDate)")
                                        let dateFormatter = DateFormatter()
                                        book.releaseDate = dateFormatter.date(from : releaseDate)
                                    }
                                    
                                    //nom du livre
                                    if let name = result["name"] as? String
                                    {
                                        print("name : \(name)")
                                        book.name = name
                                    }
                                    
                                    //Type de livre
                                    if let kind = result["kind"] as? String
                                    {
                                        print("kind : \(kind)")
                                        book.kind = kind
                                    }
                                    
                                    //ID Artiste du livre
                                    if let artistId = result["artistId"] as? Int
                                    {
                                        print("Artiste ID : \(artistId)")
                                        book.artistId = artistId
                                    }
                                    
                                    //ArtistUrl du livre
                                    if let artistUrl = result["artistUrl"] as? String
                                    {
                                        print("Artiste URL : \(artistUrl)")
                                        book.url = artistUrl
                                    }
                                    
                                    
                                    //Artwork du livre
                                    if let artworkUrl100 = result["artworkUrl100"] as? String
                                    {
                                        print("Artwork : \(artworkUrl100)")
                                        book.url100 = artworkUrl100
                                    }
                                    
                                    if let genres = result["genres"] as? [ [ String : Any ] ] {
                                        for genre in genres {
                                            let genreObject = Genre()
                                            // ID du genre
                                            if let genreIdString = genre["genreId"] as? String {
                                                print("genreId : \(genreIdString)")
                                                if let genreIdInt = Int( genreIdString ) {
                                                    genreObject.id = genreIdInt
                                                }
                                            }
                                            // Nom du genre
                                            if let name = genre["name"] as? String {
                                                print("name artiste : \(name)")
                                                genreObject.name = name
                                            }
                                            
                                            // URL du genre
                                            if let url = genre["url"] as? String {
                                                print("url du genre : \(url)")
                                                genreObject.url = url
                                            }
                                            book.genres.append(genreObject)
                                        }
                                    }
                                    
                                    //URL du livre
                                    if let urlLivre = result["url"] as? String {
                                        print("url du livre : \(urlLivre)")
                                        book.url = urlLivre
                                    }
                                    self.datas.books.append(book)
                                }
                            }
                        }
                    }
                    print("JSON OK")
                }
                catch
                {}
            }).resume()
            print("Start Download")
        }
    }
    
    func load() -> Bool
    {
        print("load")
        loadData()
        delegate!.dataLoaded(datas: datas)
        
        return false
    }

}
