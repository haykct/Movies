//
//  ViewController.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 01.12.22.
//

import UIKit

//MARK: UICollectionViewCompositionalLayout

extension MoviesViewController {
    enum Section: Int, CaseIterable {
        case inTheatres
        case mostPopular
    }
    
    private func createSection(groupWidth: CGFloat, groupHeight: CGFloat,
                              spacing: CGFloat, insets: NSDirectionalEdgeInsets) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(groupWidth),
                                               heightDimension: .absolute(groupHeight))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)

        section.interGroupSpacing = spacing
        section.contentInsetsReference = .safeArea
        section.contentInsets = insets
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    private func setupLayout() {
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout { [weak self] section, _ in
            guard let self else { return nil }
            
            switch Section(rawValue: section) {
            case .inTheatres:
                let insets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
                let section = self.createSection(groupWidth: 180, groupHeight: 180,
                                                 spacing: 48, insets: insets)
                
                return section
            case .mostPopular:
                let insets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
                let section = self.createSection(groupWidth: 180, groupHeight: 180,
                                                 spacing: 48, insets: insets)
                
                return section
            default: return nil
            }
        }
    }
}

//MARK: UICollectionViewDiffableDataSource

extension MoviesViewController {
    private func setupDiffableDataSource() {
        diffableDataSource = DiffableDataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, data) -> UICollectionViewCell? in
                switch Section(rawValue: indexPath.section) {
                case .inTheatres:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InTheatresMoviesCell",
                                                                  for: indexPath) as! InTheatresMoviesCollectionViewCell
                    
                    return cell
//                case .mostPopular:
//                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "genresCell",
//                                                                  for: indexPath) as! GenresCollectionViewCell
//
//                    return cell
                default:
                    return nil
                }
            })
    }
}

class MoviesViewController: UIViewController {
    
    typealias DiffableDataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>
    
    //MARK: outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: private properties
    
    private var diffableDataSource: DiffableDataSource!
    
    //MARK: lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //MARK: methods
    
    func setupTabBarItem() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarItem = UITabBarItem(title: "Movies", image: UIImage(systemName: "film.fill"), tag: 0)
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 13)]
        tabBarItem.standardAppearance = tabBarAppearance
        tabBarItem.scrollEdgeAppearance = tabBarAppearance
    }
    
    //MARK: private methods
    
    private func setupCollectionView() {
        setupLayout()
        registerReusableElements()
    }
    
    private func registerReusableElements() {
        collectionView.register(UINib(nibName: "InTheatresMoviesCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: "InTheatresMoviesCell")
    }
    
    private func applySnapshot(forSection section: Section, withData data: [AnyHashable]) {
        var snapshot = NSDiffableDataSourceSectionSnapshot<AnyHashable>()
        
        switch section {
        case .inTheatres:
            snapshot.append(data)
        case .mostPopular:
            snapshot.append(data)
        }
        
        diffableDataSource.apply(snapshot, to: section, animatingDifferences: true)
    }
}

