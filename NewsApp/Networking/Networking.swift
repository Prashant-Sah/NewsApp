//
//  Networking.swift
//  NewsApp
//
//  Created by Prashant Sah on 11/11/20.
//

import Foundation
import Alamofire
import Combine

class Networking {

    func request(router: NetworkingRouter) -> AnyPublisher<NetworkingResult, Never> {
        return Future<NetworkingResult, Never> { [weak self] promise in
            AF.request(router).validate().responseJSON { [weak self] (response) in
                guard let self = self else { return }
                Logger.shared.log(response)
                return promise(.success(self.parser(response: response, router: router)))
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }

    func parser(response: AFDataResponse<Any>, router: NetworkingRouter) -> NetworkingResult {
        switch response.result {
        case .success:
            guard let data = response.data else {
                return NetworkingResult(success: false, error: .failedReason(NetworkingError.malformedDataReceived.description, response.response?.statusCode ?? 0), router: router)
            }
            return NetworkingResult(success: true, result: data, statusCode: response.response?.statusCode ?? 0, router: router)
        case .failure(let error):
            return NetworkingResult(success: false, error: .failedReason(error.localizedDescription, response.response?.statusCode ?? 0), router: router)
        }
    }

}
