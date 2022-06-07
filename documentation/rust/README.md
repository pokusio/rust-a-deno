# Rust


Here you will find all my notes about the `Rust` programming language.

The `Rust` programming language is developed in `Python`.

https://github.com/rust-lang/rust


## Installing Rust

I read :
* https://www.rust-lang.org/learn/get-started


### `Rustup`: the Rust installer and version management tool

Rust updates very frequently.
If you have installed Rustup some time ago, chances are your Rust version is out of date.
Get the latest version of Rust by running :

```bash
rustup update
```

Install `Rustup` :

* Method 1 :

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

* Method 2 (to install a fixed version of Rustup) :

```bash
# I don't have yet found a method to install a fixed version of Rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | tee documentation/rust/code/1/rustup/install.sh

# Right, now, you will see for yourself that the shell script above, is really complex, and in particular, it is not endowed with any environment variable which would allow to set the Rust version you want to install.
# Never the less, Rust can be built from source, as mentioned https://github.com/rust-lang/rust#building-on-a-unix-like-system

# Buildinng from source best metjhod in my opinion is to do that into a container
# https://github.com/rust-lang/rust#building-on-a-unix-like-system

#   ./rust.build.from.src.Dockerfile


```


Following Method 1, I get an interactactive execution, and the following output :

```bash
~/rust-a-deno$ curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
info: downloading installer

Welcome to Rust!

This will download and install the official compiler for the Rust
programming language, and its package manager, Cargo.

Rustup metadata and toolchains will be installed into the Rustup
home directory, located at:

  /home/jbl/.rustup

This can be modified with the RUSTUP_HOME environment variable.

The Cargo home directory located at:

  /home/jbl/.cargo

This can be modified with the CARGO_HOME environment variable.

The cargo, rustc, rustup and other commands will be added to
Cargo's bin directory, located at:

  /home/jbl/.cargo/bin

This path will then be added to your PATH environment variable by
modifying the profile files located at:

  /home/jbl/.profile
  /home/jbl/.bashrc

You can uninstall at any time with rustup self uninstall and
these changes will be reverted.

Current installation options:


   default host triple: x86_64-unknown-linux-gnu
     default toolchain: stable (default)
               profile: default
  modify PATH variable: yes

1) Proceed with installation (default)
2) Customize installation
3) Cancel installation
>

info: profile set to 'default'
info: default host triple is x86_64-unknown-linux-gnu
info: syncing channel updates for 'stable-x86_64-unknown-linux-gnu'
699.8 KiB / 699.8 KiB (100 %) 578.0 KiB/s in  1s ETA:  0s
info: latest update on 2022-05-19, rust version 1.61.0 (fe5b13d68 2022-05-18)
info: downloading component 'cargo'
  6.4 MiB /   6.4 MiB (100 %) 625.5 KiB/s in 10s ETA:  0s
info: downloading component 'clippy'
  2.7 MiB /   2.7 MiB (100 %) 663.7 KiB/s in  4s ETA:  0s
info: downloading component 'rust-docs'
 19.7 MiB /  19.7 MiB (100 %) 535.3 KiB/s in 30s ETA:  0s
info: downloading component 'rust-std'
 26.9 MiB /  26.9 MiB (100 %) 618.2 KiB/s in 52s ETA:  0s
info: downloading component 'rustc'
 55.4 MiB /  55.4 MiB (100 %) 686.0 KiB/s in  1m 24s ETA:  0s
info: downloading component 'rustfmt'
  4.0 MiB /   4.0 MiB (100 %) 719.6 KiB/s in  6s ETA:  0s
info: installing component 'cargo'
info: installing component 'clippy'
info: installing component 'rust-docs'
 19.7 MiB /  19.7 MiB (100 %)   6.8 MiB/s in  2s ETA:  0s
info: installing component 'rust-std'
 26.9 MiB /  26.9 MiB (100 %)  12.1 MiB/s in  4s ETA:  0s
info: installing component 'rustc'
 55.4 MiB /  55.4 MiB (100 %)  13.6 MiB/s in  5s ETA:  0s
info: installing component 'rustfmt'
info: default toolchain set to 'stable-x86_64-unknown-linux-gnu'

  stable-x86_64-unknown-linux-gnu installed - rustc 1.61.0 (fe5b13d68 2022-05-18)


Rust is installed now. Great!

To get started you may need to restart your current shell.
This would reload your PATH environment variable to include
Cargo's bin directory ($HOME/.cargo/bin).

To configure your current shell, run:
source $HOME/.cargo/env


```

* After finishing the installation, we need to open a new Shell session, in order to get the updated environment :

```bash
~/rust-a-deno$ rustc --version
rustc 1.61.0 (fe5b13d68 2022-05-18)
~/rust-a-deno$ rustup --version
rustup 1.24.3 (ce5817a94 2021-05-31)
info: This is the version for the rustup toolchain manager, not the rustc compiler.
info: The currently active `rustc` version is `rustc 1.61.0 (fe5b13d68 2022-05-18)`
~/rust-a-deno$ rustup --help
rustup 1.24.3 (ce5817a94 2021-05-31)
The Rust toolchain installer

USAGE:
    rustup [FLAGS] [+toolchain] <SUBCOMMAND>

FLAGS:
    -v, --verbose    Enable verbose output
    -q, --quiet      Disable progress output
    -h, --help       Prints help information
    -V, --version    Prints version information

ARGS:
    <+toolchain>    release channel (e.g. +stable) or custom toolchain to set override

SUBCOMMANDS:
    show           Show the active and installed toolchains or profiles
    update         Update Rust toolchains and rustup
    check          Check for updates to Rust toolchains and rustup
    default        Set the default toolchain
    toolchain      Modify or query the installed toolchains
    target         Modify a toolchain's supported targets
    component      Modify a toolchain's installed components
    override       Modify directory toolchain overrides
    run            Run a command with an environment configured for a given toolchain
    which          Display which binary will be run for a given command
    doc            Open the documentation for the current toolchain
    man            View the man page for a given command
    self           Modify the rustup installation
    set            Alter rustup settings
    completions    Generate tab-completion scripts for your shell
    help           Prints this message or the help of the given subcommand(s)

DISCUSSION:
    Rustup installs The Rust Programming Language from the official
    release channels, enabling you to easily switch between stable,
    beta, and nightly compilers and keep them updated. It makes
    cross-compiling simpler with binary builds of the standard library
    for common platforms.

    If you are new to Rust consider running `rustup doc --book` to
    learn Rust.

~/rust-a-deno$ cargo --version
cargo 1.61.0 (a028ae4 2022-04-29)
~/rust-a-deno$ cargo --help
Rust's package manager

USAGE:
    cargo [+toolchain] [OPTIONS] [SUBCOMMAND]

OPTIONS:
    -V, --version               Print version info and exit
        --list                  List installed commands
        --explain <CODE>        Run `rustc --explain CODE`
    -v, --verbose               Use verbose output (-vv very verbose/build.rs output)
    -q, --quiet                 Do not print cargo log messages
        --color <WHEN>          Coloring: auto, always, never
        --frozen                Require Cargo.lock and cache are up to date
        --locked                Require Cargo.lock is up to date
        --offline               Run without accessing the network
        --config <KEY=VALUE>    Override a configuration value (unstable)
    -Z <FLAG>                   Unstable (nightly-only) flags to Cargo, see 'cargo -Z help' for
                                details
    -h, --help                  Print help information

Some common cargo commands are (see all commands with --list):
    build, b    Compile the current package
    check, c    Analyze the current package and report errors, but don't build object files
    clean       Remove the target directory
    doc, d      Build this package's and its dependencies' documentation
    new         Create a new cargo package
    init        Create a new cargo package in an existing directory
    run, r      Run a binary or example of the local package
    test, t     Run the tests
    bench       Run the benchmarks
    update      Update dependencies listed in Cargo.lock
    search      Search registry for crates
    publish     Package and upload this package to the registry
    install     Install a Rust binary. Default location is $HOME/.cargo/bin
    uninstall   Uninstall a Rust binary

See 'cargo help <command>' for more information on a specific command.

```

* When the installation process is complete, we have installed all the following exacutables (oh a debugger ... `rust-gdb`... ):

```bash
~/rust-a-deno$ rust
rustc      rustdoc    rustfmt    rust-gdb   rust-lldb  rustup
```
* `rustc` : the `Rust` compiler excutable
* `rustdoc` : to generate docuementation from comments and maybe other kind of source code meta data
* `rustfmt` : oh its a code formatter (a bit like prettier) https://github.com/rust-lang/rustfmt
* `rust-gdb` : obviously a debugger, obviously for linux targets and gdb debugger.
* `rust-lldb` : that's debugging tool, apparently related to Apple IOS targets, see https://docs.rs/lldb/latest/lldb/ https://rustc-dev-guide.rust-lang.org/debugging-support-in-rustc.html
* `rustup` : the `Rust` recommended installer and version manager (a bit like `nvm` ).

So okay, there are 4 main things installed, which seem to be the minimal, consistent toolchain to work with the `Rust` programming language :
* `rustc` : the `Rust` compiler excutable
* `rustup` : the `Rust` recommended installer and version manager (a bit like `nvm` ).
* `cargo` : the `Rust` package manager (helps managing installed rust libraries, how they are installed, like `npm` ).


To check our installation is fine :

* Run :

```bash
rustup default stable
```
* And if everything ok you should have this kind of Std Output :

```bash
$ rustup default stable
info: using existing install for 'stable-x86_64-unknown-linux-gnu'
info: default toolchain set to 'stable-x86_64-unknown-linux-gnu'

  stable-x86_64-unknown-linux-gnu unchanged - rustc 1.61.0 (fe5b13d68 2022-05-18)

```

## A few remarks about the Rust project's CI/CD

I want to know how to build from source all three `rustc` and `rustup` and `cargo` :

* They are all 3 developed in the Python programming language
* `rustc` : https://github.com/rust-lang/rust
* `rustup` : https://github.com/rust-lang/rustup
* `cargo` : https://github.com/rust-lang/cargo
* I will also automate the build from source of another tool used in the CI/CD of `Rust`:
  * https://github.com/rust-lang/triagebot
  * because to be fully open source, a project needs its own CICD to be 100% Open source too. That is why I will completely re-design the CICD of the `rust-lang` Github Organization, unsing https://tekton.dev
  * it obviously is a bot that automates triage tasks on github issues
  * it is an interesting tool i want to study as a concept later : what are the different kinds of traige bots on the market, how do I deploy them, etc...

As mentioned above, a project truly is open source, when its CI/CD itself is fully open source (you can at least provision the full CICD in an entirely, isolated from the Internet, private infrsastructure).

Also looking at CI / CD used in the `Rust` project's git repos themselves, is always a good idea : It tells you how the men behind Rust think and work, and that helps a lot understanding why they did this or that, or why such a fact is a fact, in the Rust world.


So Let's gather first things i notice when browsing the git repos at https://github.com/rust-lang/ :

* They use a triage bot developed themselves, using the Rust programming language : https://github.com/rust-lang/triagebot
* the `rustc` compiler source code is in the https://github.com/rust-lang/rust, but :
  * `rustc` is not the only binary that gets built from the source code versioned in https://github.com/rust-lang/rust
  * in the https://github.com/rust-lang/rust repository, at the `1.61.0` git tag :
    * the `compiler` folder contains the source code of the rust compiler,
    * and the `library` folder contains the source code of the system library for all builtin libraries of the rust programming language, for example the [`std` `io` library](https://github.com/rust-lang/rust/tree/1.61.0/library/std)
  * `rustc` and its associated system library source code is in the `Python` programming Language
  * `rustup` and `cargo` source codes are in the **Rust** programming language :
    * `rustup` : https://github.com/rust-lang/rustup
    * `cargo` : https://github.com/rust-lang/cargo


In the https://github.com/rust-lang/triagebot repo, we see :
* that there is no tags at all : the version iused obviously is the latest commit on `master` period.
* that there is a Docekrfile, in which we can find the build from souyrce recipe to build from source the triagebot in the Rust programming language.



## language

I will first learn the rust language basics, and will then go into learning one rust language framework, https://rocket.rs/ ( a web app framework for rust)


### Language basics

#### First basics, understanding the technology stack

#### Installing Rust



## Deno


## References


### `Rust`

* https://www.rust-lang.org/
* https://rocket.rs/


### `deno`





## ANNEX A : mdbook

Omy, they even implemented a git based headless CMS, "like gitbook, but in rust" :

https://github.com/rust-lang/mdBook

I wanna try that one guy, compare with hugo, etc..
