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
            case .describe: return UIImage(named: VaryVars.ResNames.ConversationIcon)
            case .show: return UIImage(named: VaryVars.ResNames.HandIcon)
            case .oneWord: return UIImage(named: VaryVars.ResNames.OneNumberIcon)
            case .taskFromPlayers: return UIImage()
      }
    }
    
    func getRoundDesciption() -> String {
        switch self {
            case .describe: return VaryVars.Strings.Describe
            case .show: return VaryVars.Strings.Show
            case .oneWord: return VaryVars.Strings.OneWord
            case .taskFromPlayers: return VaryVars.Strings.TaskFromPlayers
        }
    }
    

    func getRoundSubDesciption() -> String {
        switch self {
            case .describe: return VaryVars.Strings.DescribeByWords
            case .show: return VaryVars.Strings.ShowWithGestures
            case .oneWord: return VaryVars.Strings.DescribeByOneWord
            case .taskFromPlayers: return VaryVars.Strings.DoTaskFromPlayers
        }
    }
}
