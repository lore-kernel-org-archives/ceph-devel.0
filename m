From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: MDS Replay Issues
Date: Fri, 1 Jul 2011 09:39:35 -0700
Message-ID: <BANLkTimjxtNkCMqauKNoKrwz+5n+b23HpQ@mail.gmail.com>
References: <B828A4C02BE12543ACDFCF7EB0C693C678862E5C9A@NC-SVR-09.netelligent.com>
	<BANLkTimFgvG2JhTuABwnpt8qWgwAp4vDaQ@mail.gmail.com>
	<Pine.LNX.4.64.1107010910210.21506@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:45085 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757139Ab1GAQjg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Jul 2011 12:39:36 -0400
Received: by gwaa18 with SMTP id a18so1410714gwa.19
        for <ceph-devel@vger.kernel.org>; Fri, 01 Jul 2011 09:39:35 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1107010910210.21506@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Fri, Jul 1, 2011 at 9:13 AM, Sage Weil <sage@newdream.net> wrote:
> There are two parts here:
>
> =A0- 'ceph mds stop <num>' will tell the given mds rank to export its
> subtrees and leave the active set. =A0The daemon will either shut dow=
n or go
> back to standby (I forget which :).
>
> =A0- Setting max_mds to a lower value will prevent any new or standby=
 MDSs
> from (re)joining the active set.
>
> The first part isn't yet part of our testing matrix but should work!
That which is not tested does not exist. :)

gregf@kai:~/ceph/src$ ./ceph mds stop 1
2011-07-01 09:14:30.787075 mon <- [mds,stop,1]
2011-07-01 09:14:30.949816 mon0 -> 'telling mds1 10.0.1.205:6805/4545
to stop' (0)
gregf@kai:~/ceph/src$ ls core*
core.cmds.4632
gregf@kai:~/ceph/src$ ./ceph set_max_mds 1
2011-07-01 09:15:57.478978 mon <- [set_max_mds,1]
2011-07-01 09:15:57.479593 mon0 -> 'unrecognized subsystem' (-22)
gregf@kai:~/ceph/src$ ./ceph mds set_max_mds 1
2011-07-01 09:16:20.243239 mon <- [mds,set_max_mds,1]
2011-07-01 09:16:20.432809 mon0 -> 'max_mds =3D 1' (0)
-----------------------------------------

2011-07-01 09:14:18.615247    pg v13: 18 pgs: 18
active+clean+degraded; 43 KB data, 38643 MB used, 781 GB / 863 GB
avail; 37/74 degraded (50.000%)
2011-07-01 09:14:18.615427   mds e8: 2/2/2 up {0=3Da=3Dup:active,1=3Db=3D=
up:active}
2011-07-01 09:14:18.615461   osd e2: 1 osds: 1 up, 1 in
2011-07-01 09:14:18.615516   log 2011-07-01 09:11:39.639307 osd0
10.0.1.205:6800/4471 18 : [INF] 2.1p0 scrub ok
2011-07-01 09:14:18.615587   mon e1: 1 mons at {a=3D10.0.1.205:6789/0}
2011-07-01 09:14:30.949841   mds e9: 2/2/2 up {0=3Da=3Dup:active,1=3Db=3D=
up:stopping}
2011-07-01 09:14:31.201617   mds e10: 1/1/2 up {0=3Da=3Dup:active}
2011-07-01 09:14:31.503782   log 2011-07-01 09:14:31.201437 mon0
10.0.1.205:6789/0 7 : [INF] mds1 10.0.1.205:6805/4545 down:stopped
2011-07-01 09:14:32.913620    pg v14: 18 pgs: 18
active+clean+degraded; 43 KB data, 38643 MB used, 781 GB / 863 GB
avail; 37/74 degraded (50.000%)
2011-07-01 09:14:35.522757   mds e11: 1/1/2 up {0=3Da=3Dup:active}, 1 u=
p:standby
2011-07-01 09:14:35.522790   mds e12: 2/2/2 up {0=3Da=3Dup:active,1=3Db=
=3Dup:starting}
2011-07-01 09:14:36.359415   log 2011-07-01 09:14:35.522685 mon0
10.0.1.205:6789/0 8 : [INF] mds? 10.0.1.205:6806/4546 up:boot
2011-07-01 09:14:55.346502   mds e13: 2/2/2 up
{0=3Da=3Dup:active,1=3Db=3Dup:starting(laggy or crashed)}


If you've done anything in the tree it doesn't seem to even get that
far, it just gets stuck in the stopping state.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
