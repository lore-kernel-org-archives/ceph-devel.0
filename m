From: wanhai zhu <wanhaizhu@gmail.com>
Subject: Fwd: OSD recovery failed because of "leveldb: Corruption : checksum mismatch"
Date: Tue, 16 Jul 2013 15:11:42 +0800
Message-ID: <CAODg2UsX2WWNnk8QZHogCsm8GOYsN6_pp5=sCXW=t-=A1FHcig@mail.gmail.com>
References: <CAODg2UsJz1BSTkDj4hJHCJtBNYYX81BkykhAXU+NJG+OZaM43A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f43.google.com ([209.85.214.43]:43348 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751517Ab3GPHLn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Jul 2013 03:11:43 -0400
Received: by mail-bk0-f43.google.com with SMTP id jm2so103609bkc.2
        for <ceph-devel@vger.kernel.org>; Tue, 16 Jul 2013 00:11:42 -0700 (PDT)
In-Reply-To: <CAODg2UsJz1BSTkDj4hJHCJtBNYYX81BkykhAXU+NJG+OZaM43A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Dear  guys :

I have a ceph cluster which is used for backend storage of kvm guest,
and this cluster has four nodes, each node has three disks.  And the
ceph version is 0.61.4.

Because of electrical power down, the ceph cluster have been shutdown
innormally several days ago. When I restarted all the nodes and
started the ceph service in each node, two osd service are down and
out, and the error message shows =93 File system of the disk need to be
repair=94, so I execute these CLI =93xfs_check and xfs_repair -L=94. Af=
ter
that, I can mount the disk in the specific directory and see the raw
object data in the right state, then I start the specific osd service
but the osd service are also down and out and the error log show
=93leveldb: Corruption : checksum mismatch=94 , because this error make=
s
several pg =93stale+active+clean=94 and some pgs are lost in the cluste=
r.

The details of the error log are as follows:

2013-07-09 16:45:31.940767 7f9a5a7ee780  0 ceph version 0.61.4
(1669132fcfc27d0c0b5e5bb93ade59d147e23404), process ceph-osd, pid 4640

2013-07-09 16:45:31.986070 7f9a5a7ee780  0 filestore(/osd0) mount
=46IEMAP ioctl is supported and appears to work

2013-07-09 16:45:31.986084 7f9a5a7ee780  0 filestore(/osd0) mount
=46IEMAP ioctl is disabled via 'filestore fiemap' config option

2013-07-09 16:45:31.986649 7f9a5a7ee780  0 filestore(/osd0) mount did
NOT detect btrfs

2013-07-09 16:45:32.001812 7f9a5a7ee780  0 filestore(/osd0) mount
syncfs(2) syscall fully supported (by glibc and kernel)

2013-07-09 16:45:32.001895 7f9a5a7ee780  0 filestore(/osd0) mount found=
 snaps <>

2013-07-09 16:45:32.003550 7f9a5a7ee780 -1 filestore(/osd0) Error
initializing leveldb: Corruption: checksum mismatch

2013-07-09 16:45:32.003619 7f9a5a7ee780 -1 ^[[0;31m ** ERROR: error
converting store /osd0: (1) Operation not permitted^[[0m

      In these days , I have tried several ways to resolve these
problem and recovery the osd service , but all fails and I have
exclude the cause of =93xfs_check and xfs_repair=94 which is not
responsible for this issue. So I need your help or some advice to
resolve these problem.

      At the same time , I have some question about the ceph cluster
here, maybe someone can help me or give me a detail explanation.

1)       Are there some tools or command lines to move or recovery the
pg from one osd to another osd manually?  Or are there some ways to
fix the leveldb issue ?

2)       I used the rbd service for the guest block storage and when I
use the CLI =93ceph osd pg map image-name=94, I can see only one pg tha=
t
the rbd block has. Does it mean rbd block are stored in only one pg?
So does it mean the maximum of rbd block size is equal to the disk
capacity?

3)       Are there any ways or best practices to prevent the ceph
service from losing pg data when two osd services are down and out
(pool size is 2)? Customize the cluster map and rule set in order to
spilt the osd service in different failing zones as swift zone
concepts, Is that a good way?

      I need all your help and any idea or suggestion are very
appreciated.  Thanks.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
