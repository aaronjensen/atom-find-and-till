# Find and Till

Quickly jump to the next character you type on your current line.

![find-and-till](https://cloud.githubusercontent.com/assets/8588/8742523/26480284-2c1b-11e5-86c7-be78a28e6289.gif)

Find (jump to just before character) and Till (jump to just after letter) are both supported in either the forward direction or the reverse and you can select while doing it.

Multiple cursors are supported.

There are currently no default bindings, but here are some examples:

```cson
'atom-text-editor':
  'ctrl-s': 'find-and-till:find'
  'shift-ctrl-s': 'find-and-till:select-find'
  'ctrl-r': 'find-and-till:find-backwards'
  'shift-ctrl-r': 'find-and-till:select-find-backwards'
  'ctrl-alt-s': 'find-and-till:till'
  'shift-ctrl-alt-s': 'find-and-till:select-till'
  'ctrl-alt-r': 'find-and-till:till-backwards'
  'shift-ctrl-alt-r': 'find-and-till:select-till-backwards'
```

### Todo

* Come up with sensible defaults
* Learn how to write specs?
