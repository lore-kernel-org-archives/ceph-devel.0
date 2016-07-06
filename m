From: Matt Benjamin <mbenjamin@redhat.com>
Subject: cmake: problems with /tmp/ceph-detect-init-virtualenv and
 /tmp/ceph-disk-virtualenv (after install, afaict)
Date: Wed, 6 Jul 2016 10:38:35 -0400 (EDT)
Message-ID: <2007506255.12422492.1467815915172.JavaMail.zimbra@redhat.com>
References: <1022013954.12407882.1467814484109.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:43442 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753825AbcGFOig (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Jul 2016 10:38:36 -0400
In-Reply-To: <1022013954.12407882.1467814484109.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: Marcus Watts <mwatts@redhat.com>

Hi,

I ran into some new cmake build breakages after pulling up to ceph master, yesterday afternoon.

I'm not sure this is all that can go awry, but definitely builds as a non-root user now fail after "sudo make install," because logic in the ceph-disk and detect-init targets attempts to remove files in those global paths, which fails due to permissions:

[ 53%] ceph-disk is being created
Running virtualenv with interpreter /usr/bin/python2.7
New python executable in /tmp/ceph-disk-virtualenv/bin/python2.7
Also creating executable in /tmp/ceph-disk-virtualenv/bin/python
Installing setuptools, pip...done.
You are using pip version 6.0.8, however version 8.1.2 is available.
You should consider upgrading via the 'pip install --upgrade pip' command.
Collecting pip>=6.1
  Using cached pip-8.1.2-py2.py3-none-any.whl
Installing collected packages: pip
  Found existing installation: pip 6.0.8
    Uninstalling pip-6.0.8:
      Successfully uninstalled pip-6.0.8

Successfully installed pip-8.1.2
Collecting tox>=1.9
  Url 'file:///home/mbenjamin/ceph-poo/src/ceph-disk/wheelhouse' is ignored: it is neither a file nor a directory.
  Using cached tox-2.3.1-py2.py3-none-any.whl
Collecting virtualenv>=1.11.2 (from tox>=1.9)
  Url 'file:///home/mbenjamin/ceph-poo/src/ceph-disk/wheelhouse' is ignored: it is neither a file nor a directory.
  Using cached virtualenv-15.0.2-py2.py3-none-any.whl
Collecting py>=1.4.17 (from tox>=1.9)
  Url 'file:///home/mbenjamin/ceph-poo/src/ceph-disk/wheelhouse' is ignored: it is neither a file nor a directory.
  Using cached py-1.4.31-py2.py3-none-any.whl
Collecting pluggy<0.4.0,>=0.3.0 (from tox>=1.9)
  Url 'file:///home/mbenjamin/ceph-poo/src/ceph-disk/wheelhouse' is ignored: it is neither a file nor a directory.
  Using cached pluggy-0.3.1-py2.py3-none-any.whl
Installing collected packages: virtualenv, py, pluggy, tox
Successfully installed pluggy-0.3.1 py-1.4.31 tox-2.3.1 virtualenv-15.0.2
You must give at least one requirement to install (maybe you meant "pip install file:///home/mbenjamin/ceph-poo/src/ceph-disk/wheelhouse"?)
Ignoring indexes: https://pypi.python.org/simple
Obtaining file:///home/mbenjamin/ceph-poo/src/ceph-disk
Requirement already satisfied (use --upgrade to upgrade): setuptools in /tmp/ceph-disk-virtualenv/lib/python2.7/site-packages (from ceph-disk==1.0.0)
Installing collected packages: ceph-disk
  Running setup.py develop for ceph-disk
Successfully installed ceph-disk
[ 53%] Built target ceph-disk
[ 54%] Built target ceph_disk-clone
[ 54%] ceph-detect-init is being created
rm: cannot remove \u2018/tmp/ceph-detect-init-virtualenv/log.txt\u2019: Permission denied
rm: cannot remove \u2018/tmp/ceph-detect-init-virtualenv/pip-selfcheck.json\u2019: Permission denied
rm: cannot remove \u2018/tmp/ceph-detect-init-virtualenv/bin/ceph-detect-init\u2019: Permission denied
rm: cannot remove \u2018/tmp/ceph-detect-init-virtualenv/bin/tox-quickstart\u2019: Permission denied
rm: cannot remove \u2018/tmp/ceph-detect-init-virtualenv/bin/tox\u2019: Permission denied
rm: cannot remove \u2018/tmp/ceph-detect-init-virtualenv/bin/virtualenv\u2019: Permission denied
rm: cannot remove \u2018/tmp/ceph-detect-init-virtualenv/bin/pip2.7\u2019: Permission denied
...

Initially I thought parallel cmake builds were broken altogether, but I haven't been able to reproduce that after removing both ceph virtualenv trees from /tmp.

I think in general this is something we should work on cleaning up, even though I guess it existed in the original automake build.  For various reasons, the self-restriction of cmake builds to their build directory is one of their advantages, and it's been true for the ceph cmake build until last week.

Marcus has some more detailed writeup on the virtualenv trees rehashing from last week, which I think he'll send later.

Matt

-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-707-0660
fax.  734-769-8938
cel.  734-216-5309
