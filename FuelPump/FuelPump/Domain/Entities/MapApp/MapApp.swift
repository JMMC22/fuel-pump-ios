//
//  MapAppsManager.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 20/1/24.
//

import Foundation
import UIKit

public enum MapApp: CaseIterable {
    case appleMaps
    case googleMaps
    case waze

    public var appName: String {
        switch self {
        case .appleMaps:
            return "Apple Maps"
        case .googleMaps:
            return "Google Maps"
        case .waze:
            return "Waze"
        }
    }

    public var baseUrl: String {
        switch self {
        case .appleMaps:
            return "http://maps.apple.com"
        case .googleMaps:
            return "comgooglemaps://"
        case .waze:
            return "waze://"
        }
    }

    public static var availableApps: [MapApp] {
        return self.allCases.filter { $0.available }
    }
}

extension MapApp {
    public var url: URL? {
        return URL(string: self.baseUrl)
    }

    public var available: Bool {
        guard let url = self.url else {
            return false
        }
        return UIApplication.shared.canOpenURL(url)
    }
}

extension MapApp {
    func appUrl(location: Location) -> String {
        var urlString = self.baseUrl

        switch self {
        case .appleMaps:
            urlString.append("?q=\(location.latitude),\(location.longitude)=d&t=h")
        case .googleMaps:
            urlString.append("?saddr=&daddr=\(location.latitude),\(location.longitude)&directionsmode=driving")
        case .waze:
            urlString.append("?ll=\(location.latitude),\(location.longitude)&navigate=yes")
        }

        return urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? urlString
    }
}
