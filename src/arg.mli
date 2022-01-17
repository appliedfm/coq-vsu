open Cmdliner

val vsu_version : string

val vsu_man : Cmdliner.Manpage.block list

val vsu_doc : string

val show_vsu_path : bool Term.t

val show_include_path : bool Term.t