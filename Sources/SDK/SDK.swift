import DVPNSDK

public class DecentralizedVPN {
    private let nativeSDK: NorsedvpnsdkDVPNSDK
    
    public init(appToken: String, appSecret: String, configurationKey: String = "") throws {
        guard let nativeSDK = NorsedvpnsdkDVPNSDK(appToken, appSecret: appSecret, configurationKey: configurationKey) else {
            throw SDKError(description: "Unable to initialize SDK")
        }
        
        self.nativeSDK = nativeSDK
    }
    
    public func Probe() {
        self.nativeSDK.probe()
    }
    
    public func GetConnectionDetails() throws -> ConnectionDetails {
        let bytes = try self.nativeSDK.getConnectionDetails()
        
        let decoder = JSONDecoder()
        let dto = try decoder.decode(ConnectionDetailsDTO.self, from: bytes)
        
        return dto.decodeFromDTO()
    }
    
    public func RegisterDevice() throws -> Device {
        var platform = "OTHER"
        
        #if os(iOS)
        platform = "IOS"
        #elseif os(macOS)
        platform = "MACOS"
        #elseif os(tvOS)
        platform = "TVOS"
        #endif
        
        let bytes = try self.nativeSDK.registerDevice(platform)
        
        let decoder = JSONDecoder()
        let dto = try decoder.decode(DeviceDTOWrapper.self, from: bytes)
        
        if let error = dto.error {
            throw APIError(code: error)
        }
        
        guard let data = dto.data else {
            throw SDKError(description: "Unable to decode `data` for `RegisterDevice` response")
        }
        
        return data.decodeFromDTO()
    }
    
    public func ActivateDevice(accessToken: String, deviceId: String) throws -> Device {
        let bytes = try self.nativeSDK.activateDevice(accessToken, deviceId: deviceId)
        
        let decoder = JSONDecoder()
        let dto = try decoder.decode(DeviceDTOWrapper.self, from: bytes)
        
        if let error = dto.error {
            throw APIError(code: error)
        }
        
        guard let data = dto.data else {
            throw SDKError(description: "Unable to decode `data` for `ActivateDevice` response")
        }
        
        return data.decodeFromDTO()
    }
    
    public func GetCountries(accessToken: String, vpnProtocol: VPNProtocol? = nil) throws -> [Country] {
        let bytes = try self.nativeSDK.getCountries(accessToken, protocol: vpnProtocol?.rawValue)
        
        let decoder = JSONDecoder()
        let dto = try decoder.decode(CountriesDTOWrapper.self, from: bytes)
        
        if let error = dto.error {
            throw APIError(code: error)
        }
        
        guard let data = dto.data else {
            throw SDKError(description: "Unable to decode `data` for `GetCountries` response")
        }
        
        return data.map { $0.decodeFromDTO() }
    }
    
    public func GetCountry(accessToken: String, countryId: String) throws -> Country {
        let bytes = try self.nativeSDK.getCountry(accessToken, countryId: countryId)
        
        let decoder = JSONDecoder()
        let dto = try decoder.decode(CountryDTOWrapper.self, from: bytes)
        
        if let error = dto.error {
            throw APIError(code: error)
        }
        
        guard let data = dto.data else {
            throw SDKError(description: "Unable to decode `data` for `GetCountry` response")
        }
        
        return data.decodeFromDTO()
    }
    
    public func GetCities(accessToken: String, countryId: String, vpnProtocol: VPNProtocol? = nil) throws -> [City] {
        let bytes = try self.nativeSDK.getCities(accessToken, countryId: countryId, protocol: vpnProtocol?.rawValue)
        
        let decoder = JSONDecoder()
        let dto = try decoder.decode(CitiesDTOWrapper.self, from: bytes)
        
        if let error = dto.error {
            throw APIError(code: error)
        }
        
        guard let data = dto.data else {
            throw SDKError(description: "Unable to decode `data` for `GetCities` response")
        }
        
        return data.map { $0.decodeFromDTO() }
    }
    
    public func GetCity(accessToken: String, cityId: String) throws -> City {
        let bytes = try self.nativeSDK.getCity(accessToken, cityId: cityId)
        
        let decoder = JSONDecoder()
        let dto = try decoder.decode(CityDTOWrapper.self, from: bytes)
        
        if let error = dto.error {
            throw APIError(code: error)
        }
        
        guard let data = dto.data else {
            throw SDKError(description: "Unable to decode `data` for `GetCity` response")
        }
        
        return data.decodeFromDTO()
    }
    
    public func GetServers(accessToken: String, cityId: String, sort: ServerSorting? = nil, vpnProtocol: VPNProtocol? = nil, offset: Int, limit: Int) throws -> [Server] {
        let bytes = try self.nativeSDK.getServers(accessToken, cityId: cityId, sort: sort?.rawValue, protocol: vpnProtocol?.rawValue, offset: offset, limit: limit)
        
        let decoder = JSONDecoder()
        let dto = try decoder.decode(ServersDTOWrapper.self, from: bytes)
        
        if let error = dto.error {
            throw APIError(code: error)
        }
        
        guard let data = dto.data else {
            throw SDKError(description: "Unable to decode `data` for `GetServers` response")
        }
        
        return data.map { $0.decodeFromDTO() }
    }
    
    public func GetServer(accessToken: String, serverId: String) throws -> Server {
        let bytes = try self.nativeSDK.getServer(accessToken, serverId: serverId)
        
        let decoder = JSONDecoder()
        let dto = try decoder.decode(ServerDTOWrapper.self, from: bytes)
        
        if let error = dto.error {
            throw APIError(code: error)
        }
        
        guard let data = dto.data else {
            throw SDKError(description: "Unable to decode `data` for `GetServer` response")
        }
        
        return data.decodeFromDTO()
    }
    
    public func CreateCredentialsForCity(accessToken: String, cityId: String, vpnProtocol: VPNProtocol? = nil) throws -> Credentials {
        let bytes = try self.nativeSDK.createCredentials(forCity: accessToken, cityId: cityId, protocol: vpnProtocol?.rawValue)
        
        let decoder = JSONDecoder()
        let dto = try decoder.decode(CredentialsDTOWrapper.self, from: bytes)
        
        if let error = dto.error {
            throw APIError(code: error)
        }
        
        guard let data = dto.data else {
            throw SDKError(description: "Unable to decode `data` for `CreateCredentialsForCity` response")
        }
        
        return data.decodeFromDTO()
    }
    
    public func CreateCredentialsForServer(accessToken: String, serverId: String, vpnProtocol: VPNProtocol? = nil) throws -> Credentials {
        let bytes = try self.nativeSDK.createCredentials(forServer: accessToken, serverId: serverId)
        
        let decoder = JSONDecoder()
        let dto = try decoder.decode(CredentialsDTOWrapper.self, from: bytes)
        
        if let error = dto.error {
            throw APIError(code: error)
        }
        
        guard let data = dto.data else {
            throw SDKError(description: "Unable to decode `data` for `CreateCredentialsForServer` response")
        }
        
        return data.decodeFromDTO()
    }
}
