# Find and Till

Quickly jump to the next character you type on your current line.
Find (jump to just before character) and Till (jump to just after letter) are both supported in either the forward direction or the reverse.
Multiple cursors are supported.

There are currently no default bindings, but here are some examples:

```cson
'atom-text-editor':
  'ctrl-s': 'find-and-till:find'
  'ctrl-r': 'find-and-till:find-backwards'
  'ctrl-alt-s': 'find-and-till:till'
  'ctrl-alt-r': 'find-and-till:till-backwards'
```

### Todo

* Support selection
* Come up with sensible defaults
* Learn how to write specs?
