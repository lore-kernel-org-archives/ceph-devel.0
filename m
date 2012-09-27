From: hemant surale <hemant.surale@gmail.com>
Subject: Problem creating osd.0 ??
Date: Thu, 27 Sep 2012 11:13:42 +0530
Message-ID: <CAGfy=6k4wZxjcJEaWTdetXEw6_ZYzNiOaH+kqGR0S7VepPotHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:54153 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754882Ab2I0Fnm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Sep 2012 01:43:42 -0400
Received: by vbbff1 with SMTP id ff1so1546752vbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 26 Sep 2012 22:43:42 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Folks ,
     I am unable to figure it out the

--------------------------
root@hemant-virtual-machine:/etc/ceph# mkcephfs -a -c
/etc/ceph/ceph.conf -k ceph.keyring
temp dir is /tmp/mkcephfs.E1M7ay6HBa
preparing monmap in /tmp/mkcephfs.E1M7ay6HBa/monmap
/usr/bin/monmaptool --create --clobber --add alpha 10.72.147.249:6789
--print /tmp/mkcephfs.E1M7ay6HBa/monmap
/usr/bin/monmaptool: monmap file /tmp/mkcephfs.E1M7ay6HBa/monmap
/usr/bin/monmaptool: generated fsid 84d8b6ea-e062-45fe-8386-17ac7231ea13
epoch 0
fsid 84d8b6ea-e062-45fe-8386-17ac7231ea13
last_changed 2012-09-27 11:11:33.447933
created 2012-09-27 11:11:33.447933
0: 10.72.147.249:6789/0 mon.alpha
/usr/bin/monmaptool: writing epoch 0 to
/tmp/mkcephfs.E1M7ay6HBa/monmap (1 monitors)
=== osd.0 ===
2012-09-27 11:11:33.498019 7fde16353780 -1 filestore(/ceph_data/osd.0)
limited size xattrs -- enable filestore_xattr_use_omap
2012-09-27 11:11:33.498031 7fde16353780 -1 OSD::mkfs: couldn't mount
FileStore: error -95
2012-09-27 11:11:33.498057 7fde16353780 -1  ** ERROR: error creating
empty object store in /ceph_data/osd.0: (95) Operation not supported
failed: '/sbin/mkcephfs -d /tmp/mkcephfs.E1M7ay6HBa --init-daemon osd.0'
-----------------------------------

I created dir manually as well as assigned all permissions to root
user still this problem persists. Please help me out .

Thanks & Regards,
Hemant Surale.
