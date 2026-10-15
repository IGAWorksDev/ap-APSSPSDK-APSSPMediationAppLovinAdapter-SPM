//
//  AppLovinRewardVideoAdapter.swift
//  MediationAppLovin
//
//  Created by Odin.송황호 on 7/3/24.
//

import UIKit

import APSSPSDK


final public class AppLovinRewardVideoAdapter: APSSPRewardVideoAdapterProtocol {
    public weak var rootViewController: UIViewController?

    private var applovinMediationRewardVideoAd: AppLovinMediationRewardVideoAd?
    
    public weak var delegate: APSSPRewardVideoAdapterDelegate?
    
    deinit {
        APLogger.debug("AppLovinRewardVideoAdapter deinit")
        applovinMediationRewardVideoAd?.releaseSDKDelegates()
    }

    public init(placementDic: [String: String], rootViewController: UIViewController?, info: [String : Any?]) {
        let placementId = placementDic[APSSPPlacementKey.appLovinZoneId.rawValue] ?? ""
        applovinMediationRewardVideoAd = AppLovinMediationRewardVideoAd(placementId: placementId, rootViewController: rootViewController)
        self.applovinMediationRewardVideoAd?.delegate = self
    }
    
    public func connectDelegate(delegate: APSSPRewardVideoAdapterDelegate) {
        self.delegate = delegate
        self.applovinMediationRewardVideoAd?.load()
    }

    public func disconnectDelegate() {
        applovinMediationRewardVideoAd?.releaseSDKDelegates()
        applovinMediationRewardVideoAd?.delegate = nil
        delegate = nil
    }
    
    public func present(from: UIViewController, completion: @escaping() -> Void) {
        applovinMediationRewardVideoAd?.present(from: from) { completion() }
    }
    
}




extension AppLovinRewardVideoAdapter: APSSPRewardVideoAdapterDelegate {
    public func rewardVideoLoadSuccess() {
        delegate?.rewardVideoLoadSuccess()
    }
    
    public func rewardVideoLoadFail(error: APSSPNetworkError, errorMessage: String?) {
        delegate?.rewardVideoLoadFail(error: error, errorMessage: errorMessage)
    }
    
    public func rewardVideoShowSuccess(message: String) {
        delegate?.rewardVideoShowSuccess(message: message)
    }
    
    public func rewardVideoShowFail(message: String) {
        delegate?.rewardVideoShowFail(message: message)
    }
    
    public func rewardVideoClicked(message: String) {
        delegate?.rewardVideoClicked(message: message)
    }
    
    public func rewardVideoClosed(message: String) {
        delegate?.rewardVideoClosed(message: message)
    }
    
    public func rewardVideoCompleted() {
        delegate?.rewardVideoCompleted()
    }
}
