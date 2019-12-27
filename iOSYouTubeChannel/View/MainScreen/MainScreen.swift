//
//  MainScreen.swift
//  iOSYouTubeChannel
//
//  Created by Angelos Staboulis on 26/12/19.
//  Copyright © 2019 Angelos Staboulis. All rights reserved.
//

import UIKit
import SDWebImage
import SWXMLHash
class MainScreen: UITableViewController {
    let viewModel = ViewModel()
    var showList:Bool!=false
    var youtubeArray = [YouTube]()
    var getUrl:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
       
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
   
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return 10
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:YouTubeCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! YouTubeCell
        cell.showList = showList
        hideList(cell: cell)
        if(showList==true){
                setupCell(cell: cell,indexPath:indexPath)
        }
        else{

        }
        return cell
    }
 
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension MainScreen{
    func setupView(){
        self.title = "YouTube Channel Videos"
        self.tableView.register(UINib(nibName: "YouTubeCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title:"Show List", style: .done, target: self, action: #selector(reloadlist))
    }
    @objc func reloadlist(){
        if(showList == true){
            showList = false
            self.navigationItem.leftBarButtonItem?.title = "Show List"

        }
        else{
            showList = true
            self.navigationItem.leftBarButtonItem?.title = "Hide List"

        }
        tableView.reloadData()
    }
    func hideList(cell:YouTubeCell){
        if(cell.showList == false){
                     cell.lblDescription.text = "YouTube Channel Videos"
                     let urlImage = URL(string:"https://image.freepik.com/free-vector/circle-made-music-instruments_23-2147509304.jpg")
                     cell.imgVideo.sd_setImage(with:urlImage, completed: nil)
        }
    }
    func loadDesciption(cell:YouTubeCell,indexPath:IndexPath,index:XMLIndexer){
        for child in index["feed"]["entry"][indexPath.row].children{
            if((child.element?.name.contains("title"))!){
                    cell.lblDescription.text  = child.element?.text
            }
        }
    }
    func loadImages(cell:YouTubeCell,indexPath:IndexPath,index:XMLIndexer){
        self.getUrl=index["feed"]["entry"][indexPath.row]["media:group"]    ["media:thumbnail"].element?.attribute(by: "url")?.text
                               self.viewModel.updateImgVideo(imgVideo: self.getUrl ?? "https://image.freepik.com/free-vector/circle-made-music-instruments_23-2147509304.jpg")
        let urlImage = URL(string:self.viewModel.imgVideo)
        cell.imgVideo.sd_setImage(with: urlImage, completed: nil)
    }
    func setupCell(cell: YouTubeCell,indexPath:IndexPath){
        self.viewModel.loadVideos { (index) in
            if(indexPath.row < 10){
                    self.loadDesciption(cell: cell, indexPath: indexPath, index: index)
                    self.loadImages(cell: cell, indexPath: indexPath, index: index)
            }
        }
    }
}
