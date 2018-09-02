# ARWorldMap Game

Workshop to learn how to develop AR apps while using ARWorldMap from ARKit2. 

You will need: 

- Xcode 10 
- Device with IOS 12 

The workshop can be done without sharing the map with other users, just playing the simple game on AR too. 

[Slides for the workshop](https://docs.google.com/presentation/d/1ruVNwLWbEsMXsBcWwMjfdE4sRSYYOohwrMeanObjiuk/edit?usp=sharing)
[Multi User Experience on AR](https://developer.apple.com/documentation/arkit/creating_a_multiuser_ar_experience) by Apple

## ARKit basics 

### [ARSession]() | [ARConfiguration ](https://developer.apple.com/documentation/arkit/arworldtrackingconfiguration)

At the bgeinning you set up a configuration and run on the AR Session, this configuration will determine that type of tracking we will be performing (planes, images, faces, objects etc). You need to mantain the session and pause it when the user exists since it uses a lot of memory and phone power. 

In our workshop we will be using `ARWorldTrackingConfiguration` 

For this workshop the maintaining of the session and tracking and showing the user when a problem arises has been already coded for you as an extra. You can check out the code on [ViewController+ARSession](). 

Check out my post on [Getting started with ARKit](https://blog.novoda.com/getting-started-with-arkit/) for more information

## ARWorldMap

An ARWorldMap object contains a snapshot of all the spatial mapping information that ARKit uses to locate the user’s device in real-world space. Reliably sharing a map to another device requires two key steps: finding a good time to capture a map, and capturing and sending it.

ARKit provides a `worldMappingStatus` value that indicates whether it’s currently a good time to capture a world map. 

To be able to share world map we will be using [MultiPeer Connectivity](https://developer.apple.com/documentation/multipeerconnectivity) I am no expert on it so I have been following Apple guide to how to use it. This is the logic we will be following: 

-  Main view controller creates a MultipeerSession instance (at app launch)
- An [MCNearbyServiceAdvertiser](https://developer.apple.com/documentation/multipeerconnectivity/mcnearbyserviceadvertiser) starts running to broadcast the device’s ability to join multipeer sessions
- An [MCNearbyServiceBrowser](https://developer.apple.com/documentation/multipeerconnectivity/mcnearbyservicebrowser) also starts running to find other devices
- When the [MCNearbyServiceBrowser](https://developer.apple.com/documentation/multipeerconnectivity/mcnearbyservicebrowser) finds another device, it calls the `browser(_:foundPeer:withDiscoveryInfo:)` delegate. We then call `invitePeer(_:to:withContext:timeout:) ` to invite the other device to join. 
- When other device recieves an invitation , [MCNearbyServiceAdvertiser](https://developer.apple.com/documentation/multipeerconnectivity/mcnearbyserviceadvertiser) calls the `advertiser(_:didReceiveInvitationFromPeer:withContext:invitationHandler:)` the we handle the invitation to join. 

All this is already coded for you with comments, you can find it in this file [MultipeerSession]() and you can also coded it yourself if you want to. 

We will be recieving the data and then processing that data, since it can be either a WorldMap or ARAnchor to add to the session. 

`let worldMap = try NSKeyedUnarchiver.unarchivedObject(ofClass: ARWorldMap.self, from: data)`
`let anchor = try NSKeyedUnarchiver.unarchivedObject(ofClass: ARAnchor.self, from: data)`

To send data is very similar, after you have place a new model for the user you create the data object. 

`let data = try? NSKeyedArchiver.archivedData(withRootObject: anchor, requiringSecureCoding: true)` 

And send that to all peers who would recieve it as a `ARAnchor` . You can also get the most recent world map and send that to the peers: 

`getCurrentWorldMap(completionHandler:)` 

`let data = try? NSKeyedArchiver.archivedData(withRootObject: map, requiringSecureCoding: true)`

> Important This app automatically joins the first nearby session it finds. Depending on the kind of shared AR experience you want to create, you may want to more precisely control broadcasting, invitation, and acceptance behavior. See the MultipeerConnectivity documentation for details.

In our session everyone is an equal peer. We all share and recieve map data. But we could define roles, have someone be the host and the rest be guests. 

- Host: Uses MCNearbyServiceAdvertiser to broadcast availability 
- Guest: Uses MCNearbyServiceBrowser to find a host to join

## 3D models 

The project contains some 3D models but you can build your app with any 3D non complex object. I will explain a little on how to handle models and make sure they work for you. 

- [TurboSquid](https://www.turbosquid.com/Search/3D-Models/dae) you can download `.dae` which are easy for xcode to process
- [Google Poly](https://poly.google.com/category/objects) Big library, very complex objects that are downloadable in `.obj` format. It can be transformed into `.scn` format but most of the objects do not come with childNodes. Making it difficult to animate and transform. 

## Game Logic 
The game is simple, each one of you have a 3D model with a specific color. 

## Want more? 

There are a lot of resources out there for ARKit and AR in general, this are some of my favorites code to look at when I get stuck: 

- [ARStarters](https://github.com/codePrincess/ARStarter) by CodePrincess
- [ARKit by tutorials](https://store.raywenderlich.com/products/arkit-by-tutorials) by RayWanderlich
- [SlingShot creating a game for AR](https://developer.apple.com/documentation/arkit/swiftshot_creating_a_game_for_augmented_reality)

## Disclaimer

Some of this code is mine, but a lot of the helper methos are from Apple code examples. 
