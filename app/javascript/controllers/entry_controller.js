import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="entry"
export default class extends Controller {
  static targets = [
    'body',
    'bodyBtn',
    'taskList'
  ]

  toggleBody(event) {
    const button = this.bodyBtnTarget
    const body = this.bodyTarget

    body.classList.toggle('hidden')

    if (body.classList.contains('hidden'))
      button.innerText = `${String.fromCharCode(43)} Show body`
    else
      button.innerText = `${String.fromCharCode(8722)} Hide body`
  }

  taskListTargetConnected(element) {
    const connectedLength = element.children.length
    const connectedTitle = element.querySelector('[data-title]')

    if (!connectedTitle.innerHTML.length)
      connectedTitle.innerHTML = `Untitled Task #${connectedLength}`

    const callback = (mutationList, observer) => {
      for (const mutation of mutationList) {
        const length = mutation.target.children.length

        mutation.addedNodes.forEach(node => {
          const title = node.querySelector('[data-title]')
          if (title.innerHTML.length) return
          title.innerHTML = `Untitled Task #${length}`
        })
      }
    }

    this.taskListObserver = new MutationObserver(callback)

    this.taskListObserver.observe(element, {childList: true})
  }

  taskListTargetDisconnected() { this.taskListObserver.disconnect() }
}
