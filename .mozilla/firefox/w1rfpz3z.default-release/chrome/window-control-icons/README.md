## Custom window control icons

Up until Firefox `140.0`, when using my custom Firefox Color theme, the window control
icons (minimize, maximize, close) looked like what I'd call "Windows 10 style".

<svg width="12" height="12" xmlns="http://www.w3.org/2000/svg">
  <line stroke="black" stroke-width="black" fill="none" shape-rendering="crispEdges" x1="1" y1="5.5" x2="11" y2="5.5"/>
</svg>

<svg width="12" height="12" xmlns="http://www.w3.org/2000/svg" shape-rendering="crispEdges">
  <rect stroke="black" stroke-width=".9" fill="none" x="1.5" y="1.5" width="9" height="9"/>
</svg>

<svg width="12" height="12" xmlns="http://www.w3.org/2000/svg" stroke="black" stroke-width=".9" fill="none" shape-rendering="crispEdges">
  <rect x="1.5" y="3.5" width="7" height="7"/>
  <polyline points="3.5,3.5 3.5,1.5 10.5,1.5 10.5,8.5 8.5,8.5"/>
</svg>

<svg width="12" height="12" xmlns="http://www.w3.org/2000/svg">
  <path stroke="black" stroke-width=".9" fill="none" d="M1,1 l 10,10 M1,11 l 10,-10"/>
</svg>

Whether this was a bug or not, I preferred these to the GNOME-like appearance they changed
to in `140.0`. The "old" icons are provided here and set in `userChrome.css`.
