From: Florian Haas <florian@hastexo.com>
Subject: "rbd rm" allows removal of mapped device, nukes data, then returns -EBUSY
Date: Mon, 2 Jul 2012 08:58:52 +0200
Message-ID: <CAPUexz-goSwxReRH_9gW_owHbTUrOLiwx8hsBzPMEzfEnm5GBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:42982 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963Ab2GBG6x (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Jul 2012 02:58:53 -0400
Received: by qcro28 with SMTP id o28so2746328qcr.19
        for <ceph-devel@vger.kernel.org>; Sun, 01 Jul 2012 23:58:53 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi everyone,

just wanted to check if this was the expected behavior -- it doesn't
look like it would be, to me.

What I do is create a 1G RBD, and just for the heck of it, make an XFS on it:

root@alice:~# rbd create xfsdev --size 1024
root@alice:~# rbd map xfsdev
root@alice:~# rbd showmapped
id	pool	image	snap	device
0	rbd	xfsdev	-	/dev/rbd0
root@alice:~# mkfs -t xfs /dev/rbd/rbd/xfsdev
log stripe unit (4194304 bytes) is too large (maximum is 256KiB)
log stripe unit adjusted to 32KiB
meta-data=/dev/rbd/rbd/xfsdev    isize=256    agcount=9, agsize=31744 blks
         =                       sectsz=512   attr=2, projid32bit=0
data     =                       bsize=4096   blocks=262144, imaxpct=25
         =                       sunit=1024   swidth=1024 blks
naming   =version 2              bsize=4096   ascii-ci=0
log      =internal log           bsize=4096   blocks=2560, version=2
         =                       sectsz=512   sunit=8 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0

I double check to see if there's an XFS signature on the device:

root@alice:~# xxd /dev/rbd/rbd/xfsdev | head
0000000: 5846 5342 0000 1000 0000 0000 0004 0000  XFSB............
0000010: 0000 0000 0000 0000 0000 0000 0000 0000  ................
0000020: 17bb f4df b1f3 444b bc01 3b3e f827 8fef  ......DK..;>.'..
0000030: 0000 0000 0002 0008 0000 0000 0000 4000  ..............@.
0000040: 0000 0000 0000 4001 0000 0000 0000 4002  ......@.......@.
0000050: 0000 0001 0000 7c00 0000 0009 0000 0000  ......|.........
0000060: 0000 0a00 b5a4 0200 0100 0010 0000 0000  ................
0000070: 0000 0000 0000 0000 0c09 0804 0f00 0019  ................
0000080: 0000 0000 0000 0040 0000 0000 0000 003d  .......@.......=
0000090: 0000 0000 0003 f5d8 0000 0000 0000 0000  ................

Now, I try to remove the device while it's mapped:

root@alice:~# rbd rm xfsdev
Removing image: 99% complete...2012-07-02 06:52:57.386040 b6c8d710 -1
librbd: error removing header: (16) Device or resource busy
Removing image: 99% complete...failed.
delete error: image still has watchers
This means the image is still open or the client using it crashed. Try
again after closing/unmapping it or waiting 30s for the crashed client
to timeout.

That sounds reasonable, except that the data has already been nuked:

root@alice:~# xxd /dev/rbd/rbd/xfsdev | head
0000000: 0000 0000 0000 0000 0000 0000 0000 0000  ................
0000010: 0000 0000 0000 0000 0000 0000 0000 0000  ................
0000020: 0000 0000 0000 0000 0000 0000 0000 0000  ................
0000030: 0000 0000 0000 0000 0000 0000 0000 0000  ................
0000040: 0000 0000 0000 0000 0000 0000 0000 0000  ................
0000050: 0000 0000 0000 0000 0000 0000 0000 0000  ................
0000060: 0000 0000 0000 0000 0000 0000 0000 0000  ................
0000070: 0000 0000 0000 0000 0000 0000 0000 0000  ................
0000080: 0000 0000 0000 0000 0000 0000 0000 0000  ................
0000090: 0000 0000 0000 0000 0000 0000 0000 0000  ................

After unmapping, the device removal proceeds just fine.

root@alice:~# rbd unmap /dev/rbd0
root@alice:~# rbd rm xfsdev
Removing image: 100% complete...done.

Now if the RBD is capable of detecting that it's being watched, why
not fail the removal _before_ wiping data, potentially with an
override with a --force flag?

Cheers,
Florian
