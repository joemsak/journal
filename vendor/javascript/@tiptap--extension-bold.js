// @tiptap/extension-bold@2.11.7 downloaded from https://ga.jspm.io/npm:@tiptap/extension-bold@2.11.7/dist/index.js

import{Mark as t,markPasteRule as e,markInputRule as s,mergeAttributes as n}from"@tiptap/core";const o=/(?:^|\s)(\*\*(?!\s+\*\*)((?:[^*]+))\*\*(?!\s+\*\*))$/;const r=/(?:^|\s)(\*\*(?!\s+\*\*)((?:[^*]+))\*\*(?!\s+\*\*))/g;const d=/(?:^|\s)(__(?!\s+__)((?:[^_]+))__(?!\s+__))$/;const a=/(?:^|\s)(__(?!\s+__)((?:[^_]+))__(?!\s+__))/g;const i=t.create({name:"bold",addOptions(){return{HTMLAttributes:{}}},parseHTML(){return[{tag:"strong"},{tag:"b",getAttrs:t=>t.style.fontWeight!=="normal"&&null},{style:"font-weight=400",clearMark:t=>t.type.name===this.name},{style:"font-weight",getAttrs:t=>/^(bold(er)?|[5-9]\d{2,})$/.test(t)&&null}]},renderHTML({HTMLAttributes:t}){return["strong",n(this.options.HTMLAttributes,t),0]},addCommands(){return{setBold:()=>({commands:t})=>t.setMark(this.name),toggleBold:()=>({commands:t})=>t.toggleMark(this.name),unsetBold:()=>({commands:t})=>t.unsetMark(this.name)}},addKeyboardShortcuts(){return{"Mod-b":()=>this.editor.commands.toggleBold(),"Mod-B":()=>this.editor.commands.toggleBold()}},addInputRules(){return[s({find:o,type:this.type}),s({find:d,type:this.type})]},addPasteRules(){return[e({find:r,type:this.type}),e({find:a,type:this.type})]}});export{i as Bold,i as default,o as starInputRegex,r as starPasteRegex,d as underscoreInputRegex,a as underscorePasteRegex};

