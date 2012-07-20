From: Tim Flavin <tim.flavin@gmail.com>
Subject: mkcephfs problem
Date: Thu, 19 Jul 2012 21:46:26 -0400
Message-ID: <CAEj+kbmn=UY1dUKkyDDymqhbTuvEypVM+o4Ny-phS1SKZkmshA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:39817 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087Ab2GTBq1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Jul 2012 21:46:27 -0400
Received: by vbbff1 with SMTP id ff1so2515281vbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 19 Jul 2012 18:46:27 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I am trying to get Ceph running on an ARM system, currently one quad
core node, running Ubuntu 12.04.

It compiles fine, currently without tcmalloc and google perf tools, but
I am running into a problem with mkcephfs.  'mkcephfs -a -c ceph.conf'
didn't work so I did it piece by piece until I got this:

root@ubuntu:/home/tim# mkcephfs -d /tmp/foo --prepare-mon
Building generic osdmap from /tmp/foo/conf
/usr/local/bin/osdmaptool: osdmap file '/tmp/foo/osdmap'
/usr/local/bin/osdmaptool: writing epoch 1 to /tmp/foo/osdmap
Generating admin key at /tmp/foo/keyring.admin
creating /tmp/foo/keyring.admin
Building initial monitor keyring
cat: /tmp/foo/key.*: No such file or directory

There are no key.* files in /tmp/foo

# ls /tmp/foo
conf  keyring.admin  keyring.mon  monmap  osdmap


If you are running everything on one node, is it OK to use localhost and
127.0.0.1?


Here is my config file:

[osd]
        osd journal size = 1000
        filestore xattr use omap = true

[mon.a]
        host = localhost
        mon addr = 127.0.0.1:6789

[osd.0]
        host = localhost


[mds.a]
        host = localhost


Here are are the other configuration commands:

root@ubuntu:/home/tim# mkcephfs -c ceph.conf -d /tmp/foo --prepare-monmap
preparing monmap in /tmp/foo/monmap
/usr/local/bin/monmaptool --create --clobber --add a 127.0.0.1:6789
--print /tmp/foo/monmap
/usr/local/bin/monmaptool: monmap file /tmp/foo/monmap
/usr/local/bin/monmaptool: generated fsid 8e4f846b-1829-46e4-9902-5d8316c3fa4f
epoch 0
fsid 8e4f846b-1829-46e4-9902-5d8316c3fa4f
last_changed 2012-07-19 22:40:38.651045
created 2012-07-19 22:40:38.651045
0: 127.0.0.1:6789/0 mon.a
/usr/local/bin/monmaptool: writing epoch 0 to /tmp/foo/monmap (1 monitors)
root@ubuntu:/home/tim# mkcephfs -d /tmp/foo --init-local-daemons mds
root@ubuntu:/home/tim# mkcephfs -d /tmp/foo --init-local-daemons osd
root@ubuntu:/home/tim# mkcephfs -d /tmp/foo --prepare-mon
Building generic osdmap from /tmp/foo/conf
/usr/local/bin/osdmaptool: osdmap file '/tmp/foo/osdmap'
/usr/local/bin/osdmaptool: writing epoch 1 to /tmp/foo/osdmap
Generating admin key at /tmp/foo/keyring.admin
creating /tmp/foo/keyring.admin
Building initial monitor keyring
cat: /tmp/foo/key.*: No such file or directory
root@ubuntu:/home/tim#


Any ideas?  Which command was supposed to generate the key.* files?

Tim
