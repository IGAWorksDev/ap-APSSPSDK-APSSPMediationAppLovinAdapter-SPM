//
//  AppLovinMediationInterstitialAd.swift
//  MediationAppLovin
//
//  Created by Odin.송황호 on 7/3/24.
//

import UIKit

import APSSPSDK
import AppLovinSDK

final class AppLovinMediationInterstitialAd: NSObject {
    
    weak var delegate: APSSPInterstitialAdapterDelegate?
    
    private let placementId: String
    
    private var interstitialAd: ALAd?
    
    deinit {
        APLogger.debug("AppLovinMediationInterstitialAd deinit")
    }

    init(placementId: String) {
        self.placementId = placementId
    }
    
    public func present(from: UIViewController, completion: () -> Void) {
        guard let interstitialAd else  {
            delegate?.interstitialShowFail(message: "")
            return
        }
        ALInterstitialAd.shared().adDisplayDelegate = self
        ALInterstitialAd.shared().adVideoPlaybackDelegate = self
        ALInterstitialAd.shared().show(interstitialAd)
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


extension AppLovinMediationInterstitialAd: ALAdLoadDelegate, ALAdDisplayDelegate, ALAdVideoPlaybackDelegate {
    func adService(_ adService: ALAdService, didLoad ad: ALAd) {
        interstitialAd = ad
        delegate?.interstitialLoadSuccess()
    }
    
    func adService(_ adService: ALAdService, didFailToLoadAdWithError code: Int32) {
        APLogger.error("AppLovin Interstitial Error: \(APAppLovinError.init(rawValue: code) ?? .error)")
        delegate?.interstitialLoadFail(error: .nextMediation, errorMessage: "AppLovin load failed with code: \(code)")
    }
    
    func ad(_ ad: ALAd, wasDisplayedIn view: UIView) {
        delegate?.interstitialShowSuccess(message: "AppLovin Interstitial showSuccess")
    }
    
    func ad(_ ad: ALAd, wasClickedIn view: UIView) {
        delegate?.interstitialClicked(message: "AppLovin Interstitial Click")
    }
    
    func ad(_ ad: ALAd, wasHiddenIn view: UIView) {
        delegate?.interstitialClosed(message: "AppLovin Interstitial Closed")
        releaseSDKDelegates()
    }

    func videoPlaybackBegan(in ad: ALAd) { }
    
    func videoPlaybackEnded(in ad: ALAd, atPlaybackPercent percentPlayed: NSNumber, fullyWatched wasFullyWatched: Bool) { }
}
