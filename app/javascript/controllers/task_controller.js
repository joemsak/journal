import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="task"
export default class extends Controller {
  static targets = [
    'editor'
  ]

  static values = {
    entryDate: String,
    taskId: Number
  }

  saveTitle(event) {
    const el = event.target
    const token = document.querySelector("meta[name='csrf-token']").content
    const headers = {
      'Content-Type': 'application/json',
      'X-CSRF-Token': token
    }
    const params = {
      entryDate: this.entryDateValue,
      task: {title: el.innerText}
    }

    if (this.taskIdValue) params.task['id'] = this.taskIdValue

    const body = JSON.stringify(params)

    fetch('/tasks', { method: 'PATCH', headers, body })
      .then(resp => {
        if (!resp.ok) throw new Error(resp.json())
        return resp.json()
      })
      .then(json => {
        this.taskIdValue = json.taskId
        this.editorTargets.forEach(e => e.dataset.tiptapResourceIdValue = json.taskId)
        this.blurTitle(event)
      })
      .catch(err => console.error(err))
  }

  blurTitle(event) {
    window.getSelection().removeAllRanges()
    event.target.blur()
  }
}
