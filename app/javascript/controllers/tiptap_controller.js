import { Controller } from "@hotwired/stimulus"

import { Editor } from 'https://esm.sh/@tiptap/core'
import StarterKit from 'https://esm.sh/@tiptap/starter-kit'


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
