open Printf
open Unit_t

let do__show_coq_variant_path package =
  let m_path = sprintf "%s/%s.json" Constants.vsu_unit_metadata_path package in
  match Option.bind (Unit.load_unit_metadata m_path) (fun pkg -> pkg.coq_library_path) with
  | Some x -> x
  | _ ->
    match String.lowercase_ascii package with
    | "coq-compcert-32" -> sprintf "%s/%s" Constants.coq_variant_path "compcert32/compcert"
    | "coq-vst-32" -> sprintf "%s/%s" Constants.coq_variant_path "VST32/VST"
    | "coq-certigraph-32" -> sprintf "%s/%s" Constants.coq_variant_path "CertiGraph32/CertiGraph"
    | _ -> ""

let do__show_coq_variant_name package =
  let m_path = sprintf "%s/%s.json" Constants.vsu_unit_metadata_path package in
  match Option.bind (Unit.load_unit_metadata m_path) (fun pkg -> pkg.coq_library_name) with
  | Some x -> x
  | _ ->
    match String.lowercase_ascii package with
    | "coq-compcert-32" -> "compcert"
    | "coq-vst-32" -> "VST"
    | "coq-certigraph-32" -> "CertiGraph"
    | _ -> ""

let do__show_coq_q_arg package =
  let p = do__show_coq_variant_path package in
  let n = do__show_coq_variant_name package in
  if String.equal p "" || String.equal n "" then "" else sprintf "-Q %s %s" p n

let do__show_tool_path package_tool =
  match String.split_on_char '/' (String.lowercase_ascii package_tool) with
  | (package::tool::[]) ->
    begin
      let m_path = sprintf "%s/%s.json" Constants.vsu_unit_metadata_path package in
      match Option.bind (Unit.load_unit_metadata m_path) (fun pkg -> (List.assoc tool pkg.tools).tool_path) with
      | Some x -> x
      | _ ->
        match package, tool with
        | "coq-compcert", "ccomp" -> sprintf "%s/%s" Constants.opam_switch_base_path "bin/ccomp"
        | "coq-compcert", "clightgen" -> sprintf "%s/%s" Constants.opam_switch_base_path "bin/clightgen"
        | "coq-compcert-32", "ccomp" -> sprintf "%s/%s" Constants.opam_switch_base_path "variants/compcert32/bin/ccomp"
        | "coq-compcert-32", "clightgen" -> sprintf "%s/%s" Constants.opam_switch_base_path "variants/compcert32/bin/clightgen"
        | _ -> ""
    end
  | _ -> ""


let driver
    (show_vsu_path: bool)
    (show_unit_metadata_path: bool)
    (show_include_path: bool)
    (show_coq_variant_path: string option)
    (show_coq_q_arg: string option)
    (show_tool_path: string option) =
  if show_vsu_path then printf "%s" Constants.vsu_base_path;
  if show_unit_metadata_path then printf "%s" Constants.vsu_unit_metadata_path;
  if show_include_path then printf "%s" Constants.vsu_include_path;
  Option.iter (fun package -> printf "%s" (do__show_coq_variant_path package)) show_coq_variant_path;
  Option.iter (fun package -> printf "%s" (do__show_tool_path package)) show_tool_path;
  Option.iter (fun package -> printf "%s" (do__show_coq_q_arg package)) show_coq_q_arg;
  ()

let main () =
  let vsu_cmd =
    let open Arg in
    ( Cmdliner.Term.(
        const driver
        $ show_vsu_path
        $ show_unit_metadata_path
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