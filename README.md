# file_to_data_uri

A Ruby gem that converts files or file-like objects to data URI strings (e.g. image files to strings suitable for use as the `src` of an `<img>`).

## Installation

### Gemfile way (preferred)

Add this line to your application's Gemfile:

```ruby
gem "file_to_data_uri", "< 1.0.0"
```

And then, at a command prompt:

```
bundle install
```

### Direct way

Or, install it directly with:

```
gem install file_to_data_uri
```

## Usage

```ruby
# With a file path
@data_uri = DataURI.convert("path/to/image.jpg") # => "data:image/jpeg;base64,..."

# With a file-like object, e.g. an uploaded file
@data_uri = DataURI.convert(params[:image]) # => "data:image/png;base64,..."

# Then you can use it in an ERB template
# <img src="<%= @data_uri %>">
```

### Supported Input Types

- **File paths**: Pass a string with a path to a local file.
- **File-like objects**: Pass an object that responds to `read` (like `File.open("image.jpg")` or a Rails uploaded file).

## License

This gem is available as open source under the terms of the [MIT License](LICENSE).
