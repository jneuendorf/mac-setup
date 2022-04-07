# mac-setup

A script for setting up a new macos machine for my needs

1. prepare dotfiles
    1. Chrome (or descendant) bookmarks
    1. VSCode Extensions
    1. PyCharm Plugins
       - located in `~/Library/Application Support/JetBrains/PyCharm2021.3` and thus handled by mackup, but `configuration_files` don't include all versions (see https://github.com/lra/mackup/pull/1807)
    1. `defaults`
        - some may be located in `~/Library/Preferences`
1. use mackup
    - enable running from source project instead of assuming homebrew-installed in order to support unofficial sources, i.e. pull requests
1. output standalone executable file using [PyInstaller](https://pyinstaller.readthedocs.io/en/v4.10/usage.html) so that a blank machine can run the setup without installing Python etc. beforehand.



## Usage



### Backup

```bash
./backup
# Custom repo clone
# - The clone must be executable in the same way as https://github.com/lra/mackup.git
./backup 'git@github.com:jneuendorf/mackup.git --branch enable_glob'
```



### Restore

```bash
./restore
```


## Related Projects

- https://github.com/Aerolab/setup
- https://github.com/ptb/mac-setup
- https://github.com/bkuhlmann/mac_os-config
- https://github.com/bkuhlmann/mac_os
- https://github.com/pathikrit/mac-setup-script
- https://github.com/daemonza/setupmac
- https://github.com/wilsonmar/mac-setup
- https://github.com/AkkeyLab/mac-auto-setup
- https://github.com/kaishin/Setup
- https://github.com/andrewconnell/osx-install
- https://git.herrbischoff.com/awesome-macos-command-line/about/
- https://github.com/CodelyTV/dotfiles



## Roadmap

### Backup

- ~~[ ] user account(s)~~
- [x] dot files
- [x] homebrew
- [x] homebrew casks
- ~~[ ] internet accounts (i.e. iCloud and Mail)~~
  - decided, not to sync those, since `mackup` is single-user only
- [x] application configs (e.g. Atom)
- [x] application licenses
  - application specific, thus handled by `mackup`
- [x] syncing unsynced data (e.g. `~/Pictures`)
  - custom `mackup` config can be saved to `~/.mackup/my-files.cfg` specifying any user files (see [Add support for an application or (almost) any file or directory](https://github.com/lra/mackup/tree/master/doc#add-support-for-an-application-or-almost-any-file-or-directory))
- [x] macOS settings (mostly `defaults ...`, see https://github.com/jneuendorf/AdvancedSettingsMacOS)


### Restore

- `...Backup` ;)
- install homebrew: `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
- `xcode-select --install`
- Create new SSH key? See https://github.com/AkkeyLab/mac-auto-setup/blob/master/setup.sh#L24-L28



---



## TSDX User Guide

Congrats! You just saved yourself hours of work by bootstrapping this project with TSDX. Let’s get you oriented with what’s here and how to use it.

> This TSDX setup is meant for developing libraries (not apps!) that can be published to NPM. If you’re looking to build a Node app, you could use `ts-node-dev`, plain `ts-node`, or simple `tsc`.

> If you’re new to TypeScript, checkout [this handy cheatsheet](https://devhints.io/typescript)

### Commands

TSDX scaffolds your new library inside `/src`.

To run TSDX, use:

```bash
npm start # or yarn start
```

This builds to `/dist` and runs the project in watch mode so any edits you save inside `src` causes a rebuild to `/dist`.

To do a one-off build, use `npm run build` or `yarn build`.

To run tests, use `npm test` or `yarn test`.

### Configuration

Code quality is set up for you with `prettier`, `husky`, and `lint-staged`. Adjust the respective fields in `package.json` accordingly.

#### Jest

Jest tests are set up to run with `npm test` or `yarn test`.

#### Bundle Analysis

[`size-limit`](https://github.com/ai/size-limit) is set up to calculate the real cost of your library with `npm run size` and visualize the bundle with `npm run analyze`.

##### Setup Files

This is the folder structure we set up for you:

```txt
/src
  index.tsx       # EDIT THIS
/test
  blah.test.tsx   # EDIT THIS
.gitignore
package.json
README.md         # EDIT THIS
tsconfig.json
```

#### Rollup

TSDX uses [Rollup](https://rollupjs.org) as a bundler and generates multiple rollup configs for various module formats and build settings. See [Optimizations](#optimizations) for details.

#### TypeScript

`tsconfig.json` is set up to interpret `dom` and `esnext` types, as well as `react` for `jsx`. Adjust according to your needs.

### Continuous Integration

#### GitHub Actions

Two actions are added by default:

- `main` which installs deps w/ cache, lints, tests, and builds on all pushes against a Node and OS matrix
- `size` which comments cost comparison of your library on every pull request using [`size-limit`](https://github.com/ai/size-limit)

### Optimizations

Please see the main `tsdx` [optimizations docs](https://github.com/palmerhq/tsdx#optimizations). In particular, know that you can take advantage of development-only optimizations:

```js
// ./types/index.d.ts
declare var __DEV__: boolean;

// inside your code...
if (__DEV__) {
  console.log('foo');
}
```

You can also choose to install and use [invariant](https://github.com/palmerhq/tsdx#invariant) and [warning](https://github.com/palmerhq/tsdx#warning) functions.

### Module Formats

CJS, ESModules, and UMD module formats are supported.

The appropriate paths are configured in `package.json` and `dist/index.js` accordingly. Please report if any issues are found.

### Named Exports

Per Palmer Group guidelines, [always use named exports.](https://github.com/palmerhq/typescript#exports) Code split inside your React app instead of your React library.

### Including Styles

There are many ways to ship styles, including with CSS-in-JS. TSDX has no opinion on this, configure how you like.

For vanilla CSS, you can include it at the root directory and add it to the `files` section in your `package.json`, so that it can be imported separately by your users and run through their bundler's loader.

### Publishing to NPM

We recommend using [np](https://github.com/sindresorhus/np).
