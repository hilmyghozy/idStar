//
//  TaskPresenter.swift
//  Hilmyghozy
//
//  Created by hilmy ghozy on 28/03/22.
//

import Foundation

protocol TaskInterface {
    func doGetAllItem()
    func doGetUncompletedItem()
    func doGetCompletedItem()
}

protocol TaskDelegate: AnyObject {
    func didSuccessGetItems()
    func didSuccessGetItemsCompleted()
    func didSuccessGetItemsUncompleted()
    func didFailedGetItems(errorMessage: String)
}

class TaskPresenter: TaskInterface {
    weak var delegate: TaskDelegate?
    private let networkManager: NetworkManager
    
    var responseItems: [TaskAll]? = nil
    var responseItemsCompleted: [TaskAll]? = nil
    var responseItemsUncompleted: [TaskAll]? = nil
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func doGetAllItem() {
        networkManager.requestTaskAll(completion: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
                strongSelf.responseItems = response
                strongSelf.delegate?.didSuccessGetItems()
            case .failure(let error):
                self?.delegate?.didFailedGetItems(errorMessage: error.localizedDescription)
            }
        })
    }
    
    func doGetUncompletedItem() {
        networkManager.requestTaskUncompleted(completion: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
                strongSelf.responseItemsUncompleted = response
                strongSelf.delegate?.didSuccessGetItemsUncompleted()
            case .failure(let error):
                self?.delegate?.didFailedGetItems(errorMessage: error.localizedDescription)
            }
        })
    }
    
    func doGetCompletedItem() {
        networkManager.requestTaskCompleted(completion: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
                strongSelf.responseItemsCompleted = response
                strongSelf.delegate?.didSuccessGetItemsCompleted()
            case .failure(let error):
                self?.delegate?.didFailedGetItems(errorMessage: error.localizedDescription)
            }
        })
    }
}

