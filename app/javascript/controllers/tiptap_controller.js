import { Controller } from "@hotwired/stimulus"

import { Editor } from 'https://esm.sh/@tiptap/core'

import Document from 'https://esm.sh/@tiptap/extension-document'
import Text from 'https://esm.sh/@tiptap/extension-text'
import Paragraph from 'https://esm.sh/@tiptap/extension-paragraph'
import Heading from 'https://esm.sh/@tiptap/extension-heading'
import Bold from 'https://esm.sh/@tiptap/extension-bold'
import BulletList from 'https://esm.sh/@tiptap/extension-bullet-list'
import ListItem from 'https://esm.sh/@tiptap/extension-list-item'
import Blockquote from 'https://esm.sh/@tiptap/extension-blockquote'
import CodeBlock from 'https://esm.sh/@tiptap/extension-code-block'

// Connects to data-controller="tiptap"
export default class extends Controller {
  static targets = [
    'heading',
    'bold',
    'bulletList',
    'blockQuote',
    'codeBlock',
    'savingDots',
    'savedText',
    'errorText',
    'editor'
  ]

  static values = {
    content: String,
    path: String,
    method: String,
    entityName: String,
    attribute: String,
    resourceId: Number
  }

  initialize() {
    const onUpdate = ({ editor }) => {
      if (this.updateTimeoutId) clearTimeout(this.updateTimeoutId)

      let content = null
      if (!!editor.getText().length) content = editor.getHTML()

      const token = document.querySelector("meta[name='csrf-token']").content

      const method = this.methodValue.toUpperCase()

      const headers = {
        'Content-Type': 'application/json',
        'X-CSRF-Token': token
      }

      const params = {}
      params[this.entityNameValue] = {}
      params[this.entityNameValue][this.attributeValue] = content
      if (this.resourceIdValue) params[this.entityNameValue]['id'] = this.resourceIdValue

      const body = JSON.stringify(params)

      this.savedTextTarget.classList.add('hidden')
      this.errorTextTarget.classList.add('hidden')
      this.savingDotsTarget.classList.remove('hidden')

      this.updateTimeoutId = setTimeout(() => {
        fetch(this.pathValue, { method, headers, body })
          .then(resp => {
            this.savingDotsTarget.classList.add('hidden')

            if (!resp.ok) {
              this.errorTextTarget.classList.remove('hidden')
              throw new Error(resp.json())
            }

            this.savedTextTarget.classList.remove('hidden')
            return resp.json()
          })
          .then(json => this.resourceIdValue = json.resourceId)
          .catch(err => console.error(err))
      }, 350)
    }

    this.editor = new Editor({
      extensions: [
        Document,
        Text,
        Paragraph.configure({
          HTMLAttributes: {class: "min-h-4"}
        }),
        Heading.configure({
          levels: [2],
          HTMLAttributes: {class: 'font-bold text-lg md:text-xl'}
        }),
        Bold,
        BulletList.configure({
          HTMLAttributes: {class: "list-disc ml-6"}
        }),
        ListItem,
        Blockquote.configure({
          HTMLAttributes: {class: "p-4 my-4 border-s-4 border-gray-300"}
        }),
        CodeBlock.configure({
          HTMLAttributes: {class: "p-4 bg-gray-100 w-full truncate overflow-x-auto"}
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

      onUpdate
    })
  }

  connect() {
    this.editor.on('selectionUpdate', ({ editor }) => {
      this.headingTarget.classList.toggle("bg-blue-200", editor.isActive('heading', {level: 2}))
      this.boldTarget.classList.toggle("bg-blue-200", editor.isActive('bold'))
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
    const editor = this.editor

    editor.chain().focus().toggleHeading({level: 2}).run()
    this.headingTarget.classList.toggle("bg-blue-200", editor.isActive('heading', {level: 2}))
    this.codeBlockTarget.classList.toggle("bg-blue-200", editor.isActive('codeBlock'))
  }

  toggleBold(event) {
    const editor = this.editor
    editor.chain().focus().toggleBold().run()
    this.boldTarget.classList.toggle("bg-blue-200", editor.isActive('bold'))
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
    this.headingTarget.classList.toggle("bg-blue-200", editor.isActive('heading', {level: 2}))
  }
}
