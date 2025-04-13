import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="task"
export default class extends Controller {
  static targets = [
    'notesBtn',
    'notes'
  ]

  static values = {
    entryDate: String,
    taskId: Number
  }

  toggleNotes() {
    const button = this.notesBtnTarget
    const notes = this.notesTarget

    notes.classList.toggle('hidden')

    if (notes.classList.contains('hidden'))
      button.innerText = `${String.fromCharCode(43)} Show notes`
    else
      button.innerText = `${String.fromCharCode(8722)} Hide notes`
  }

  saveTitle(event) {
    const el = event.target
    const token = document.querySelector("meta[name='csrf-token']").content
    const headers = {
      'Content-Type': 'application/json',
      'X-CSRF-Token': token
    }
    const body = JSON.stringify({
      entryDate: this.entryDateValue,
      task: {
        title: el.innerText,
        id: this.taskIdValue,
      }
    })

    fetch('/tasks', { method: 'PATCH', headers, body })
      .then(resp => {
        if (!resp.ok) throw new Error(resp.json())
        return resp.json()
      })
      .then(json => {
        this.taskIdValue = json.taskId
        el.blur()
      })
      .catch(err => console.error(err))
  }

  blurTitle(event) {
    window.getSelection().removeAllRanges()
    event.target.blur()
  }
}
