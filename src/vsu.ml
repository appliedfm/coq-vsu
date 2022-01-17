let driver (show_vsu_path: bool) (show_include_path: bool) =
  let opam_switch_prefix = Sys.getenv "OPAM_SWITCH_PREFIX" in
  let vsu_relative = "lib/coq-vsu" in
  if show_vsu_path then Printf.printf "%s/%s" opam_switch_prefix vsu_relative;
  if show_include_path then Printf.printf "%s/%s/%s" opam_switch_prefix vsu_relative "include"

let main () =
  let vsu_cmd =
    let open Arg in
    ( Cmdliner.Term.(
        const driver $ show_vsu_path $ show_include_path),
      Cmdliner.Term.info "vsu" ~version:vsu_version ~doc:vsu_doc ~man:vsu_man )
  in match Cmdliner.Term.eval ~catch:false vsu_cmd with
  | `Error _ -> exit 1
  | `Version
  | `Help
  | `Ok () -> exit 0

let _ = main ()