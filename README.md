# DataURI

A Ruby gem that converts files or file-like objects to data URI strings suitable for use in HTML elements.

## Installation

### Gemfile way (preferred)

Add this line to your application's Gemfile:

```ruby
gem "data_uri", "< 1.0.0"
```

And then, at a command prompt:

```
bundle install
```

### Direct way

Or, install it directly with:

```
gem install data_uri
```

## Usage

```ruby
# With a file path
data_uri = DataURI.new("path/to/image.jpg")
data_uri.to_s # => "data:image/jpeg;base64,..."

# With a file-like object (anything that responds to `read`)
file = File.open("image.png")
data_uri = DataURI.new(file)
data_uri.to_s # => "data:image/png;base64,..."

# Direct use in HTML
# <img src="<%= DataURI.new('logo.png').to_s %>">
```

### Supported Input Types

- **File paths**: Pass a string with a path to a local image file.
- **File-like objects**: Pass an object that responds to `read` (like `File.open("image.jpg")` or a Rails uploaded file).

## License

This gem is available as open source under the terms of the [MIT License](LICENSE).
