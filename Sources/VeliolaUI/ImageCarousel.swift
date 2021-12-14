//
//  ImageCarousel.swift
//  Veliola
//
//  Created by Tadreik Campbell on 8/10/21.
//  Copyright © 2021 Tadreik Campbell. All rights reserved.
//

import UIKit

public protocol ImageCarouselViewDelegate {
    func scrolledToPage(_ page: Int)
}


public class ImageCarouselView: UIView {
    
    public var delegate: ImageCarouselViewDelegate?
    
    public var imageList: [String] = [] {
        didSet {
            configure(images: imageList)
        }
    }
    
    var showPageControl: Bool = true
    
    var pageControlMaxItems: Int = 10
    
    var pageLabel = UILabel()
    
    var counter = 1
    
    var carouselScrollView = UIScrollView()
    
    var pageControl = UIPageControl()
    
    public var width: CGFloat!
    
    var currentPage: Int! {
        if round(carouselScrollView.contentOffset.x) == 0 {
            return 0
        } else {
            return Int(round(carouselScrollView.contentOffset.x / self.bounds.width))
        }
        
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.width = 300
    }
    
    public init(images: [String], width: CGFloat) {
        super.init(frame: .zero)
        self.width = width
        configure(images: images)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(images: [String]) {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        clipsToBounds = true
        carouselScrollView.translatesAutoresizingMaskIntoConstraints = false
        carouselScrollView.clipsToBounds = true
        carouselScrollView.showsVerticalScrollIndicator = false
        carouselScrollView.showsHorizontalScrollIndicator = false
        carouselScrollView.delegate = self
        carouselScrollView.isPagingEnabled = true
        
        for i in 0..<images.count {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.kfImage(images[i])
            imageView.contentMode = .scaleAspectFill
            imageView.layer.masksToBounds = true
            imageView.clipsToBounds = true
            imageView.isUserInteractionEnabled = true
            carouselScrollView.addSubview(imageView)
            if i == 0 {
                imageView.leadingAnchor.constraint(equalTo: carouselScrollView.leadingAnchor).isActive = true
                carouselScrollView.addConstraint(NSLayoutConstraint(item: carouselScrollView, attribute: .height, relatedBy: .equal, toItem: imageView, attribute: .height, multiplier: 1, constant: 0.0))            } else {
                    imageView.leadingAnchor.constraint(equalTo: carouselScrollView.subviews[i-1].trailingAnchor).isActive = true
                }
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: carouselScrollView.topAnchor),
                imageView.bottomAnchor.constraint(equalTo: carouselScrollView.bottomAnchor),
                imageView.widthAnchor.constraint(equalToConstant: width),
            ])
            if i == images.count - 1 {
                imageView.trailingAnchor.constraint(equalTo: carouselScrollView.trailingAnchor).isActive = true
            }
        }
        
        addSubview(carouselScrollView)
        NSLayoutConstraint.activate([
            carouselScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            carouselScrollView.topAnchor.constraint(equalTo: topAnchor),
            carouselScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            carouselScrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        if images.count > 1 {
            addPageControl(images: images)
        }
    }
    
    func addPageControl(images: [String]) {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.backgroundStyle = .prominent
        pageControl.numberOfPages = images.count
        pageControl.sizeToFit()
        pageControl.currentPage = 0
        
        self.addSubview(pageControl)
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    @objc private func scrollToPage(images: [String]) {
        var frame: CGRect = self.carouselScrollView.frame
        frame.origin.x = frame.size.width * CGFloat(self.counter)
        frame.origin.y = 0;
        self.carouselScrollView.scrollRectToVisible(frame, animated: true)
        if self.counter == images.count - 1 {
            self.counter = 0
        } else {
            self.counter += 1
        }
    }
    
}

extension ImageCarouselView: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.pageControl.currentPage = self.currentPage
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.delegate?.scrolledToPage(self.currentPage)
    }
    
}
