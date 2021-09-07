//
//  ViewController.swift
//  Pokedex
//
//  Created by Daniele Valente on 01/09/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {

    private var pokeViewModel : PokeViewModel!
    private var pokeTableView: UITableView!
    private var dataSource : PokeTableViewDataSource<PokeTableViewCell, Pokemon>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //table view
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        var displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        //setto la grafica per ipad
        if UIDevice.current.userInterfaceIdiom == .pad {
            displayWidth /= 2
        }
        
        self.view.backgroundColor = UIColor(red: 231.0/255.0, green: 59.0/255.0, blue: 63.0/255.0, alpha: 1)
        pokeTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        pokeTableView.register(PokeTableViewCell.self, forCellReuseIdentifier: "PokeTableViewCell")
        
        //inizializzo DataModel
        self.pokeViewModel = PokeViewModel()
        self.pokeViewModel.bindPokemonViewModelToController = {
            self.dataSource = PokeTableViewDataSource(cellIdentifier: "PokeTableViewCell", items: self.pokeViewModel.pokeData, configureCell: { (cell, poke) in
                cell.name = poke.name ?? ""
            })
            DispatchQueue.main.async {
                self.pokeTableView.dataSource = self.dataSource
                self.pokeTableView.reloadData()
            }
        }
        
        pokeTableView.delegate = self
        self.view.addSubview(pokeTableView)
        pokeTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        pokeTableView.backgroundColor = .clear
        pokeTableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: 120))
        
        //header
        let headerImageView = UIImageView(image: UIImage.init(named: "Title"))
        headerImageView.frame.size = CGSize(width: 257, height: 103)
        pokeTableView.tableHeaderView?.addSubview(headerImageView)
        headerImageView.center = pokeTableView.tableHeaderView!.center
    }

    //delegates
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        detailViewController.pokeId = (indexPath.row+1).description
        if UIDevice.current.userInterfaceIdiom == .phone {
            present(detailViewController, animated: true, completion: nil)
        } else {
            if self.children.count > 0 {
                   let viewControllers:[UIViewController] = self.children
                   for viewContoller in viewControllers{
                       viewContoller.willMove(toParent: nil)
                       viewContoller.view.removeFromSuperview()
                       viewContoller.removeFromParent()
                   }
               }
            detailViewController.view.frame = CGRect(x: self.view.frame.maxX/2, y: 0, width: self.view.frame.width*2, height: self.view.frame.height)
            self.view.addSubview(detailViewController.view)
            self.addChild(detailViewController)
            detailViewController.didMove(toParent: self)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }

}
