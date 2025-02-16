# [Envchain](https://github.com/sorah/envchain)

Use envchain for all secret environment variables

## Install

```
brew install envchain
```

## Usage

- set your environment variable like this

```
envchain --set <namespace> <envvar>
```

- use this var by chaining envchain with your command

```
envchain <namespace> [CMD]
```

If you want to have the same environment variable name but contain different values depending on the context (aka, namespace), create different namespaces. This is useful for something like $PGPASSWORD where you'd want a different PGPASSWORD per environment

Example:

```
envchain --set production PGPASSWORD
envchain --set staging PGPASSWORD
```

then psql commands can be written like this

```
envchain production psql....
envchain staging psql....
```
