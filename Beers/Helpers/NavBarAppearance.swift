//
//  NavBarAppearance.swift
//  Beers
//
//  Created by Линар Нигматзянов on 07/08/2022.
//
import UIKit

public func setupAppearanceNavigationBar(with controller: UINavigationController) {

        let navigationBarAppearance = UINavigationBarAppearance()

        navigationBarAppearance.backgroundColor = UIColor.black

        let paragraphStyle = NSMutableParagraphStyle()

        paragraphStyle.lineHeightMultiple = 1.01

        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]

        navigationBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white,

                                                            .paragraphStyle: paragraphStyle,

                                                            .kern: 0.41]

        UINavigationBar.appearance().tintColor = UIColor.purple

        controller.navigationBar.standardAppearance = navigationBarAppearance

        controller.navigationBar.compactAppearance = navigationBarAppearance

        controller.navigationBar.scrollEdgeAppearance = navigationBarAppearance

        controller.navigationBar.setBackgroundImage(UIImage(), for: .default)

        controller.navigationBar.shadowImage = UIImage()

    }
