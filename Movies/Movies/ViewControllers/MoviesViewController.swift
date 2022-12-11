//
//  ViewController.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 01.12.22.
//

import UIKit

//MARK: UICollectionViewCompositionalLayout

extension MoviesViewController {
    enum Section: Int {
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
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item]) // Add UUID in models
        let section = NSCollectionLayoutSection(group: group)

        section.interGroupSpacing = spacing
        section.contentInsets = insets
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    private func createSectionHeader(withHeight height: CGFloat) -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                             heightDimension: .absolute(height))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize,
                                                                              elementKind: UICollectionView.elementKindSectionHeader,
                                                                              alignment: .top,
                                                                              absoluteOffset: CGPoint.zero)
        
        return layoutSectionHeader
    }
    
    private func setupLayout() {
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout { [weak self] section, _ in
            guard let self else { return nil }
            
            switch Section(rawValue: section) {
            case .inTheatres:
                let insets = NSDirectionalEdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 25)
                let section = self.createSection(groupWidth: 290, groupHeight: 400,
                                                 spacing: 25, insets: insets)
                
                section.boundarySupplementaryItems = [self.createSectionHeader(withHeight: 40)]
                
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

extension MoviesViewController: UICollectionViewDelegate {
    private func setupDiffableDataSource() {
        diffableDataSource = DiffableDataSource(
            collectionView: collectionView,
            cellProvider: { [weak self] (collectionView, indexPath, data) -> UICollectionViewCell? in
                switch Section(rawValue: indexPath.section) {
                case .inTheatres:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InTheatresMoviesCell",
                                                                  for: indexPath) as! InTheatresMoviesCollectionViewCell
                    let deviceScale = self?.view.window?.windowScene?.screen.scale ?? 1
                    let imageSize = CGSize(width: cell.frame.width * deviceScale, height: cell.frame.height * deviceScale)
                    
                    cell.setupCell(withData: data as! InTheatresMovie, imageSize: imageSize)
                    
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
        
        diffableDataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) -> UICollectionReusableView? in
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: "header",
                                                                             for: indexPath) as! SectionHeaderReusableView
            switch Section(rawValue: indexPath.section) {
            case .inTheatres:
                headerView.setTitle(text: "In The Theatres")
//            case .mostPopular:
//                headerView.setTitle(text: "Recommended")
            default:
                break
            }

            return headerView
        }
    }
}

class MoviesViewController: UIViewController {
    
    typealias DiffableDataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>
    
    //MARK: outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: private properties
    
    private var diffableDataSource: DiffableDataSource!
    private var viewModel = MoviesViewModel(withNetworkService: DefaultNetworkService())
    
    //MARK: lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupCollectionView()
        setupDiffableDataSource()
        setupBindings()
        requestInTheatresMovies()
    }

    //MARK: public methods
    
    func setupTabBarItem() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarItem = UITabBarItem(title: "Movies", image: UIImage(systemName: "film.fill"), tag: 0)
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 13)]
        tabBarItem.standardAppearance = tabBarAppearance
        tabBarItem.scrollEdgeAppearance = tabBarAppearance
    }
    
    //MARK: private methods
    
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Movies"
        appearance.titleTextAttributes = [.foregroundColor: Colors.title as Any,
                                          .font: UIFont(name: "NunitoSans-Black", size: 20) as Any]
        appearance.largeTitleTextAttributes = [.foregroundColor: Colors.title as Any,
                                               .font: UIFont(name: "NunitoSans-Black", size: 32) as Any]
        navigationItem.standardAppearance = appearance
    }
    
    private func requestInTheatresMovies() {
        viewModel.requestInTheatresMovies()
    }
    
    private func setupBindings() {
        viewModel.movies.bind { [weak self] movies in
            self?.applySnapshot(forSection: .inTheatres, withData: movies)
        }
        
        viewModel.error.bind { _ in
            // Show error screen
        }
    }
    
    private func setupCollectionView() {
        setupLayout()
        registerReusableElements()
    }
    
    private func registerReusableElements() {
        collectionView.register(UINib(nibName: "InTheatresMoviesCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: "InTheatresMoviesCell")
        collectionView.register(SectionHeaderReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "header")
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

