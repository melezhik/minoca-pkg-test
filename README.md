# SYNOPSIS

Minoca third party packages smoke tests.

# Description

Install third party package, run package specific tests

# INSTALL

    $ sparrow plg run minoca-pkg-test

# USAGE

    $ sparrow plg run minoca-pkg-test


# Setting package list

By default package list to be verified defined at [default list](https://github.com/melezhik/minoca-pkg-test/blob/master/suite.ini).

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
    </packages>
    
    $ sparrow task run minoca/third-party-test


  


