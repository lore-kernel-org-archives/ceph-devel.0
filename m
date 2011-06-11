From: Wilfrid Allembrand <wilfrid.allembrand@gmail.com>
Subject: Don't understand why space usage keeps growing
Date: Sun, 12 Jun 2011 01:24:47 +0200
Message-ID: <BANLkTiny=PO5eq=ok_ad6T94YfAK-Tk=CA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=000e0cd719dafa75e104a577fd02
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51068 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715Ab1FKXYs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 11 Jun 2011 19:24:48 -0400
Received: by ywe9 with SMTP id 9so1485001ywe.19
        for <ceph-devel@vger.kernel.org>; Sat, 11 Jun 2011 16:24:47 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

--000e0cd719dafa75e104a577fd02
Content-Type: text/plain; charset=ISO-8859-1

Hi,

So I have my small test cluster with 2 OSD nodes. In each OSD node,
there is one disk (5 GB) and one cosd.
When I mount the FS on a client, I see it's 10 GB in total. Fine.
I copied a small set of multimedia files (135 MB) and that's all. So
why do I see the space used is getting higher and higher ?

root@client:/mnt/osd$ df -h .
Filesystem            Size  Used Avail Use% Mounted on
10.1.56.232:6789:/     10G  5.2G  3.9G  57% /mnt/osd

and like 2 hours later :

root@client:/mnt/osd$ df -h .
Filesystem            Size  Used Avail Use% Mounted on
10.1.56.232:6789:/     10G  6.8G  2.3G  76% /mnt/osd


I'm using btrfs to store the files and I made no creation/modification
of files; i just run some bench with "ceph osd tell [12] bench"
Does the bench create files and do note delete them ?

Extract of ceph -w :
root@test2:/data/mon1# ceph -w
2011-06-11 19:16:09.186416 7fbefd01e700 -- :/14931 >>
10.1.56.233:6789/0 pipe(0x1e58540 sd=4 pgs=0 cs=0 l=0).fault first
fault
2011-06-11 19:16:12.191439    pg v1990: 594 pgs: 594 active+clean;
2066 MB data, 6906 MB used, 2286 MB / 10240 MB avail
2011-06-11 19:16:12.193479   mds e48: 1/1/1 up {0=test4=up:active}, 1 up:standby
2011-06-11 19:16:12.193551   osd e44: 2 osds: 2 up, 2 in
2011-06-11 19:16:12.193658   log 2011-06-12 00:55:42.389017 osd2
10.1.56.237:6800/1744 307 : [INF] bench: wrote 1024 MB in blocks of
4096 KB in 12.438478 sec at 84300 KB/sec
2011-06-11 19:16:12.193757   mon e1: 3 mons at
{0=10.1.56.231:6789/0,1=10.1.56.232:6789/0,2=10.1.56.233:6789/0}


Attached is my ceph.conf

Thanks !
Wilfrid

--000e0cd719dafa75e104a577fd02
Content-Type: application/octet-stream; name="ceph.conf"
Content-Disposition: attachment; filename="ceph.conf"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_got6xw4x0

W2dsb2JhbF0NCiAgICB1c2VyID0gcm9vdA0KICAgIGxvZyBmaWxlID0gL3Zhci9sb2cvY2VwaC8k
bmFtZS5sb2cNCiAgICBwaWQgZmlsZSA9IC92YXIvcnVuL2NlcGgvJG5hbWUucGlkDQoNCg0KDQpb
bW9uXQ0KICAgICAgICBtb24gZGF0YSA9IC9kYXRhL21vbiRpZA0KDQogICAgICAgIDsgc29tZSBt
aW5pbWFsIGxvZ2dpbmcgKGp1c3QgbWVzc2FnZSB0cmFmZmljKSB0byBhaWQgZGVidWdnaW5nDQog
ICAgICAgIGRlYnVnIG1zID0gMQ0KDQpbbW9uLjBdDQogICAgICAgIGhvc3QgPSB0ZXN0MQ0KICAg
ICAgICBtb24gYWRkciA9IDEwLjEuNTYuMjMxOjY3ODkNCg0KW21vbi4xXQ0KICAgICAgICBob3N0
ID0gdGVzdDINCiAgICAgICAgbW9uIGFkZHIgPSAxMC4xLjU2LjIzMjo2Nzg5DQoNClttb24uMl0N
CiAgICAgICAgaG9zdCA9IHRlc3QzDQogICAgICAgIG1vbiBhZGRyID0gMTAuMS41Ni4yMzM6Njc4
OQ0KDQoNCg0KW21kc10NCg0KW21kcy50ZXN0NF0NCiAgICAgICAgaG9zdCA9IHRlc3Q0DQoNCltt
ZHMudGVzdDVdDQogICAgICAgIGhvc3QgPSB0ZXN0NQ0KDQoNCg0KW29zZF0NCiAgICBvc2QgZGF0
YSA9IC9kYXRhL29zZCRpZA0KICAgIG9zZCBqb3VybmFsID0gL2RhdGEvb3NkJGlkL2pvdXJuYWwN
CiAgICBvc2Qgam91cm5hbCBzaXplID0gNTEyDQogICAgb3NkIGhlYXJ0YmVhdCBncmFjZSA9IDMw
DQogICAgZmlsZXN0b3JlIGpvdXJuYWwgd3JpdGVhaGVhZCA9IHRydWUNCiAgICBqb3VybmFsZXJf
YWxsb3dfc3BsaXRfZW50cmllcyA9IHRydWUNCg0KICAgIDtkZWJ1ZyBvc2QgPSAyMA0KICAgIDtk
ZWJ1ZyBmaWxlc3RvcmUgPSAyMA0KDQpbb3NkLjFdDQogICAgaG9zdCA9IHRlc3Q2DQogICAgYnRy
ZnMgZGV2cz0vZGV2L3NkYg0KDQpbb3NkLjJdDQogICBob3N0ID0gdGVzdDcNCiAgICBidHJmcyBk
ZXZzPS9kZXYvc2RiDQo=
--000e0cd719dafa75e104a577fd02--
