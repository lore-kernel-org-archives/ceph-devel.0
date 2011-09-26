From: huang jun <hjwsm1989@gmail.com>
Subject: Re: Ceph hangs when accessed
Date: Tue, 27 Sep 2011 07:56:40 +0800
Message-ID: <CABAwU-aNQYO-wHO871=ryVBHUTq+H6zW0oWbxLA=+X7NQ4y+LQ@mail.gmail.com>
References: <1801183894.301109.1316793492464.JavaMail.root@zmbs4.inria.fr>
	<1316798414.2822.33.camel@wido-laptop>
	<AB162BB9-8DFB-42CF-93E7-85460723CE7C@inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:57868 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752990Ab1IZX4l convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Sep 2011 19:56:41 -0400
Received: by gyg10 with SMTP id 10so4648028gyg.19
        for <ceph-devel@vger.kernel.org>; Mon, 26 Sep 2011 16:56:41 -0700 (PDT)
In-Reply-To: <AB162BB9-8DFB-42CF-93E7-85460723CE7C@inria.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?C=E9dric_Morandin?= <cedric.morandin@inria.fr>
Cc: Wido den Hollander <wido@widodh.nl>, ceph-devel@vger.kernel.org

2011/9/27 C=E9dric Morandin <cedric.morandin@inria.fr>:
> Hi Wido,
>
> Thanks for your answer and your kind help.
> I tried to give you all useful information but maybe something is mis=
sing.
> Let me know if you want me to do more tests.
>
> Please find the output of ceph -s below:
> [root@node91 ~]# ceph -s
> 2011-09-26 22:48:08.048659 =A0 =A0pg v297: 792 pgs: 792 active+clean;=
 24 KB data, 80512 KB used, 339 GB / 340 GB avail
> 2011-09-26 22:48:08.049742 =A0 mds e5: 1/1/1 up {0=3Dalpha=3Dup:activ=
e}, 1 up:standby
> 2011-09-26 22:48:08.049764 =A0 osd e5: 4 osds: 4 up, 4 in
> 2011-09-26 22:48:08.049800 =A0 log 2011-09-26 19:38:14.372125 osd3 13=
8.96.126.95:6800/2973 242 : [INF] 2.1p3 scrub ok
> 2011-09-26 22:48:08.049847 =A0 mon e1: 3 mons at {alpha=3D138.96.126.=
91:6789/0,beta=3D138.96.126.92:6789/0,gamma=3D138.96.126.93:6789/0}
>
> The same command ten minutes after the cfuse hangs on the client node=
 :
>
> [root@node91 ~]# ceph -s
> 2011-09-26 23:07:49.403774 =A0 =A0pg v335: 792 pgs: 101 active, 276 a=
ctive+clean, 415 active+clean+degraded; 4806 KB data, 114 MB used, 339 =
GB / 340 GB avail; 24/56 degraded (42.857%)
> 2011-09-26 23:07:49.404847 =A0 mds e5: 1/1/1 up {0=3Dalpha=3Dup:activ=
e}, 1 up:standby
> 2011-09-26 23:07:49.404867 =A0 osd e13: 4 osds: 2 up, 4 in
> 2011-09-26 23:07:49.404929 =A0 log 2011-09-26 23:07:46.093670 mds0 13=
8.96.126.91:6800/4682 2 : [INF] closing stale session client4124 138.96=
=2E126.91:0/5563 after 455.778957
> 2011-09-26 23:07:49.404966 =A0 mon e1: 3 mons at {alpha=3D138.96.126.=
91:6789/0,beta=3D138.96.126.92:6789/0,gamma=3D138.96.126.93:6789/0}
>
> [root@node91 ~]# /etc/init.d/ceph -a status
> =3D=3D=3D mon.alpha =3D=3D=3D
> running...
> =3D=3D=3D mon.beta =3D=3D=3D
> running...
> =3D=3D=3D mon.gamma =3D=3D=3D
> running...
> =3D=3D=3D mds.alpha =3D=3D=3D
> running...
> =3D=3D=3D mds.beta =3D=3D=3D
> running...
> =3D=3D=3D osd.0 =3D=3D=3D
> dead.
> =3D=3D=3D osd.1 =3D=3D=3D
> running...
> =3D=3D=3D osd.2 =3D=3D=3D
> running...
> =3D=3D=3D osd.3 =3D=3D=3D
> dead.
>
> I finally paste the last lines of osd.0 :
>
> 2011-09-26 22:57:06.822182 7faf6a6f8700 -- 138.96.126.92:6802/3157 >>=
 138.96.126.93:6801/3162 pipe(0x7faf50001320 sd=3D20 pgs=3D0 cs=3D0 l=3D=
0).accept connect_seq 2 vs existing 1 state 3
> 2011-09-26 23:07:09.084901 7faf8e1b5700 FileStore: sync_entry timed o=
ut after 600 seconds.
> =A0ceph version 0.34 (commit:2f039eeeb745622b866d80feda7afa055e15f6d6=
)
> 2011-09-26 23:07:09.084934 1: (SafeTimer::timer_thread()+0x323) [0x5c=
95a3]
> 2011-09-26 23:07:09.084943 2: (SafeTimerThread::entry()+0xd) [0x5cbc7=
d]
> 2011-09-26 23:07:09.084950 3: /lib64/libpthread.so.0() [0x31fec077e1]
> 2011-09-26 23:07:09.084957 4: (clone()+0x6d) [0x31fe4e18ed]
> 2011-09-26 23:07:09.084963 *** Caught signal (Aborted) **
> =A0in thread 0x7faf8e1b5700
> =A0ceph version 0.34 (commit:2f039eeeb745622b866d80feda7afa055e15f6d6=
)
> =A01: /usr/bin/cosd() [0x649ca9]
> =A02: /lib64/libpthread.so.0() [0x31fec0f4c0]
> =A03: (gsignal()+0x35) [0x31fe4329a5]
> =A04: (abort()+0x175) [0x31fe434185]
> =A05: (__assert_fail()+0xf5) [0x31fe42b935]
> =A06: (SyncEntryTimeout::finish(int)+0x130) [0x683400]
> =A07: (SafeTimer::timer_thread()+0x323) [0x5c95a3]
> =A08: (SafeTimerThread::entry()+0xd) [0x5cbc7d]
> =A09: /lib64/libpthread.so.0() [0x31fec077e1]
> =A010: (clone()+0x6d) [0x31fe4e18ed]
may be the underlayer fs(btrfs/ext4)  is busy or hang that result the
sync_commit took more than 600s,the osd think it is dead, so use
ceph_abort to terminate cosd process.
> ceph.conf:
>
> [global]
> =A0 =A0 =A0 =A0max open files =3D 131072
> =A0 =A0 =A0 =A0log file =3D /var/log/ceph/$name.log
> =A0 =A0 =A0 =A0pid file =3D /var/run/ceph/$name.pid
> [mon]
> =A0 =A0 =A0 =A0mon data =3D /data/$name
> =A0 =A0 =A0 =A0mon clock drift allowed =3D 1
> [mon.alpha]
> =A0 =A0 =A0 =A0host =3D node91
> =A0 =A0 =A0 =A0mon addr =3D 138.96.126.91:6789
> [mon.beta]
> =A0 =A0 =A0 =A0host =3D node92
> =A0 =A0 =A0 =A0mon addr =3D 138.96.126.92:6789
> [mon.gamma]
> =A0 =A0 =A0 =A0host =3D node93
> =A0 =A0 =A0 =A0mon addr =3D 138.96.126.93:6789
> [mds]
>
> =A0 =A0 =A0 =A0keyring =3D /data/keyring.$name
> [mds.alpha]
> =A0 =A0 =A0 =A0host =3D node91
> [mds.beta]
> =A0 =A0 =A0 =A0host =3D node92
> [osd]
> =A0 =A0 =A0 =A0osd data =3D /data/$name
> =A0 =A0 =A0 =A0osd journal =3D /data/$name/journal
> =A0 =A0 =A0 =A0osd journal size =3D 1000
> [osd.0]
> =A0 =A0 =A0 =A0host =3D node92
> [osd.1]
> =A0 =A0 =A0 =A0host =3D node93
> [osd.2]
> =A0 =A0 =A0 =A0host =3D node94
> [osd.3]
> =A0 =A0 =A0 =A0host =3D node95
>
> ----
>
> Thank you one more time for your help.
>
> Regards
>
> C=E9dric
>
> Le 23 sept. 2011 =E0 19:20, Wido den Hollander a =E9crit :
>
>> Hi.
>>
>> Could you sent us your ceph.conf and the output of "ceph -s" ?
>>
>> Wido
>>
>> On Fri, 2011-09-23 at 17:58 +0200, Cedric Morandin wrote:
>>> Hi everybody,
>>>
>>> I didn't find any ceph-users list so I post here. If this is not th=
e right place to do it please let me know.
>>> I'm currently trying to test ceph but I'm probably doing something =
wrong because I have a really strange behavior.
>>>
>>> Context:
>>> Ceph compiled and installed on five Centos6 machines.
>>> A BTRFS partition is available on each machine.
>>> This partition is mounted under /data/osd.[0-3]
>>> Clients are using cfuse compiled for FC11 ( 2.6.29.4-167.fc11.x86_6=
4 )
>>>
>>> What happen:
>>> I configured everything in ceph.conf, started ceph daemons on all n=
odes.
>>> When I issue ceph health, I have a HEALTH_OK answer.
>>> I can access the filesystem through cfuse and create some files on =
it, but when I try to create files bigger than 2 or 3 Mo, the filesyste=
m hangs.
>>> When I try to copy an entire directory ( ceph sources for instance)=
 I have the same problem.
>>> When the system is in this state, the cosd daemon die on OSD machin=
es: [INF] osd0 out (down for 304.836218)
>>> Even killing it doesn't release the mountpoint :
>>> cosd =A0 =A0 =A0 9170 =A0 =A0 =A0root =A0 10uW =A0 =A0 REG =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A08,6 =A0 =A0 =A0 =A0 =A08 =A0 =A02506754 /data/os=
d.0/fsid
>>> cosd =A0 =A0 =A0 9170 =A0 =A0 =A0root =A0 11r =A0 =A0 =A0DIR =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A08,6 =A0 =A0 =A0 4096 =A0 =A02506753 /data/osd.0
>>> cosd =A0 =A0 =A0 9170 =A0 =A0 =A0root =A0 12r =A0 =A0 =A0DIR =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A08,6 =A0 =A0 =A024576 =A0 =A02506755 /data/osd.0=
/current
>>> cosd =A0 =A0 =A0 9170 =A0 =A0 =A0root =A0 13u =A0 =A0 =A0REG =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A08,6 =A0 =A0 =A0 =A0 =A04 =A0 =A02506757 /data/o=
sd.0/current/commit_op_seq
>>>
>>>
>>> I tried to change some parameters but it results in the same proble=
m:
>>> Tried both with the 0.34 and 0.35 releases and using both BTRFS or =
EXTR3 with user_attr attribute.
>>> I tried the cfuse client on one of the Centos 6 machine.
>>>
>>> I read everything on =A0http://ceph.newdream.net/wiki but I can't f=
igure out the problem.
>>> Does somebody have any clue of the problem's origin ?
>>>
>>> Regards,
>>>
>>> Cedric Morandin
>>>
>>>
>>>
>>
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
