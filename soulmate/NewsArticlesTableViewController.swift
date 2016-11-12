//
//  NewsArticlesTableViewController.swift
//  soulmate
//
//  Created by Richard Hsu on 11/2/16.
//  Copyright © 2016 Richard Hsu. All rights reserved.
//

import UIKit

class NewsArticlesTableViewController: UITableViewController {
    
    
    lazy var newsAPIClient = {
        return NewsAPIClient(APIKey: "hello")
    }()
    
    var articles: [NewsArticle] = []
    {
        didSet
        {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        // start network request to alchemyapi
        newsAPIClient.fetchCurrentNews()
        {
                result in
                switch result
                {
                case .Success(let currentNews):
                    print("---start---")
                    print(currentNews.newsArticles)
                    self.articles = currentNews.newsArticles
                    print("---end---")
                    
                case .Failure(let error as NSError):
                    self.showAlert("Unable to retrieve news", message: error.localizedDescription)
                    
                default: break
                    
                }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return articles.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("NewsArticleCell", forIndexPath: indexPath) as! NewsArticleCell

        // Configure the cell...
        let article = articles[indexPath.row]
        //cell.textLabel?.text = article.title
        cell.articleTitleLabel.text = article.title
        cell.articleAuthorLabel.text = article.author

        return cell
    }
    
    func showAlert(title: String, message: String?, style: UIAlertControllerStyle = .Alert)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        
        let dismissAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        
        alertController.addAction(dismissAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showNewsDetail"
        {
            if let indexPath = self.tableView.indexPathForSelectedRow
            {
                let controller = segue.destinationViewController as! NewsDetailController
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
