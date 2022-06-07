# First dive into the Rocket.rs Framework

You will read under there, the few tests i made with Rocket.rs and my conclusion came quick :

* The framework seems reliable, but the project too young,
* the project comunity too small yet to rely on support long term
* the demoed example apps are not convincing enough
* there are no examples about how to make APIs, how to add OAuth etc...
* I found other web frameworks which seem much more widely adopted, like https://github.com/actix/actix-web
* SO i will now switch to ry a first time https://github.com/actix/actix-web


## Quick start

I read : https://rocket.rs/v0.5-rc/guide/quickstart/#running-examples

I start a first example app, to check my entire system is fine for working with `Rocket.rs` framework :

```bash
# ensure the latest toolchain is installled by running the command:
rustup default stable

git clone https://github.com/SergioBenitez/Rocket example1/
cd example1/
git checkout v0.5-rc
cd examples/hello
cargo run
```


### Create my first app from scratch

I read : https://rocket.rs/v0.5-rc/guide/getting-started/

I assume all the Rust toolchain installed

I work with Rust `1.61.0`, and successfully launched a new Rocket.rs app like this :

```bash
mkdir exampleRocket2/
cd exampleRocket2/

# ensure the latest toolchain is installled by running the command:
rustup default stable

# first create the project
cargo new pokus-rocket --bin
cd ./pokus-rocket/

cat <<EOF>./Cargo.toml
[package]
name = "pokus-rocket"
version = "0.0.0"
# workspace = "./"
edition = "2021"
publish = false

[dependencies]
# add Rocket as a dependency
rocket = "0.5.0-rc.2"
# To depend on a specific version of a dependency like the Rocket.rs framework itself :
# rocket = { git = "https://github.com/SergioBenitez/Rocket", rev = "${ROCKET_RS_GIT_COMMIT_HASH}" }
EOF

cat <<EOF>./src/main.rs
#[macro_use] extern crate rocket;

#[get("/")]
fn index() -> &'static str {
    "Hello, world!"
}

#[launch]
fn rocket() -> _ {
    rocket::build().mount("/", routes![index])
}
EOF

cargo run

```
