# Homebrew Tap for Mull

[Mull](https://github.com/mull-project/mull) is a practical mutation testing tool for C and C++.

## Installation

```bash
brew tap mull-project/mull
brew install mull@19   # or mull@16, mull@17, mull@18, mull@20
```

### Development Builds

```bash
# Nightly builds (from main branch)
brew install mull-nightly@19

# Testing builds (from PRs)
brew install mull-testing@19
```

## Usage

```bash
# Run mutation testing
mull-runner-19 --help

# Generate reports
mull-reporter-19 --help

# Use the Clang plugin
clang -fpass-plugin=$(brew --prefix)/lib/mull-ir-frontend-19 your_code.c
```

## Maintaining This Tap

Formulas are generated from the main [mull repo](https://github.com/mull-project/mull). Config comes from `MODULE.bazel`.

```bash
# In the mull repo:
bazel run //infrastructure:generate-homebrew-formulas -- /path/to/homebrew-mull
```

URL and SHA256 are updated automatically when packages are published to Cloudsmith.

## Support

[Main Mull Repository](https://github.com/mull-project/mull/issues)
