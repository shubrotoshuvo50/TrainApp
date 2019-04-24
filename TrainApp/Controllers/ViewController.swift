//
//  ViewController.swift
//  TrainApp
//
//  Created by IMCS2 on 4/24/19.
//  Copyright © 2019 Shubroto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let cellIdentifier: String = "stationNameCell"
    var stationList: [StationModel] = [] // List of all the station
    
    let stationViewModel: StationViewModel = StationViewModel()

    @IBOutlet weak var stationTableView: UITableView!
    @IBOutlet weak var searchStationTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callServerData(stationName: "")
        self.searchStationTextField.delegate = self
    }
    
    // Get data from the server
    private func callServerData(stationName: String) {
        stationViewModel.getStationList(stationName: stationName) { (stationArray) in
            self.stationList = stationArray
            self.stationTableView.reloadData()
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.detailTextLabel?.text = stationList[indexPath.row].StationCode ?? "Not Found"
        cell.textLabel?.text = stationList[indexPath.row].StationDesc
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let station = stationList[indexPath.row] // Station Model Object
        let storyboard = UIStoryboard(name: "StationTrainStoryboard", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "StationTrainStoryboardId") as! StationTrainsViewController
        controller.title = station.StationDesc // Set title for the screen
        controller.stationObj = station
        self.navigationController?.show(controller, sender: nil)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        callServerData(stationName: textField.text ?? "" ) // Get Data from server and update UI
        return true
    }
}
