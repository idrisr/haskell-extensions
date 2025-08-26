{ pkgs, stdenvNoCC, python312Packages }:
let
  mytex = pkgs.texlive.combine {
    inherit (pkgs.texlive)
      biblatex
      forest
      enumitem
      glossaries
      latex-bin
      latexmk
      colortbl
      minted
      pdfcol
      rsfs cm-super
      scheme-small
      supertabular
      tcolorbox
      tikzfill
      titlesec
      tocloft
      upquote
      xcolor
      ;
  };
in

stdenvNoCC.mkDerivation {
  name = "haskell extensions";
  pname = "haskell extensions";
  src = ./src;
  nativeBuildInputs = [ mytex python312Packages.pygments pkgs.biber ];
  buildPhase = ''
    latexmk 00-main.tex
  '';
  installPhase = ''
    mkdir -p $out
    mv build/00-main.pdf $out/
  '';
}
