import Foundation

public struct SDKError: Error {
    public var description: String
    
    init(description: String) {
        self.description = description
    }
}

public struct APIError: Error {
    public var code: String

    init(code: String) {
        self.code = code
    }
}

public enum ServerSorting: String {
    case CurrentLoad = "CURRENT_LOAD"
}

public struct ConnectionDetails {
    public let IP: String
    public let countryCode: String
}

public struct Device {
    public let id: String
    public let platform: String
    public let token: String
    public let isActivated: Bool
    public let isBanned: Bool
    public let isEnrolled: Bool
    public let walletAddress: String
}

public struct Country {
    public let id: String
    public let name: String
    public let code: String
    public let serversAvailable: Int
}

public struct City {
    public let id: String
    public let countryId: String
    public let name: String
    public let serversAvailable: Int
}

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

public enum VPNProtocol: String {
    case WireGuard = "WIREGUARD"
    case V2Ray = "V2RAY"
    case Unknown = "UNKNOWN"
}

public struct Credentials {
    public let serverId: String
    public let vpnProtocol: VPNProtocol
    public let payload: String?
    public let privateKey: String?
    public let uid: String?
}
