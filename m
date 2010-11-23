From: jeff <cpwu@tnsoft.com.cn>
Subject: Re: mount error on cephv0.22.2
Date: Tue, 23 Nov 2010 15:19:46 +0800
Message-ID: <1290496786.1662.20.camel@cephhost>
References: <AANLkTinJUHUs1Zub-05ov=SXnLEn7mHrGihxnzad4G3+@mail.gmail.com>
	 <1289397347.2212.8.camel@wido-desktop>
	 <AANLkTinRfL3-MPB-22i7eO8Xqs2VJdu0r65Cc5kyBSDm@mail.gmail.com>
	 <1289463589.2233.0.camel@wido-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [210.22.136.227] ([210.22.136.227]:30550 "EHLO
	MAIL.TNSOFT.COM.CN" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752094Ab0KWHTF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Nov 2010 02:19:05 -0500
In-Reply-To: <1289463589.2233.0.camel@wido-desktop>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: srimugunthan dhandapani <srimugunthan.dhandapani@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


Hi ,=20

Are your OSDs disk file system btrfs ? or ext4 ,ext3 , or ??
i use ceph 0.23 , ubuntu 10.10 x86_64,2.6.35-22 ,mount btrfs osd is
successful, but mount ext4 osd fail, with its logs , it seems that it
should set "osd journal =3D /PATH/TO/JOURNAL" at ceph.conf and set
"user_xattr" at /etc/fstab. you can try it.

jeff





=E5=9C=A8 2010-11-11=E5=9B=9B=E7=9A=84 16:19 +0800=EF=BC=8CWido den Hol=
lander=E5=86=99=E9=81=93=EF=BC=9A
> Hi,
>=20
> Right now only the mount process is in status D, not the cosd process=
,
> do you still get the same messages in your dmesg?
>=20
> Wido
>=20
> On Wed, 2010-11-10 at 23:16 +0530, srimugunthan dhandapani wrote:
> > Hi
> > The process with the D state is:
> > root      5167  0.0  0.0   1804   240 pts/0    D+   23:09   0:00
> > /sbin/mount.ceph 192.168.1.79 / /ceph -o rw
> >=20
> > ps aux | grep ceph output is:
> >=20
> > 1000      1419  3.1  1.0  89684 21016 ?        S    23:04   0:15 ge=
dit
> > /home/srimugunthan/Desktop/ceph_checklist
> > root      4072  0.2  0.1  49604  3228 ?        Ssl  23:08   0:00
> > /usr/bin/cmon -i 0 -c /tmp/ceph.conf.3544
> > root      4589  0.4  0.1  73652  2988 ?        Ssl  23:08   0:00
> > /usr/bin/cmds -i node0 -c /tmp/ceph.conf.3544
> > root      5119  0.2  0.7 198356 15756 ?        Ssl  23:08   0:00
> > /usr/bin/cosd -i 1 -c /tmp/ceph.conf.3544
> > root      5157  0.0  0.0      0     0 ?        S<   23:09   0:00 [c=
eph-msgr]
> > root      5166  0.0  0.0   3788   608 pts/0    S+   23:09   0:00 mo=
unt
> > -t ceph 192.168.1.79:/ /ceph
> > root      5167  0.0  0.0   1804   240 pts/0    D+   23:09   0:00
> > /sbin/mount.ceph 192.168.1.79 / /ceph -o rw
> > root      5168  0.0  0.0      0     0 ?        S<   23:09   0:00
> > [ceph-writeback]
> > root      5169  0.0  0.0      0     0 ?        S<   23:09   0:00
> > [ceph-pg-invalid]
> > root      5170  0.0  0.0      0     0 ?        S<   23:09   0:00 [c=
eph-trunc]
> > root      5225  0.0  0.0   3372   732 pts/1    S+   23:12   0:00 gr=
ep
> > --color=3Dauto ceph
> >=20
> > ceph -s output is :
> > 2010-11-10 23:11:50.345617 b74296d0 -- :/5216 messenger.start
> > 2010-11-10 23:11:50.346006 b74296d0 -- :/5216 --> mon0
> > 192.168.1.79:6789/0 -- auth(proto 0 30 bytes) v1 -- ?+0 0x9b4f828
> > 2010-11-10 23:11:50.346464 b6426b70 -- 192.168.1.79:0/5216 learned =
my
> > addr 192.168.1.79:0/5216
> > 2010-11-10 23:11:50.347320 b7428b70 -- 192.168.1.79:0/5216 <=3D=3D =
mon0
> > 192.168.1.79:6789/0 1 =3D=3D=3D=3D auth_reply(proto 1 0 Success) v1=
 =3D=3D=3D=3D
> > 24+0+0 (1462504351 0 0) 0x9b51ae0
> > 2010-11-10 23:11:50.347475 b7428b70 -- 192.168.1.79:0/5216 --> mon0
> > 192.168.1.79:6789/0 -- mon_subscribe({monmap=3D0+}) v1 -- ?+0 0x9b5=
19c8
> > 2010-11-10 23:11:50.347529 b7428b70 -- 192.168.1.79:0/5216 --> mon0
> > 192.168.1.79:6789/0 -- observe(0 v0) v1 -- ?+0 0x9b51c40
> > 2010-11-10 23:11:50.347582 b7428b70 -- 192.168.1.79:0/5216 --> mon0
> > 192.168.1.79:6789/0 -- observe(1 v0) v1 -- ?+0 0x9b51df8
> > 2010-11-10 23:11:50.347675 b7428b70 -- 192.168.1.79:0/5216 --> mon0
> > 192.168.1.79:6789/0 -- observe(2 v0) v1 -- ?+0 0x9b4f9f0
> > 2010-11-10 23:11:50.347734 b7428b70 -- 192.168.1.79:0/5216 --> mon0
> > 192.168.1.79:6789/0 -- observe(3 v0) v1 -- ?+0 0x9b4fb10
> > 2010-11-10 23:11:50.347790 b7428b70 -- 192.168.1.79:0/5216 --> mon0
> > 192.168.1.79:6789/0 -- observe(4 v0) v1 -- ?+0 0x9b4fc40
> > 2010-11-10 23:11:50.347840 b7428b70 -- 192.168.1.79:0/5216 --> mon0
> > 192.168.1.79:6789/0 -- observe(5 v0) v1 -- ?+0 0x9b4fd70
> > 2010-11-10 23:11:50.347890 b7428b70 -- 192.168.1.79:0/5216 --> mon0
> > 192.168.1.79:6789/0 -- observe(6 v0) v1 -- ?+0 0x9b4fea0
> > 2010-11-10 23:11:50.348445 b7428b70 -- 192.168.1.79:0/5216 <=3D=3D =
mon0
> > 192.168.1.79:6789/0 2 =3D=3D=3D=3D mon_map v1 =3D=3D=3D=3D 187+0+0 =
(2881423474 0 0)
> > 0x9b51998
> > 2010-11-10 23:11:50.349157 b74296d0 -- 192.168.1.79:0/5216 --> mon0
> > 192.168.1.79:6789/0 -- observe(0 v0) v1 -- ?+0 0x9b51a98
> > 2010-11-10 23:11:50.349407 b7428b70 -- 192.168.1.79:0/5216 <=3D=3D =
mon0
> > 192.168.1.79:6789/0 3 =3D=3D=3D=3D mon_subscribe_ack(300s) v1 =3D=3D=
=3D=3D 20+0+0
> > (20232142 0 0) 0x9b51998
> > 2010-11-10 23:11:50.349628 b74296d0 -- 192.168.1.79:0/5216 --> mon0
> > 192.168.1.79:6789/0 -- observe(1 v0) v1 -- ?+0 0x9b51bb8
> > 2010-11-10 23:11:50.349708 b74296d0 -- 192.168.1.79:0/5216 --> mon0
> > 192.168.1.79:6789/0 -- observe(2 v0) v1 -- ?+0 0x9b51df8
> > 2010-11-10 23:11:50.349760 b74296d0 -- 192.168.1.79:0/5216 --> mon0
> > 192.168.1.79:6789/0 -- observe(3 v0) v1 -- ?+0 0x9b4f9f0
> > 2010-11-10 23:11:50.349812 b74296d0 -- 192.168.1.79:0/5216 --> mon0
> > 192.168.1.79:6789/0 -- observe(4 v0) v1 -- ?+0 0x9b4fb10
> > 2010-11-10 23:11:50.349861 b74296d0 -- 192.168.1.79:0/5216 --> mon0
> > 192.168.1.79:6789/0 -- observe(5 v0) v1 -- ?+0 0x9b4fc40
> > 2010-11-10 23:11:50.349912 b74296d0 -- 192.168.1.79:0/5216 --> mon0
> > 192.168.1.79:6789/0 -- observe(6 v0) v1 -- ?+0 0x9b51998
> > 2010-11-10 23:11:50.350574 b7428b70 -- 192.168.1.79:0/5216 <=3D=3D =
mon0
> > 192.168.1.79:6789/0 4 =3D=3D=3D=3D mon_observe_notify(v8 114646 byt=
es latest
> > v8) v1 =3D=3D=3D=3D 114697+0+0 (1311084701 0 0) 0x9b4f9f0
> > 2010-11-10 23:11:50.350674    pg v8: 528 pgs: 528
> > active+clean+degraded; 11 KB data, 89846 MB used, 30508 MB / 123 GB
> > avail; 10/20 degraded (50.000%)
> > 2010-11-10 23:11:50.354159 b7428b70 -- 192.168.1.79:0/5216 <=3D=3D =
mon0
> > 192.168.1.79:6789/0 5 =3D=3D=3D=3D mon_observe_notify(v4 459 bytes =
latest v4)
> > v1 =3D=3D=3D=3D 510+0+0 (3032970034 0 0) 0x9b7dcf8
> > 2010-11-10 23:11:50.354200   mds e4: 1/1/1 up {0=3Dup:active}
> > 2010-11-10 23:11:50.354250 b7428b70 -- 192.168.1.79:0/5216 <=3D=3D =
mon0
> > 192.168.1.79:6789/0 6 =3D=3D=3D=3D mon_observe_notify(v3 1638 bytes=
 latest v3)
> > v1 =3D=3D=3D=3D 1689+0+0 (4040025353 0 0) 0x9b7e568
> > 2010-11-10 23:11:50.354281   osd e3: 1 osds: 1 up, 1 in
> > 2010-11-10 23:11:50.354375 b7428b70 -- 192.168.1.79:0/5216 <=3D=3D =
mon0
> > 192.168.1.79:6789/0 10 =3D=3D=3D=3D mon_observe_notify(v5 1002 byte=
s latest
> > v5) v1 =3D=3D=3D=3D 1053+0+0 (180097538 0 0) 0x9b7f080
> > 2010-11-10 23:11:50.354409   log 2010-11-10 23:09:06.232712 mon0
> > 192.168.1.79:6789/0 4 : [INF] mds0 192.168.1.79:6800/4588 up:active
> > 2010-11-10 23:11:50.354469 b7428b70 -- 192.168.1.79:0/5216 <=3D=3D =
mon0
> > 192.168.1.79:6789/0 12 =3D=3D=3D=3D mon_observe_notify(v1 13 bytes =
latest v1)
> > v1 =3D=3D=3D=3D 64+0+0 (3469238695 0 0) 0x9b7f408
> > 2010-11-10 23:11:50.354508 b7428b70 -- 192.168.1.79:0/5216 <=3D=3D =
mon0
> > 192.168.1.79:6789/0 13 =3D=3D=3D=3D mon_observe_notify(v1 183 bytes=
 latest v1)
> > v1 =3D=3D=3D=3D 234+0+0 (1598745335 0 0) 0x9b7f6a0
> > 2010-11-10 23:11:50.354540   mon e1: 1 mons at {0=3D192.168.1.79:67=
89/0}
> > 2010-11-10 23:11:50.354573 b7428b70 -- 192.168.1.79:0/5216 <=3D=3D =
mon0
> > 192.168.1.79:6789/0 14 =3D=3D=3D=3D mon_observe_notify(v3 1025 byte=
s latest
> > v3) v1 =3D=3D=3D=3D 1076+0+0 (4171918925 0 0) 0x9b7fc80
> > 2010-11-10 23:11:50.355243 b74296d0 -- 192.168.1.79:0/5216 shutdown=
 complete.
> >=20
> > the new ceph.conf is attached.
> > Thanks,
> > mugunthan
> >=20
> >=20
> > On Wed, Nov 10, 2010 at 7:25 PM, Wido den Hollander <wido@widodh.nl=
> wrote:
> > > Hi,
> > >
> > > It seems you OSD is stalling.
> > >
> > > When you do "ps aux", do you see any processes in the "D" state (=
beside
> > > cosd)
> > >
> > > And what does "ceph -s" show?
> > >
> > > Btw, in your ceph.conf, use "host =3D <hostname>" instead of the
> > > IP-Address of the machine.
> > >
> > > Wido
> > >
> > > On Wed, 2010-11-10 at 18:45 +0530, srimugunthan dhandapani wrote:
> > >> Hi all,
> > >> I used v0.22.2 ceph with latest git "ceph-standalone-client kern=
el"
> > >> (2.6.36-rc8) and when i try to mount i get the following error
> > >> mount error 5 =3D Input/output error
> > >> the dmesg call trace is as follows:
> > >> [  199.099511] ceph: loaded (mds proto 32)
> > >> [  227.730778] libceph: client4099 fsid 2bf77910-49e4-89cb-8ef0-=
b74ce321acc4
> > >> [  227.730999] libceph: mon0 192.168.1.79:6789 session establish=
ed
> > >> [  360.236062] INFO: task cosd:5004 blocked for more than 120 se=
conds.
> > >> [  360.236068] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs=
"
> > >> disables this message.
> > >> [  360.236073] cosd          D f4f7df20     0  5004      1 0x000=
00000
> > >> [  360.236080]  f4f7df30 00200086 00000002 f4f7df20 f4f7dee8 c01=
673d0
> > >> ffffffff 00000000
> > >> [  360.236092]  c02383f0 f4f758d0 c085c940 f4f75b58 f4f75b5c 5ad=
ef48d
> > >> 00000035 c085c940
> > >> [  360.236104]  c085c940 c085c940 00000000 c085c940 5ade69ed 000=
00035
> > >> f4f758d0 00000001
> > >> [  360.236115] Call Trace:
> > >> [  360.236128]  [<c01673d0>] ? autoremove_wake_function+0x20/0x5=
0
> > >> [  360.236135]  [<c02383f0>] ? blkdev_writepage+0x0/0x20
> > >> [  360.236143]  [<c05a21e5>] rwsem_down_failed_common+0x95/0xf0
> > >> [  360.236148]  [<c05a2272>] rwsem_down_read_failed+0x12/0x20
> > >> [  360.236153]  [<c05a22c7>] call_rwsem_down_read_failed+0x7/0x1=
0
> > >> [  360.236157]  [<c05a16ec>] ? down_read+0x1c/0x20
> > >> [  360.236163]  [<c020f51f>] iterate_supers+0x5f/0xc0
> > >> [  360.236167]  [<c0230400>] ? sync_one_sb+0x0/0x30
> > >> [  360.236171]  [<c0230459>] sys_sync+0x29/0x60
> > >> [  360.236176]  [<c0102fe3>] sysenter_do_call+0x12/0x28
> > >>
> > >> my ceph.conf is attached. i was able to mount with the same ceph=
=2Econf
> > >> file in ceph0.21.1 and kernel 2.6.35  and also with ceph0.21.3 a=
nd
> > >> 2.6.35 kernel.
> > >> I got  the same error with v0.22.2 and kernel 2.6.35 . So i upda=
ted
> > >> the kernel but it didn't help.
> > >> In ceph code , in src/cmds.cc and src/cosd.cc i commented out th=
e line
> > >> //  g_conf.profiler_running =3D IsHeapProfilerRunning;
> > >> for the compilation to pass.
> > >>
> > >> the steps i used the following commands as root:
> > >>
> > >> mkcephfs -c /etc/ceph/ceph.conf --allhosts -v
> > >> /etc/init.d/ceph -a start
> > >> modprobe ceph
> > >> mount -t ceph 192.168.1.79:/ /ceph
> > >>
> > >> Kindly point out what i am missing.
> > >> thanks,
> > >> mugunthan
> > >
> > >
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
