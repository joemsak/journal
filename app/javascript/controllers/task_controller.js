import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="task"
export default class extends Controller {
  static targets = [
    'notesBtn',
    'notes'
  ]

  toggleNotes() {
    const button = this.notesBtnTarget
    const notes = this.notesTarget

    notes.classList.toggle('hidden')

    if (notes.classList.contains('hidden'))
      button.innerText = `${String.fromCharCode(43)} Show notes`
    else
      button.innerText = `${String.fromCharCode(8722)} Hide notes`
  }
}
