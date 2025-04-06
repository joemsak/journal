import { Controller } from "@hotwired/stimulus"

import { Editor } from 'https://esm.sh/@tiptap/core'
import StarterKit from 'https://esm.sh/@tiptap/starter-kit'


// Connects to data-controller="tiptap"
export default class extends Controller {
  static values = {
    content: String
  }

  connect() {
    new Editor({
      element: this.element,
      extensions: [StarterKit],
      autofocus: true,
      content: this.contentValue,
      editorProps: {
        attributes: {
          class: 'p-4',
        },
      },
      onUpdate({ editor }) {
        fetch("/contents", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content
          },
          body: JSON.stringify({ "content": editor.getText() })
        })
      },
    })
  }
}
