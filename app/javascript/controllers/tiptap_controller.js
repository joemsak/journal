import { Controller } from "@hotwired/stimulus"

import debounce from 'lodash.debounce'

import { Editor, mergeAttributes } from 'https://esm.sh/@tiptap/core'

import Document from 'https://esm.sh/@tiptap/extension-document'
import Text from 'https://esm.sh/@tiptap/extension-text'
import Paragraph from 'https://esm.sh/@tiptap/extension-paragraph'
import BaseHeading from 'https://esm.sh/@tiptap/extension-heading'
import Blockquote from 'https://esm.sh/@tiptap/extension-blockquote'
import CodeBlock from 'https://esm.sh/@tiptap/extension-code-block'

const classes = {
  1: 'text-2xl',
  2: 'text-xl',
}

export const Heading = BaseHeading.configure({ levels: [1, 2] }).extend({
  renderHTML({ node, HTMLAttributes }) {
    const hasLevel = this.options.levels.includes(node.attrs.level)
    const level = hasLevel ? node.attrs.level : this.options.levels[0]

    return [
      `h${level}`,
      mergeAttributes(this.options.HTMLAttributes, HTMLAttributes, {
        class: `${classes[level]}`,
      }),
      0,
    ]
  },
})

// Connects to data-controller="tiptap"
export default class extends Controller {
  static targets = [
    'heading1',
    'heading2',
    'blockQuote',
    'codeBlock',
    'editor'
  ]

  static values = {
    content: String
  }

  initialize() {
    this.updateContentFn = ({ editor }) => {
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

    this.debouncedOnUpdate = debounce(this.updateContentFn, 350)

    this.editor = new Editor({
      extensions: [
        Document,
        Text,
        Paragraph,
        Heading,
        Blockquote.configure({
          HTMLAttributes: {
            class: "p-4 my-4 border-s-4 border-gray-300 bg-gray-50 dark:border-gray-500 dark:bg-gray-800"
          }
        }),
        CodeBlock
      ],
      autofocus: true,
      content: this.contentValue,
      editorProps: {
        attributes: {
          class: 'p-4 min-h-[50vh]'
        },
      },

      onUpdate: this.debouncedOnUpdate
    })
  }

  connect() {
    this.editor.on('selectionUpdate', ({ editor }) => {
      this.heading1Target.classList.toggle("bg-blue-200", editor.isActive('heading', {level: 1}))
      this.heading2Target.classList.toggle("bg-blue-200", editor.isActive('heading', {level: 2}))
      this.blockQuoteTarget.classList.toggle("bg-blue-200", editor.isActive('blockquote'))
      this.codeBlockTarget.classList.toggle("bg-blue-200", editor.isActive('codeBlock'))
    })
  }

  editorTargetConnected(element) {
    element.append(this.editor.options.element)
    element.classList.remove('hidden')
  }

  toggleHeading(event) {
    const button = event.target.closest("button")
    const level = event.params.level
    const editor = this.editor

    editor.chain().focus().toggleHeading({level}).run()
    button.classList.toggle("bg-blue-200", editor.isActive('heading', {level}))
  }

  toggleBlockquote(event) {
    const button = event.target.closest("button")
    const editor = this.editor
    editor.chain().focus().toggleBlockquote().run()
    button.classList.toggle("bg-blue-200", editor.isActive('blockquote'))
  }

  toggleCodeBlock(event) {
    const button = event.target.closest("button")
    const editor = this.editor
    editor.chain().focus().toggleCodeBlock().run()
    button.classList.toggle("bg-blue-200", editor.isActive('codeBlock'))
  }
}
