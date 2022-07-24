//
//  HomeViewModel.swift
//  Rx_NetflixCloneApp
//
//  Created by anies1212 on 2022/07/24.
//

import Foundation
import RxSwift
import RxCocoa
import RxOptional

struct Constants {
    static let apiKey = "5203469e2a48c64b29913d7a2ac0183c"
    static let baseURL = "https://api.themoviedb.org"
    static let imageBaseURL = "https://image.tmdb.org/t/p/w500"
    static let youtubeAPIKey = "AIzaSyBAUp6_8Vk-HNXtS1YwQNBojXb6h-AW_K8"
    static let youtubeSearchBaseAPIKey = "https://youtube.googleapis.com/youtube/v3/search?"
}

class HomeViewModel {
    private var disposeBag = DisposeBag()
    var titles = BehaviorRelay<[Title]>(value: [])
    
    func getTrendingMovies(){
        guard let url = URL(string: Constants.baseURL + "/3/trending/movie/day?api_key=" + Constants.apiKey) else { return }
        let urlRequest = URLRequest(url: url)
        URLSession.shared.rx.response(request: urlRequest)
            .subscribe(onNext: {[weak self] response, data in
                guard let titles = try? JSONDecoder().decode(TitleResponse.self, from: data) else { return }
                self?.titles.accept(titles.results)
            }, onError: { error in
                print(error.localizedDescription)
            })
            .disposed(by: disposeBag)
            
    }
}
