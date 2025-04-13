import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="entry"
export default class extends Controller {
  static targets = [
    'body',
    'bodyBtn',
  ]

  addTask() {
  }

  toggleBody(event) {
    const button = this.bodyBtnTarget
    const body = this.bodyTarget

    body.classList.toggle('hidden')

    if (body.classList.contains('hidden'))
      button.innerText = `${String.fromCharCode(43)} Show body`
    else
      button.innerText = `${String.fromCharCode(8722)} Hide body`
  }
}
