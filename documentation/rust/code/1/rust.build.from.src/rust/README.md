# What is this ?

Its a Docker image to build from source the `rustc` compiler version `1.61.0` (and its system library with all primitives)

I just use unchanged the `config.example.toml` cofiguration for the build

>
> When complete, `./x.py install` will place several
> programs into `$PREFIX/bin`: `rustc`, the Rust compiler, and `rustdoc`, the API-documentation tool.
> This install does not include `Cargo`, Rust's package manager.
> To build and install `Cargo`, you may run `./x.py install cargo` or set the `build.extended` key in config.toml to true to build and install all tools.

Note that in `config.alltools.toml`, I set the `build.extended` key to true, to build and install all tools.inluding cargo ?

Quoting  the `config.toml` :

```Toml
# Enable a build of the extended Rust tool set which is not only the compiler
# but also tools such as Cargo. This will also produce "combined installers"
# which are used to install Rust and Cargo together. This is disabled by
# default. The `tools` option (immediately below) specifies which tools should
# be built if `extended = true`.
#extended = false
```

## References

* https://github.com/rust-lang/rust/tree/1.61.0#building-on-a-unix-like-system
