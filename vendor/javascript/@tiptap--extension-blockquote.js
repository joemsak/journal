// @tiptap/extension-blockquote@2.11.7 downloaded from https://ga.jspm.io/npm:@tiptap/extension-blockquote@2.11.7/dist/index.js

import{Node as t,wrappingInputRule as e,mergeAttributes as o}from"@tiptap/core";const r=/^\s*>\s$/;const n=t.create({name:"blockquote",addOptions(){return{HTMLAttributes:{}}},content:"block+",group:"block",defining:true,parseHTML(){return[{tag:"blockquote"}]},renderHTML({HTMLAttributes:t}){return["blockquote",o(this.options.HTMLAttributes,t),0]},addCommands(){return{setBlockquote:()=>({commands:t})=>t.wrapIn(this.name),toggleBlockquote:()=>({commands:t})=>t.toggleWrap(this.name),unsetBlockquote:()=>({commands:t})=>t.lift(this.name)}},addKeyboardShortcuts(){return{"Mod-Shift-b":()=>this.editor.commands.toggleBlockquote()}},addInputRules(){return[e({find:r,type:this.type})]}});export{n as Blockquote,n as default,r as inputRegex};

