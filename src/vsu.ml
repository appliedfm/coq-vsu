open Printf

let do__show_vsu_path opam_switch_prefix vsu_relative =
  sprintf "%s/%s" opam_switch_prefix vsu_relative

let do__show_meta_path opam_switch_prefix vsu_relative =
  sprintf "%s/%s" (do__show_vsu_path opam_switch_prefix vsu_relative) "meta"
  
let do__show_include_path opam_switch_prefix vsu_relative =
  sprintf "%s/%s" (do__show_vsu_path opam_switch_prefix vsu_relative) "lib/include"

let do__show_coq_variant_path opam_switch_prefix package =
  let coq_user_contrib = "lib/coq/user-contrib" in
  let coq_variant_user_contrib = "lib/coq-variant" in
  match String.lowercase_ascii package with
  | "coq-compcert" -> sprintf "%s/%s/%s" opam_switch_prefix coq_user_contrib "compcert"
  | "coq-compcert-32" -> sprintf "%s/%s/%s" opam_switch_prefix coq_variant_user_contrib "compcert32/compcert"
  | "coq-vst" -> sprintf "%s/%s/%s" opam_switch_prefix coq_user_contrib "VST"
  | "coq-vst-32" -> sprintf "%s/%s/%s" opam_switch_prefix coq_variant_user_contrib "VST32/VST"
  | "coq-certigraph" -> sprintf "%s/%s/%s" opam_switch_prefix coq_user_contrib "CertiGraph"
  | "coq-certigraph-32" -> sprintf "%s/%s/%s" opam_switch_prefix coq_variant_user_contrib "CertiGraph32/CertiGraph"
  | _ -> ""

let do__show_coq_q_arg opam_switch_prefix package =
  match String.lowercase_ascii package with
  | "coq-compcert-32" -> sprintf "-Q %s compcert" (do__show_coq_variant_path opam_switch_prefix package)
  | "coq-vst-32" -> sprintf "-Q %s VST" (do__show_coq_variant_path opam_switch_prefix package)
  | "coq-certigraph-32" -> sprintf "-Q %s CertiGraph" (do__show_coq_variant_path opam_switch_prefix package)
  | _ -> ""

let do__show_tool_path opam_switch_prefix tool =
  match String.lowercase_ascii tool with
  | "coq-compcert/ccomp" -> sprintf "%s/%s" opam_switch_prefix "bin/ccomp"
  | "coq-compcert/clightgen" -> sprintf "%s/%s" opam_switch_prefix "bin/clightgen"
  | "coq-compcert-32/ccomp" -> sprintf "%s/%s" opam_switch_prefix "variants/compcert32/bin/ccomp"
  | "coq-compcert-32/clightgen" -> sprintf "%s/%s" opam_switch_prefix "variants/compcert32/bin/clightgen"
  | _ -> ""


let driver
    (show_vsu_path: bool)
    (show_meta_path: bool)
    (show_include_path: bool)
    (show_coq_variant_path: string option)
    (show_coq_q_arg: string option)
    (show_tool_path: string option) =
  let opam_switch_prefix = Sys.getenv "OPAM_SWITCH_PREFIX" in
  let vsu_relative = "lib/coq-vsu" in
  if show_vsu_path then printf "%s" (do__show_vsu_path opam_switch_prefix vsu_relative);
  if show_meta_path then printf "%s" (do__show_meta_path opam_switch_prefix vsu_relative);
  if show_include_path then printf "%s" (do__show_include_path opam_switch_prefix vsu_relative);
  Option.iter (fun package -> printf "%s" (do__show_coq_variant_path opam_switch_prefix package)) show_coq_variant_path;
  Option.iter (fun package -> printf "%s" (do__show_tool_path opam_switch_prefix package)) show_tool_path;
  Option.iter (fun package -> printf "%s" (do__show_coq_q_arg opam_switch_prefix package)) show_coq_q_arg;
  ()

let main () =
  let vsu_cmd =
    let open Arg in
    ( Cmdliner.Term.(
        const driver
        $ show_vsu_path
        $ show_meta_path
        $ show_include_path
        $ show_coq_variant_path
        $ show_coq_q_arg
        $ show_tool_path),
      Cmdliner.Term.info "vsu" ~version:vsu_version ~doc:vsu_doc ~man:vsu_man )
  in match Cmdliner.Term.eval ~catch:false vsu_cmd with
  | `Error _ -> exit 1
  | `Version
  | `Help
  | `Ok () -> exit 0

let _ = main ()