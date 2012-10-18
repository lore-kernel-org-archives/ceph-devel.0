From: hemant surale <work.hemant.surale@gmail.com>
Subject: Unable to build Ceph from source code
Date: Thu, 18 Oct 2012 10:28:50 +0530
Message-ID: <CAAY-_OEHukt7ESqyxHQx4Bp_Vx6ui8ahy1UwESC25E7SZ0vE3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:46087 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197Ab2JRE6v convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Oct 2012 00:58:51 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so5536948lag.19
        for <ceph-devel@vger.kernel.org>; Wed, 17 Oct 2012 21:58:50 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Community,
 I have tried to build ceph from source code i.e. v0.48 tarball .
After proceeding to all steps given at official site . when I execute
"service ceph start " it gives following error

-----------------//Error ------------------------------------
root@atish-virtual-machine:~# service ceph start
/etc/init.d/ceph: 37: .: Can't open /usr/lib/ceph/ceph_common.sh
-----------------------------------------------------------------

As well as I have created ceph.conf .. and when I execute "mkcephfs -a
-c /usr/local/bin/ceph.conf -k ceph.keyring" it gives following error

-----------------//Error ------------------------------------
temp dir is /tmp/mkcephfs.fwMGAd6Qko
preparing monmap in /tmp/mkcephfs.fwMGAd6Qko/monmap
/usr/local/bin/monmaptool --create --clobber --add alpha
10.72.148.248:6789 --print /tmp/mkcephfs.fwMGAd6Qko/monmap
/usr/local/bin/monmaptool: monmap file /tmp/mkcephfs.fwMGAd6Qko/monmap
/usr/local/bin/monmaptool: generated fsid 390b4802-a482-4d28-98ea-e5437881b22b
epoch 0
fsid 390b4802-a482-4d28-98ea-e5437881b22b
last_changed 2012-10-17 16:57:30.446192
created 2012-10-17 16:57:30.446192
0: 10.72.148.248:6789/0 mon.alpha
/usr/local/bin/monmaptool: writing epoch 0 to
/tmp/mkcephfs.fwMGAd6Qko/monmap (1 monitors)
=== osd.0 ===
2012-10-17 16:57:30.550339 b6fb3740 -1
filestore(/var/lib/ceph/osd/ceph-0) limited size xattrs -- enable
filestore_xattr_use_omap
2012-10-17 16:57:30.550399 b6fb3740 -1 OSD::mkfs: couldn't mount
FileStore: error -95
2012-10-17 16:57:30.550440 b6fb3740 -1  ** ERROR: error creating empty
object store in /var/lib/ceph/osd/ceph-0: (95) Operation not supported
failed: '/usr/local/sbin/mkcephfs -d /tmp/mkcephfs.fwMGAd6Qko
--init-daemon osd.0'
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Please help me out. Thanks in advance

-
Hemant Surale.
