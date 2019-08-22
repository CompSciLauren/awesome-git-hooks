# Contribution Guidelines

Please note that this project is released with a [Contributor Code of Conduct](CODE-OF-CONDUCT.md). By participating in this project you agree to abide by its terms.

Contributions are *always* welcome! Please ensure you follow the guidelines explained below. Thank you!

## Pull Requests

- Search previous pull requests before making a new one, as yours may be a duplicate.
- Keep pull request title short and simple, but descriptive.
- Keep descriptions short and simple, but descriptive.
- Check your spelling and grammar.

## Adding a New Git Hook

Hooray! We like these a lot. These are the requirements for adding a new Git hook.

- Format the beginning of the hook file like this:

```
#[!/bin/bash or other shebang]
# Based on a hook from [title of source]
# Source: [https://www.website.com/]
#
# This sentence describes in simple terms what the git hook is actually doing.
#
# The hook should exit with non-zero status after issuing an appropriate
# message if it stops the [git command]. (If your script doesn't do this then you can remove this section)
#
# Requirements: 
#   * Python 2/3 (whatever language the script is written in)
#
# To enable this hook, rename this file to "[type of git hook]".

// code for actual hook goes here
```

- Add a comment above each body/section of code to explain what it's doing.
- Add additional comments as needed.
- Add it to the list of Git Hook Scripts on the readme, following the existing formatting.

## Adding Anything Else

Have something to contribute that isn't a Git hook? We love all forms of friendly contributions! Feel free to make a change to the readme or other files and create a pull request, or you can [create a new issue](https://github.com/CompSciLauren/awesome-git-hooks/issues/new?assignees=&labels=enhancement&template=feature_request.md&title=) to discuss any proposals/feedback/thoughts/etc.

## How to Contribute

To fix a bug or add an enhancement, follow these steps:

- Fork the repo
- Create a new branch (`git checkout -b improve-feature`)
- Make the appropriate changes in the files
- Commit your changes (`git commit -am 'Improve feature'`)
- Push to the branch (`git push origin improve-feature`)
- Create a Pull Request
