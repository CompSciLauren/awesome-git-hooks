# Contribution Guidelines

Please note that this project is released with a [Contributor Code of Conduct](CODE-OF-CONDUCT.md). By participating in this project you agree to abide by its terms.

Please ensure your pull request adheres to the following guidelines:

- Search previous pull requests before making a new one, as yours may be a duplicate.
- Keep pull request title short and simple, but descriptive.
- Keep descriptions short and simple, but descriptive.
- Check your spelling and grammar.

Requirements for adding a new git hook:

- Format the beginning of the hook file like this:

```
#[!/bin/sh or other shebang]
# Based on a hook from [title of source]
# Source: [https://www.website.com/]
#
# This sentence describes in simple terms what the git hook is actually doing.
#
# The hook should exit with non-zero status after issuing an appropriate
# message if it stops the [git command].
#
# To enable this hook, rename this file to "[type of git hook]".

// code
```

- Add a comment above each body/section of code to explain what it's doing.
- Add additional comments as needed.
- If you choose not to follow one of the requirements listed, please explain your reasoning.

To fix a bug or add an enhancement, follow these steps:

- Fork the repo
- Create a new branch (`git checkout -b improve-feature`)
- Make the appropriate changes in the files
- Commit your changes (`git commit -am 'Improve feature'`)
- Push to the branch (`git push origin improve-feature`)
- Create a Pull Request

Thank you!
