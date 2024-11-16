//
//  ViewController.swift
//  Project22
//
//  Created by Eren Elçi on 16.11.2024.
//

import UIKit
import CoreLocation

class ViewController: UIViewController , CLLocationManagerDelegate {

    @IBOutlet var distanceReading: UILabel!
    var locationManeger: CLLocationManager?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        locationManeger = CLLocationManager()
        locationManeger?.delegate = self
        locationManeger?.requestAlwaysAuthorization()
        
        view.backgroundColor = .gray
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScannning()
                }
            }
        }
    }
    
    func startScannning() {
        let uuid = UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: 123, minor: 456, identifier: "Mybeacon")
        locationManeger?.startMonitoring(for: beaconRegion)
        locationManeger?.startRangingBeacons(in: beaconRegion)
        
    }
    
    
    func update(distance: CLProximity) {
        UIView.animate(withDuration: 1) {
            switch distance {
            case .far:
                self.view.backgroundColor = .blue
                self.distanceReading.text = "FAR"
            case .near:
                self.view.backgroundColor = .orange
                self.distanceReading.text = "NEAR"
            case .immediate :
                self.view.backgroundColor = .red
                self.distanceReading.text = "RIGHT HERE"
             default:
                self.view.backgroundColor = .gray
                self.distanceReading.text = "UNKNOW"
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        if let becaon = beacons.first {
            update(distance: becaon.proximity)

        } else {
            update(distance: .unknown)
        }
    }


}

