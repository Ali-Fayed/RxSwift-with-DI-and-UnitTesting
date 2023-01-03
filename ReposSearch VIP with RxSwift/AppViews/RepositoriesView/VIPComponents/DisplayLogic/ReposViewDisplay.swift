//
//  ReposViewDisplay.swift
//  RxSwift with DI and UnitTesting
//
//  Created by Ali Fayed on 27/12/2022.
//
import UIKit
class ReposViewDisplay: UIViewController, ReposDisplayLogic {
    // MARK: - Properties
    var dataSource = ReposDataSource()
    // MARK: - Types
    typealias viewModel = ReposVCModel.ReposViewModel
    typealias error = ReposVCModel.ReposAPIError
    // MARK: - Protocol Implementation
    func displayVCwithData(viewModel: viewModel) {
        /// check for searching state to append or replace value when search or not
        if dataSource.isSearching.value {
            /// replace the current subject values with new that come from search
            dataSource.reposData = viewModel.repos
            dataSource.reposSubject.onNext(dataSource.reposData)
        } else {
            /// append to the current subject values with new data
            dataSource.reposData.append(contentsOf: viewModel.repos)
            dataSource.reposSubject.onNext(dataSource.reposData)
        }
    }
    func displayVCwithError(error: error) {
        /// send error model to the UI
        dataSource.errorBehaviour.accept(error.error)
    }
}