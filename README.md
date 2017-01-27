# SYNOPSIS

Minoca third party packages smoke tests.

# Description

Install third party package, run package specific tests

# INSTALL

On running minoca instance:

    $ wget -O - http://sparrowhub.org/minoca.sh | sh # bootstraping sparrow tool
    $ sparrow plg install minoca-pkg-test

# USAGE

    $ sparrow plg run minoca-pkg-test

![minoca-pkg-test screen shot](https://raw.githubusercontent.com/melezhik/minoca-pkg-test/master/minoca-pkg-test.png)

# Configuring package list

By default package list to be verified defined at [default configuration file](https://github.com/melezhik/minoca-pkg-test/blob/master/suite.ini).

## Overriding package list

Choose command line options to set up a *new* list:

    $ sparrow plg run minoca-pkg-test --param pkg-list=perl,sqlite

## Add new packages to default list

Create a sparrow task:


    $ sparrow project create minoca
    $ sparrow task add minoca third-party-test minoca-pkg-test

Then set up a new packages to check:

    $ sparrow task ini minoca/third-party-test

    # these 3 packages
    # will be added to
    # default list:
    <packages>
      foo
      bar  
      baz
    </packages>

Now run the task:
    
    $ sparrow task run minoca/third-party-test

# Configuring smoke tests

Package in `package list` might have a smoke test command with output verified:


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
    
You may add a new commands or update existed ones:

    $ sparrow task ini minoca/third-party-test

    <smoke_test>
      <tar>
        command tar --version
        output tar (GNU tar)    
      </tar>
      # bla bla bla
    </smoke_test>

# Load configuration from file

To make things fully automated you may save your desired configuration into file and
load it in runtime:

    $ sparrow task run minoca/third-party-test --ini /path/to/config/file


# Helper actions

## List installed packages

To know what packages are already installed use `list-installed` action.

    $ sparrow plg run minoca-pkg-test --param action=list-installed


# Author

[Alexey Melezhik](mailto:melezhik@gmail.com)  

  
