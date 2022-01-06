# README

This is a dinky little shopping cart app. You load products into it via Rails.root/products.json.

## Environment settings

I used Ruby 3.0.2 and Rails 7.0.0. Yes this is arguably overkill, but I'd been wanting to brush up on the basics of Rails 7 for a while now, and figured why not kill two birds with one stone?

## App preparation

You'll need to prepare the app first. I created a simple Rake task for this. Just simply run `rake prepare_app`.

## App running

Now just run `bin/dev` (Rails 7's new Foreman-friendly syntax), and load localhost:3000 in your nearest browser. The app will take things from there.