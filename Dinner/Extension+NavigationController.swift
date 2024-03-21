//
//  Extension+NavigationController.swift
//  Dinner
//
//  Created by 주환 on 3/21/24.
//

import Foundation
import UIKit

extension UINavigationController {
    
    
    /// 기존에 해당하는 뷰컨이 있다면 그걸로 팝, 아니라면 넣은것 푸시
    /// - Parameters:
    ///   - newViewController: 새로 넣는 뷰컨
    ///   - animated: 애니메이션 여부
    ///   - completion: 화면이동 완료 이벤트
    func pushOrPopToViewController<Destination: UIViewController>(
        newViewController: Destination,
        animated: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        
        // 기존에 해당하는 타입의 뷰컨이 있는지 없는지 여부
        guard let destinationVC : Destination = self.viewControllers.first(where: { vcItem in
            return vcItem.isKind(of: Destination.self)
        }) as? Destination else {
            
            // 기존에 해당 뷰컨타입이 없었다면 지금 넣은 뷰컨으로 푸시
            self.pushViewController(newViewController, animated: animated)
            
            if animated, let transitionCoordinator = transitionCoordinator {
                transitionCoordinator.animate(alongsideTransition: nil, completion: { _ in
                    completion?()
                })
            } else {
                completion?()
            }
            
            return
        }
        
        self.popToViewController(destinationVC, animated: animated)
        
        if animated, let transitionCoordinator = transitionCoordinator {
            transitionCoordinator.animate(alongsideTransition: nil, completion: { _ in
                completion?()
            })
        } else {
            completion?()
        }
        
    }
    
    
    /// 기존에 해당하는 뷰컨이 있다면 그걸로 Set, 아니라면 넣은것 푸시
    /// - Parameters:
    ///   - newViewController: 새로 넣는 뷰컨
    ///   - animated: 애니메이션 여부
    func pushOrSetToViewController<Destination: UIViewController>(
        newViewController: Destination,
        animated: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        
        // 기존에 해당하는 타입의 뷰컨이 있는지 없는지 여부
        guard let destinationVC : Destination = self.viewControllers.first(where: { vcItem in
            return vcItem.isKind(of: Destination.self)
        }) as? Destination else {
            
            // 기존에 해당 뷰컨타입이 없었다면 지금 넣은 뷰컨으로 푸시
            self.pushViewController(newViewController, animated: animated)
            
            if animated, let transitionCoordinator = transitionCoordinator {
                transitionCoordinator.animate(alongsideTransition: nil, completion: { _ in
                    completion?()
                })
            } else {
                completion?()
            }
            
            return
        }
        
        //
        var filteredViewControllerList = self.viewControllers.filter{ !$0.isKind(of: Destination.self) }
        
        filteredViewControllerList.append(newViewController)
        
        self.setViewControllers(filteredViewControllerList, animated: animated)
        
        if animated, let transitionCoordinator = transitionCoordinator {
            transitionCoordinator.animate(alongsideTransition: nil, completion: { _ in
                completion?()
            })
        } else {
            completion?()
        }
        
    }
}

