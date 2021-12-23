//
//  VaryVars.swift
//  Vary
//
//  Created by user207433 on 12/15/21.
//

import Foundation
import UIKit

class VaryVars{

    public enum Strings{
      static let newGame = "Новая игра"
      static let continueGame = "Продолжить игру"
      static let Vary =  "Vary"
      static let Updated = "Updated"
      static let UpdatedToVersion  = "Updated to version "
      static let Teams = "Команды"
      static let Next = "Далее"
      static let Back = "< Назад"
      static let Add = "Добавить"
      static let TeamName = "Название команды"
      static let Save = "Сохранить"
      static let Name = "Название"
      static let Cancel = "Отмена"
      static let Team = "Команда"
      static let None = "Нет"
      static let LosePoints = "Потеря баллов"
      static let TaskFromPlayers = "Задание от игроков"
      static let DeckNumber = "Количество карт"
        static let Unit = "штук"
      static let TimeRound = "Время раунда"
        static let Sec = "сек"
        static let GameSettings = "Настройки игры"
        static let PenaltyForSkip = "Штраф за пропуск"
        static let CommonLastWord = "Общее последнее слово"
        static let BeginningTeam = "Начинающая команда"
        static let ChooseDeck = "Выбрать колоду"
        static let DefaultPullDownText = "Вместо выпадающего списка"
        static let Random = "Случайная"
              static let Guessed = "Отгадано"
              static let Skipped = "Пропущено"
        static let Ready = "Готово"
        static let TouchWordToChangeResult = "Нажмите на слово, чтобы изменить его результат"
              static let ReChecking = "Перепроверка"
        static let PointsEarned = "Набранные баллы"
              static let Winners = "Победители!"
        static let NextRound  = "Следующий раунд"
        static let AppSettings = "Настройки приложения"
        
              static let AppSounds = "Звуки в игре"
              static let CheckUpdates = "Проверять обновления"
              static let Describe = "Объясни"
              static let Show = "Покажи"
              static let OneWord = "Одно слово"
              static let DescribeByWords = "Объясни Словами"
              static let ShowWithGestures = "Покажи жестами"
              static let DescribeByOneWord = "Объясни одним словом"
              static let DoTaskFromPlayers = "Выполни задание от игроков"
              static let TouchWordWhenWillBeReady = "Нажми на экран, когда будешь готов"
        //      static let
        //      static let
        //      static let
        //      static let
        //      static let
        
        
        
        
    }
    
    public enum ResNames{
        static let primaryColor = "Primary"
        static let surfaceColor = "Surface"
        static let secondaryColor = "Secondary"
        static let additionalColor = "Additional"
        static let textColor = "TextBright"
        static let HelpImg = "HelpImg"
        static let SettingsImg = "SettingsImg"
              static let MusicOnIcon = "MusicOnIcon"
              static let MusicOffIcon = "MusicOffIcon"
              static let SystemUpdateIcon = "SystemUpdateIcon"
              static let SystemUpdateOffIcon = "MobileOffIcon"
              static let ConversationIcon = "ConversationIcon"
              static let HandIcon = "HandIcon"
              static let OneNumberIcon = "OneNumberIcon"
    }
    
    
    public enum Colors{
        static let primaryColor = UIColor(named: VaryVars.ResNames.primaryColor)!
        static let surfaceColor = UIColor(named: VaryVars.ResNames.surfaceColor)!
        static let secondaryColor = UIColor(named: VaryVars.ResNames.secondaryColor)!
        static let additionalColor = UIColor(named: VaryVars.ResNames.additionalColor)!
        static let textColor = UIColor(named: VaryVars.ResNames.textColor)!
    }
    
    
    public enum Keys{
        static let appVersionKey = "appVersionKey"
        static let storageQueueLabel = "StorageQueue"
        static let defaultFileName = "dictionary.json"
        static let gameSettingsOptionsKey = "gameSettingsOptions"
        static let gameInfo = "gameInfo"
    }
    
    public enum ServerRequests{
        
        static func requestGetVersion(ip:String) -> String{
            return "http://\(ip)/categories/version"
        }
        
        static func requestGetCardsByVersion(ip:String, version:String) -> String{
            return "http://\(ip)/categories?version=\(version)"
        }
    }
    
    public static let iconsSize = CGFloat(60)
    public static let scoreForWord: Int = 10
    public static var juniorDebug: Bool = true
    public static let DefaultTeamChoice = ["Случайная", "Команда 1", "Команда 2"]
    public static let DefaultDeckChoice = ["Средние", "Маленькие", "Большие"]
         
    //      static let
    //      static let
    //      static let
    //      static let
    //      static let
    //      static let
    //      static let
    //      static let
    //      static let
    
}

