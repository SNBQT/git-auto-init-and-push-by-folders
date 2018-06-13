# Auto init and push project by folders 
requre pypinyin to transfer Chinese hanzi to pinyin for projectPath. It will auto install in the code or run 

```
pip install pypinyin
```

## How to config and use?

1. download
    ```
    git clone https://github.com/SNBQT/git-auto-init-and-push-by-folders.git
    cd git-auto-init-and-push-by-folders
    ```

1. config `.env` file by run below
    ```
    cp .env.example .env
    vi .env
    ```

    ```
    # Init params
    username=xx 
    useremail=xx@xxx.xx
    password=xxxxxx
    accesstoken=xxx

    # Group path, id
    grouppath=test-group
    grouppathId=35

    # domain or host
    domain=127.0.0.1:8888
    ```

1. acquire accesstoken

    ![](doc/1.png)

    ![](doc/2.png)

    ![](doc/3.png)
    
1. acquire Group path, id


    ![](doc/7.png)

    ![](doc/4.png)

    ![](doc/5.png)

    ![](doc/6.png)

1. The edit sample of `.env` file as below

    ```
    # Init params
    username=123
    useremail=12@12.12
    password=123456
    accesstoken=123456789

    # Group path, id
    grouppath=test-group
    grouppathId=616

    # domain:port or host:port
    domain=mekhub.cn
    ```



3. run code

```
./init-and-push.sh
```



### Issue: GitLab issuing temporary IP bans - 403 forbidden

Example configuration in /etc/gitlab/gitlab.rb:
```
gitlab_rails['rack_attack_git_basic_auth'] = {
  'enabled' => true,
  'ip_whitelist' => ["192.168.123.123", "192.168.123.124"],
  'maxretry' => 10,
  'findtime' => 60,
  'bantime' => 600
}
```
In this example, we are whitelisting the servers 192.168.123.123 and 192.168.123.124, and adjusting down the ban time from one hour to 10 minutes (600 seconds). maxretry = 10 allows a user to get the password wrong 10 times before ban, and findtime = 60 means that the failed attempts counter resets after 60 seconds.


**Ref:**

* https://stackoverflow.com/questions/36298959/gitlab-issuing-temporary-ip-bans-403-forbidden