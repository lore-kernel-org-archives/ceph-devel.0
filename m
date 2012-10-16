From: Lokesh Krishnappa <lokesh.professional.it@gmail.com>
Subject: Fwd: s3 UnboundLocalError
Date: Tue, 16 Oct 2012 10:34:09 +0530
Message-ID: <CABpo6h+hq0EnzG_vx5f7igNZr37uk_NvJvZr7_4hCe+_G5qt9Q@mail.gmail.com>
References: <CABpo6hKK3Xyc0BhcUYRdP+OGtG6sc31YnGPc0cx+XTRM_WBY=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:48578 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755683Ab2JPFEK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Oct 2012 01:04:10 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so5802274oag.19
        for <ceph-devel@vger.kernel.org>; Mon, 15 Oct 2012 22:04:09 -0700 (PDT)
In-Reply-To: <CABpo6hKK3Xyc0BhcUYRdP+OGtG6sc31YnGPc0cx+XTRM_WBY=w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi all,

am following, the below given link :
https://github.com/ceph/s3-tests for my testing purpose ... and while
am executing the command as:

S3TEST_CONF=example.conf ./virtualenv/bin/nosetests

getting results with 2error , which is as follows:

 lokesh@lokesh:~/Downloads/ceph-teuthology-78b7b02$
S3TEST_CONF=example.conf ./virtualenv/bin/nosetests
................EES................................
======================================================================
ERROR: teuthology.orchestra.test.test_connection.test_connect
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/home/lokesh/Downloads/ceph-teuthology-78b7b02/virtualenv/local/lib/python2.7/site-packages/nose/case.py",
line 197, in runTest
    self.test(*self.arg)
  File "/home/lokesh/Downloads/ceph-teuthology-78b7b02/virtualenv/local/lib/python2.7/site-packages/fudge/__init__.py",
line 168, in apply_clear_and_verify
    method(*args, **kw)
  File "/home/lokesh/Downloads/ceph-teuthology-78b7b02/teuthology/orchestra/test/test_connection.py",
line 47, in test_connect
    _SSHClient=sshclient,
  File "/home/lokesh/Downloads/ceph-teuthology-78b7b02/teuthology/orchestra/connection.py",
line 30, in connect
    ssh.load_system_host_keys()
UnboundLocalError: local variable 'ssh' referenced before assignment

======================================================================
ERROR: teuthology.orchestra.test.test_connection.test_connect_override_hostkeys
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/home/lokesh/Downloads/ceph-teuthology-78b7b02/virtualenv/local/lib/python2.7/site-packages/nose/case.py",
line 197, in runTest
    self.test(*self.arg)
  File "/home/lokesh/Downloads/ceph-teuthology-78b7b02/virtualenv/local/lib/python2.7/site-packages/fudge/__init__.py",
line 168, in apply_clear_and_verify
    method(*args, **kw)
  File "/home/lokesh/Downloads/ceph-teuthology-78b7b02/teuthology/orchestra/test/test_connection.py",
line 78, in test_connect_override_hostkeys
    _create_key = create_key,
  File "/home/lokesh/Downloads/ceph-teuthology-78b7b02/teuthology/orchestra/connection.py",
line 33, in connect
    ssh.get_host_keys().add(
UnboundLocalError: local variable 'ssh' referenced before assignment

----------------------------------------------------------------------
Ran 50 tests in 1.822s

FAILED (SKIP=1, errors=2)

i thought it would be ssh login problem and tried to secure login, its
working fine .

pls tel me where i made wrong . if idea! pls ...

with regards ,

Lokesh K
