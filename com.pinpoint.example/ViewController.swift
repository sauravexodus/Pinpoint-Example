//
//  ViewController.swift
//  com.pinpoint.example
//
//  Created by Sourav Chandra on 03/04/18.
//  Copyright © 2018 DocTalk. All rights reserved.
//

import UIKit
import AWSPinpoint

class ViewController: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    
    @IBAction func updateAction(_ sender: Any) {
        updateEndpoint(with: "\(Date().timeIntervalSince1970)@example.com")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func updateEndpoint(with email: String) {
        if let endpointRequest = AWSPinpointTargetingEndpointRequest(), let user = AWSPinpointTargetingEndpointUser(), let updateRequest = AWSPinpointTargetingUpdateEndpointRequest() {
            endpointRequest.address = email
            endpointRequest.channelType = .email
            user.userId = "1234567890"
            endpointRequest.user = user
            let service = AWSPinpointTargeting()
            updateRequest.applicationId = AWSPinpointConfiguration.defaultPinpointConfiguration(launchOptions: nil).appId
            updateRequest.endpointRequest = endpointRequest
            updateRequest.endpointId = "\(Date().timeIntervalSince1970)"
            service.updateEndpoint(updateRequest).continueWith(block: { [weak self] (response) -> Any? in
                guard let strongSelf = self else { return nil }
                strongSelf.statusLabel.text = "Updating \(email) status \(response.isCompleted)"
                return nil
            })
        }
    }

}

