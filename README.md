# &lt;Leader&gt; keymappings
## Navigation -- &lt;Leader&gt;  (feel free as i3!)

| Action | Key | implementation |
| :-  | :-: | :- |
| Navigate buffers | [ ] | built-in command |
| Navigate windows | j k l ; | built-in command |
| Move Window | J K L : | built-in command |
| Close window | / | built-in command |
| Switch buffer by bufnr | 1 to 9 | plugin (buftabline) |

## Files -- &lt;Leader&gt; + f

| Action | Key | implementation |
| :-  | :-: | :- |
| Open file in current window | f | plugin (ranger) |
| Open mru file | r | plugin (neomru) |
| Open file and split window | g n | plugin (ranger) |
| Open a new file | m | plugin (denite) |
| Save current buffer | s | built-in command |
| Save all | S | built-in command |

## Buffers -- &lt;Leader&gt; + b

| Action | Key | implementation |
| :-  | :-: | :- |
| Open denite buffer | b | plugin (denite) |
| Kill Buffer *in denite buffer* | / | plugin (denite) |

## Windows -- &lt;Leader&gt; + w

| Action | Key | implementation |
| :-  | :-: | :- |
| Split the current file | g n | built-in command |
| Split empty window | sg sn | built-in command |

## Help -- &lt;Leader&gt; + h

| Action | Key | implementation |
| :-  | :-: | :- |
| Help denite buffer | h | plugin (denite) |

## Quit -- &lt;Leader&gt; + q

| Action | Key | implementation |
| :-  | :-: | :- |
| Save all buffers and exit | s | built-in command |
| Close all windows and exit | q | built-in command |
| Discard changes and exit | Q | built-in command |
