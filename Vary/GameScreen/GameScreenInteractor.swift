//
//  GameScreenInteractor.swift
//  Vary
//
//  Created by Даниил Волков on 10.12.2021.
//  
//

import Foundation

final class GameScreenInteractor {
	weak var output: GameScreenInteractorOutput?
}

extension GameScreenInteractor: GameScreenInteractorInput {
}
