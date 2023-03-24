//
//  ViewController.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 01.12.22.
//

import UIKit
import Combine

//MARK: UICollectionViewCompositionalLayout

private extension MoviesViewController {
    func createSection(itemSize: NSCollectionLayoutSize, groupSize: NSCollectionLayoutSize,
                              spacing: CGFloat) -> NSCollectionLayoutSection {
        let insets = (top: 5.0, leading: 25.0, bottom: 18.0, trailing: 25.0)
        let headerHeight: CGFloat = 40
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: insets.top, leading: insets.leading,
                                                        bottom: insets.bottom, trailing: insets.trailing)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [createSectionHeader(withHeight: headerHeight)]
        
        return section
    }
    
    func createSectionHeader(withHeight height: CGFloat) -> NSCollectionLayoutBoundarySupplementaryItem {
        let fractionalWidth: CGFloat = 1
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fractionalWidth),
                                                             heightDimension: .absolute(height))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize,
                                                                              elementKind: UICollectionView.elementKindSectionHeader,
                                                                              alignment: .top,
                                                                              absoluteOffset: CGPoint.zero)
        
        return layoutSectionHeader
    }
    
    func setupLayout() {
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout { section, _ in
            let spacing: CGFloat = 25
            
            switch MoviesViewModel.Section(rawValue: section) {
            case .inTheatres:
                let fractionalWidth: CGFloat = 1
                let fractionalHeight: CGFloat = 1
                let absoluteWidth: CGFloat = 290
                let absoluteHeight: CGFloat = 400
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fractionalWidth),
                                                      heightDimension: .fractionalHeight(fractionalHeight))
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(absoluteWidth),
                                                       heightDimension: .absolute(absoluteHeight))
                let section = self.createSection(itemSize: itemSize, groupSize: groupSize,
                                                 spacing: spacing)
                
                return section
            case .mostPopular:
                let fractionalWidth: CGFloat = 1
                let itemEstimatedHeight: CGFloat = 265
                let absoluteWidth: CGFloat = 140
                let groupEstimatedHeight: CGFloat = 265
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fractionalWidth),
                                                      heightDimension: .estimated(itemEstimatedHeight))
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(absoluteWidth),
                                                       heightDimension: .estimated(groupEstimatedHeight))
                let section = self.createSection(itemSize: itemSize, groupSize: groupSize,
                                                 spacing: spacing)
                
                return section
            default: return nil
            }
        }
    }
}

// Datasource and delegate methods can be moved to a separate file
//MARK: UICollectionViewDiffableDataSource

private extension MoviesViewController {
    func setupDiffableDataSource() {
        let cellProvider: DiffableDataSource.CellProvider = { [weak self] collectionView, indexPath, data in
            guard let self else { return nil }
            
            let defaultScale: CGFloat = 1
            let deviceScale = self.view.window?.windowScene?.screen.scale ?? defaultScale
            
            switch MoviesViewModel.Section(rawValue: indexPath.section) {
            case .inTheatres:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.inTheatresCellID,
                                                              for: indexPath) as! InTheatresMoviesCollectionViewCell
                let imageSize = CGSize(width: cell.frame.width * deviceScale, height: cell.frame.height * deviceScale)
                
                cell.setupCell(withData: data as! InTheatresMovie, imageSize: imageSize)
                
                return cell
            case .mostPopular:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.popularMoviesCellID,
                                                              for: indexPath) as! PopularMoviesCollectionViewCell
                let imageSize = CGSize(width: cell.frame.width * deviceScale, height: cell.frame.height * deviceScale)
                
                cell.setupCell(withData: data as! PopularMovie, imageSize: imageSize)
                
                return cell
            default:
                return nil
            }
        }
        
        let viewProvider: DiffableDataSource.SupplementaryViewProvider = { collectionView, kind, indexPath in
            let inTheatresHeaderTitle = "In Theatres"
            let mostPopularHeaderTitle = "Most Popular"
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: self.headerID,
                                                                             for: indexPath) as! SectionHeaderReusableView
            
            switch MoviesViewModel.Section(rawValue: indexPath.section) {
            case .inTheatres:
                headerView.setTitle(text: inTheatresHeaderTitle)
            case .mostPopular:
                headerView.setTitle(text: mostPopularHeaderTitle)
            default:
                break
            }
            
            return headerView
        }
        
        diffableDataSource = DiffableDataSource(collectionView: collectionView, cellProvider: cellProvider)
        diffableDataSource.supplementaryViewProvider = viewProvider
    }
}

//MARK: UICollectionViewDelegate

extension MoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.openDetail(withIndexPath: indexPath)
    }
}

final class MoviesViewController: UIViewController, BaseConfiguration {
    
    //MARK: constants
    
    private let inTheatresCellID = "InTheatresMoviesCell"
    private let popularMoviesCellID = "PopularMoviesCell"
    private let headerID = "header"
    
    //MARK: typealiases
    
    private typealias DiffableDataSource = UICollectionViewDiffableDataSource<MoviesViewModel.Section, AnyHashable>
    
    //MARK: outlets
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    //MARK: public properties
    
    var viewModel: MoviesViewModel?
    var navigationTitle: String? { "Movies" }
    
    //MARK: private properties
    
    private var diffableDataSource: DiffableDataSource!
    private var cancellable: AnyCancellable?
    
    //MARK: lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarItem()
        setupNavigationBar()
        setupCollectionView()
        setupDiffableDataSource()
        setupBindings()
        requestData()
    }

    //MARK: private methods
    
    private func requestData() {
        viewModel?.requestAllMovies()
    }
    
    private func setupBindings() {
        cancellable = viewModel?.allMovies
            .sink(receiveCompletion: { [weak self] completion in
                self?.handleError()
            }, receiveValue: { [weak self] allMovies in
                if allMovies.0.isEmpty && allMovies.1.isEmpty { return }
                
                self?.applySnapshot(allMovies: allMovies)
            })
    }
    
    private func setupCollectionView() {
        setupLayout()
        registerReusableElements()
    }
    
    private func registerReusableElements() {
        let inTheatresCellNibName = "InTheatresMoviesCollectionViewCell"
        let popularMoviesCellNibName = "PopularMoviesCollectionViewCell"
        let inTheatresCellNib = UINib(nibName: inTheatresCellNibName, bundle: nil)
        let popularMoviesCellNib = UINib(nibName: popularMoviesCellNibName, bundle: nil)
        
        collectionView.register(inTheatresCellNib, forCellWithReuseIdentifier: inTheatresCellID)
        collectionView.register(popularMoviesCellNib, forCellWithReuseIdentifier: popularMoviesCellID)
        collectionView.register(SectionHeaderReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: headerID)
    }
    
    private func applySnapshot(allMovies: (inTheatresMovies: [InTheatresMovie], mostPopularMovies: [PopularMovie])) {
        var snapshot = NSDiffableDataSourceSnapshot<MoviesViewModel.Section, AnyHashable>()
        
        snapshot.appendSections([.inTheatres, .mostPopular])
        snapshot.appendItems(allMovies.inTheatresMovies, toSection: .inTheatres)
        snapshot.appendItems(allMovies.mostPopularMovies, toSection: .mostPopular)
        
        diffableDataSource.apply(snapshot)
    }
    
    private func handleError() {
        let title = "Alert"
        let message = "Oops, something went wrong."
        let actionTitle = "Close"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: actionTitle, style: .cancel))
        present(alert, animated: true, completion: nil)
    }
}

