import Foundation
import BSWFoundation

/* SKIP @bridge */
public class LemonAPIClient: APIClient, @unchecked Sendable {
    
    /* SKIP @bridge */
    public static let shared = LemonAPIClient()

    /* SKIP @bridge */
    public func sendAppLaunch(platformUserID: String, projectName: String, osVersion: String, appVersion: String) async throws {
        let request = Request<VoidResponse>(
            endpoint: Requests.sendAppLaunch(
                platformUserID: platformUserID,
                projectName: projectName,
                osVersion: osVersion,
                appVersion: appVersion
            )
        )
        _ = try await perform(request)
    }
    
    #if canImport(Darwin)
    public func sendAppLaunch(deviceUUID: UUID) async throws {
        let osVersion = ProcessInfo.processInfo.operatingSystemVersion
        let request = Request<VoidResponse>(
            endpoint: Requests.sendAppLaunch(
                platformUserID: deviceUUID.uuidString,
                projectName: Bundle.main.bundleIdentifier ?? "com.mediquo.main",
                osVersion: "\(osVersion.majorVersion).\(osVersion.minorVersion).\(osVersion.patchVersion)",
                appVersion: Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
            )
        )
        _ = try await perform(request)
    }
    #endif
    
    //MARK: Private

    private init() {
        super.init(environment: Environment.production)
        loggingConfiguration = .init(requestBehaviour: .all, responseBehaviour: .all)
    }

    private enum Environment: BSWFoundation.Environment {

        case production

        var baseURL: URL {
            switch self {
            case .production:
                return URL(string: "https://lemon-backend.fly.dev/")!
            }
        }
    }

    private enum Requests: Endpoint {
        case sendAppLaunch(platformUserID: String, projectName: String, osVersion: String, appVersion: String)

        var method: HTTPMethod {
            switch self {
            case .sendAppLaunch:
                return .POST
            }
        }

        var path: String {
            switch self {
            case .sendAppLaunch:
                return "events"
            }
        }

        var parameters: [String : Any]? {
            switch self {
            case .sendAppLaunch(let platformUserID, let projectName, let osVersion, let appVersion):
                let osName: String = {
                    #if os(iOS)
                    return "ios"
                    #elseif os(macOS)
                    return "mac"
                    #elseif os(Android)
                    return "android"
                    #else
                    return "unknown"
                    #endif
                }()
                return [
                    "event_kind": "app_launch",
                    "platform_user_id": platformUserID,
                    "platform": osName,
                    "project_name": projectName,
                    "os_version": osVersion,
                    "app_version": appVersion
                ]
            }
        }

        var parameterEncoding: HTTPParameterEncoding {
            .json
        }
    }
}
