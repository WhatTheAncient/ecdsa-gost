# Description

This project is a simple implementation of Russian Federation's "ГОСТ Р 34.10-2012" standard of Elliptic Curve Digital Signature Algorithm.

To run the project, follow this instructions:
- Copy .env.sample into .env (`cp .env.sample .env`)
- Set curve params in .env (optional)
- Run app with `docker run --rm -it $(docker build -q .)` command