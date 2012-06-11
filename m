From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: RBD stale on VM, and RBD cache enable problem
Date: Mon, 11 Jun 2012 21:53:07 +0200
Message-ID: <CAMwB3Tg_+aWekzGeAmXfraqkwgjzcjn-FsF52a4z_Us0SS=a6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001485f6288ce9743504c237b251
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:60886 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495Ab2FKTxJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Jun 2012 15:53:09 -0400
Received: by wgbdr13 with SMTP id dr13so3644070wgb.1
        for <ceph-devel@vger.kernel.org>; Mon, 11 Jun 2012 12:53:07 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

--001485f6288ce9743504c237b251
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I have two questions. My newly created cluster with xfs on all osd,
ubuntu precise, kernel 3.2.0-23-generic. Ceph 0.47.2-1precise

pool 0 'data' rep size 3 crush_ruleset 0 object_hash rjenkins pg_num
64 pgp_num 64 last_change 1228 owner 0 crash_replay_interval 45
pool 1 'metadata' rep size 3 crush_ruleset 1 object_hash rjenkins
pg_num 64 pgp_num 64 last_change 1226 owner 0
pool 2 'rbd' rep size 3 crush_ruleset 2 object_hash rjenkins pg_num 64
pgp_num 64 last_change 1232 owner 0
pool 3 '.rgw' rep size 2 crush_ruleset 0 object_hash rjenkins pg_num 8
pgp_num 8 last_change 3878 owner 18446744073709551615

1. After i stop all daemons on 1 machine in my 3 node cluster with 3
replicas, rbd image operations on vm, staling. DD on this device in VM
freezing, and after ceph start on this machine everything goes online.
Is there any problem with my config ?? in this situation ceph should
go from another copies with reads, and writes into another osd in
replica chain, yes ??

Another test iozone on device, and it's stop after daemons stop on 1
machine, and after osd up, iozone go forward, how can i tune this to
work without freeze ??

2012-06-11 21:38:49.583133    pg v88173: 200 pgs: 60 active+clean, 1
stale+active+clean, 139 active+degraded; 783 GB data, 1928 GB used,
18111 GB / 20040 GB avail; 78169/254952 degraded (30.660%)
2012-06-11 21:38:50.582257    pg v88174: 200 pgs: 60 active+clean, 1
stale+active+clean, 139 active+degraded; 783 GB data, 1928 GB used,
18111 GB / 20040 GB avail; 78169/254952 degraded (30.660%)
.....
2012-06-11 21:39:49.991893    pg v88197: 200 pgs: 60 active+clean, 1
stale+active+clean, 139 active+degraded; 783 GB data, 1928 GB used,
18111 GB / 20040 GB avail; 78169/254952 degraded (30.660%)
2012-06-11 21:39:50.992755    pg v88198: 200 pgs: 60 active+clean, 1
stale+active+clean, 139 active+degraded; 783 GB data, 1928 GB used,
18111 GB / 20040 GB avail; 78169/254952 degraded (30.660%)
2012-06-11 21:39:51.993533    pg v88199: 200 pgs: 60 active+clean, 1
stale+active+clean, 139 active+degraded; 783 GB data, 1928 GB used,
18111 GB / 20040 GB avail; 78169/254952 degraded (30.660%)
2012-06-11 21:39:52.994397    pg v88200: 200 pgs: 60 active+clean, 1
stale+active+clean, 139 active+degraded; 783 GB data, 1928 GB used,
18111 GB / 20040 GB avail; 78169/254952 degraded (30.660%)

After boot all osd on stoped machine:

2012-06-11 21:40:37.826619   osd e4162: 72 osds: 53 up, 72 in
2012-06-11 21:40:37.825706 mon.0 10.177.66.4:6790/0 348 : [INF] osd.24
10.177.66.6:6800/21597 boot
2012-06-11 21:40:38.825297    pg v88202: 200 pgs: 54 active+clean, 7
stale+active+clean, 139 active+degraded; 783 GB data, 1928 GB used,
18111 GB / 20040 GB avail; 78169/254952 degraded (30.660%)
2012-06-11 21:40:38.826517   osd e4163: 72 osds: 54 up, 72 in
2012-06-11 21:40:38.825250 mon.0 10.177.66.4:6790/0 349 : [INF] osd.25
10.177.66.6:6803/21712 boot
2012-06-11 21:40:38.825655 mon.0 10.177.66.4:6790/0 350 : [INF] osd.28
10.177.66.6:6812/26210 boot
2012-06-11 21:40:38.825907 mon.0 10.177.66.4:6790/0 351 : [INF] osd.29
10.177.66.6:6815/26327 boot
2012-06-11 21:40:39.826738    pg v88203: 200 pgs: 56 active+clean, 4
stale+active+clean, 3 peering, 137 active+degraded; 783 GB data, 1928
GB used, 18111 GB / 20040 GB avail; 76921/254952 degraded (30.171%)
2012-06-11 21:40:39.830098   osd e4164: 72 osds: 59 up, 72 in
2012-06-11 21:40:39.826570 mon.0 10.177.66.4:6790/0 352 : [INF] osd.26
10.177.66.6:6806/21835 boot
2012-06-11 21:40:39.826961 mon.0 10.177.66.4:6790/0 353 : [INF] osd.27
10.177.66.6:6809/21953 boot
2012-06-11 21:40:39.828147 mon.0 10.177.66.4:6790/0 354 : [INF] osd.30
10.177.66.6:6818/26511 boot
2012-06-11 21:40:39.828418 mon.0 10.177.66.4:6790/0 355 : [INF] osd.31
10.177.66.6:6821/26583 boot
2012-06-11 21:40:39.828935 mon.0 10.177.66.4:6790/0 356 : [INF] osd.33
10.177.66.6:6827/26859 boot
2012-06-11 21:40:39.829274 mon.0 10.177.66.4:6790/0 357 : [INF] osd.34
10.177.66.6:6830/26979 boot
2012-06-11 21:40:40.827935    pg v88204: 200 pgs: 56 active+clean, 4
stale+active+clean, 3 peering, 137 active+degraded; 783 GB data, 1928
GB used, 18111 GB / 20040 GB avail; 76921/254952 degraded (30.171%)
2012-06-11 21:40:40.830059   osd e4165: 72 osds: 62 up, 72 in
2012-06-11 21:40:40.827798 mon.0 10.177.66.4:6790/0 358 : [INF] osd.32
10.177.66.6:6824/26701 boot
2012-06-11 21:40:40.829043 mon.0 10.177.66.4:6790/0 359 : [INF] osd.35
10.177.66.6:6833/27165 boot
2012-06-11 21:40:40.829316 mon.0 10.177.66.4:6790/0 360 : [INF] osd.36
10.177.66.6:6836/27280 boot
2012-06-11 21:40:40.829602 mon.0 10.177.66.4:6790/0 361 : [INF] osd.37
10.177.66.6:6839/27397 boot
2012-06-11 21:40:41.828776    pg v88205: 200 pgs: 56 active+clean, 4
stale+active+clean, 3 peering, 137 active+degraded; 783 GB data, 1928
GB used, 18111 GB / 20040 GB avail; 76921/254952 degraded (30.171%)
2012-06-11 21:40:41.831823   osd e4166: 72 osds: 68 up, 72 in
2012-06-11 21:40:41.828713 mon.0 10.177.66.4:6790/0 362 : [INF] osd.38
10.177.66.6:6842/27513 boot
2012-06-11 21:40:41.829440 mon.0 10.177.66.4:6790/0 363 : [INF] osd.39
10.177.66.6:6845/27628 boot
2012-06-11 21:40:41.830226 mon.0 10.177.66.4:6790/0 364 : [INF] osd.40
10.177.66.6:6848/27835 boot
2012-06-11 21:40:41.830531 mon.0 10.177.66.4:6790/0 365 : [INF] osd.41
10.177.66.6:6851/27950 boot
2012-06-11 21:40:41.830778 mon.0 10.177.66.4:6790/0 366 : [INF] osd.42
10.177.66.6:6854/28065 boot
2012-06-11 21:40:41.831249 mon.0 10.177.66.4:6790/0 367 : [INF] osd.43
10.177.66.6:6857/28181 boot
2012-06-11 21:40:42.830440    pg v88206: 200 pgs: 57 active+clean, 4
stale+active+clean, 7 peering, 132 active+degraded; 783 GB data, 1928
GB used, 18111 GB / 20040 GB avail; 75543/254952 degraded (29.630%)
2012-06-11 21:40:42.833294   osd e4167: 72 osds: 72 up, 72 in
2012-06-11 21:40:42.831046 mon.0 10.177.66.4:6790/0 368 : [INF] osd.44
10.177.66.6:6860/28373 boot
2012-06-11 21:40:42.832004 mon.0 10.177.66.4:6790/0 369 : [INF] osd.45
10.177.66.6:6863/28489 boot
2012-06-11 21:40:42.832314 mon.0 10.177.66.4:6790/0 370 : [INF] osd.46
10.177.66.6:6866/28607 boot
2012-06-11 21:40:42.832545 mon.0 10.177.66.4:6790/0 371 : [INF] osd.47
10.177.66.6:6869/28731 boot
2012-06-11 21:40:43.830481    pg v88207: 200 pgs: 64 active+clean, 4
stale+active+clean, 7 peering, 125 active+degraded; 783 GB data, 1928
GB used, 18111 GB / 20040 GB avail; 72874/254952 degraded (28.583%)
2012-06-11 21:40:43.831113   osd e4168: 72 osds: 72 up, 72 in
2012-06-11 21:40:44.832521    pg v88208: 200 pgs: 79 active+clean, 1
stale+active+clean, 4 peering, 113 active+degraded, 3
active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
avail; 66185/254952 degraded (25.960%)
2012-06-11 21:40:45.834077    pg v88209: 200 pgs: 104 active+clean, 1
stale+active+clean, 4 peering, 85 active+degraded, 6
active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
avail; 50399/254952 degraded (19.768%)
2012-06-11 21:40:46.835367    pg v88210: 200 pgs: 125 active+clean, 1
stale+active+clean, 4 peering, 59 active+degraded, 11
active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
avail; 38563/254952 degraded (15.126%)
2012-06-11 21:40:47.836516    pg v88211: 200 pgs: 158 active+clean, 1
stale+active+clean, 26 active+degraded, 15 active+recovering; 783 GB
data, 1928 GB used, 18111 GB / 20040 GB avail; 18542/254952 degraded
(7.273%)
2012-06-11 21:40:48.853560    pg v88212: 200 pgs: 184 active+clean, 16
active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
avail; 1/254952 degraded (0.000%)
2012-06-11 21:40:49.868514    pg v88213: 200 pgs: 184 active+clean, 16
active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
avail; 1/254952 degraded (0.000%)
2012-06-11 21:40:50.858244    pg v88214: 200 pgs: 184 active+clean, 16
active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
avail; 1/254952 degraded (0.000%)
2012-06-11 21:40:51.845622    pg v88215: 200 pgs: 184 active+clean, 16
active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
avail
2012-06-11 21:40:52.857823    pg v88216: 200 pgs: 184 active+clean, 16
active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
avail
2012-06-11 21:40:53.858281    pg v88217: 200 pgs: 184 active+clean, 16
active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
avail
2012-06-11 21:40:54.855602    pg v88218: 200 pgs: 184 active+clean, 16
active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
avail
2012-06-11 21:40:55.857241    pg v88219: 200 pgs: 184 active+clean, 16
active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
avail
2012-06-11 21:40:56.857631    pg v88220: 200 pgs: 184 active+clean, 16
active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
avail
2012-06-11 21:40:57.858987    pg v88221: 200 pgs: 185 active+clean, 15
active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
avail
2012-06-11 21:40:58.880252    pg v88222: 200 pgs: 185 active+clean, 15
active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
avail
2012-06-11 21:40:59.861910    pg v88223: 200 pgs: 188 active+clean, 12
active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
avail
2012-06-11 21:41:00.902582    pg v88224: 200 pgs: 191 active+clean, 9
active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
avail
2012-06-11 21:41:01.907767    pg v88225: 200 pgs: 196 active+clean, 4
active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
avail
2012-06-11 21:41:02.876377    pg v88226: 200 pgs: 199 active+clean, 1
active+recovering; 783 GB data, 1928 GB used, 18111 GB / 20040 GB
avail
2012-06-11 21:41:03.876929    pg v88227: 200 pgs: 200 active+clean;
783 GB data, 1928 GB used, 18111 GB / 20040 GB avail

<disk type=3D"network" device=3D"disk">
         <driver name=3D"qemu" type=3D"raw"/>
         <source protocol=3D"rbd" name=3D"rbd/foo4">
         </source>
         <target dev=3D"vdf" bus=3D"virtio"/>
</disk>

2. When i use rbd_cache=3D1, or true in my xml, for libvirt i get:

<disk type=3D"network" device=3D"disk">
         <driver name=3D"qemu" type=3D"raw"/>
         <source protocol=3D"rbd" name=3D"rbd/foo5:rbd_cache=3D1">
         </source>
         <target dev=3D"vdf" bus=3D"virtio"/>
</disk>

libvirtd.log
2012-06-11 18:50:36.992+0000: 1751: error :
qemuMonitorTextAddDrive:2820 : operation failed: open disk image file
failed

Libvirt version 0.9.8-2ubuntu17 with some additional patch set before
ceph 0.46 version appears. Qemu-kvm 1.0+noroms-0ubuntu13.

Do i need any other patch for libvirt ?? Without rbd_cache attaching is ok.

--=20
-----
Pozdrawiam

S=C5=82awek "sZiBis" Skowron

--001485f6288ce9743504c237b251
Content-Type: text/plain; charset=US-ASCII; name="ceph.conf.txt"
Content-Disposition: attachment; filename="ceph.conf.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h3bycdxp1

OyBnbG9iYWwKW2dsb2JhbF0KICAgICAgICA7IGVuYWJsZSBzZWN1cmUgYXV0aGVudGljYXRpb24K
CiAgICAgICAgYXV0aCBzdXBwb3J0ZWQgPSBjZXBoeAogICAgICAgIGtleXJpbmcgPSAvZXRjL2Nl
cGgvJGNsdXN0ZXIua2V5cmluZwogCiAgICAgICAgcmd3X2NhY2hlX2VuYWJsZWQgPSBmYWxzZSA7
cmd3IGNhY2hlIGVuYWJsZWQKICAgICAgICByZ3dfY2FjaGVfbHJ1X3NpemUgPSAxMzEwNzIgO251
bSBvZiBlbnRyaWVzIGluIHJndyBjYWNoZQogICAgICAgIHJnd190aHJlYWRfcG9vbF9zaXplID0g
NDA5NiAKICAgICAgICByZ3cgcHJpbnQgY29udGludWUgPSBmYWxzZSA7ZW5hYmxlIGlmIDEwMC1D
b250aW51ZSB3b3JrcwogICAgICAgIHJnd19lbmFibGVfb3BzX2xvZyA9IHRydWUgO2VuYWJsZSBs
b2dnaW5nIGV2ZXJ5IHJndyBvcGVyYXRpb24KICAgICAgICByZ3cgc29ja2V0IHBhdGggPSAvdmFy
L3J1bi9yYWRvc2d3LnNvY2sKICAgICAgICBkZWJ1ZyByZ3cgPSAxCgogICAgICAgIHJiZCBjYWNo
ZSA9IHRydWUKICAgICAgICByYmQgY2FjaGUgbWF4IGRpcnR5ID0gMAoKICAgICAgICBhZG1pbl9z
b2NrZXQgPSAvdmFyL3J1bi9jZXBoLyRjbHVzdGVyLSRuYW1lLmFzb2sKCjsgcmFkb3NndyBjbGll
bnQgbGlzdAoKW2NsaWVudC5yYWRvc2d3Lm9icy0xMC0xNzctNjYtNF0KICAgICAgICBob3N0ID0g
b2JzLTEwLTE3Ny02Ni00CiAgICAgICAga2V5cmluZyA9IC9ldGMvY2VwaC9jbGllbnQucmFkb3Nn
dy5vYnMtMTAtMTc3LTY2LTQuYmluCiAgICAgICAgbG9nIGZpbGUgPSAvdmFyL2xvZy9yYWRvc2d3
LyRuYW1lLmxvZwogICAgICAgIGRlYnVnIG1zID0gMQoKW2NsaWVudC5yYWRvc2d3Lm9icy0xMC0x
NzctNjYtNl0KICAgICAgICBob3N0ID0gb2JzLTEwLTE3Ny02Ni02CiAgICAgICAga2V5cmluZyA9
IC9ldGMvY2VwaC9jbGllbnQucmFkb3Nndy5vYnMtMTAtMTc3LTY2LTYuYmluCiAgICAgICAgbG9n
IGZpbGUgPSAvdmFyL2xvZy9yYWRvc2d3LyRuYW1lLmxvZwogICAgICAgIGRlYnVnIG1zID0gMQoK
W2NsaWVudC5yYWRvc2d3Lm9icy0xMC0xNzctNjYtOF0KICAgICAgICBob3N0ID0gb2JzLTEwLTE3
Ny02Ni04CiAgICAgICAga2V5cmluZyA9IC9ldGMvY2VwaC9jbGllbnQucmFkb3Nndy5vYnMtMTAt
MTc3LTY2LTguYmluCiAgICAgICAgbG9nIGZpbGUgPSAvdmFyL2xvZy9yYWRvc2d3LyRuYW1lLmxv
ZwogICAgICAgIGRlYnVnIG1zID0gMQoKCjsgbW9uaXRvcnMKOyAgWW91IG5lZWQgYXQgbGVhc3Qg
b25lLiAgWW91IG5lZWQgYXQgbGVhc3QgdGhyZWUgaWYgeW91IHdhbnQgdG8KOyAgdG9sZXJhdGUg
YW55IG5vZGUgZmFpbHVyZXMuICBBbHdheXMgY3JlYXRlIGFuIG9kZCBudW1iZXIuClttb25dCiAg
ICAgICAgbW9uIGRhdGEgPSAvdm9sMC9kYXRhL21vbi4kaWQKIAogICAgICAgIDsgc29tZSBtaW5p
bWFsIGxvZ2dpbmcgKGp1c3QgbWVzc2FnZSB0cmFmZmljKSB0byBhaWQgZGVidWdnaW5nCiAKICAg
ICAgICBkZWJ1ZyBtcyA9IDAgICAgIDsgc2VlIG1lc3NhZ2UgdHJhZmZpYwogICAgICAgIGRlYnVn
IG1vbiA9IDAgICA7IG1vbml0b3IKICAgICAgICBkZWJ1ZyBwYXhvcyA9IDAgOyBtb25pdG9yIHJl
cGxpY2F0aW9uCiAgICAgICAgZGVidWcgYXV0aCA9IDAgIDsKIAogICAgICAgIG1vbiBhbGxvd2Vk
IGNsb2NrIGRyaWZ0ID0gMgogCgpbbW9uLjBdCiAgICAgICAgaG9zdCA9IG9icy0xMC0xNzctNjYt
NAogICAgICAgIG1vbiBhZGRyID0gMTAuMTc3LjY2LjQ6Njc5MAoKCjsgb3NkCjsgIFlvdSBuZWVk
IGF0IGxlYXN0IG9uZS4gIFR3byBpZiB5b3Ugd2FudCBkYXRhIHRvIGJlIHJlcGxpY2F0ZWQuCjsg
IERlZmluZSBhcyBtYW55IGFzIHlvdSBsaWtlLgpbb3NkXQogICAgICAgIDsgVGhpcyBpcyB3aGVy
ZSB0aGUgYnRyZnMgdm9sdW1lIHdpbGwgYmUgbW91bnRlZC4KCiAgICAgICAgb3NkIGRhdGEgPSAv
dm9sMC9kYXRhL29zZC4kaWQKIAogICAgICAgIDsgSWRlYWxseSwgbWFrZSB0aGlzIGEgc2VwYXJh
dGUgZGlzayBvciBwYXJ0aXRpb24uICBBIGZldyBHQgogICAgICAgIDsgaXMgdXN1YWxseSBlbm91
Z2g7IG1vcmUgaWYgeW91IGhhdmUgZmFzdCBkaXNrcy4gIFlvdSBjYW4gdXNlCiAgICAgICAgOyBh
IGZpbGUgdW5kZXIgdGhlIG9zZCBkYXRhIGRpciBpZiBuZWVkIGJlCiAgICAgICAgOyAoZS5nLiAv
ZGF0YS9vc2QkaWQvam91cm5hbCksIGJ1dCBpdCB3aWxsIGJlIHNsb3dlciB0aGFuIGEKICAgICAg
ICA7IHNlcGFyYXRlIGRpc2sgb3IgcGFydGl0aW9uLgoKICAgICAgICBvc2Qgam91cm5hbCA9IC92
b2wwL2RhdGEvb3NkLiRpZC9qb3VybmFsCiAKICAgICAgICA7IElmIHRoZSBPU0Qgam91cm5hbCBp
cyBhIGZpbGUsIHlvdSBuZWVkIHRvIHNwZWNpZnkgdGhlIHNpemUuIFRoaXMgaXMgc3BlY2lmaWVk
IGluIE1CLgoKICAgICAgICBrZXlyaW5nID0gL3ZvbDAvZGF0YS9vc2QuJGlkL2tleXJpbmcKCiAg
ICAgICAgb3NkIGpvdXJuYWwgc2l6ZSA9IDEwMjQKIAo7ICAgICAgIGZpbGVzdG9yZV94YXR0cl91
c2Vfb21hcCA9IDAKICAgICAgICBmaWxlc3RvcmUgam91cm5hbCB3cml0ZWFoZWFkID0gMQogICAg
ICAgIG9zZCBoZWFydGJlYXQgZ3JhY2UgPSA4CiAKICAgICAgICBkZWJ1ZyBtcyA9IDAgICAgICAg
ICA7IG1lc3NhZ2UgdHJhZmZpYwogICAgICAgIGRlYnVnIG9zZCA9IDEKICAgICAgICBkZWJ1ZyBm
aWxlc3RvcmUgPSAxIDsgbG9jYWwgb2JqZWN0IHN0b3JhZ2UKICAgICAgICBkZWJ1ZyBqb3VybmFs
ID0gMCAgIDsgbG9jYWwgam91cm5hbGluZwogICAgICAgIGRlYnVnIG1vbmMgPSAwCiAgICAgICAg
ZGVidWcgcmFkb3MgPSAwCiAKCltvc2QuMF0KICAgICAgICBob3N0ID0gb2JzLTEwLTE3Ny02Ni00
Cgpbb3NkLjFdCiAgICAgICAgaG9zdCA9IG9icy0xMC0xNzctNjYtNAoKW29zZC4xMF0KICAgICAg
ICBob3N0ID0gb2JzLTEwLTE3Ny02Ni00Cgpbb3NkLjExXQogICAgICAgIGhvc3QgPSBvYnMtMTAt
MTc3LTY2LTQKCltvc2QuMTJdCiAgICAgICAgaG9zdCA9IG9icy0xMC0xNzctNjYtNAoKW29zZC4x
M10KICAgICAgICBob3N0ID0gb2JzLTEwLTE3Ny02Ni00Cgpbb3NkLjE0XQogICAgICAgIGhvc3Qg
PSBvYnMtMTAtMTc3LTY2LTQKCltvc2QuMTVdCiAgICAgICAgaG9zdCA9IG9icy0xMC0xNzctNjYt
NAoKW29zZC4xNl0KICAgICAgICBob3N0ID0gb2JzLTEwLTE3Ny02Ni00Cgpbb3NkLjE3XQogICAg
ICAgIGhvc3QgPSBvYnMtMTAtMTc3LTY2LTQKCltvc2QuMThdCiAgICAgICAgaG9zdCA9IG9icy0x
MC0xNzctNjYtNAoKW29zZC4xOV0KICAgICAgICBob3N0ID0gb2JzLTEwLTE3Ny02Ni00Cgpbb3Nk
LjJdCiAgICAgICAgaG9zdCA9IG9icy0xMC0xNzctNjYtNAoKW29zZC4yMF0KICAgICAgICBob3N0
ID0gb2JzLTEwLTE3Ny02Ni00Cgpbb3NkLjIxXQogICAgICAgIGhvc3QgPSBvYnMtMTAtMTc3LTY2
LTQKCltvc2QuMjJdCiAgICAgICAgaG9zdCA9IG9icy0xMC0xNzctNjYtNAoKW29zZC4yM10KICAg
ICAgICBob3N0ID0gb2JzLTEwLTE3Ny02Ni00Cgpbb3NkLjI0XQogICAgICAgIGhvc3QgPSBvYnMt
MTAtMTc3LTY2LTYKCltvc2QuMjVdCiAgICAgICAgaG9zdCA9IG9icy0xMC0xNzctNjYtNgoKW29z
ZC4yNl0KICAgICAgICBob3N0ID0gb2JzLTEwLTE3Ny02Ni02Cgpbb3NkLjI3XQogICAgICAgIGhv
c3QgPSBvYnMtMTAtMTc3LTY2LTYKCltvc2QuMjhdCiAgICAgICAgaG9zdCA9IG9icy0xMC0xNzct
NjYtNgoKW29zZC4yOV0KICAgICAgICBob3N0ID0gb2JzLTEwLTE3Ny02Ni02Cgpbb3NkLjNdCiAg
ICAgICAgaG9zdCA9IG9icy0xMC0xNzctNjYtNAoKW29zZC4zMF0KICAgICAgICBob3N0ID0gb2Jz
LTEwLTE3Ny02Ni02Cgpbb3NkLjMxXQogICAgICAgIGhvc3QgPSBvYnMtMTAtMTc3LTY2LTYKCltv
c2QuMzJdCiAgICAgICAgaG9zdCA9IG9icy0xMC0xNzctNjYtNgoKW29zZC4zM10KICAgICAgICBo
b3N0ID0gb2JzLTEwLTE3Ny02Ni02Cgpbb3NkLjM0XQogICAgICAgIGhvc3QgPSBvYnMtMTAtMTc3
LTY2LTYKCltvc2QuMzVdCiAgICAgICAgaG9zdCA9IG9icy0xMC0xNzctNjYtNgoKW29zZC4zNl0K
ICAgICAgICBob3N0ID0gb2JzLTEwLTE3Ny02Ni02Cgpbb3NkLjM3XQogICAgICAgIGhvc3QgPSBv
YnMtMTAtMTc3LTY2LTYKCltvc2QuMzhdCiAgICAgICAgaG9zdCA9IG9icy0xMC0xNzctNjYtNgoK
W29zZC4zOV0KICAgICAgICBob3N0ID0gb2JzLTEwLTE3Ny02Ni02Cgpbb3NkLjRdCiAgICAgICAg
aG9zdCA9IG9icy0xMC0xNzctNjYtNAoKW29zZC40MF0KICAgICAgICBob3N0ID0gb2JzLTEwLTE3
Ny02Ni02Cgpbb3NkLjQxXQogICAgICAgIGhvc3QgPSBvYnMtMTAtMTc3LTY2LTYKCltvc2QuNDJd
CiAgICAgICAgaG9zdCA9IG9icy0xMC0xNzctNjYtNgoKW29zZC40M10KICAgICAgICBob3N0ID0g
b2JzLTEwLTE3Ny02Ni02Cgpbb3NkLjQ0XQogICAgICAgIGhvc3QgPSBvYnMtMTAtMTc3LTY2LTYK
Cltvc2QuNDVdCiAgICAgICAgaG9zdCA9IG9icy0xMC0xNzctNjYtNgoKW29zZC40Nl0KICAgICAg
ICBob3N0ID0gb2JzLTEwLTE3Ny02Ni02Cgpbb3NkLjQ3XQogICAgICAgIGhvc3QgPSBvYnMtMTAt
MTc3LTY2LTYKCltvc2QuNDhdCiAgICAgICAgaG9zdCA9IG9icy0xMC0xNzctNjYtOAoKW29zZC40
OV0KICAgICAgICBob3N0ID0gb2JzLTEwLTE3Ny02Ni04Cgpbb3NkLjVdCiAgICAgICAgaG9zdCA9
IG9icy0xMC0xNzctNjYtNAoKW29zZC41MF0KICAgICAgICBob3N0ID0gb2JzLTEwLTE3Ny02Ni04
Cgpbb3NkLjUxXQogICAgICAgIGhvc3QgPSBvYnMtMTAtMTc3LTY2LTgKCltvc2QuNTJdCiAgICAg
ICAgaG9zdCA9IG9icy0xMC0xNzctNjYtOAoKW29zZC41M10KICAgICAgICBob3N0ID0gb2JzLTEw
LTE3Ny02Ni04Cgpbb3NkLjU0XQogICAgICAgIGhvc3QgPSBvYnMtMTAtMTc3LTY2LTgKCltvc2Qu
NTVdCiAgICAgICAgaG9zdCA9IG9icy0xMC0xNzctNjYtOAoKW29zZC41Nl0KICAgICAgICBob3N0
ID0gb2JzLTEwLTE3Ny02Ni04Cgpbb3NkLjU3XQogICAgICAgIGhvc3QgPSBvYnMtMTAtMTc3LTY2
LTgKCltvc2QuNThdCiAgICAgICAgaG9zdCA9IG9icy0xMC0xNzctNjYtOAoKW29zZC41OV0KICAg
ICAgICBob3N0ID0gb2JzLTEwLTE3Ny02Ni04Cgpbb3NkLjZdCiAgICAgICAgaG9zdCA9IG9icy0x
MC0xNzctNjYtNAoKW29zZC42MF0KICAgICAgICBob3N0ID0gb2JzLTEwLTE3Ny02Ni04Cgpbb3Nk
LjYxXQogICAgICAgIGhvc3QgPSBvYnMtMTAtMTc3LTY2LTgKCltvc2QuNjJdCiAgICAgICAgaG9z
dCA9IG9icy0xMC0xNzctNjYtOAoKW29zZC42M10KICAgICAgICBob3N0ID0gb2JzLTEwLTE3Ny02
Ni04Cgpbb3NkLjY0XQogICAgICAgIGhvc3QgPSBvYnMtMTAtMTc3LTY2LTgKCltvc2QuNjVdCiAg
ICAgICAgaG9zdCA9IG9icy0xMC0xNzctNjYtOAoKW29zZC42Nl0KICAgICAgICBob3N0ID0gb2Jz
LTEwLTE3Ny02Ni04Cgpbb3NkLjY3XQogICAgICAgIGhvc3QgPSBvYnMtMTAtMTc3LTY2LTgKCltv
c2QuNjhdCiAgICAgICAgaG9zdCA9IG9icy0xMC0xNzctNjYtOAoKW29zZC42OV0KICAgICAgICBo
b3N0ID0gb2JzLTEwLTE3Ny02Ni04Cgpbb3NkLjddCiAgICAgICAgaG9zdCA9IG9icy0xMC0xNzct
NjYtNAoKW29zZC43MF0KICAgICAgICBob3N0ID0gb2JzLTEwLTE3Ny02Ni04Cgpbb3NkLjcxXQog
ICAgICAgIGhvc3QgPSBvYnMtMTAtMTc3LTY2LTgKCltvc2QuOF0KICAgICAgICBob3N0ID0gb2Jz
LTEwLTE3Ny02Ni00Cgpbb3NkLjldCiAgICAgICAgaG9zdCA9IG9icy0xMC0xNzctNjYtNAo=
--001485f6288ce9743504c237b251--
