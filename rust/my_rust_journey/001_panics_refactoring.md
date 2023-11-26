# Panics refactoring

## Problem statement

How many lines of code in your project have `.expect()` or `panic!()` or `.unwrap()`? Or when should we use **unrecoverable** error that will immediately stop the execution?

## Ideas for improvements

It wouldn't hurt to avoid `.unwrap()` in anycase, since it's just a comentless interruption and `.expect()` is essentially `.unwrap()` with a message.

The alternative would be to return `Result` type and meaningful error type, and even propage errors with `?`.

## Action

Where you can use `.expect`?
- `Result` > you can replace it with `?`
- `Option` > convert `Option` to `Result` with `.ok_or()` and then `?`

