import { Controller } from "@hotwired/stimulus"

import debounce from 'lodash.debounce'

import { Editor } from 'https://esm.sh/@tiptap/core'
import StarterKit from 'https://esm.sh/@tiptap/starter-kit'

// Connects to data-controller="tiptap"
export default class extends Controller {
  static values = {
    content: String
  }

  connect() {
    const func = ({ editor }) => {
      const path = '/contents'
      const method = 'POST'
      const token = document.querySelector("meta[name='csrf-token']").content
      const headers = {
        'Content-Type': 'application/json',
        'X-CSRF-Token': token
      }
      const body = JSON.stringify({'content': editor.getHTML()})

      fetch(path, {method, headers, body})
    }

    const debouncedOnUpdate = debounce(func, 350)

    new Editor({
      element: this.element,
      extensions: [StarterKit],
      autofocus: true,
      content: this.contentValue,
      editorProps: {
        attributes: {
          class: 'p-4 min-h-[50vh]'
        },
      },
      onUpdate: debouncedOnUpdate
    })
  }
}
