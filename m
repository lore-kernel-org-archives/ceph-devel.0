From: Gregory Farnum <greg@inktank.com>
Subject: Re: RBD stale on VM, and RBD cache enable problem
Date: Tue, 3 Jul 2012 10:39:56 -0700
Message-ID: <CAPYLRziFydW1N4-r5ZEH_4goMWiEDraSZz3ppA-R3RywB1Ba_w@mail.gmail.com>
References: <CAMwB3Tg_+aWekzGeAmXfraqkwgjzcjn-FsF52a4z_Us0SS=a6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:58633 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932083Ab2GCRj5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jul 2012 13:39:57 -0400
Received: by lbbgm6 with SMTP id gm6so9825937lbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 03 Jul 2012 10:39:56 -0700 (PDT)
In-Reply-To: <CAMwB3Tg_+aWekzGeAmXfraqkwgjzcjn-FsF52a4z_Us0SS=a6A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Jun 11, 2012 at 12:53 PM, S=C5=82awomir Skowron <szibis@gmail.c=
om> wrote:
> I have two questions. My newly created cluster with xfs on all osd,
> ubuntu precise, kernel 3.2.0-23-generic. Ceph 0.47.2-1precise
>
> pool 0 'data' rep size 3 crush_ruleset 0 object_hash rjenkins pg_num
> 64 pgp_num 64 last_change 1228 owner 0 crash_replay_interval 45
> pool 1 'metadata' rep size 3 crush_ruleset 1 object_hash rjenkins
> pg_num 64 pgp_num 64 last_change 1226 owner 0
> pool 2 'rbd' rep size 3 crush_ruleset 2 object_hash rjenkins pg_num 6=
4
> pgp_num 64 last_change 1232 owner 0
> pool 3 '.rgw' rep size 2 crush_ruleset 0 object_hash rjenkins pg_num =
8
> pgp_num 8 last_change 3878 owner 18446744073709551615
>
> 1. After i stop all daemons on 1 machine in my 3 node cluster with 3
> replicas, rbd image operations on vm, staling. DD on this device in V=
M
> freezing, and after ceph start on this machine everything goes online=
=2E
> Is there any problem with my config ?? in this situation ceph should
> go from another copies with reads, and writes into another osd in
> replica chain, yes ??

It should switch to a new "primary" OSD as soon as they detect that
one machine is missing, which by default will be ~25 seconds. How long
did you wait to see if it would continue?
If you'd like to reduce this time, you can turn down some combination o=
f
osd_heartbeat_grace =E2=80=94=C2=A0default 20 seconds, and controls how=
 long an OSD
will wait before it decides a peer is down.
osd_min_down_reporters =E2=80=94=C2=A0default 1, controls how many OSDs=
 need to
report an OSD as down before accepting it. This is already as low as
it should go
osd_min_down_reports =E2=80=94=C2=A0default 3, controls how many failur=
e reports
the monitor needs to receive before accepting an OSD as down. Since
you only have 3 OSDs, and one is down, leaving this at 3 means you're
going to wait for osd_heartbeat_grace plus osd_mon_report_interval_min
(default 5; don't change this) before an OSD is marked down.

Given the logging you include I'm a little concerned that you have 1
PG "stale", indicating that the monitor hasn't gotten a report on that
PG in a very long time. That means either that one PG is somehow
broken, or else that the OSD you turned off isn't getting marked down
and that PG is the only one noticing it.
Could you re-run this test with monitor debugging turned up, see how
long it takes for the OSD to get marked down (using "ceph -w"), and
report back?
-Greg

> Another test iozone on device, and it's stop after daemons stop on 1
> machine, and after osd up, iozone go forward, how can i tune this to
> work without freeze ??
>
> 2012-06-11 21:38:49.583133 =C2=A0 =C2=A0pg v88173: 200 pgs: 60 active=
+clean, 1
> stale+active+clean, 139 active+degraded; 783 GB data, 1928 GB used,
> 18111 GB / 20040 GB avail; 78169/254952 degraded (30.660%)
> 2012-06-11 21:38:50.582257 =C2=A0 =C2=A0pg v88174: 200 pgs: 60 active=
+clean, 1
> stale+active+clean, 139 active+degraded; 783 GB data, 1928 GB used,
> 18111 GB / 20040 GB avail; 78169/254952 degraded (30.660%)
> .....
> 2012-06-11 21:39:49.991893 =C2=A0 =C2=A0pg v88197: 200 pgs: 60 active=
+clean, 1
> stale+active+clean, 139 active+degraded; 783 GB data, 1928 GB used,
> 18111 GB / 20040 GB avail; 78169/254952 degraded (30.660%)
> 2012-06-11 21:39:50.992755 =C2=A0 =C2=A0pg v88198: 200 pgs: 60 active=
+clean, 1
> stale+active+clean, 139 active+degraded; 783 GB data, 1928 GB used,
> 18111 GB / 20040 GB avail; 78169/254952 degraded (30.660%)
> 2012-06-11 21:39:51.993533 =C2=A0 =C2=A0pg v88199: 200 pgs: 60 active=
+clean, 1
> stale+active+clean, 139 active+degraded; 783 GB data, 1928 GB used,
> 18111 GB / 20040 GB avail; 78169/254952 degraded (30.660%)
> 2012-06-11 21:39:52.994397 =C2=A0 =C2=A0pg v88200: 200 pgs: 60 active=
+clean, 1
> stale+active+clean, 139 active+degraded; 783 GB data, 1928 GB used,
> 18111 GB / 20040 GB avail; 78169/254952 degraded (30.660%)
>
> After boot all osd on stoped machine:
>
> 2012-06-11 21:40:37.826619 =C2=A0 osd e4162: 72 osds: 53 up, 72 in
> 2012-06-11 21:40:37.825706 mon.0 10.177.66.4:6790/0 348 : [INF] osd.2=
4
> 10.177.66.6:6800/21597 boot
> 2012-06-11 21:40:38.825297 =C2=A0 =C2=A0pg v88202: 200 pgs: 54 active=
+clean, 7
> stale+active+clean, 139 active+degraded; 783 GB data, 1928 GB used,
> 18111 GB / 20040 GB avail; 78169/254952 degraded (30.660%)
> 2012-06-11 21:40:38.826517 =C2=A0 osd e4163: 72 osds: 54 up, 72 in
> 2012-06-11 21:40:38.825250 mon.0 10.177.66.4:6790/0 349 : [INF] osd.2=
5
> 10.177.66.6:6803/21712 boot
> 2012-06-11 21:40:38.825655 mon.0 10.177.66.4:6790/0 350 : [INF] osd.2=
8
> 10.177.66.6:6812/26210 boot
> 2012-06-11 21:40:38.825907 mon.0 10.177.66.4:6790/0 351 : [INF] osd.2=
9
> 10.177.66.6:6815/26327 boot
> 2012-06-11 21:40:39.826738 =C2=A0 =C2=A0pg v88203: 200 pgs: 56 active=
+clean, 4
> stale+active+clean, 3 peering, 137 active+degraded; 783 GB data, 1928
> GB used, 18111 GB / 20040 GB avail; 76921/254952 degraded (30.171%)
> 2012-06-11 21:40:39.830098 =C2=A0 osd e4164: 72 osds: 59 up, 72 in
> 2012-06-11 21:40:39.826570 mon.0 10.177.66.4:6790/0 352 : [INF] osd.2=
6
> 10.177.66.6:6806/21835 boot
> 2012-06-11 21:40:39.826961 mon.0 10.177.66.4:6790/0 353 : [INF] osd.2=
7
> 10.177.66.6:6809/21953 boot
> 2012-06-11 21:40:39.828147 mon.0 10.177.66.4:6790/0 354 : [INF] osd.3=
0
> 10.177.66.6:6818/26511 boot
> 2012-06-11 21:40:39.828418 mon.0 10.177.66.4:6790/0 355 : [INF] osd.3=
1
> 10.177.66.6:6821/26583 boot
> 2012-06-11 21:40:39.828935 mon.0 10.177.66.4:6790/0 356 : [INF] osd.3=
3
> 10.177.66.6:6827/26859 boot
> 2012-06-11 21:40:39.829274 mon.0 10.177.66.4:6790/0 357 : [INF] osd.3=
4
> 10.177.66.6:6830/26979 boot
> 2012-06-11 21:40:40.827935 =C2=A0 =C2=A0pg v88204: 200 pgs: 56 active=
+clean, 4
> stale+active+clean, 3 peering, 137 active+degraded; 783 GB data, 1928
> GB used, 18111 GB / 20040 GB avail; 76921/254952 degraded (30.171%)
> 2012-06-11 21:40:40.830059 =C2=A0 osd e4165: 72 osds: 62 up, 72 in
> 2012-06-11 21:40:40.827798 mon.0 10.177.66.4:6790/0 358 : [INF] osd.3=
2
> 10.177.66.6:6824/26701 boot
> 2012-06-11 21:40:40.829043 mon.0 10.177.66.4:6790/0 359 : [INF] osd.3=
5
> 10.177.66.6:6833/27165 boot
> 2012-06-11 21:40:40.829316 mon.0 10.177.66.4:6790/0 360 : [INF] osd.3=
6
> 10.177.66.6:6836/27280 boot
> 2012-06-11 21:40:40.829602 mon.0 10.177.66.4:6790/0 361 : [INF] osd.3=
7
> 10.177.66.6:6839/27397 boot
> 2012-06-11 21:40:41.828776 =C2=A0 =C2=A0pg v88205: 200 pgs: 56 active=
+clean, 4
> stale+active+clean, 3 peering, 137 active+degraded; 783 GB data, 1928
> GB used, 18111 GB / 20040 GB avail; 76921/254952 degraded (30.171%)
> 2012-06-11 21:40:41.831823 =C2=A0 osd e4166: 72 osds: 68 up, 72 in
> 2012-06-11 21:40:41.828713 mon.0 10.177.66.4:6790/0 362 : [INF] osd.3=
8
> 10.177.66.6:6842/27513 boot
> 2012-06-11 21:40:41.829440 mon.0 10.177.66.4:6790/0 363 : [INF] osd.3=
9
> 10.177.66.6:6845/27628 boot
> 2012-06-11 21:40:41.830226 mon.0 10.177.66.4:6790/0 364 : [INF] osd.4=
0
> 10.177.66.6:6848/27835 boot
> 2012-06-11 21:40:41.830531 mon.0 10.177.66.4:6790/0 365 : [INF] osd.4=
1
> 10.177.66.6:6851/27950 boot
> 2012-06-11 21:40:41.830778 mon.0 10.177.66.4:6790/0 366 : [INF] osd.4=
2
> 10.177.66.6:6854/28065 boot
> 2012-06-11 21:40:41.831249 mon.0 10.177.66.4:6790/0 367 : [INF] osd.4=
3
> 10.177.66.6:6857/28181 boot
> 2012-06-11 21:40:42.830440 =C2=A0 =C2=A0pg v88206: 200 pgs: 57 active=
+clean, 4
> stale+active+clean, 7 peering, 132 active+degraded; 783 GB data, 1928
> GB used, 18111 GB / 20040 GB avail; 75543/254952 degraded (29.630%)
> 2012-06-11 21:40:42.833294 =C2=A0 osd e4167: 72 osds: 72 up, 72 in
> 2012-06-11 21:40:42.831046 mon.0 10.177.66.4:6790/0 368 : [INF] osd.4=
4
> 10.177.66.6:6860/28373 boot
> 2012-06-11 21:40:42.832004 mon.0 10.177.66.4:6790/0 369 : [INF] osd.4=
5
> 10.177.66.6:6863/28489 boot
> 2012-06-11 21:40:42.832314 mon.0 10.177.66.4:6790/0 370 : [INF] osd.4=
6
> 10.177.66.6:6866/28607 boot
> 2012-06-11 21:40:42.832545 mon.0 10.177.66.4:6790/0 371 : [INF] osd.4=
7
> 10.177.66.6:6869/28731 boot
> 2012-06-11 21:40:43.830481 =C2=A0 =C2=A0pg v88207: 200 pgs: 64 active=
+clean, 4
> stale+active+clean, 7 peering, 125 active+degraded; 783 GB data, 1928
> GB used, 18111 GB / 20040 GB avail; 72874/254952 degraded (28.583%)
> 2012-06-11 21:40:43.831113 =C2=A0 osd e4168: 72 osds: 72 up, 72 in
> 2012-06-11 21:40:44.832521 =C2=A0 =C2=A0pg v88208: 200 pgs: 79 active=
+clean, 1
> stale+active+clean, 4 peering, 113 active+degraded, 3
> active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
> avail; 66185/254952 degraded (25.960%)
> 2012-06-11 21:40:45.834077 =C2=A0 =C2=A0pg v88209: 200 pgs: 104 activ=
e+clean, 1
> stale+active+clean, 4 peering, 85 active+degraded, 6
> active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
> avail; 50399/254952 degraded (19.768%)
> 2012-06-11 21:40:46.835367 =C2=A0 =C2=A0pg v88210: 200 pgs: 125 activ=
e+clean, 1
> stale+active+clean, 4 peering, 59 active+degraded, 11
> active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
> avail; 38563/254952 degraded (15.126%)
> 2012-06-11 21:40:47.836516 =C2=A0 =C2=A0pg v88211: 200 pgs: 158 activ=
e+clean, 1
> stale+active+clean, 26 active+degraded, 15 active+recovering; 783 GB
> data, 1928 GB used, 18111 GB / 20040 GB avail; 18542/254952 degraded
> (7.273%)
> 2012-06-11 21:40:48.853560 =C2=A0 =C2=A0pg v88212: 200 pgs: 184 activ=
e+clean, 16
> active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
> avail; 1/254952 degraded (0.000%)
> 2012-06-11 21:40:49.868514 =C2=A0 =C2=A0pg v88213: 200 pgs: 184 activ=
e+clean, 16
> active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
> avail; 1/254952 degraded (0.000%)
> 2012-06-11 21:40:50.858244 =C2=A0 =C2=A0pg v88214: 200 pgs: 184 activ=
e+clean, 16
> active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
> avail; 1/254952 degraded (0.000%)
> 2012-06-11 21:40:51.845622 =C2=A0 =C2=A0pg v88215: 200 pgs: 184 activ=
e+clean, 16
> active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
> avail
> 2012-06-11 21:40:52.857823 =C2=A0 =C2=A0pg v88216: 200 pgs: 184 activ=
e+clean, 16
> active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
> avail
> 2012-06-11 21:40:53.858281 =C2=A0 =C2=A0pg v88217: 200 pgs: 184 activ=
e+clean, 16
> active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
> avail
> 2012-06-11 21:40:54.855602 =C2=A0 =C2=A0pg v88218: 200 pgs: 184 activ=
e+clean, 16
> active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
> avail
> 2012-06-11 21:40:55.857241 =C2=A0 =C2=A0pg v88219: 200 pgs: 184 activ=
e+clean, 16
> active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
> avail
> 2012-06-11 21:40:56.857631 =C2=A0 =C2=A0pg v88220: 200 pgs: 184 activ=
e+clean, 16
> active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
> avail
> 2012-06-11 21:40:57.858987 =C2=A0 =C2=A0pg v88221: 200 pgs: 185 activ=
e+clean, 15
> active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
> avail
> 2012-06-11 21:40:58.880252 =C2=A0 =C2=A0pg v88222: 200 pgs: 185 activ=
e+clean, 15
> active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
> avail
> 2012-06-11 21:40:59.861910 =C2=A0 =C2=A0pg v88223: 200 pgs: 188 activ=
e+clean, 12
> active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
> avail
> 2012-06-11 21:41:00.902582 =C2=A0 =C2=A0pg v88224: 200 pgs: 191 activ=
e+clean, 9
> active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
> avail
> 2012-06-11 21:41:01.907767 =C2=A0 =C2=A0pg v88225: 200 pgs: 196 activ=
e+clean, 4
> active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
> avail
> 2012-06-11 21:41:02.876377 =C2=A0 =C2=A0pg v88226: 200 pgs: 199 activ=
e+clean, 1
> active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
> avail
> 2012-06-11 21:41:03.876929 =C2=A0 =C2=A0pg v88227: 200 pgs: 200 activ=
e+clean;
> 783 GB data, 1928 GB used, 18111 GB / 20040 GB avail
>
> <disk type=3D"network" device=3D"disk">
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<driver name=3D"qemu" type=3D"raw"/=
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<source protocol=3D"rbd" name=3D"rb=
d/foo4">
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0</source>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<target dev=3D"vdf" bus=3D"virtio"/=
>
> </disk>
>
> 2. When i use rbd_cache=3D1, or true in my xml, for libvirt i get:
>
> <disk type=3D"network" device=3D"disk">
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<driver name=3D"qemu" type=3D"raw"/=
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<source protocol=3D"rbd" name=3D"rb=
d/foo5:rbd_cache=3D1">
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0</source>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<target dev=3D"vdf" bus=3D"virtio"/=
>
> </disk>
>
> libvirtd.log
> 2012-06-11 18:50:36.992+0000: 1751: error :
> qemuMonitorTextAddDrive:2820 : operation failed: open disk image file
> failed
>
> Libvirt version 0.9.8-2ubuntu17 with some additional patch set before
> ceph 0.46 version appears. Qemu-kvm 1.0+noroms-0ubuntu13.
>
> Do i need any other patch for libvirt ?? Without rbd_cache attaching =
is ok.
>
> --
> -----
> Pozdrawiam
>
> S=C5=82awek "sZiBis" Skowron
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
