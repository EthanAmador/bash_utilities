## Before to use read this :point_down:

1.  _For a better experience of use, please install and configure [zsh](https://ohmyz.sh/) and [jq](https://formulae.brew.sh/formula/jq)_

2.  Before needs aws credetials configured. for this, check if exist this route `~/.aws` and these files `config` and `credentials`, files examples :point_down:

```sh
    # config file
    [default]
    region = us-east-1
    output = json
    [profile profile-name]
    output = json
    region = us-east-1

    # credentials file
    [prod-ceb]
    aws_access_key_id = XxxXXX
    aws_secret_access_key = ABC!@#123
    [default]
    aws_access_key_id = XxxXXX
    aws_secret_access_key = ABC!@#123
```

# How to configure.

1. Download all `.sh` files and save in the same path.

   ### _if you uses zsh follow these steps to create a alias for the commands_

   - In the file `~/.zshrc` add these alias

   ```sh
   alias aws_get_secret="~/pathFile/./aws_get_secret_values.sh"
   alias aws_put_secret="~/pathFile/./aws_put_secret_values.sh"
   ```

   - Restart de terminal o execute this command `source ~/.zshrc`

2. Give permission to execute to all scripts, for this execute this command
   ```sh
       cd ~/pathFile && chmod +x *.sh
   ```

---

# How to use

- zsh users:

  - to get secret: excute this alias `aws_get_secret` for example.
    ```sh
    aws_get_secret [secrets name] [profile-name]
    # example
    aws_get_secret dev/yours_service dev-ec
    ```
  - to put secret: excure this alias `aws_put_secret` for example.
    ```sh
        aws_put_secret [secrets name] [profile-name] [path .json file]
        #example
        aws_put_secret dev/yours_service dev-ec ~/path/environments/environment.json
    ```

- other users
  - to get secret: excute this alias `aws_get_secret_values.sh` for example.
    ```sh
        sh aws_get_secret_values.sh [secrets name] [profile-name]
        # example
        sh aws_get_secret_values.sh dev/yours_service dev-ec
    ```
  - to put secret: excure this alias `aws_put_secret_values.sh` for example.
    ```sh
        sh aws_put_secret_values.sh [secrets name] [profile-name] [path .json file]
        #example
        sh aws_put_secret_values.sh dev/yours_service dev-ec ~/path/environments/environment.json
    ```

# Enjoy :smiley:
