//
//  ViewController.swift
//  TheCatApp
//
//  Created by isha pathak on 29/06/22.
//

import UIKit

class MainViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet var catListTableView: UITableView!
    
    @IBOutlet var selectCategoryButton: [UIButton]!
    
    var cats = [Cat]() // cats: collection of data
    var pageNumber : Int = 0 // default page number
    var selectedCategory : Int = 4 // default selected category: sunglasses
    
    override func viewDidLoad() {
        super.viewDidLoad()
        catListTableView.tableFooterView = UIView(frame: .zero)
        getCatsList()
    }
   
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true

    }
    
    // MARK: getCatsList -> To fetch the data from server with given API
    func getCatsList(){
        let url = URL(string: "https://api.thecatapi.com/v1/images/search?limit=10&page=\(pageNumber)&category_ids=\(selectedCategory)")
        
        guard let downloadURL = url else {return}
        URLSession.shared.dataTask(with: downloadURL) { data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil else {
                print("Something went Wrong")
                return
            }
            do {
                // MARK: Decoder to parse the JSON response
                let decoder = JSONDecoder()
                let catLists = try decoder.decode([Cat].self, from: data)
                self.cats.append(contentsOf: catLists)
                self.pageNumber += 1
                DispatchQueue.main.async {
                    self.catListTableView.reloadData()
                }
            }catch {
                print("Something went wrong", error)
            }
            }.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatCell") as! CatListTableViewCell
        let theFileName = (cats[indexPath.row].url as NSURL).lastPathComponent
        cell.fileNameLabel?.text = theFileName
        cell.set(cat: cats[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath) as! CatListTableViewCell
        let mainController = self.storyboard?.instantiateViewController(withIdentifier: "DetailedCatImageVC") as?DetailViewController
        
        // Sending cat image and cat id from tableview to detailsview
        mainController?.catDetailedImage = currentCell.imageViewCell.image!
        mainController?.catName = cats[indexPath.row].id
        self.navigationController?.pushViewController(mainController!, animated: true)
        
    }
    // MARK: Fetch data on demand
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == cats.count - 1 {
            getCatsList()
        }
        
    }
    // MARK: Re-fetch cats data using selected category
    @IBAction func applyCategoryFilterAction(_ sender: UIButton) {
        if selectedCategory != sender.tag {
            cats = []
            selectedCategory = sender.tag
            getCatsList()
        }
    }
}

