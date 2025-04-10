import { Controller } from "@hotwired/stimulus"

import debounce from 'lodash.debounce'

import { Editor, mergeAttributes } from 'https://esm.sh/@tiptap/core'

import Document from 'https://esm.sh/@tiptap/extension-document'
import Text from 'https://esm.sh/@tiptap/extension-text'
import Paragraph from 'https://esm.sh/@tiptap/extension-paragraph'
import BaseHeading from 'https://esm.sh/@tiptap/extension-heading'
import BulletList from 'https://esm.sh/@tiptap/extension-bullet-list'
import ListItem from 'https://esm.sh/@tiptap/extension-list-item'
import Blockquote from 'https://esm.sh/@tiptap/extension-blockquote'
import CodeBlock from 'https://esm.sh/@tiptap/extension-code-block'

export const Heading = BaseHeading.configure({ levels: [1, 2] }).extend({
  renderHTML({ node, HTMLAttributes }) {
    const hasLevel = this.options.levels.includes(node.attrs.level)
    const level = hasLevel ? node.attrs.level : this.options.levels[0]
    const classes = { 1: 'text-2xl', 2: 'text-xl' }

    return [
      `h${level}`,
      mergeAttributes(this.options.HTMLAttributes, HTMLAttributes, {
        class: `font-bold ${classes[level]}`,
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
    'bulletList',
    'blockQuote',
    'codeBlock',
    'savingDots',
    'savedText',
    'errorText',
    'editor'
  ]

  static values = {
    content: String
  }

  initialize() {
    this.onUpdate = ({ editor }) => {
      const path = '/contents'
      const method = 'POST'
      const token = document.querySelector("meta[name='csrf-token']").content
      const headers = {
        'Content-Type': 'application/json',
        'X-CSRF-Token': token
      }
      const body = JSON.stringify({'content': editor.getHTML()})

      this.savedTextTarget.classList.add('hidden')
      this.errorTextTarget.classList.add('hidden')
      this.savingDotsTarget.classList.remove('hidden')

      debounce(() => {
        fetch(path, {method, headers, body}).then(resp => {
          this.savingDotsTarget.classList.add('hidden')

          if (resp.status == 200)
            this.savedTextTarget.classList.remove('hidden')
          else
            this.errorTextTarget.classList.remove('hidden')
        })
      }, 350)()
    }

    this.editor = new Editor({
      extensions: [
        Document,
        Text,
        Paragraph.configure({
          HTMLAttributes: {
            class: "min-h-4"
          }
        }),
        Heading,
        BulletList.configure({
          HTMLAttributes: {
            class: "list-disc ml-6"
          }
        }),
        ListItem,
        Blockquote.configure({
          HTMLAttributes: {
            class: "p-4 my-4 border-s-4 border-gray-300"
          }
        }),
        CodeBlock.configure({
          HTMLAttributes: {
            class: "p-4 bg-gray-100 w-full truncate overflow-x-auto"
          }
        }),
      ],
      autofocus: true,
      content: this.contentValue,
      injectCSS: false,
      editorProps: {
        attributes: {
          class: 'p-4 min-h-[352px] max-h-[75vh] overflow-y-auto'
        },
      },

      onUpdate: this.onUpdate
    })
  }

  connect() {
    this.editor.on('selectionUpdate', ({ editor }) => {
      this.heading1Target.classList.toggle("bg-blue-200", editor.isActive('heading', {level: 1}))
      this.heading2Target.classList.toggle("bg-blue-200", editor.isActive('heading', {level: 2}))
      this.bulletListTarget.classList.toggle("bg-blue-200", editor.isActive('bulletList'))
      this.blockQuoteTarget.classList.toggle("bg-blue-200", editor.isActive('blockquote'))
      this.codeBlockTarget.classList.toggle("bg-blue-200", editor.isActive('codeBlock'))
    })
  }

  editorTargetConnected(element) {
    element.append(this.editor.options.element)
    element.classList.remove('hidden')
  }

  toggleHeading(event) {
    const level = event.params.level
    const editor = this.editor

    editor.chain().focus().toggleHeading({level}).run()
    this.heading1Target.classList.toggle("bg-blue-200", editor.isActive('heading', {level: 1}))
    this.heading2Target.classList.toggle("bg-blue-200", editor.isActive('heading', {level: 2}))
    this.codeBlockTarget.classList.toggle("bg-blue-200", editor.isActive('codeBlock'))
  }

  toggleBulletList(event) {
    const editor = this.editor
    editor.chain().focus().toggleBulletList().run()
    this.bulletListTarget.classList.toggle("bg-blue-200", editor.isActive('bulletList'))
  }

  toggleBlockquote(event) {
    const editor = this.editor
    editor.chain().focus().toggleBlockquote().run()
    this.blockQuoteTarget.classList.toggle("bg-blue-200", editor.isActive('blockquote'))
  }

  toggleCodeBlock(event) {
    const editor = this.editor
    editor.chain().focus().toggleCodeBlock().run()
    this.codeBlockTarget.classList.toggle("bg-blue-200", editor.isActive('codeBlock'))
    this.heading1Target.classList.toggle("bg-blue-200", editor.isActive('heading', {level: 1}))
    this.heading2Target.classList.toggle("bg-blue-200", editor.isActive('heading', {level: 2}))
  }
}
