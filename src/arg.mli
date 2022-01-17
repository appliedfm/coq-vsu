open Cmdliner

val coqvsu_version : string

val coqvsu_man : Cmdliner.Manpage.block list

val coqvsu_doc : string

val show_vsu_path : bool Term.t

val show_include_path : bool Term.t