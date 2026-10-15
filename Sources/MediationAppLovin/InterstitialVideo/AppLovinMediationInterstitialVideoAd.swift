//
//  AppLovinMediationInterstitialVideoAd.swift
//  MediationAppLovin
//
//  Created by Odin.송황호 on 7/3/24.
//

import UIKit

import APSSPSDK
import AppLovinSDK


final class AppLovinMediationInterstitialVideoAd: NSObject {
    
    weak var delegate: APSSPInterstitialVideoAdapterDelegate?
    
    private let placementId: String
    
    private var interstitialVideoAd: ALAd?
    
    deinit {
        APLogger.debug("AppLovinMediationInterstitialVideoAd deinit")
    }

    init(placementId: String) {
        self.placementId = placementId
    }
    
    func present(from: UIViewController, completion: @escaping () -> Void) {
        guard let interstitialVideoAd else { return }
        ALInterstitialAd.shared().adDisplayDelegate = self
        ALInterstitialAd.shared().adVideoPlaybackDelegate = self

        ALInterstitialAd.shared().show(interstitialVideoAd)
    }
    
    /// ALInterstitialAd 싱글톤이 delegate 를 strong 으로 잡으므로, 아직 자신이 등록돼 있을 때만 끊는다.
    func releaseSDKDelegates() {
        let shared = ALInterstitialAd.shared()
        if shared.adDisplayDelegate as AnyObject? === self { shared.adDisplayDelegate = nil }
        if shared.adVideoPlaybackDelegate as AnyObject? === self { shared.adVideoPlaybackDelegate = nil }
    }

    func load() {
        ALSdk.shared().adService.loadNextAd(forZoneIdentifier: placementId, andNotify: self)
    }

}


extension AppLovinMediationInterstitialVideoAd: ALAdLoadDelegate, ALAdDisplayDelegate, ALAdVideoPlaybackDelegate {
    
    func adService(_ adService: ALAdService, didLoad ad: ALAd) {
        interstitialVideoAd = ad
        delegate?.interstitialVideoLoadSuccess()
    }
    
    func adService(_ adService: ALAdService, didFailToLoadAdWithError code: Int32) {
        APLogger.error("AppLovin InterstitialVideo Error: \(APAppLovinError.init(rawValue: code) ?? .error)")
        delegate?.interstitialVideoLoadFail(error: .nextMediation, errorMessage: "AppLovin load failed with code: \(code)")
    }
    
    func ad(_ ad: ALAd, wasDisplayedIn view: UIView) {
        delegate?.interstitialVideoShowSuccess(message: "AppLovin InterstitialVideo showSuccess")
    }
    
    func ad(_ ad: ALAd, wasClickedIn view: UIView) {
        delegate?.interstitialVideoClicked(message: "AppLovin InterstitialVideo Click")
    }
    
    func ad(_ ad: ALAd, wasHiddenIn view: UIView) {
        delegate?.interstitialVideoClosed(message: "AppLovin InterstitialVideo Closed")
        releaseSDKDelegates()
    }

    func videoPlaybackBegan(in ad: ALAd) { }
    
    func videoPlaybackEnded(in ad: ALAd, atPlaybackPercent percentPlayed: NSNumber, fullyWatched wasFullyWatched: Bool) { }
}
