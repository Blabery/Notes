//
//  Created by Владислав Якубец on 26.11.2020.
//

import UIKit

class RootVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var label: UILabel!
    
    let sections: [UIImage] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    
    private var notesList: NotesList!
    var filteredNotes: [Note] = []
    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notesList = NotesList.sharedNotesList
        
        table.dataSource = self
        table.delegate = self
        
        if notesList.notes.count > 0 {
            table.isHidden = false
        }
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Найти заметку"
        navigationItem.searchController = searchController
        definesPresentationContext = true

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "newNote" {
            guard let destinationVC = segue.destination as? EntryVC else {
                return
            }
            destinationVC.title = "Новая заметка"
            
            destinationVC.completion = { [self] noteTitle, noteText, date, important in
                notesList.addNote(titleName: noteTitle, titleText: noteText, date: date, important: important)
                
                table.reloadData()
            }
        } 
    }
}

//Table Methods
extension RootVC {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering {
            return filteredNotes.count
        }
        
        return notesList.notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let note: Note
        if isFiltering {
            note = filteredNotes[indexPath.row]
        } else {
            note = notesList.notes[indexPath.row]
        }
        cell.textLabel?.text = note.title
        cell.detailTextLabel?.text = note.text
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        
        if let noteVC = storyboard?.instantiateViewController(identifier: "noteVC") as? NoteVC {
            
            let note: Note
            noteVC.title = "Заметка"
            var index = 0
            
            if isFiltering {
                
                note = filteredNotes[indexPath.row]
                
                for item in notesList.notes {
                    
                    if note == item {
                        break
                    }
                    index += 1
                }
                
            } else {
                note = notesList.notes[indexPath.row]
                index = indexPath.row
            }
            
            var color = UIColor.systemBlue
            if note.important == 3 {
                color = UIColor.red
                
            } else if note.important == 2 {
                color = UIColor.yellow
                
            } else if note.important == 1 {
                color = UIColor.green
                
            }
            
            noteVC.noteTitle = note.title
            noteVC.noteText = note.text
            noteVC.date = note.date
            noteVC.color = color
                
            noteVC.completion = { [self] noteTitle, noteText, important in
                notesList.editNote(at: index, titleText: noteTitle, noteText: noteText, important: important)
                navigationController?.popToRootViewController(animated: true)
                table.reloadData()
            }
            
            navigationController?.pushViewController(noteVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            notesList.deleteRow(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            if notesList.notes.count == 0 {
                tableView.isHidden = true
            }
        }
    }
}

//View Methods
extension RootVC {
    
    override func viewWillAppear(_ animated: Bool) {
        
        if notesList.notes.count > 0 {
            table.isHidden = false
        }
    }
}

//Search Methods
extension RootVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
      }
    
    func filterContentForSearchText(_ searchText: String) {
        
        filteredNotes = notesList.notes.filter({ (note: Note) -> Bool in
            return note.text.lowercased().contains(searchText.lowercased())
        })
        
        table.reloadData()
    }
}

