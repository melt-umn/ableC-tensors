grammar zoe ;

exports zoe:concretesyntax ;
exports zoe:abstractsyntax ;

-- exports zoe:src ;

{- Exporting the 'src' directory allows extension users to
   place your extension directory in a directory in which they already
   keep language extensions. This lets them easily use it in creating a
   new compiler without having to specify a path to your extension - it
   can be simply referenced by name.
 -}
