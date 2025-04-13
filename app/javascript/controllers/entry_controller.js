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
    const getTitle = el => el.querySelector('[data-task-target="title"]')

    const setDefaultTitle = (elem, index, elems) => {
      const title = getTitle(elem)
      if (title.innerHTML.length) return
      title.innerHTML = `Untitled Task #${elems.length - index}`
    }

    const initTaskList = () => {
      Array.from(element.children).forEach(setDefaultTitle)
    }

    initTaskList()

    this.taskListObserver = new MutationObserver(() => {
      initTaskList()
      const title = getTitle(element)
      if (title) window.getSelection().selectAllChildren(title)
    })

    this.taskListObserver.observe(element, {childList: true})
  }

  taskListTargetDisconnected() { this.taskListObserver.disconnect() }
}
