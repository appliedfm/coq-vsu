# coq-vsu

![GitHub](https://img.shields.io/github/license/appliedfm/coq-vsu)

Tools for working with [Verified Software Units](https://softwarefoundations.cis.upenn.edu/vc-current/VSU_intro.html) in the [Coq](https://coq.inria.fr/) ecosystem.


## What is a Verified Software Unit?

A *verified software unit* (VSU) is a C library that has been proven correct using the [Verified Software Toolchain](https://vst.cs.princeton.edu/).

The theory of VSUs was introduced by *[Verified Software Units](https://link.springer.com/chapter/10.1007/978-3-030-72019-3_5)* ([Beringer](https://www.cs.princeton.edu/~eberinge/) 2021). Examples of how to use VST to build VSUs are given in [Software Foundations Volume 5: Verifiable C](https://softwarefoundations.cis.upenn.edu/vc-current/toc.html).


## What is `coq-vsu`?

A typical VSU consists of a library written in Coq that proves functional correctness of a library written in C.

This unique project structure is not natively supported by `opam`. In particular, `opam` provides no guidance on questions such as *Where should the C library be installed to?* and *How will users configure their compiler to find it?*

`coq-vsu` answers these questions with a single tool: `vsu`, which has the magic ability to locate paths.

For a simple example of `coq-vsu` in action, see [coq-vsu-int63](https://github.com/appliedfm/coq-vsu-int63).


## Example: C library paths

The `vsu -I` command prints a path within the current `opam` switch that is suitable for installing VSU libraries.

```console
$ echo `vsu -I`
/home/tcarstens/.opam/coq-8.14/lib/coq-vsu/lib/include
$
```

One important feature of this design is that it is compatible with the `-I` flag found in `compcert`, `clang`, and `gcc`. For example, the following brings *all* VSU libraries into scope when compiling `main.c`:

    $(CC) -I`vsu -I` main.c


## Example: Coq library paths

### compcert

```console
$ echo `vsu --show-coq-variant-path=coq-compcert`
/home/tcarstens/.opam/coq-8.14/lib/coq/user-contrib/compcert
$ echo `vsu --show-coq-variant-path=coq-compcert-32`
/home/tcarstens/.opam/coq-8.14/lib/coq-variant/compcert32/compcert
```

### vst

```console
$ echo `vsu --show-coq-variant-path=coq-vst`
/home/tcarstens/.opam/coq-8.14/lib/coq/user-contrib/VST
$ echo `vsu --show-coq-variant-path=coq-vst-32`
/home/tcarstens/.opam/coq-8.14/lib/coq-variant/VST32/VST
$
```

### certigraph

```console
$ echo `vsu --show-coq-variant-path=coq-certigraph`
/home/tcarstens/.opam/coq-8.14/lib/coq/user-contrib/CertiGraph
$ echo `vsu --show-coq-variant-path=coq-certigraph-32`
/home/tcarstens/.opam/coq-8.14/lib/coq-variant/CertiGraph32/CertiGraph
$
```


## Example: finding tools

### compcert/ccomp

```console
$ echo `vsu --show-compcert-tool-path=coq-compcert/ccomp`
/home/tcarstens/.opam/coq-8.14/bin/ccomp
$ echo `vsu --show-compcert-tool-path=coq-compcert-32/ccomp`
/home/tcarstens/.opam/coq-8.14/variants/compcert32/bin/ccomp
$
```

### compcert/clightgen

```console
$ echo `vsu --show-compcert-tool-path=coq-compcert/clightgen`
/home/tcarstens/.opam/coq-8.14/bin/clightgen
$ echo `vsu --show-compcert-tool-path=coq-compcert-32/clightgen`
/home/tcarstens/.opam/coq-8.14/variants/compcert32/bin/clightgen
$
```


## Installing

```console
$ opam pin -n -y src
$ opam install coq-vsu
$ vsu --help
```


## Uninstalling

To remove the pin *and* uninstall in one step, simply run

```console
$ opam unpin coq-vsu
```

## Building & running without installing

```console
$ cd src
/src$ dune build
/src$ dune exec ./vsu.exe -- --help
```

#

[![Coq](https://img.shields.io/badge/-Coq-royalblue)](https://github.com/coq/coq)
[![compcert](https://img.shields.io/badge/-compcert-orangered)](https://compcert.org/)
[![VST](https://img.shields.io/badge/-VST-navy)](https://vst.cs.princeton.edu/)

[![applied.fm](https://img.shields.io/badge/-applied.fm-orchid)](https://applied.fm)
