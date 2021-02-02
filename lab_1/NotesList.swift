//
//  Created by Владислав Якубец on 26.11.2020.
//

import Foundation

class NotesList {
 
    static let sharedNotesList = NotesList()
    
    private (set) var notes: [Note] = []
    
    private init() {
        
        let defaults = UserDefaults.standard
        
        if let storedNotes = defaults.object(forKey: "notes") as? Data {
            if let savedData = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(storedNotes) as? [Note]{
                notes = savedData
            }
        }
        
    }
    
    func addNote(titleName: String, titleText: String, date: String, important: Int) {
        
        notes.append(Note(title: titleName, text: titleText, date: date, important: important))
        saveNotes()
    }
    
    func editNote(at index: Int, titleText: String, noteText: String, important: Int) {
        
        let editableNote = notes[index]
        
        let newNote = Note(title: titleText, text: noteText, date: editableNote.date, important: important)
        
        notes[index] = newNote
        saveNotes()
    
    }
    
    func deleteRow(at index: Int) {
        notes.remove(at: index)
        saveNotes()
    }
    
    private func saveNotes() {
        let defaults = UserDefaults.standard
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: notes, requiringSecureCoding: false){
            defaults.set(savedData, forKey: "notes")
            defaults.synchronize()
        }
    }
}
