//
//  ViewController.swift
//  SwipingSample
//
//  Created by Vuk Radosavljevic on 5/13/20.
//  Copyright © 2020 Vuk Radosavljevic. All rights reserved.
//

import UIKit



final class ViewController: UIViewController {

    @IBOutlet weak var detailCollectionView: UICollectionView!
    @IBOutlet weak var topCollectionView: UICollectionView!


    lazy var topDataSource = TopDataSource(didSelectNewIndexPath: { [weak self] in
        self?.scrollToDetailCell(at: $0)
    })

    private let detailDataSource = DetailDataSource()

    private func scrollToDetailCell(at indexPath: IndexPath) {
        detailCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        topCollectionView.register(UINib(nibName: String(describing: TopCollectionViewCell.self),
                                         bundle: nil),
                                   forCellWithReuseIdentifier: "TopCollectionViewCell")
        topCollectionView.dataSource = topDataSource
        topCollectionView.delegate = topDataSource

        detailCollectionView.register(UINib(nibName: String(describing: DetailCollectionViewCell.self),
                                            bundle: nil),
                                      forCellWithReuseIdentifier: "DetailCollectionViewCell")
        detailCollectionView.dataSource = detailDataSource
        detailCollectionView.delegate = detailDataSource

    }
}


final class TopDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private let didSelectNewIndexPath: (IndexPath) -> Void

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SampleData.mock.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopCollectionViewCell",
                                                      for: indexPath) as! TopCollectionViewCell
        let data = SampleData.mock[indexPath.item]
        cell.sampleLabel.text = String(data.number)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 6, height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectNewIndexPath(indexPath)
    }

    init(didSelectNewIndexPath: @escaping (IndexPath) -> Void) {
        self.didSelectNewIndexPath = didSelectNewIndexPath
    }

}

final class DetailDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SampleData.mock.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCollectionViewCell", for: indexPath) as! DetailCollectionViewCell
        let data = SampleData.mock[indexPath.item]
        cell.sampleLabel.text = String(data.number)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}


