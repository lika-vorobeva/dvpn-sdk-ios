# Norse DVPN SDK

This SDK is compatible with iOS, iPadOS and macOS. Simply add it to your Xcode project using SPM (Swift Package Manager): 

```
https://github.com/norselabs/dvpn-sdk-ios
```

## Protections

Norse DVPN SDK is heavily protected against reverse-engineering and traffic analysis to prevent unwanted traffic inspection by unauthorized 3rd parties (e.g. ISP). Unfortunately, it also means that tools like Proxyman or Charles won't be able to intercept data as SDK refuses to communicate with anything in the middle, even if MITM ceritifcate is marked as *Trusted* in the system.

## How to use it?

### Initialize SDK

```swift
//Have to supply our Application Token and Application Secret (you'll get 'em from us)
let dvpn = try DecentralizedVPN(appToken: "yourtoken", appSecret: "yoursecret")
```
You have to specify your application token & application secret. SDK will automatically initialize, evaluate current network conditions and restrtictions. SDK finds a way to communicate with our backend automatically, even if default API endpoints are blocked by ISP. 

### Get current connection info

```swift
let info = try! dvpn.GetConnectionDetails()
```

This method will return `ConnectionDetails` object:

```swift 
public struct ConnectionDetails {
    public let IP: String
    public let countryCode: String
}
```

### Registering device

```swift
// You registering your user's device.
let device = try dvpn.RegisterDevice()
```
Registering device is mandatory to use DVPN service. This method will return `Device` object:

```swift
public struct Device {
    public let id: String
    public let platform: String
    public let token: String
    public let isActivated: Bool
    public let isBanned: Bool
    public let isEnrolled: Bool
    public let walletAddress: String
}
```
You'll need `token` for all further requests. Please note, that your device should have `isEnrolled=true`, `isBanned=false` & `isActivated=true` in order to make requests.

### Activating device

```swift
// You're activating it.
_ = try dvpn.ActivateDevice(accessToken: device.token, deviceId: device.id)
```
This method also returns an updated `Device` object, activating it for further use.

### Get list of countries

```swift
// You can filter result by VPN protocol (optional).
let countries = try dvpn.GetCountries(accessToken: device.token, vpnProtocol: .V2Ray)
```
Returns array of `Country` objects. Here's how `Country` object look like:
```swift
public struct Country {
    public let id: String
    public let name: String
    public let code: String
    public let serversAvailable: Int
}
```

### Get list of cities

```swift
// You'll need to specify ID of the country. You can also filter by VPN protocol (optional).
let cities = try dvpn.GetCities(accessToken: device.token, countryId: "ed3c261f-3a9f-40f3-9a27-75d5e88d31a5", vpnProtocol: .WireGuard)
```
Returns array of `City` objects. Here's how `City` object look like:
```swift
public struct City {
    public let id: String
    public let countryId: String
    public let name: String
    public let serversAvailable: Int
}
```

### Get list of servers

```swift
// You'll need to specify ID of the city.
let servers = try! dvpn.GetServers(accessToken: device.token, cityId: "07f51695-70ff-4863-83c3-6ae3df3b8ff0", offset: 0, limit: 100)
```
Returns array of `Server` objects. Here's how `Server` object look like:
```swift
public struct Server {
    public let id: String
    public let countryId: String
    public let cityId: String
    public let name: String
    public let address: String
    public let isAvailable: Bool
    public let load: Float
    public let version: String
    public let latitude: Float
    public let longitude: Float
    public let uploadSpeed: Int
    public let downloadSpeed: Int
    public let remoteURL: String
    public let vpnProtocol: VPNProtocol
}
```

### Get credentials

#### Best server in the city

```swift
// // You'll need to specify ID of the city. You can also specify VPN protocol (optional).
let credentials = try dvpn.CreateCredentialsForCity(accessToken: device.token, cityId: "07f51695-70ff-4863-83c3-6ae3df3b8ff0", vpnProtocol: .WireGuard)
```

#### Specific server

```swift
// // You'll need to specify ID of the server.
let credentials = try dvpn.CreateCredentialsForServer(accessToken: device.token, serverId: "668696b2-d289-43ec-9f80-ae39d7dcc124")
```

An example of result (`Credentials` structure):

```swift
public struct Credentials {
    public let serverId: String
    public let vpnProtocol: VPNProtocol
    public let payload: String?
    public let privateKey: String?
    public let uid: String?
}
```

## Additional features

### Re-evaluate network conditions

If user has moved to another network or requests are not going through any longer, you might wanna ask SDK to re-evaluate network conditions and find a new way to communicate with the API. You can do so by calling *Probing* method:

```swift
dvpn.Probe()
```

In the worst case scenario, it might take up to two minutes to complete probing, but usually it is much faster.
