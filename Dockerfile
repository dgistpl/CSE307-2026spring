FROM ocaml/opam:ubuntu-24.04-ocaml-5.2

USER root

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    m4 \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Switch back to opam user
USER opam

# Update opam and install useful OCaml tools
RUN opam update && \
    opam install -y \
    ocaml-lsp-server \
    ocamlformat \
    utop \
    dune \
    && opam clean -a -c -s --logs

# Set working directory
WORKDIR /home/opam/workspace

# Set default command
CMD ["bash"]
