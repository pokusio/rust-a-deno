#[macro_use] extern crate rocket;

#[get("/")]
fn index() -> &'static str {
    "I am a Pokus Rocket, Yea!"
}

#[launch]
fn rocket() -> _ {
    rocket::build().mount("/", routes![index])
}
