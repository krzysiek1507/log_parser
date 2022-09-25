## Installation

You need ruby 2.7+ to run this program.

1. Go to https://rvm.io/ and install relevant version
2. run `bundle` in the project directory
3. You should be ready!

## Running

`bin/run.rb` file can be used to run the program. It takes just one argument, which is the location of the log file.

Example:

`bin/run.rb webserver.log`

The output should look like:
```
Pages ordered descending by page views
/about/2 90 visit(s)
/contact 89 visit(s)
/index 82 visit(s)
/about 81 visit(s)
/help_page/1 80 visit(s)
/home 78 visit(s)

Pages ordered descending by unique page views
/contact 23 unique view(s)
/help_page/1 23 unique view(s)
/home 23 unique view(s)
/index 23 unique view(s)
/about/2 22 unique view(s)
/about 21 unique view(s)
```

## Testing

We use `rspec` for the tests so you can just type `rspec` in your console.
