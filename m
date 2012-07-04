From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: Re: RBD stale on VM, and RBD cache enable problem
Date: Wed, 4 Jul 2012 11:28:19 +0200
Message-ID: <CAMwB3Ti+gk-n+uf7xJajbKhoZ5h9vbVyw5OXNuoOvosFb6OqgA@mail.gmail.com>
References: <CAMwB3Tg_+aWekzGeAmXfraqkwgjzcjn-FsF52a4z_Us0SS=a6A@mail.gmail.com>
	<CAPYLRziFydW1N4-r5ZEH_4goMWiEDraSZz3ppA-R3RywB1Ba_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:34492 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049Ab2GDJ2V convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Jul 2012 05:28:21 -0400
Received: by lbbgm6 with SMTP id gm6so10896323lbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 04 Jul 2012 02:28:19 -0700 (PDT)
In-Reply-To: <CAPYLRziFydW1N4-r5ZEH_4goMWiEDraSZz3ppA-R3RywB1Ba_w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Jul 3, 2012 at 7:39 PM, Gregory Farnum <greg@inktank.com> wrote=
:
> On Mon, Jun 11, 2012 at 12:53 PM, S=B3awomir Skowron <szibis@gmail.co=
m> wrote:
>> I have two questions. My newly created cluster with xfs on all osd,
>> ubuntu precise, kernel 3.2.0-23-generic. Ceph 0.47.2-1precise
>>
>> pool 0 'data' rep size 3 crush_ruleset 0 object_hash rjenkins pg_num
>> 64 pgp_num 64 last_change 1228 owner 0 crash_replay_interval 45
>> pool 1 'metadata' rep size 3 crush_ruleset 1 object_hash rjenkins
>> pg_num 64 pgp_num 64 last_change 1226 owner 0
>> pool 2 'rbd' rep size 3 crush_ruleset 2 object_hash rjenkins pg_num =
64
>> pgp_num 64 last_change 1232 owner 0
>> pool 3 '.rgw' rep size 2 crush_ruleset 0 object_hash rjenkins pg_num=
 8
>> pgp_num 8 last_change 3878 owner 18446744073709551615
>>
>> 1. After i stop all daemons on 1 machine in my 3 node cluster with 3
>> replicas, rbd image operations on vm, staling. DD on this device in =
VM
>> freezing, and after ceph start on this machine everything goes onlin=
e.
>> Is there any problem with my config ?? in this situation ceph should
>> go from another copies with reads, and writes into another osd in
>> replica chain, yes ??
>
> It should switch to a new "primary" OSD as soon as they detect that
> one machine is missing, which by default will be ~25 seconds. How lon=
g
> did you wait to see if it would continue?
> If you'd like to reduce this time, you can turn down some combination=
 of
> osd_heartbeat_grace -- default 20 seconds, and controls how long an O=
SD
> will wait before it decides a peer is down.
> osd_min_down_reporters -- default 1, controls how many OSDs need to
> report an OSD as down before accepting it. This is already as low as
> it should go
> osd_min_down_reports -- default 3, controls how many failure reports
> the monitor needs to receive before accepting an OSD as down. Since
> you only have 3 OSDs, and one is down, leaving this at 3 means you're
> going to wait for osd_heartbeat_grace plus osd_mon_report_interval_mi=
n
> (default 5; don't change this) before an OSD is marked down.

Thanks for this options, i will try this on int cluster.

> Given the logging you include I'm a little concerned that you have 1
> PG "stale", indicating that the monitor hasn't gotten a report on tha=
t
> PG in a very long time. That means either that one PG is somehow
> broken, or else that the OSD you turned off isn't getting marked down
> and that PG is the only one noticing it.
> Could you re-run this test with monitor debugging turned up, see how
> long it takes for the OSD to get marked down (using "ceph -w"), and
> report back?

There will be some problems with this, because this cluster is newly
re-inited, from ext4, to xfs, and with many other changes. Actual
there are two clusters @ bottom of one application doing data sync to
this clusters.

What is real problem, is that in moment of backfill, when i change
crush config, and rebalancing starting, or machine/group of osd goes
down, radosgw has some problems, with PUT request (writes) in next 9
minutes, cause some 504 (timeout on loadbalancer) in nginx, and down,
some delayed operations in Ceph cluster.

I will try to test this on integration cluster, but in this sprint it
will be difficult :(

> -Greg
>
>> Another test iozone on device, and it's stop after daemons stop on 1
>> machine, and after osd up, iozone go forward, how can i tune this to
>> work without freeze ??
>>
>> 2012-06-11 21:38:49.583133    pg v88173: 200 pgs: 60 active+clean, 1
>> stale+active+clean, 139 active+degraded; 783 GB data, 1928 GB used,
>> 18111 GB / 20040 GB avail; 78169/254952 degraded (30.660%)
>> 2012-06-11 21:38:50.582257    pg v88174: 200 pgs: 60 active+clean, 1
>> stale+active+clean, 139 active+degraded; 783 GB data, 1928 GB used,
>> 18111 GB / 20040 GB avail; 78169/254952 degraded (30.660%)
>> .....
>> 2012-06-11 21:39:49.991893    pg v88197: 200 pgs: 60 active+clean, 1
>> stale+active+clean, 139 active+degraded; 783 GB data, 1928 GB used,
>> 18111 GB / 20040 GB avail; 78169/254952 degraded (30.660%)
>> 2012-06-11 21:39:50.992755    pg v88198: 200 pgs: 60 active+clean, 1
>> stale+active+clean, 139 active+degraded; 783 GB data, 1928 GB used,
>> 18111 GB / 20040 GB avail; 78169/254952 degraded (30.660%)
>> 2012-06-11 21:39:51.993533    pg v88199: 200 pgs: 60 active+clean, 1
>> stale+active+clean, 139 active+degraded; 783 GB data, 1928 GB used,
>> 18111 GB / 20040 GB avail; 78169/254952 degraded (30.660%)
>> 2012-06-11 21:39:52.994397    pg v88200: 200 pgs: 60 active+clean, 1
>> stale+active+clean, 139 active+degraded; 783 GB data, 1928 GB used,
>> 18111 GB / 20040 GB avail; 78169/254952 degraded (30.660%)
>>
>> After boot all osd on stoped machine:
>>
>> 2012-06-11 21:40:37.826619   osd e4162: 72 osds: 53 up, 72 in
>> 2012-06-11 21:40:37.825706 mon.0 10.177.66.4:6790/0 348 : [INF] osd.=
24
>> 10.177.66.6:6800/21597 boot
>> 2012-06-11 21:40:38.825297    pg v88202: 200 pgs: 54 active+clean, 7
>> stale+active+clean, 139 active+degraded; 783 GB data, 1928 GB used,
>> 18111 GB / 20040 GB avail; 78169/254952 degraded (30.660%)
>> 2012-06-11 21:40:38.826517   osd e4163: 72 osds: 54 up, 72 in
>> 2012-06-11 21:40:38.825250 mon.0 10.177.66.4:6790/0 349 : [INF] osd.=
25
>> 10.177.66.6:6803/21712 boot
>> 2012-06-11 21:40:38.825655 mon.0 10.177.66.4:6790/0 350 : [INF] osd.=
28
>> 10.177.66.6:6812/26210 boot
>> 2012-06-11 21:40:38.825907 mon.0 10.177.66.4:6790/0 351 : [INF] osd.=
29
>> 10.177.66.6:6815/26327 boot
>> 2012-06-11 21:40:39.826738    pg v88203: 200 pgs: 56 active+clean, 4
>> stale+active+clean, 3 peering, 137 active+degraded; 783 GB data, 192=
8
>> GB used, 18111 GB / 20040 GB avail; 76921/254952 degraded (30.171%)
>> 2012-06-11 21:40:39.830098   osd e4164: 72 osds: 59 up, 72 in
>> 2012-06-11 21:40:39.826570 mon.0 10.177.66.4:6790/0 352 : [INF] osd.=
26
>> 10.177.66.6:6806/21835 boot
>> 2012-06-11 21:40:39.826961 mon.0 10.177.66.4:6790/0 353 : [INF] osd.=
27
>> 10.177.66.6:6809/21953 boot
>> 2012-06-11 21:40:39.828147 mon.0 10.177.66.4:6790/0 354 : [INF] osd.=
30
>> 10.177.66.6:6818/26511 boot
>> 2012-06-11 21:40:39.828418 mon.0 10.177.66.4:6790/0 355 : [INF] osd.=
31
>> 10.177.66.6:6821/26583 boot
>> 2012-06-11 21:40:39.828935 mon.0 10.177.66.4:6790/0 356 : [INF] osd.=
33
>> 10.177.66.6:6827/26859 boot
>> 2012-06-11 21:40:39.829274 mon.0 10.177.66.4:6790/0 357 : [INF] osd.=
34
>> 10.177.66.6:6830/26979 boot
>> 2012-06-11 21:40:40.827935    pg v88204: 200 pgs: 56 active+clean, 4
>> stale+active+clean, 3 peering, 137 active+degraded; 783 GB data, 192=
8
>> GB used, 18111 GB / 20040 GB avail; 76921/254952 degraded (30.171%)
>> 2012-06-11 21:40:40.830059   osd e4165: 72 osds: 62 up, 72 in
>> 2012-06-11 21:40:40.827798 mon.0 10.177.66.4:6790/0 358 : [INF] osd.=
32
>> 10.177.66.6:6824/26701 boot
>> 2012-06-11 21:40:40.829043 mon.0 10.177.66.4:6790/0 359 : [INF] osd.=
35
>> 10.177.66.6:6833/27165 boot
>> 2012-06-11 21:40:40.829316 mon.0 10.177.66.4:6790/0 360 : [INF] osd.=
36
>> 10.177.66.6:6836/27280 boot
>> 2012-06-11 21:40:40.829602 mon.0 10.177.66.4:6790/0 361 : [INF] osd.=
37
>> 10.177.66.6:6839/27397 boot
>> 2012-06-11 21:40:41.828776    pg v88205: 200 pgs: 56 active+clean, 4
>> stale+active+clean, 3 peering, 137 active+degraded; 783 GB data, 192=
8
>> GB used, 18111 GB / 20040 GB avail; 76921/254952 degraded (30.171%)
>> 2012-06-11 21:40:41.831823   osd e4166: 72 osds: 68 up, 72 in
>> 2012-06-11 21:40:41.828713 mon.0 10.177.66.4:6790/0 362 : [INF] osd.=
38
>> 10.177.66.6:6842/27513 boot
>> 2012-06-11 21:40:41.829440 mon.0 10.177.66.4:6790/0 363 : [INF] osd.=
39
>> 10.177.66.6:6845/27628 boot
>> 2012-06-11 21:40:41.830226 mon.0 10.177.66.4:6790/0 364 : [INF] osd.=
40
>> 10.177.66.6:6848/27835 boot
>> 2012-06-11 21:40:41.830531 mon.0 10.177.66.4:6790/0 365 : [INF] osd.=
41
>> 10.177.66.6:6851/27950 boot
>> 2012-06-11 21:40:41.830778 mon.0 10.177.66.4:6790/0 366 : [INF] osd.=
42
>> 10.177.66.6:6854/28065 boot
>> 2012-06-11 21:40:41.831249 mon.0 10.177.66.4:6790/0 367 : [INF] osd.=
43
>> 10.177.66.6:6857/28181 boot
>> 2012-06-11 21:40:42.830440    pg v88206: 200 pgs: 57 active+clean, 4
>> stale+active+clean, 7 peering, 132 active+degraded; 783 GB data, 192=
8
>> GB used, 18111 GB / 20040 GB avail; 75543/254952 degraded (29.630%)
>> 2012-06-11 21:40:42.833294   osd e4167: 72 osds: 72 up, 72 in
>> 2012-06-11 21:40:42.831046 mon.0 10.177.66.4:6790/0 368 : [INF] osd.=
44
>> 10.177.66.6:6860/28373 boot
>> 2012-06-11 21:40:42.832004 mon.0 10.177.66.4:6790/0 369 : [INF] osd.=
45
>> 10.177.66.6:6863/28489 boot
>> 2012-06-11 21:40:42.832314 mon.0 10.177.66.4:6790/0 370 : [INF] osd.=
46
>> 10.177.66.6:6866/28607 boot
>> 2012-06-11 21:40:42.832545 mon.0 10.177.66.4:6790/0 371 : [INF] osd.=
47
>> 10.177.66.6:6869/28731 boot
>> 2012-06-11 21:40:43.830481    pg v88207: 200 pgs: 64 active+clean, 4
>> stale+active+clean, 7 peering, 125 active+degraded; 783 GB data, 192=
8
>> GB used, 18111 GB / 20040 GB avail; 72874/254952 degraded (28.583%)
>> 2012-06-11 21:40:43.831113   osd e4168: 72 osds: 72 up, 72 in
>> 2012-06-11 21:40:44.832521    pg v88208: 200 pgs: 79 active+clean, 1
>> stale+active+clean, 4 peering, 113 active+degraded, 3
>> active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
>> avail; 66185/254952 degraded (25.960%)
>> 2012-06-11 21:40:45.834077    pg v88209: 200 pgs: 104 active+clean, =
1
>> stale+active+clean, 4 peering, 85 active+degraded, 6
>> active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
>> avail; 50399/254952 degraded (19.768%)
>> 2012-06-11 21:40:46.835367    pg v88210: 200 pgs: 125 active+clean, =
1
>> stale+active+clean, 4 peering, 59 active+degraded, 11
>> active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
>> avail; 38563/254952 degraded (15.126%)
>> 2012-06-11 21:40:47.836516    pg v88211: 200 pgs: 158 active+clean, =
1
>> stale+active+clean, 26 active+degraded, 15 active+recovering; 783 GB
>> data, 1928 GB used, 18111 GB / 20040 GB avail; 18542/254952 degraded
>> (7.273%)
>> 2012-06-11 21:40:48.853560    pg v88212: 200 pgs: 184 active+clean, =
16
>> active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
>> avail; 1/254952 degraded (0.000%)
>> 2012-06-11 21:40:49.868514    pg v88213: 200 pgs: 184 active+clean, =
16
>> active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
>> avail; 1/254952 degraded (0.000%)
>> 2012-06-11 21:40:50.858244    pg v88214: 200 pgs: 184 active+clean, =
16
>> active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
>> avail; 1/254952 degraded (0.000%)
>> 2012-06-11 21:40:51.845622    pg v88215: 200 pgs: 184 active+clean, =
16
>> active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
>> avail
>> 2012-06-11 21:40:52.857823    pg v88216: 200 pgs: 184 active+clean, =
16
>> active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
>> avail
>> 2012-06-11 21:40:53.858281    pg v88217: 200 pgs: 184 active+clean, =
16
>> active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
>> avail
>> 2012-06-11 21:40:54.855602    pg v88218: 200 pgs: 184 active+clean, =
16
>> active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
>> avail
>> 2012-06-11 21:40:55.857241    pg v88219: 200 pgs: 184 active+clean, =
16
>> active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
>> avail
>> 2012-06-11 21:40:56.857631    pg v88220: 200 pgs: 184 active+clean, =
16
>> active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
>> avail
>> 2012-06-11 21:40:57.858987    pg v88221: 200 pgs: 185 active+clean, =
15
>> active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
>> avail
>> 2012-06-11 21:40:58.880252    pg v88222: 200 pgs: 185 active+clean, =
15
>> active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
>> avail
>> 2012-06-11 21:40:59.861910    pg v88223: 200 pgs: 188 active+clean, =
12
>> active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
>> avail
>> 2012-06-11 21:41:00.902582    pg v88224: 200 pgs: 191 active+clean, =
9
>> active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
>> avail
>> 2012-06-11 21:41:01.907767    pg v88225: 200 pgs: 196 active+clean, =
4
>> active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
>> avail
>> 2012-06-11 21:41:02.876377    pg v88226: 200 pgs: 199 active+clean, =
1
>> active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
>> avail
>> 2012-06-11 21:41:03.876929    pg v88227: 200 pgs: 200 active+clean;
>> 783 GB data, 1928 GB used, 18111 GB / 20040 GB avail
>>
>> <disk type=3D"network" device=3D"disk">
>>          <driver name=3D"qemu" type=3D"raw"/>
>>          <source protocol=3D"rbd" name=3D"rbd/foo4">
>>          </source>
>>          <target dev=3D"vdf" bus=3D"virtio"/>
>> </disk>
>>
>> 2. When i use rbd_cache=3D1, or true in my xml, for libvirt i get:
>>
>> <disk type=3D"network" device=3D"disk">
>>          <driver name=3D"qemu" type=3D"raw"/>
>>          <source protocol=3D"rbd" name=3D"rbd/foo5:rbd_cache=3D1">
>>          </source>
>>          <target dev=3D"vdf" bus=3D"virtio"/>
>> </disk>
>>
>> libvirtd.log
>> 2012-06-11 18:50:36.992+0000: 1751: error :
>> qemuMonitorTextAddDrive:2820 : operation failed: open disk image fil=
e
>> failed
>>
>> Libvirt version 0.9.8-2ubuntu17 with some additional patch set befor=
e
>> ceph 0.46 version appears. Qemu-kvm 1.0+noroms-0ubuntu13.
>>
>> Do i need any other patch for libvirt ?? Without rbd_cache attaching=
 is ok.
>>
>> --
>> -----
>> Pozdrawiam
>>
>> S=B3awek "sZiBis" Skowron



--=20
-----
Pozdrawiam

S=B3awek "sZiBis" Skowron
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
