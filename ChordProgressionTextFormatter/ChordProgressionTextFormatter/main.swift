//
//  main.swift
//  ChordProgressionTextFormatter
//
//  Created by 除村武志 on 2024/08/13.
//

import Foundation

let input = """
(A)
|Abm   Db7  |Em   A7  |Cm   F7   |Abm    Db7   |
|Gb         |Ebm      |Abm       |Db7          |
|Abm   Db7  |Em   A7  |Cm   F7   |Abm    Db7   |
|Gb         |Ebm      |Abm  Db7  |Gb           |

(B)
|Abm        |Db7      |Em        |A7           |
|Cm         |F7       |Bb        |             |
|Abm        |Db7      |Em        |A7           |
|Cm         |F7       |Abm       |Db7          |

(A)
|Abm   Db7  |Em   A7  |Cm   F7   |Abm    Db7   |
|Gb         |Ebm      |Abm       |Db7          |
|Abm   Db7  |Em   A7  |Cm   F7   |Abm    Db7   |
|Gb         |Ebm      |Abm  Db7  |Gb           |

(Break)
|Abm        |Db7      |Gb        |Ebm          |
|Abm        |Db7      |Gb        |Ebm          |
|Abm        |Db7      |Gb        |Ebm          |
|Abm        |Db7      |Gb        |             |

(Solo = B, A)
(B)
(A)

(最後)
|Abm  Db7  |Gb          |
|Abm       |Db7    G7   |Gb          |
"""

let doc = try! Document.fromString(input)

let out = DocumentFormatter(document: doc, barWidth: 12, transpose: 2).formatted

print(out)
