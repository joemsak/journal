import { Controller } from "@hotwired/stimulus"
import { Editor } from '@tiptap/core'
import StarterKit from '@tiptap/starter-kit'


// Connects to data-controller="tiptap"
export default class extends Controller {
  connect() {
    new Editor({
      element: this.element,
      extensions: [StarterKit],
      content: '<p>Hello World!</p>',
    })
  }
}
