# Portrait / Logo Fix — V2

The hero logo is now rendered only in the dedicated left-side identity zone.
It is no longer rendered as a pseudo-element inside the title container.

This prevents:
- CHARLES WABERA touching/overlapping the logo
- the logo entering the text area at narrower desktop widths
- duplicate logo layers

The portrait remains `object-fit: contain`, so the photograph is not squeezed.
