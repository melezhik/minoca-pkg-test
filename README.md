# SYNOPSIS

Minoca third party packages smoke tests.

# Description

Install third party package, run package specific tests

# INSTALL

    $ sparrow plg install minoca-pkg-test

# USAGE

    $ sparrow plg run minoca-pkg-test


![minoca-pkg-test screen shot](https://raw.githubusercontent.com/melezhik/minoca-pkg-test/master/minoca-pkg-test.png)

# Configuring package list

By default package list to be verified defined at [default configuration file](https://github.com/melezhik/minoca-pkg-test/blob/master/suite.ini).

You may redefine one either via command line:

    $ sparrow plg run minoca-pkg-test pkg-list=perl-5.20.1,sqlite=3080500
    $ sparrow plg run minoca-pkg-test pkg-list=perl,sqlite # will pick up packages versions from default list

Or via sparrow task:


    $ sparrow project create minoca
    $ sparrow task add minoca third-party-test minoca-pkg-test
    $ sparrow task ini minoca/third-party-test

    <packages>
      perl 5.20.1
      sqlite 3080500  
      screen 4.4.0
    </packages>
    
    $ sparrow task run minoca/third-party-test


# Configuring smoke tests

Every package in `package list` could be optionally accompanied a smoke test command with output verified:


    <smoke_test>
      <perl>
        command perl --version
        output  This is perl 5
      </perl>
      <sqlite>
        command sqlite3 --version
        output regexp: \d\.\d\.\d
      </sqlite>
      <screen>
        command screen --version
        output regexp: Screen version \d
      </screen>
    </smoke_test>

A default smoke test list is set at [default configuration file](https://github.com/melezhik/minoca-pkg-test/blob/master/suite.ini)
    

You may redefine it as well:

    $ sparrow task ini minoca/third-party-test
    <smoke_test>
      # bla bla bla
    <smoke_test>

# Author

[Alexey Melezhik](mailto:melezhik@gmail.com)  


