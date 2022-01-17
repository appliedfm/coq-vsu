open Cmdliner

let vsu_version = "0.0.1"

let vsu_man =
  [
    `S "DESCRIPTION";
    `P "Tools for working with Verified Software Units";
    `S "USAGE";
    `P "To print the C include path:";
    `Pre "vsu --show-include-path";
    `P "See https://github.com/appliedfm/coq-vsu for more information.";
  ]

let vsu_doc = "vsu Verified Software Unit CLI"

let show_vsu_path : bool Term.t =
  let doc = "Print the path to the VSU directory" in
  Arg.(value & flag & info [ "show-vsu-path" ] ~doc)

let show_include_path : bool Term.t =
  let doc = "Print the C include path" in
  Arg.(value & flag & info [ "I"; "show-include-path" ] ~doc)
