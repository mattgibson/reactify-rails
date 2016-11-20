[![Travis build status](https://travis-ci.org/mattgibson/reactify-rails.svg?branch=master)](https://travis-ci.org/mattgibson/reactify-rails)

# Reactify::Rails
Reactify exists to make starting a new [Rails](http://rubyonrails.org/) app with 
[React](https://facebook.github.io/react/) and [Redux](http://redux.js.org/) easy. 
It provides a
series of Rails generators that will first set up your project to be able to 
use modern JavaScript, and then add React/Redux boilerplate when you run Rails
scaffold generators.

Inevitably it takes an opinitionated approach, with the following attitudes:

* Javascript should be a first class citizen in your app. Rather than running 
it through Ruby first via Sprockets, Reactify sets up 
[Webpack](https://webpack.github.io/) so that everything
happens via npm. This completely bypasses Sprockets and allows the 
Webpack code
to peacefully coexist with whatever Sprockets stuff you might already have. All
of the JavaScript will live in `/webpack` in order to keep it totally separate
from the rest of the app.
* Modern JavaScript is worth learning and using. Webpack allows us to easily 
use [Babel](https://babeljs.io/) to transpile ES6/7, so this is set up from the 
Start. We also have instant access to everything that npm has to offer.
* Live reloading of JS and CSS is a huge time saver. This is also set up out of 
the box using [react-hot-loader V3](https://github.com/gaearon/react-hot-loader)
* The best approach to using React and Rails is ultimately to have a single page
app (SPA) talking to a Rails API. However, this is a pain to set up initially, so the
approach Reactify takes is as follows
  * Rails is set up to respond to all HTML requests that have no template in `app/views`
  with a default template in `app/views/reactify/spa_html.erb`. This renders a 
  single page React/Redux app, which incorporates all the `@variables` that would
  normally be sent to the view template, so that the Redux store can access them
  * The SPA will pre-render the app based on the url params, so there is no flicker
  whilst the end user waits for JavaScript to load, and no problem with SEO. This 
  also incorporates the `@variables` so the approach is truly universal
  * Each controller action will respnd to JSON requests by automatically sending
  the `@variables` as JSON, allowing the SPA to function properly 
* When the time comes, it should be very easy to separate the SPA into its own
[node](https://nodejs.org/en/) app. This is easily done as the `/webpack` folder 
is entirely self contained (TODO: instructions below).

## Installation and usage

### For a new project

Run `rails new` with your favourite settings, then `cd` into the directory and 
continue as below.

### For an existing project

Reactify-Rails is intended to work alongside your existing sprockets javascipt.
You can safely install it over the top of an existing Rails app and everything
else should continue to work perfectly. Be sure sure to commit your work to
source control before running the generator though, and run `git diff` (or whatever)
to make sure you know what it's done!

Add this line to your application's Gemfile:

```ruby
gem 'reactify-rails'
```

And then execute:
```bash
$ bundle install
```

Or install it yourself as:
```bash
$ gem install reactify-rails
```

Then, run the install generator (commit your files to source control first!)
```bash
$ bundle exec rails g reactify:install
```

This will add a bunch of stuff to your Rails project, most of which is in
`/webpack`.

## Running it

```bash
$ cd myproject
$ foreman start
```

Now you can find the app at `http:://localhost:3000`

## Precompiling the assets in production
 
As we are not using Sprockets, you will need to tell yoir deployment tool to 
build the assets on each deploy. On Heroku, this happens automatically as it 
reads `package.json` and sees the `postinstall` task, but otherwise, run this 
command: `npm run postinstall` as part of your deploy process.


## Contributing
Contributions are very much welcomed, but please follow the procedure below:

1. File an issue on Github outlining what you are intending. Some new features may
not be a good fit for the gem and may be better off in their own gem (I'm trying to 
keep this one as lightweight as possible). Similarly, what appears to be bug may 
occasionally turn out to be deliberate in order to cover non-obvious edge cases. 
Better to check first before you spend valuable time writing code! Assuming the 
response to your issue is positive:
2. Fork the repo on Github
3. Create a new branch against master
4. Write tests (first!)
5. Write code until the tests pass
6. Push your code and file a pull request

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
