//
//  StationTrainsViewController.swift
//  TrainApp
//
//  Created by IMCS2 on 4/24/19.
//  Copyright © 2019 Shubroto. All rights reserved.
//

import UIKit

class StationTrainsViewController: UIViewController {
    
    var stationObj: StationModel?
    
    var stationTrainList: [StationTrainInfoModel] = []
    let stationViewModel: StationViewModel = StationViewModel()

    @IBOutlet weak var stationTrainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stationViewModel.getTrainListFromStationBy(code: stationObj?.StationCode) { (listOfStationTrain) in
            self.stationTrainList = listOfStationTrain
            self.stationTrainTableView.reloadData()
        }
    }

}

extension StationTrainsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stationTrainList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StationTrainCellId", for: indexPath)
        cell.textLabel?.text = "DEST: \(stationTrainList[indexPath.row].Destination ?? "Unknown ")"
        cell.detailTextLabel?.text = "Arrive in: \(stationTrainList[indexPath.row].Duein ?? "Unknown") minutes"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stationTrainListInfo = stationTrainList[indexPath.row]
        let storyboard = UIStoryboard(name: "TrainDetailStoryboard", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "TrainDetailStoryboardId") as! TrainDetailViewController
        controller.stationTrainInfo = stationTrainListInfo // Set the object
        controller.title = stationTrainListInfo.Destination ?? "Unknown"
        self.navigationController?.show(controller, sender: nil)
    }
}
