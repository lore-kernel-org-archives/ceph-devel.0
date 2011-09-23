From: Cedric Morandin <cedric.morandin@inria.fr>
Subject: Ceph hangs when accessed
Date: Fri, 23 Sep 2011 17:58:12 +0200 (CEST)
Message-ID: <1801183894.301109.1316793492464.JavaMail.root@zmbs4.inria.fr>
References: <1126025760.301101.1316793469807.JavaMail.root@zmbs4.inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail4-relais-sop.national.inria.fr ([192.134.164.105]:41902
	"EHLO mail4-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754836Ab1IWP6N convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 23 Sep 2011 11:58:13 -0400
In-Reply-To: <1126025760.301101.1316793469807.JavaMail.root@zmbs4.inria.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi everybody,

I didn't find any ceph-users list so I post here. If this is not the ri=
ght place to do it please let me know.
I'm currently trying to test ceph but I'm probably doing something wron=
g because I have a really strange behavior.

Context:
Ceph compiled and installed on five Centos6 machines.
A BTRFS partition is available on each machine.
This partition is mounted under /data/osd.[0-3]
Clients are using cfuse compiled for FC11 ( 2.6.29.4-167.fc11.x86_64 )

What happen:
I configured everything in ceph.conf, started ceph daemons on all nodes=
=2E
When I issue ceph health, I have a HEALTH_OK answer.
I can access the filesystem through cfuse and create some files on it, =
but when I try to create files bigger than 2 or 3 Mo, the filesystem ha=
ngs.
When I try to copy an entire directory ( ceph sources for instance) I h=
ave the same problem.
When the system is in this state, the cosd daemon die on OSD machines: =
[INF] osd0 out (down for 304.836218)
Even killing it doesn't release the mountpoint :
cosd       9170      root   10uW     REG                8,6          8 =
   2506754 /data/osd.0/fsid
cosd       9170      root   11r      DIR                8,6       4096 =
   2506753 /data/osd.0
cosd       9170      root   12r      DIR                8,6      24576 =
   2506755 /data/osd.0/current
cosd       9170      root   13u      REG                8,6          4 =
   2506757 /data/osd.0/current/commit_op_seq


I tried to change some parameters but it results in the same problem:
Tried both with the 0.34 and 0.35 releases and using both BTRFS or EXTR=
3 with user_attr attribute.
I tried the cfuse client on one of the Centos 6 machine.

I read everything on  http://ceph.newdream.net/wiki but I can't figure =
out the problem.
Does somebody have any clue of the problem's origin ?

Regards,

Cedric Morandin=20



--=20
C=E9dric Morandin -  OASIS Research Team
INRIA Sophia Antipolis
2004 route des lucioles - BP 93
06902  Sophia-Antipolis (France)
Phone: +33 4 97 15 53 89


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
