From: ramu <ramu.freesystems@gmail.com>
Subject: Re: How to build ceph upon zfs filesystem.
Date: Mon, 27 Aug 2012 04:34:59 +0000 (UTC)
Message-ID: <loom.20120827T063044-980@post.gmane.org>
References: <loom.20120826T033818-148@post.gmane.org> <503A2142.2000505@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:45077 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750771Ab2H0EfS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 27 Aug 2012 00:35:18 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1T5r2j-00026n-GV
	for ceph-devel@vger.kernel.org; Mon, 27 Aug 2012 06:35:18 +0200
Received: from 81-254-187-203.static.youbroadband.in ([81-254-187-203.static.youbroadband.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 27 Aug 2012 06:35:17 +0200
Received: from ramu.freesystems by 81-254-187-203.static.youbroadband.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 27 Aug 2012 06:35:17 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

  After install zfs and created zpool using
"zpool create tank /dev/sdb2" after set mountpoint"zfs set 
mountpoint=/data/osd.1" then
"zfs mount -a"

But when am running mkcephfs command am getting following error,

temp dir is /tmp/mkcephfs.Em23UGJyWd
preparing monmap in /tmp/mkcephfs.Em23UGJyWd/monmap
/usr/local/bin/monmaptool --create --clobber --add a 192.168.120.32:6789 --add b 
192.168.120.32:6790 --print /tmp/mkcephfs.Em23UGJyWd/monmap
/usr/local/bin/monmaptool: monmap file /tmp/mkcephfs.Em23UGJyWd/monmap
/usr/local/bin/monmaptool: generated fsid a9d2dba0-a490-4c92-a5e1-04cce1118462
epoch 0
fsid a9d2dba0-a490-4c92-a5e1-04cce1118462
last_changed 2012-08-27 10:00:22.031670
created 2012-08-27 10:00:22.031670
0: 192.168.120.32:6789/0 mon.a
1: 192.168.120.32:6790/0 mon.b
/usr/local/bin/monmaptool: writing epoch 0 to /tmp/mkcephfs.Em23UGJyWd/monmap (2 
monitors)
=== osd.0 === 
pushing conf and monmap to node32:/tmp/mkfs.ceph.5587
2012-08-27 10:00:25.408604 7f46bf574780 -1 filestore(/data/osd.0) leveldb db 
created
2012-08-27 10:00:25.585815 7f46bf574780 -1 filestore(/data/osd.0) limited size 
xattrs -- filestore_xattr_use_omap enabled
2012-08-27 10:00:26.207126 7f46bf574780 -1 created object store /data/osd.0 
journal /data/osd.0/osd.0.journal for osd.0 fsid a9d2dba0-a490-4c92-a5e1-
04cce1118462
creating private key for osd.0 keyring /etc/ceph/keyring.osd.0
creating /etc/ceph/keyring.osd.0
collecting osd.0 key
=== osd.1 === 
pushing conf and monmap to node32:/tmp/mkfs.ceph.5587
2012-08-27 10:00:40.308853 7fb416bc2780 -1 filestore(/data/osd.1) leveldb db 
created
2012-08-27 10:00:40.309546 7fb416bc2780 -1 journal FileJournal::_open: unable to 
open journal: open() failed: (22) Invalid argument
2012-08-27 10:00:40.310103 7fb416bc2780 -1 OSD::mkfs: FileStore::mkfs failed 
with error -22
2012-08-27 10:00:40.310291 7fb416bc2780 -1  ** ERROR: error creating empty 
object store in /data/osd.1: (22) Invalid argument
failed: 'ssh root@node32 /usr/local/sbin/mkcephfs -d /tmp/mkfs.ceph.5587 --init-
daemon osd.1'

Thanks,
Ramu.

