(lang dune 2.9)
(name coq-vsu)
(version 0.0.1)

(generate_opam_files true)
(source (github appliedfm/coq-vsu))
(license MIT)
(authors "Tim Carstens" "appliedfm")
(maintainers "appliedfm")

(package
 (name coq-vsu)
 (synopsis "Tools for working with Verified Software Units")
 (description "Tools for working with Verified Software Units")
 (depends
  (atdgen (>= 2.2.1))
  (cmdliner (>= 1.0.4))
  (dune (> 1.5))
  (stdio (>= v0.14.0))
  (yojson (>= 1.7.0))
))