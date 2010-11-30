From: Jeff Wu <cpwu@tnsoft.com.cn>
Subject: Re: Performence test on ceph v0.23 + EXT4 and Btrfs
Date: Tue, 30 Nov 2010 14:19:35 +0800
Message-ID: <1291097975.1809.54.camel@cephhost>
References: <1291001135.1872.106.camel@cephhost>
	 <AANLkTi=E=pjvixkronpD-ij0CxjFBVauN5bBrsbT8nqW@mail.gmail.com>
	 <1291085741.1809.25.camel@cephhost>
	 <AANLkTikz_quAcoYL8VUoA4i87WczKCh0yM2TsCG6dQEz@mail.gmail.com>
Reply-To: <cpwu@tnsoft.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [210.22.136.227] ([210.22.136.227]:22898 "EHLO
	MAIL.TNSOFT.COM.CN" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752041Ab0K3GSk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Nov 2010 01:18:40 -0500
In-Reply-To: <AANLkTikz_quAcoYL8VUoA4i87WczKCh0yM2TsCG6dQEz@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Andrew Lv <mllv@tnsoft.com.cn>



=E5=9C=A8 2010-11-30=E4=BA=8C=E7=9A=84 11:18 +0800=EF=BC=8CGregory Farn=
um=E5=86=99=E9=81=93=EF=BC=9A
> On Mon, Nov 29, 2010 at 6:55 PM, Jeff Wu <cpwu@tnsoft.com.cn> wrote:
> >> Could you run "ceph osd tell * bench", then run "ceph -w", and rep=
ort
> >> the results? (That'll just run local benchmarking on the OSD to re=
port
> >> the approximate write speed it's capable of.)
> >
> > I run six times for the command: "$ sudo ceph osd tell 0/1 bench "
> > use "$ sudo ceph -w" to get the following results:
> >
> > osd0 : [INF] bench: wrote 1024 MB in blocks of 4096 KB in 12.906598=
 sec
> > at 49775 KB/sec
> > osd1 : [INF] bench: wrote 1024 MB in blocks of 4096 KB in 21.023294=
 sec
> > at 49384 KB/sec
> > osd0 : [INF] bench: wrote 1024 MB in blocks of 4096 KB in 12.834682=
 sec
> > at 51535 KB/sec
> > osd1 : [INF] bench: wrote 1024 MB in blocks of 4096 KB in 20.792697=
 sec
> > at 37547 KB/sec
> > osd0  : [INF] bench: wrote 1024 MB in blocks of 4096 KB in 13.05841=
2 sec
> > at 77191 KB/sec
> > osd1  : [INF] bench: wrote 1024 MB in blocks of 4096 KB in 21.11361=
2 sec
> > at 47369 KB/sec
> Okay, those are a bit slow but reasonable. Based on these I'd expect
> you to generally manage about 40-50MB/s (since everything is
> replicated; in a 2-disk configuration it'll just be the speed of your
> slowest disk), assuming a properly configured system.

Is "40-50MB/s" the speed that it run bench at local btrfs disk ?
not the speed that run bench from client to osd server ?=20
with this speed ,run bench from client to osd server ,will which  get
about 20~25MB/s( 40~50MB /2 )speed ?


>=20
> >> You can also run "rados -p data bench 60 write", and then "rados -=
p
> >> data bench 0 seq" to get a simpler (better understood) performance
> >> test.
> >
> > I run twice for the command: "rados -p data bench 60 write" ,
> > Get the results:
> > $ sudo rados -p data bench 60 write
> > ..........................
> > ..........................
> >
> > Total time run:        76.182225
> > Total writes made:     121
> > Write size:            4194304
> > Bandwidth (MB/sec):    6.219
> >
> > Average Latency:       13.3068
> > Max latency:           23.9986
> > Min latency:           7.01847
> WOAH. That's a lot of latency. Rather more than I'd expect to get jus=
t
> from seek times in a non-journaled environment. What's the round-trip
> time to ping the OSDs from your client? Are your disks okay?
>=20
Hi,i get the RTT and the disks are okay .

1. RTT:
client ping OSD0:
rtt min/avg/max/mdev =3D 0.103/0.124/0.143/0.016 ms
client ping OSD1:
rtt min/avg/max/mdev =3D 0.112/0.116/0.122/0.005 ms

2. disks

1) mon data save in sda4, which formatted with mkfs.btrfs
$lsscsi
[0:0:0:0]    disk    ATA      WDC WD3200AAKS-7 02.0  /dev/sda
$fdisk -l
=2E............
/dev/sda4           17264       38913   173897568+  83  Linux

2) OSD0 data save in  sda5,which formatted with mkfs.btrfs
~$ lsscsi
[0:0:0:0]    disk    ATA      ST3320418AS      CC45  /dev/sda
$ fdisk -l=20
=2E......................
/dev/sda5           18480       38913   164131649   83  Linux


3) OSD1 data save in  sda5,which formatted with mkfs.btrfs

$ lsscsi
[0:0:0:0]    disk    ATA      ST3160812AS      3.AD  /dev/sda
$ fdisk -l
/dev/sda5           11185       19452    66405470+  83  Linux


more detail logs attached(see below)


Thank you=20
jeff.wu

> > but run  "$ sudo rados -p data bench 0 seq"
> > fail to get the results, Maybe it's a bug,ceph version 0.23.
> Oh right, sorry. We put in a quick fix to make the write benchmark
> scale across multiple client writers and forgot to adjust the read
> benchmark. *oops*

thank you !

> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

logs:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

transoft@ubuntu-mon0:/usr/local/etc/ceph$ ping 172.16.10.65
PING 172.16.10.65 (172.16.10.65) 56(84) bytes of data.
64 bytes from 172.16.10.65: icmp_req=3D1 ttl=3D64 time=3D0.127 ms
64 bytes from 172.16.10.65: icmp_req=3D2 ttl=3D64 time=3D0.121 ms
64 bytes from 172.16.10.65: icmp_req=3D3 ttl=3D64 time=3D0.127 ms
64 bytes from 172.16.10.65: icmp_req=3D4 ttl=3D64 time=3D0.124 ms
64 bytes from 172.16.10.65: icmp_req=3D5 ttl=3D64 time=3D0.128 ms
64 bytes from 172.16.10.65: icmp_req=3D6 ttl=3D64 time=3D0.128 ms
64 bytes from 172.16.10.65: icmp_req=3D7 ttl=3D64 time=3D0.127 ms
64 bytes from 172.16.10.65: icmp_req=3D8 ttl=3D64 time=3D0.126 ms
64 bytes from 172.16.10.65: icmp_req=3D9 ttl=3D64 time=3D0.126 ms
64 bytes from 172.16.10.65: icmp_req=3D10 ttl=3D64 time=3D0.128 ms
64 bytes from 172.16.10.65: icmp_req=3D11 ttl=3D64 time=3D0.120 ms
64 bytes from 172.16.10.65: icmp_req=3D12 ttl=3D64 time=3D0.127 ms
64 bytes from 172.16.10.65: icmp_req=3D13 ttl=3D64 time=3D0.120 ms
64 bytes from 172.16.10.65: icmp_req=3D14 ttl=3D64 time=3D0.125 ms
64 bytes from 172.16.10.65: icmp_req=3D15 ttl=3D64 time=3D0.131 ms
64 bytes from 172.16.10.65: icmp_req=3D16 ttl=3D64 time=3D0.125 ms
64 bytes from 172.16.10.65: icmp_req=3D17 ttl=3D64 time=3D0.124 ms
64 bytes from 172.16.10.65: icmp_req=3D18 ttl=3D64 time=3D0.103 ms
64 bytes from 172.16.10.65: icmp_req=3D19 ttl=3D64 time=3D0.124 ms
64 bytes from 172.16.10.65: icmp_req=3D20 ttl=3D64 time=3D0.125 ms
64 bytes from 172.16.10.65: icmp_req=3D21 ttl=3D64 time=3D0.143 ms
64 bytes from 172.16.10.65: icmp_req=3D22 ttl=3D64 time=3D0.127 ms
64 bytes from 172.16.10.65: icmp_req=3D23 ttl=3D64 time=3D0.117 ms
^C
--- 172.16.10.65 ping statistics ---
23 packets transmitted, 23 received, 0% packet loss, time 21999ms
rtt min/avg/max/mdev =3D 0.103/0.124/0.143/0.016 ms


transoft@ubuntu-mon0:/usr/local/etc/ceph$ ping 172.16.10.42
PING 172.16.10.42 (172.16.10.42) 56(84) bytes of data.
64 bytes from 172.16.10.42: icmp_req=3D1 ttl=3D64 time=3D0.121 ms
64 bytes from 172.16.10.42: icmp_req=3D2 ttl=3D64 time=3D0.116 ms
64 bytes from 172.16.10.42: icmp_req=3D3 ttl=3D64 time=3D0.122 ms
64 bytes from 172.16.10.42: icmp_req=3D5 ttl=3D64 time=3D0.117 ms
64 bytes from 172.16.10.42: icmp_req=3D6 ttl=3D64 time=3D0.112 ms
64 bytes from 172.16.10.42: icmp_req=3D7 ttl=3D64 time=3D0.117 ms
64 bytes from 172.16.10.42: icmp_req=3D8 ttl=3D64 time=3D0.112 ms
64 bytes from 172.16.10.42: icmp_req=3D9 ttl=3D64 time=3D0.112 ms
64 bytes from 172.16.10.42: icmp_req=3D10 ttl=3D64 time=3D0.112 ms
64 bytes from 172.16.10.42: icmp_req=3D11 ttl=3D64 time=3D0.117 ms
64 bytes from 172.16.10.42: icmp_req=3D12 ttl=3D64 time=3D0.114 ms
64 bytes from 172.16.10.42: icmp_req=3D13 ttl=3D64 time=3D0.121 ms
^C
--- 172.16.10.42 ping statistics ---
13 packets transmitted, 12 received, 7% packet loss, time 11999ms
rtt min/avg/max/mdev =3D 0.112/0.116/0.122/0.005 ms
transoft@ubuntu-mon0:/usr/local/etc/ceph$=20


transoft@ubuntu-mon0:~$ lsscsi
[0:0:0:0]    disk    ATA      WDC WD3200AAKS-7 02.0  /dev/sda
transoft@ubuntu-mon0:~$ sudo fdisk -l
[sudo] password for transoft:=20

Disk /dev/sda: 320.1 GB, 320072933376 bytes
255 heads, 63 sectors/track, 38913 cylinders
Units =3D cylinders of 16065 * 512 =3D 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00006279

   Device Boot      Start         End      Blocks   Id  System
/dev/sda1   *           1        4864    39061504   83  Linux
/dev/sda2            4864       17264    99607553    5  Extended
/dev/sda3           38914       38914           0+  83  Linux
/dev/sda4           17264       38913   173897568+  83  Linux
/dev/sda5            4864       17021    97654784   83  Linux
/dev/sda6           17021       17264     1951744   82  Linux swap /
Solaris

Partition table entries are not in disk order
transoft@ubuntu-mon0:~$=20



transoft@ubuntu-osd0:~$ lsscsi
[0:0:0:0]    disk    ATA      ST3320418AS      CC45  /dev/sda
transoft@ubuntu-osd0:~$ sudo fdisk -l
[sudo] password for transoft:=20

Disk /dev/sda: 320.1 GB, 320072933376 bytes
255 heads, 63 sectors/track, 38913 cylinders
Units =3D cylinders of 16065 * 512 =3D 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x50000000

   Device Boot      Start         End      Blocks   Id  System
/dev/sda1   *           1        6079    48827392   83  Linux
/dev/sda2            6079       18237    97655808   83  Linux
/dev/sda3           18237       18480     1952768   82  Linux swap /
Solaris
/dev/sda4           18480       38913   164131680+   5  Extended
/dev/sda5           18480       38913   164131649   83  Linux
transoft@ubuntu-osd0:~$=20



transoft@ubuntu-osd1:~$ lsscsi
[0:0:0:0]    disk    ATA      ST3160812AS      3.AD  /dev/sda
transoft@ubuntu-osd1:~$ sudo fdisk -l
[sudo] password for transoft:=20

Disk /dev/sda: 160.0 GB, 160000000000 bytes
255 heads, 63 sectors/track, 19452 cylinders
Units =3D cylinders of 16065 * 512 =3D 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0xc45cc45c

   Device Boot      Start         End      Blocks   Id  System
/dev/sda1   *           1        3648    29295616   83  Linux
/dev/sda2            3648       10942    58593280   83  Linux
/dev/sda3           10942       11185     1952768   82  Linux swap /
Solaris
/dev/sda4           11185       19452    66405502    5  Extended
/dev/sda5           11185       19452    66405470+  83  Linux
transoft@ubuntu-osd1:~$=20

























--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
