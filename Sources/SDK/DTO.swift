import Foundation

struct ConnectionDetailsDTO: Codable {
    let ip: String
    let country_code: String
    
    func decodeFromDTO() -> ConnectionDetails {
        return ConnectionDetails(
            IP: ip,
            countryCode: country_code
        )
    }
}

struct DeviceDTOWrapper: Codable {
    let data: DeviceDTO?
    let error: String?
}

struct DeviceDTO: Codable {
    let id: String
    let platform: String
    let token: String
    let is_activated: Bool
    let is_banned: Bool
    let is_enrolled: Bool
    let wallet_address: String
    
    func decodeFromDTO() -> Device {
        return Device(
            id: id,
            platform: platform,
            token: token,
            isActivated: is_activated,
            isBanned: is_banned,
            isEnrolled: is_enrolled,
            walletAddress: wallet_address
        )
    }
}

struct CountriesDTOWrapper: Codable {
    let data: [CountryDTO]?
    let error: String?
}

struct CountryDTOWrapper: Codable {
    let data: CountryDTO?
    let error: String?
}

struct CountryDTO: Codable {
    let id: String
    let name: String
    let code: String
    let servers_available: Int
    
    func decodeFromDTO() -> Country {
        return Country(
            id: id,
            name: name,
            code: code,
            serversAvailable: servers_available
        )
    }
}

struct CitiesDTOWrapper: Codable {
    let data: [CityDTO]?
    let error: String?
}

struct CityDTOWrapper: Codable {
    let data: CityDTO?
    let error: String?
}

struct CityDTO: Codable {
    let id: String
    let country_id: String
    let name: String
    let servers_available: Int
    
    func decodeFromDTO() -> City {
        return City(
            id: id,
            countryId: country_id,
            name: name,
            serversAvailable: servers_available
        )
    }
}

struct ServersDTOWrapper: Codable {
    let data: [ServerDTO]?
    let error: String?
}

struct ServerDTOWrapper: Codable {
    let data: ServerDTO?
    let error: String?
}

struct ServerDTO: Codable {
    let id: String
    let country_id: String
    let city_id: String
    let name: String
    let address: String
    let is_available: Bool
    let load: Float
    let version: String
    let latitude: Float
    let longitude: Float
    let upload_speed: Int
    let download_speed: Int
    let remote_url: String
    let `protocol`: String
    
    func decodeFromDTO() -> Server {
        return Server(
            id: id,
            countryId: country_id,
            cityId: city_id,
            name: name,
            address: address,
            isAvailable: is_available,
            load: load,
            version: version,
            latitude: latitude,
            longitude: longitude,
            uploadSpeed: upload_speed,
            downloadSpeed: download_speed,
            remoteURL: remote_url,
            vpnProtocol: VPNProtocol(rawValue: self.protocol) ?? .Unknown
        )
    }
}

struct CredentialsDTOWrapper: Codable {
    let data: CredentialsDTO?
    let error: String?
}

struct CredentialsDTO: Codable {
    let server_id: String
    let `protocol`: String
    let payload: String?
    let private_key: String?
    let uid: String?
    
    func decodeFromDTO() -> Credentials {
        return Credentials(
            serverId: server_id,
            vpnProtocol: VPNProtocol(rawValue: self.protocol) ?? .Unknown,
            payload: payload,
            privateKey: private_key,
            uid: uid
        )
    }
}
