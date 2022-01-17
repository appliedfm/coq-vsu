open Cmdliner

val vsutool_version : string

val vsutool_man : Cmdliner.Manpage.block list

val vsutool_doc : string

val show_vsu_path : bool Term.t

val show_include_path : bool Term.t