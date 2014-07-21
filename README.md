wintersmith-csv
===============

[![Dependency Status](https://david-dm.org/xdarklight/wintersmith-sandbox.svg)](https://david-dm.org/xdarklight/wintersmith-sandbox)

A [Wintersmith](https://github.com/jnordberg/wintersmith) plugin for dynamically reading data provided by JavaScript files/snippets.
The script will run inside a [sandbox](http://gf3.github.com/sandbox/).

The data provided by the script will be available in the content tree. It's added as `data` on the file's object.

## Installing

Install globally or locally using `npm`:

```
npm install [-g] wintersmith-sandbox
```

and add `wintersmith-sandbox` to your config.json

```json
{
  "plugins": [
    "wintersmith-sandbox"
  ]
}
```

## Author

© 2014 Martin Blumenstingl

## License

Released under the [MIT License](http://tlvince.mit-license.org).
