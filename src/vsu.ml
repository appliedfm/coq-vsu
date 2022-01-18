let do__show_vsu_path opam_switch_prefix vsu_relative =
  Printf.printf "%s/%s" opam_switch_prefix vsu_relative

let do__show_include_path opam_switch_prefix vsu_relative vsu_include_relative =
  Printf.printf "%s/%s/%s" opam_switch_prefix vsu_relative vsu_include_relative

let do__show_coq_variant_path opam_switch_prefix variant =
  let coq_user_contrib = "lib/coq/user-contrib" in
  let coq_variant_user_contrib = "lib/coq-variant" in
  match String.lowercase_ascii variant with
  | "coq-compcert" -> Printf.printf "%s/%s/%s" opam_switch_prefix coq_user_contrib "compcert"
  | "coq-compcert-32" -> Printf.printf "%s/%s/%s" opam_switch_prefix coq_variant_user_contrib "compcert32/compcert"
  | "coq-vst" -> Printf.printf "%s/%s/%s" opam_switch_prefix coq_user_contrib "VST"
  | "coq-vst-32" -> Printf.printf "%s/%s/%s" opam_switch_prefix coq_variant_user_contrib "VST32/VST"
  | "coq-certigraph" -> Printf.printf "%s/%s/%s" opam_switch_prefix coq_user_contrib "CertiGraph"
  | "coq-certigraph-32" -> Printf.printf "%s/%s/%s" opam_switch_prefix coq_variant_user_contrib "CertiGraph32/CertiGraph"
  | _ -> Printf.printf "i don't know\n"

let do__show_compcert_tool_path opam_switch_prefix tool =
  match String.lowercase_ascii tool with
  | "coq-compcert/ccomp" -> Printf.printf "%s/%s" opam_switch_prefix "bin/ccomp"
  | "coq-compcert/clightgen" -> Printf.printf "%s/%s" opam_switch_prefix "bin/clightgen"
  | "coq-compcert-32/ccomp" -> Printf.printf "%s/%s" opam_switch_prefix "variants/compcert32/bin/ccomp"
  | "coq-compcert-32/clightgen" -> Printf.printf "%s/%s" opam_switch_prefix "variants/compcert32/bin/clightgen"
  | _ -> Printf.printf "i don't know\n"

  let driver (show_vsu_path: bool) (show_include_path: bool) (show_coq_variant_path: string option) (show_compcert_tool_path: string option) =
  let opam_switch_prefix = Sys.getenv "OPAM_SWITCH_PREFIX" in
  let vsu_relative = "lib/coq-vsu" in
  if show_vsu_path then do__show_vsu_path opam_switch_prefix vsu_relative;
  if show_include_path then do__show_include_path opam_switch_prefix vsu_relative "lib/include";
  Option.iter (do__show_coq_variant_path opam_switch_prefix) show_coq_variant_path;
  Option.iter (do__show_compcert_tool_path opam_switch_prefix) show_compcert_tool_path;
  ()

let main () =
  let vsu_cmd =
    let open Arg in
    ( Cmdliner.Term.(
        const driver
        $ show_vsu_path
        $ show_include_path
        $ show_coq_variant_path
        $ show_compcert_tool_path),
      Cmdliner.Term.info "vsu" ~version:vsu_version ~doc:vsu_doc ~man:vsu_man )
  in match Cmdliner.Term.eval ~catch:false vsu_cmd with
  | `Error _ -> exit 1
  | `Version
  | `Help
  | `Ok () -> exit 0

let _ = main ()