//
//  ViewController.swift
//  ARWorldMapGame
//
//  Created by Berta Devant on 02/09/2018.
//  Copyright © 2018 Berta Devant. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import MultipeerConnectivity

class ViewController: UIViewController {

    @IBOutlet weak var sessionInfoView: UIView!
    @IBOutlet weak var sessionInfoLabel: UILabel!
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var sendMapButton: UIButton!
    @IBOutlet weak var mappingStatusLabel: UILabel!

    // MARK: - View Life Cycle
    var multipeerSession: MultipeerSession!
    //to remember who provided the map (device) and show it to the UI
    var mapProvider: MCPeerID?

    override func viewDidLoad() {
        super.viewDidLoad()

        multipeerSession = MultipeerSession(receivedDataHandler: receivedData)
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - Multiuser shared session

    /// - Tag: ReceiveData
    func receivedData(_ data: Data, from peer: MCPeerID) {
        //TODO process data

    }

    /// - Tag: PlaceCharacter
    @IBAction func handleSceneTap(_ sender: UITapGestureRecognizer) {

    }

    // MARK: - ARSession

    /// - Tag: CheckMappingStatus
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        //TODO update labels and button when map is provided
    }

    /// - Tag: GetWorldMap
    @IBAction func shareSession(_ button: UIButton) {

    }
}
