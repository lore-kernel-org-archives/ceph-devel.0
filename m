From: Adam Nielsen <a.nielsen@shikadi.net>
Subject: OSD::mkfs: couldn't mount FileStore: error -22
Date: Sun, 14 Oct 2012 17:50:16 +1000
Message-ID: <k5dqro$s4d$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:34493 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750924Ab2JNHui (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 14 Oct 2012 03:50:38 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1TNIy5-0005lp-H1
	for ceph-devel@vger.kernel.org; Sun, 14 Oct 2012 09:50:37 +0200
Received: from 124-170-67-40.dyn.iinet.net.au ([124.170.67.40])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sun, 14 Oct 2012 09:50:37 +0200
Received: from a.nielsen by 124-170-67-40.dyn.iinet.net.au with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sun, 14 Oct 2012 09:50:37 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

I'm attempting to set up a Ceph cluster for testing, initially with only one 
node so I can add others next.  I think I've followed the guides as closely as 
I could, but now when running mkcephfs it fails and I can't find much about 
the error through Google.

What am I doing wrong?  This is on Debian Squeeze with the stable repo from 
ceph.com.

$ mkcephfs -a -c /etc/ceph/ceph.conf
temp dir is /tmp/mkcephfs.FqyH7RCFY1
preparing monmap in /tmp/mkcephfs.FqyH7RCFY1/monmap
/usr/bin/monmaptool --create --clobber --add 0 192.168.0.6:6789 --print 
/tmp/mkcephfs.FqyH7RCFY1/monmap
/usr/bin/monmaptool: monmap file /tmp/mkcephfs.FqyH7RCFY1/monmap
/usr/bin/monmaptool: generated fsid 77b0e551-b545-42df-957e-b99292539501
epoch 0
fsid 77b0e551-b545-42df-957e-b99292539501
last_changed 2012-10-14 17:40:11.128447
created 2012-10-14 17:40:11.128447
0: 192.168.0.6:6789/0 mon.0
/usr/bin/monmaptool: writing epoch 0 to /tmp/mkcephfs.FqyH7RCFY1/monmap (1 
monitors)
=== osd.0 ===
  ** WARNING: 'filestore btrfs snap' is enabled (for safe transactions,
              rollback), but btrfs does not support the SNAP_CREATE_V2 ioctl
              (added in Linux 2.6.37).  Expect slow btrfs sync/commit
              performance.
2012-10-14 17:40:12.768973 b732b710 -1 filestore(/var/lib/ceph/osd/ceph-0) 
mount initial op seq is 0; something is wrong
2012-10-14 17:40:12.769238 b732b710 -1 OSD::mkfs: couldn't mount FileStore: 
error -22
2012-10-14 17:40:12.769522 b732b710 -1  ** ERROR: error creating empty object 
store in /var/lib/ceph/osd/ceph-0: (22) Invalid argument
failed: '/sbin/mkcephfs -d /tmp/mkcephfs.FqyH7RCFY1 --init-daemon osd.0'

$ cat /etc/ceph/ceph.conf
[osd]
         osd journal size = 10000

[mon.0]
         host = node1
         mon addr = 192.168.0.6:6789
         mon data = /var/lib/ceph/osd/$cluster-$id/

[osd.0]
         host = node1

[mds.0]
         host = node1

Any suggestions?  I tried commenting out "mon data" but it didn't make a 
difference (and I need this in because the test machine's root filesystem is 
on a 4GB CF card, so I need all non-OS data to be stored on the disks assigned 
to Ceph.)

Thanks,
Adam.

