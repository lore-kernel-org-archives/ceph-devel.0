From: kernel neophyte <neophyte.hacker001@gmail.com>
Subject: With ceph-detect-init changes, make install fails
Date: Tue, 12 May 2015 11:26:24 -0700
Message-ID: <CAFkUHxdwK4YkoJ+B1Vkcn5006wXpj5nKDu5tR1w16Q_1mBntBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:34338 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933302AbbELS0Y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 May 2015 14:26:24 -0400
Received: by pdbqa5 with SMTP id qa5so22470409pdb.1
        for <ceph-devel@vger.kernel.org>; Tue, 12 May 2015 11:26:24 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Loic Dachary <loic@dachary.org>

Hi,

With the recent ceph-detect-init changes, make install now fails (
make succeeds hence this is not detected by build bots )

Error:

cd ceph-detect-init ; \

if lsb_release -si | grep --quiet 'Ubuntu\|Debian\|Devuan' ; then \

options=--install-layout=deb ; \

else \

options=--prefix=/usr ; \

fi ; \

python setup.py install --root= $options

running install

Checking .pth file support in usr/lib/python2.7/dist-packages/

/usr/bin/python -E -c pass

TEST FAILED: usr/lib/python2.7/dist-packages/ does NOT support .pth files

error: bad install directory or PYTHONPATH


You are attempting to install a package to a directory that is not

on PYTHONPATH and which Python does not read ".pth" files from.  The

installation directory you specified (via --install-dir, --prefix, or

the distutils default setting) was:


    usr/lib/python2.7/dist-packages/


and your PYTHONPATH environment variable currently contains:


    '../src/pybind'


Here are some of your options for correcting the problem:


* You can choose a different installation directory, i.e., one that is

  on PYTHONPATH or supports .pth files


* You can add the installation directory to the PYTHONPATH environment

  variable.  (It must then also be on PYTHONPATH whenever you run

  Python and want to use the package(s) you are installing.)


* You can set up the installation directory to support ".pth" files by

  using one of the approaches described here:


  https://pythonhosted.org/setuptools/easy_install.html#custom-installation-locations


-Neo
