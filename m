From: =?iso-8859-1?Q?C=E9dric_Morandin?= <cedric.morandin@inria.fr>
Subject: Re: Ceph hangs when accessed
Date: Mon, 26 Sep 2011 23:23:07 +0200
Message-ID: <AB162BB9-8DFB-42CF-93E7-85460723CE7C@inria.fr>
References: <1801183894.301109.1316793492464.JavaMail.root@zmbs4.inria.fr> <1316798414.2822.33.camel@wido-laptop>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail1-relais-roc.national.inria.fr ([192.134.164.82]:28424 "EHLO
	mail1-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752257Ab1IZVXL convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 26 Sep 2011 17:23:11 -0400
In-Reply-To: <1316798414.2822.33.camel@wido-laptop>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

Hi Wido,

Thanks for your answer and your kind help.
I tried to give you all useful information but maybe something is missi=
ng.
Let me know if you want me to do more tests.

Please find the output of ceph -s below:
[root@node91 ~]# ceph -s
2011-09-26 22:48:08.048659    pg v297: 792 pgs: 792 active+clean; 24 KB=
 data, 80512 KB used, 339 GB / 340 GB avail
2011-09-26 22:48:08.049742   mds e5: 1/1/1 up {0=3Dalpha=3Dup:active}, =
1 up:standby
2011-09-26 22:48:08.049764   osd e5: 4 osds: 4 up, 4 in
2011-09-26 22:48:08.049800   log 2011-09-26 19:38:14.372125 osd3 138.96=
=2E126.95:6800/2973 242 : [INF] 2.1p3 scrub ok
2011-09-26 22:48:08.049847   mon e1: 3 mons at {alpha=3D138.96.126.91:6=
789/0,beta=3D138.96.126.92:6789/0,gamma=3D138.96.126.93:6789/0}

The same command ten minutes after the cfuse hangs on the client node :

[root@node91 ~]# ceph -s
2011-09-26 23:07:49.403774    pg v335: 792 pgs: 101 active, 276 active+=
clean, 415 active+clean+degraded; 4806 KB data, 114 MB used, 339 GB / 3=
40 GB avail; 24/56 degraded (42.857%)
2011-09-26 23:07:49.404847   mds e5: 1/1/1 up {0=3Dalpha=3Dup:active}, =
1 up:standby
2011-09-26 23:07:49.404867   osd e13: 4 osds: 2 up, 4 in
2011-09-26 23:07:49.404929   log 2011-09-26 23:07:46.093670 mds0 138.96=
=2E126.91:6800/4682 2 : [INF] closing stale session client4124 138.96.1=
26.91:0/5563 after 455.778957
2011-09-26 23:07:49.404966   mon e1: 3 mons at {alpha=3D138.96.126.91:6=
789/0,beta=3D138.96.126.92:6789/0,gamma=3D138.96.126.93:6789/0}

[root@node91 ~]# /etc/init.d/ceph -a status
=3D=3D=3D mon.alpha =3D=3D=3D=20
running...
=3D=3D=3D mon.beta =3D=3D=3D=20
running...
=3D=3D=3D mon.gamma =3D=3D=3D=20
running...
=3D=3D=3D mds.alpha =3D=3D=3D=20
running...
=3D=3D=3D mds.beta =3D=3D=3D=20
running...
=3D=3D=3D osd.0 =3D=3D=3D=20
dead.
=3D=3D=3D osd.1 =3D=3D=3D=20
running...
=3D=3D=3D osd.2 =3D=3D=3D=20
running...
=3D=3D=3D osd.3 =3D=3D=3D=20
dead.

I finally paste the last lines of osd.0 :

2011-09-26 22:57:06.822182 7faf6a6f8700 -- 138.96.126.92:6802/3157 >> 1=
38.96.126.93:6801/3162 pipe(0x7faf50001320 sd=3D20 pgs=3D0 cs=3D0 l=3D0=
).accept connect_seq 2 vs existing 1 state 3
2011-09-26 23:07:09.084901 7faf8e1b5700 FileStore: sync_entry timed out=
 after 600 seconds.
 ceph version 0.34 (commit:2f039eeeb745622b866d80feda7afa055e15f6d6)
2011-09-26 23:07:09.084934 1: (SafeTimer::timer_thread()+0x323) [0x5c95=
a3]
2011-09-26 23:07:09.084943 2: (SafeTimerThread::entry()+0xd) [0x5cbc7d]
2011-09-26 23:07:09.084950 3: /lib64/libpthread.so.0() [0x31fec077e1]
2011-09-26 23:07:09.084957 4: (clone()+0x6d) [0x31fe4e18ed]
2011-09-26 23:07:09.084963 *** Caught signal (Aborted) **
 in thread 0x7faf8e1b5700
 ceph version 0.34 (commit:2f039eeeb745622b866d80feda7afa055e15f6d6)
 1: /usr/bin/cosd() [0x649ca9]
 2: /lib64/libpthread.so.0() [0x31fec0f4c0]
 3: (gsignal()+0x35) [0x31fe4329a5]
 4: (abort()+0x175) [0x31fe434185]
 5: (__assert_fail()+0xf5) [0x31fe42b935]
 6: (SyncEntryTimeout::finish(int)+0x130) [0x683400]
 7: (SafeTimer::timer_thread()+0x323) [0x5c95a3]
 8: (SafeTimerThread::entry()+0xd) [0x5cbc7d]
 9: /lib64/libpthread.so.0() [0x31fec077e1]
 10: (clone()+0x6d) [0x31fe4e18ed]

ceph.conf:

[global]
        max open files =3D 131072
        log file =3D /var/log/ceph/$name.log
        pid file =3D /var/run/ceph/$name.pid
[mon]
        mon data =3D /data/$name
        mon clock drift allowed =3D 1
[mon.alpha]
        host =3D node91
        mon addr =3D 138.96.126.91:6789
[mon.beta]
        host =3D node92
        mon addr =3D 138.96.126.92:6789
[mon.gamma]
        host =3D node93
        mon addr =3D 138.96.126.93:6789
[mds]

        keyring =3D /data/keyring.$name
[mds.alpha]
        host =3D node91
[mds.beta]
        host =3D node92
[osd]
        osd data =3D /data/$name
        osd journal =3D /data/$name/journal
        osd journal size =3D 1000
[osd.0]
        host =3D node92
[osd.1]
        host =3D node93
[osd.2]
        host =3D node94
[osd.3]
        host =3D node95

----

Thank you one more time for your help.

Regards

C=E9dric

Le 23 sept. 2011 =E0 19:20, Wido den Hollander a =E9crit :

> Hi.
>=20
> Could you sent us your ceph.conf and the output of "ceph -s" ?
>=20
> Wido
>=20
> On Fri, 2011-09-23 at 17:58 +0200, Cedric Morandin wrote:
>> Hi everybody,
>>=20
>> I didn't find any ceph-users list so I post here. If this is not the=
 right place to do it please let me know.
>> I'm currently trying to test ceph but I'm probably doing something w=
rong because I have a really strange behavior.
>>=20
>> Context:
>> Ceph compiled and installed on five Centos6 machines.
>> A BTRFS partition is available on each machine.
>> This partition is mounted under /data/osd.[0-3]
>> Clients are using cfuse compiled for FC11 ( 2.6.29.4-167.fc11.x86_64=
 )
>>=20
>> What happen:
>> I configured everything in ceph.conf, started ceph daemons on all no=
des.
>> When I issue ceph health, I have a HEALTH_OK answer.
>> I can access the filesystem through cfuse and create some files on i=
t, but when I try to create files bigger than 2 or 3 Mo, the filesystem=
 hangs.
>> When I try to copy an entire directory ( ceph sources for instance) =
I have the same problem.
>> When the system is in this state, the cosd daemon die on OSD machine=
s: [INF] osd0 out (down for 304.836218)
>> Even killing it doesn't release the mountpoint :
>> cosd       9170      root   10uW     REG                8,6         =
 8    2506754 /data/osd.0/fsid
>> cosd       9170      root   11r      DIR                8,6       40=
96    2506753 /data/osd.0
>> cosd       9170      root   12r      DIR                8,6      245=
76    2506755 /data/osd.0/current
>> cosd       9170      root   13u      REG                8,6         =
 4    2506757 /data/osd.0/current/commit_op_seq
>>=20
>>=20
>> I tried to change some parameters but it results in the same problem=
:
>> Tried both with the 0.34 and 0.35 releases and using both BTRFS or E=
XTR3 with user_attr attribute.
>> I tried the cfuse client on one of the Centos 6 machine.
>>=20
>> I read everything on  http://ceph.newdream.net/wiki but I can't figu=
re out the problem.
>> Does somebody have any clue of the problem's origin ?
>>=20
>> Regards,
>>=20
>> Cedric Morandin=20
>>=20
>>=20
>>=20
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
