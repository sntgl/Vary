//
//  RoundTypeDescription.swift
//  Vary
//
//  Created by user207433 on 12/11/21.
//

import Foundation
import UIKit

enum RoundType: Codable{
    case describe
    case show
    case oneWord
    case taskFromPlayers
    
    func getIcon() -> UIImage? {
      switch self {
      // Use Internationalization, as appropriate.
      case .describe: return UIImage(named: "ConversationIcon")
      case .show: return UIImage(named: "HandIcon")
      case .oneWord: return UIImage(named: "OneNumberIcon")
      case .taskFromPlayers: return UIImage()
      }
    }
    
    func getRoundDesciption() -> String {
        switch self {
        // Use Internationalization, as appropriate.
        case .describe: return "Объясни"
        case .show: return "Покажи"
        case .oneWord: return "Одно слово"
        case .taskFromPlayers: return "Задание от игроков"
        }
    }
    

    func getRoundSubDesciption() -> String {
        switch self {
        // Use Internationalization, as appropriate.
        case .describe: return "Объясни Словами"
        case .show: return "Покажи жестами"
        case .oneWord: return "Объясни одним словом"
        case .taskFromPlayers: return "Выполни задание от игроков"
        }
    }
}
