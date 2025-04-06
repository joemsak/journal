import { Controller } from "@hotwired/stimulus"
import { Editor } from '@tiptap/core'
import StarterKit from '@tiptap/starter-kit'


// Connects to data-controller="tiptap"
export default class extends Controller {
  connect() {
    console.log("Hello, Stimulus!", this.element)
    new Editor({
      element: this.element,
      extensions: [StarterKit],
      content: '<p>Hello World!</p>',
    })
  }
}
