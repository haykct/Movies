//
//  ViewController.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 01.12.22.
//

import UIKit
import Combine

//MARK: UICollectionViewCompositionalLayout

extension MoviesViewController {
    private func createSection(itemSize: NSCollectionLayoutSize, groupSize: NSCollectionLayoutSize,
                              spacing: CGFloat) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 25, bottom: 18, trailing: 25)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [createSectionHeader(withHeight: 40)]
        
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
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout { section, _ in
            switch Section(rawValue: section) {
            case .inTheatres:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                      heightDimension: .fractionalHeight(1))
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(290),
                                                       heightDimension: .absolute(400))
                let section = self.createSection(itemSize: itemSize, groupSize: groupSize,
                                                 spacing: 25)
                
                return section
            case .mostPopular:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                      heightDimension: .estimated(265))
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(140),
                                                       heightDimension: .estimated(265))
                let section = self.createSection(itemSize: itemSize, groupSize: groupSize,
                                                 spacing: 25)
                
                return section
            default: return nil
            }
        }
    }
}

// Datasource and delegate methods should be moved to a separate class
//MARK: UICollectionViewDiffableDataSource

extension MoviesViewController {
    private func setupDiffableDataSource() {
        diffableDataSource = DiffableDataSource(
            collectionView: collectionView,
            cellProvider: { [weak self] (collectionView, indexPath, data) -> UICollectionViewCell? in
                let deviceScale = self?.view.window?.windowScene?.screen.scale ?? 1
                
                switch Section(rawValue: indexPath.section) {
                case .inTheatres:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InTheatresMoviesCell",
                                                                  for: indexPath) as! InTheatresMoviesCollectionViewCell
                    let imageSize = CGSize(width: cell.frame.width * deviceScale, height: cell.frame.height * deviceScale)
                    
                    cell.setupCell(withData: data as! InTheatresMovie, imageSize: imageSize)
                    
                    return cell
                case .mostPopular:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularMoviesCell",
                                                                  for: indexPath) as! PopularMoviesCollectionViewCell
                    let imageSize = CGSize(width: cell.frame.width * deviceScale, height: cell.frame.height * deviceScale)
                    
                    cell.setupCell(withData: data as! PopularMovie, imageSize: imageSize)

                    return cell
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
                headerView.setTitle(text: "In Theatres")
            case .mostPopular:
                headerView.setTitle(text: "Most Popular")
            default:
                break
            }

            return headerView
        }
    }
}

//MARK: UICollectionViewDelegate

extension MoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.openDetail(withIndexPath: indexPath)
    }
}

enum Section: Int, CaseIterable {
    case inTheatres
    case mostPopular
}

final class MoviesViewController: UIViewController {
    
    private typealias DiffableDataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>
    
    //MARK: outlets
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    //MARK: public properties
    
    var viewModel: MoviesViewModel?
    
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
    
    private func setupTabBarItem() {
        let tabBarAppearance = UITabBarAppearance()

        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.font: UIFont(name: "NunitoSans-SemiBold",
                                                                                             size: 14) as Any]
        tabBarItem.standardAppearance = tabBarAppearance
        tabBarItem.scrollEdgeAppearance = tabBarAppearance
    }
    
    
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        
        navigationItem.title = "Movies"
        navigationController?.navigationBar.prefersLargeTitles = true
        appearance.titleTextAttributes = [.foregroundColor: Colors.grey as Any,
                                          .font: UIFont(name: "NunitoSans-Black", size: 20) as Any]
        appearance.largeTitleTextAttributes = [.foregroundColor: Colors.grey as Any,
                                               .font: UIFont(name: "NunitoSans-Black", size: 32) as Any]
        appearance.buttonAppearance.normal.titleTextAttributes = [.foregroundColor: Colors.grey as Any,
                                                                  .font: UIFont(name: "NunitoSans-Bold", size: 18) as Any]
        appearance.setBackIndicatorImage(UIImage(systemName: "chevron.backward.circle.fill"),
                                         transitionMaskImage: UIImage(systemName: "chevron.backward.circle.fill"))
        navigationController?.navigationBar.tintColor = Colors.grey
        navigationController?.navigationBar.standardAppearance = appearance
    }
    
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
        collectionView.register(UINib(nibName: "InTheatresMoviesCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: "InTheatresMoviesCell")
        collectionView.register(UINib(nibName: "PopularMoviesCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: "PopularMoviesCell")
        collectionView.register(SectionHeaderReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "header")
    }
    
    private func applySnapshot(allMovies: (inTheatresMovies: [InTheatresMovie], mostPopularMovies: [PopularMovie])) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        
        snapshot.appendSections([.inTheatres, .mostPopular])
        snapshot.appendItems(allMovies.inTheatresMovies, toSection: .inTheatres)
        snapshot.appendItems(allMovies.mostPopularMovies, toSection: .mostPopular)
        
        diffableDataSource.apply(snapshot)
    }
    
    private func handleError() {
        let alert = UIAlertController(title: "Alert", message: "Oops, something went wrong.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Close", style: .cancel))
        present(alert, animated: true, completion: nil)
    }
}

