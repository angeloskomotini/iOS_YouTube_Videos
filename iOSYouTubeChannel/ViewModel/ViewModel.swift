//
//  ViewModel.swift
//  iOSYouTubeChannel
//
//  Created by Angelos Staboulis on 26/12/19.
//  Copyright © 2019 Angelos Staboulis. All rights reserved.
//

import Foundation
import Alamofire
import SWXMLHash
class ViewModel{
    private var youtube = YouTube()
    
    var subchild:Int!=0
    
    var getImageUrl:String!
    
    var getLinkUrl:String!
    
    var imgVideo:String{
        return youtube.img!
    }
    
    var description:String{
        return youtube.description!
    }
    var link:String{
        return youtube.link!
    }
    func updateImgVideo(imgVideo:String){
        youtube.img = imgVideo
    }
    
    func updateDescription(description:String){
        youtube.description = description
    }
    func updateLink(link:String){
        youtube.link = link
    }
    func getURL()->URL{
        return URL(string:"https://www.youtube.com/feeds/videos.xml?channel_id=UCGLVF25EeueVaIZo9_cfO_w")!
    }
    func loadVideos(completion:@escaping (XMLIndexer)->()){
        DispatchQueue.global(qos: .utility).async{
        let urlVideos = self.getURL()
        let urlRequest = URLRequest(url: urlVideos)
            Alamofire.request(urlRequest).responseString { (response) in
                let xml = SWXMLHash.parse(response.data!)
                completion(xml)
            }
                
        }
    }

}
