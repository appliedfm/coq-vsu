coq-vsu
=======

Tools for working with Verified Software Units.

.. note:: This is a work in progress! We welcome feedback and pull requests. `Find us on GitHub <https://github.com/appliedfm/coq-vsu>`_.


What is a Verified Software Unit?
---------------------------------

A *verified software unit* (VSU) is a C library that has been proven correct using the `Verified Software Toolchain <https://vst.cs.princeton.edu/>`_.

The theory of VSUs was introduced by `Verified Software Units (Beringer, 2021) <https://link.springer.com/chapter/10.1007/978-3-030-72019-3_5>`_. Examples of how to use VST to build VSUs are given in `Software Foundations Volume 5: Verifiable C <https://softwarefoundations.cis.upenn.edu/vc-current/toc.html>`_.

What is `coq-vsu`?
------------------

A typical VSU consists of a library written in Coq that proves functional correctness of a library written in C.

This unique project structure is not natively supported by `opam`. In particular, `opam` provides no guidance on questions such as *Where should the C library be installed to?* and *How will users configure their compiler to find it?*

`coq-vsu` answers these questions with a single tool: `vsu`, which has the magic ability to locate paths.

For a simple example of `coq-vsu` in action, see `coq-vsu-int63 <https://coq-vsu-int63.readthedocs.io/>`_.
