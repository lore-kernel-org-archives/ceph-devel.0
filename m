From: Jeff Wu <cpwu@tnsoft.com.cn>
Subject: Re: Performence test on ceph v0.23 + EXT4 and Btrfs
Date: Wed, 1 Dec 2010 14:59:45 +0800
Message-ID: <1291186785.1809.91.camel@cephhost>
References: <1291001135.1872.106.camel@cephhost>
	 <AANLkTi=E=pjvixkronpD-ij0CxjFBVauN5bBrsbT8nqW@mail.gmail.com>
	 <1291085741.1809.25.camel@cephhost>
	 <AANLkTikz_quAcoYL8VUoA4i87WczKCh0yM2TsCG6dQEz@mail.gmail.com>
	 <1291097975.1809.54.camel@cephhost>
	 <AANLkTinkgBwzfESaQNs0VkLn+LGbd8wEccy6LNDSFM2Z@mail.gmail.com>
	 <1291167344.1809.60.camel@cephhost>
Reply-To: <cpwu@tnsoft.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [210.22.136.227] ([210.22.136.227]:22461 "EHLO
	MAIL.TNSOFT.COM.CN" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751517Ab0LAG6c (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Dec 2010 01:58:32 -0500
In-Reply-To: <1291167344.1809.60.camel@cephhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Andrew Lv <mllv@tnsoft.com.cn>



=E5=9C=A8 2010-12-01=E4=B8=89=E7=9A=84 09:35 +0800=EF=BC=8CJeff Wu=E5=86=
=99=E9=81=93=EF=BC=9A=20
>=20
> =E5=9C=A8 2010-12-01=E4=B8=89=E7=9A=84 01:07 +0800=EF=BC=8CGregory Fa=
rnum=E5=86=99=E9=81=93=EF=BC=9A
> > On Mon, Nov 29, 2010 at 10:19 PM, Jeff Wu <cpwu@tnsoft.com.cn> wrot=
e:
> > > Is "40-50MB/s" the speed that it run bench at local btrfs disk ?
> > > not the speed that run bench from client to osd server ?
> > > with this speed ,run bench from client to osd server ,will which =
 get
> > > about 20~25MB/s( 40~50MB /2 )speed ?
> > Data on Ceph is replicated across 2 OSDs (by default; this is
> > configurable). So while figuring out potential performance involves=
 a
> > lot of variables, in a simple case like this where you aren't bound=
ed
> > by network bandwidth you'll find that your read/write performance
> > simply tracks the slower disk. I'd expect your Ceph tests (at least
> > the streaming ones) to run at 40-50MB/s.
>=20
> Hi Greg,thank you very much for your quickly reply.
> >=20
> > Given that everything else is okay, I cannot stress enough that
> > running without a journal is going to cause significant performance
> > degradations. I have a hard time believing that it's responsible fo=
r
> > 13-second latencies, but it's possible. So how about you set up a
> > journal (it can just be a file or new partition on the drives you'r=
e
> > already using) and report back your results after you do that. :)
>=20
> I will add journal to ceph.conf to try it .=20
>=20
>=20
Hi ,greg,=20

With your suggestions, i add the journal config:
"
osd data =3D /opt/ceph/data/osd$id
osd journal =3D /home/transoft/data/osd$id/journal
filestore journal writeahead =3D true
osd journal size =3D 10000
"=20
to ceph.conf.  the  detail ceph.conf attached below.

then , run six times for the commad: "$ sudo ceph osd tell 0/1
bench" ,get the results:


$ sudo ceph -w

osd0 172.16.10.42:6800/17347 1 : [INF] bench: wrote 1024 MB in blocks o=
f
4096 KB in 29.818194 sec at 28201 KB/sec
osd0 172.16.10.42:6800/17347 2 : [INF] bench: wrote 1024 MB in blocks o=
f
4096 KB in 30.013058 sec at 34801 KB/sec
osd0 172.16.10.42:6800/17347 3 : [INF] bench: wrote 1024 MB in blocks o=
f
4096 KB in 30.463511 sec at 30274 KB/sec

osd1 172.16.10.65:6800/4845 1 : [INF] bench: wrote 1024 MB in blocks of
4096 KB in 165.067603 sec at 6329 KB/sec
osd1 172.16.10.65:6800/4845 2 : [INF] bench: wrote 1024 MB in blocks of
4096 KB in 181.034333 sec at 5782 KB/sec
osd1 172.16.10.65:6800/4845 3 : [INF] bench: wrote 1024 MB in blocks of
4096 KB in 196.055812 sec at 5334 KB/sec

and i also use "dd" to test raw drive, get the logs:

1. OSD0, mkfs.btrfs format /opt=20

$ sudo dd if=3D/dev/zero of=3D/opt/dd.img bs=3D2M count=3D1024=20
1024+0 records in
1024+0 records out
2147483648 bytes transfered in 21.4497 secs(100 MB/sec)

2. OSD1 ,mkfs. btrfs format /opt=20

~$ sudo dd if=3D/dev/zero of=3D/opt/dd.img bs=3D2M count=3D1024
1024+0 records in
1024+0 records out
2147483648 bytes transfered in 48.2037 secs(44.6 MB/sec)

with these logs, OSD1 disk speed might limit the  test performance.

and i also detect a issue ,take the following steps:

$. mckephfs -c ceph.conf -v --mkbtrfs -a=20
$  init-ceph - ceph.conf --btrfs -v -a start=20
then execute:
$  init-ceph - ceph.conf --btrfs -v -a stop

this command can't stop OSD0 and OSD1 cosd process:
OSD0:
/usr/local/bin/cosd -i 0 -c ceph.conf
OSD1:
/usr/local/bin/cosd -i 1 -c ceph.conf


then , i create the folder "/var/run/ceph"  at OSD0 and OSD1 host
manually.
execute:
$  init-ceph - ceph.conf --btrfs -v -a stop

this command can  stop OSD0 and OSD1 cosd process:

/usr/local/bin/cosd -i 0 -c ceph.conf
/usr/local/bin/cosd -i 1 -c ceph.conf


Thanks,
Jeff.Wu

>=20
> > Adding a journal to the OSDs lets them turn all their random writes
> > into streaming ones.
> > -Greg
>=20

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
transoft@ubuntu-mon0:/usr/local/etc/ceph$ sudo ceph osd tell 0 bench
2010-12-01 10:45:13.670910 mon <- [osd,tell,0,bench]
2010-12-01 10:45:13.671180 mon1 -> 'ok' (0)
transoft@ubuntu-mon0:/usr/local/etc/ceph$ sudo ceph osd tell 0 bench
2010-12-01 10:45:29.350198 mon <- [osd,tell,0,bench]
2010-12-01 10:45:29.350457 mon1 -> 'ok' (0)
transoft@ubuntu-mon0:/usr/local/etc/ceph$ sudo ceph osd tell 0 bench
2010-12-01 10:45:31.000281 mon <- [osd,tell,0,bench]
2010-12-01 10:45:31.000560 mon0 -> 'ok' (0)
transoft@ubuntu-mon0:/usr/local/etc/ceph$ sudo ceph osd tell 1 bench
2010-12-01 10:45:34.860782 mon <- [osd,tell,1,bench]
2010-12-01 10:45:34.861020 mon1 -> 'ok' (0)
transoft@ubuntu-mon0:/usr/local/etc/ceph$ sudo ceph osd tell 1 bench
2010-12-01 10:45:36.760811 mon <- [osd,tell,1,bench]
2010-12-01 10:45:36.761161 mon2 -> 'ok' (0)
transoft@ubuntu-mon0:/usr/local/etc/ceph$ sudo ceph osd tell 1 bench
2010-12-01 10:45:37.530714 mon <- [osd,tell,1,bench]
2010-12-01 10:45:37.530968 mon2 -> 'ok' (0)

transoft@ubuntu-mon0:/usr/local/etc/ceph$ sudo ceph -w

2010-12-01 10:44:59.450653    pg v13: 528 pgs: 528 active+clean; 12 KB
data, 5304 KB used, 219 GB / 219 GB avail
2010-12-01 10:44:59.451365   mds e5: 1/1/1 up {0=3Dup:active}, 1
up:standby
2010-12-01 10:44:59.451387   osd e6: 2 osds: 2 up, 2 in
2010-12-01 10:44:59.451412   log 2010-12-01 10:43:43.044865 mon0
172.16.10.171:6789/0 7 : [INF] mds0 172.16.10.171:6801/2482 up:active
2010-12-01 10:44:59.451440   mon e1: 3 mons at
{0=3D172.16.10.171:6789/0,1=3D172.16.10.171:6790/0,2=3D172.16.10.171:67=
91/0}
2010-12-01 10:46:45.000262   log 2010-12-01 10:45:15.599526 osd0
172.16.10.42:6800/17347 1 : [INF] bench: wrote 1024 MB in blocks of 409=
6
KB in 29.818194 sec at 28201 KB/sec
2010-12-01 10:46:45.000262   log 2010-12-01 10:45:46.062142 osd0
172.16.10.42:6800/17347 2 : [INF] bench: wrote 1024 MB in blocks of 409=
6
KB in 30.013058 sec at 34801 KB/sec
2010-12-01 10:46:45.000262   log 2010-12-01 10:46:16.836607 osd0
172.16.10.42:6800/17347 3 : [INF] bench: wrote 1024 MB in blocks of 409=
6
KB in 30.463511 sec at 30274 KB/sec
2010-12-01 10:48:20.042152    pg v14: 528 pgs: 528 active+clean; 32780
KB data, 888 MB used, 218 GB / 219 GB avail
2010-12-01 10:50:50.038298    pg v15: 528 pgs: 528 active+clean; 73740
KB data, 54928 KB used, 219 GB / 219 GB avail
2010-12-01 10:52:15.074470    pg v16: 528 pgs: 528 active+clean; 73740
KB data, 79440 KB used, 219 GB / 219 GB avail
2010-12-01 10:54:55.546098   log 2010-12-01 11:52:34.244851 osd1
172.16.10.65:6800/4845 1 : [INF] bench: wrote 1024 MB in blocks of 4096
KB in 165.067603 sec at 6329 KB/sec
2010-12-01 10:54:55.546098   log 2010-12-01 11:55:52.010739 osd1
172.16.10.65:6800/4845 2 : [INF] bench: wrote 1024 MB in blocks of 4096
KB in 181.034333 sec at 5782 KB/sec
2010-12-01 10:54:55.546098   log 2010-12-01 11:59:09.560115 osd1
172.16.10.65:6800/4845 3 : [INF] bench: wrote 1024 MB in blocks of 4096
KB in 196.055812 sec at 5334 KB/sec
2010-12-01 10:55:01.001357    pg v17: 528 pgs: 528 active+clean; 73741
KB data, 1106 MB used, 218 GB / 219 GB avail


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dceph.conf=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


;
; Sample ceph ceph.conf file.
;
; This file defines cluster membership, the various locations
; that Ceph stores data, and any other runtime options.

; If a 'host' is defined for a daemon, the start/stop script will
; verify that it matches the hostname (or else ignore it).  If it is
; not defined, it is assumed that the daemon is intended to start on
; the current host (e.g., in a setup with a startup.conf on each
; node).

; global
[global]
; enable secure authentication
; auth supported =3D cephx
keyring =3D /etc/ceph/keyring.bin
; monitors
;  You need at least one.  You need at least three if you want to
;  tolerate any node failures.  Always create an odd number.
[mon]
mon data =3D /opt/ceph/data/mon$id
;mon data =3D /home/transoft/data/mon$id

; logging, for debugging monitor crashes, in order of
; their likelihood of being helpful :)
;debug ms =3D 20
;debug mon =3D 20
;debug paxos =3D 20
;debug auth =3D 20

[mon0]
host =3D ubuntu-mon0
mon addr =3D 172.16.10.171:6789

[mon1]
host =3D ubuntu-mon0
mon addr =3D 172.16.10.171:6790

[mon2]
host =3D ubuntu-mon0
mon addr =3D 172.16.10.171:6791

; mds
;  You need at least one.  Define two to get a standby.
[mds]
; where the mds keeps it's secret encryption keys
keyring =3D /etc/ceph/keyring.$name

; mds logging to debug issues.
;debug ms =3D 20
;debug mds =3D 20

[mds.0]
host =3D ubuntu-mon0

[mds.1]
host =3D ubuntu-mon0

; osd
;  You need at least one.  Two if you want data to be replicated.
;  Define as many as you like.
[osd]
; This is where the btrfs volume will be mounted.
;osd data =3D /opt/ceph/data/osd$id
osd class tmp =3D /var/lib/ceph/tmp

; Ideally, make this a separate disk or partition.  A few
; hundred MB should be enough; more if you have fast or many
; disks.  You can use a file under the osd data dir if need be
; (e.g. /data/osd$id/journal), but it will be slower than a
; separate disk or partition.

        ; This is an example of a file-based journal.
;osd journal =3D /home/transoft/data/osd$id/journal
;filestore journal writeahead =3D true
; journal size, in megabytes
;osd journal size =3D 1000=20
keyring =3D /etc/ceph/keyring.$name

; osd logging to debug osd issues, in order of likelihood of being
; helpful
;debug ms =3D 20
;debug osd =3D 20
;debug filestore =3D 20
;debug journal =3D 20

[osd0]
host =3D ubuntu-osd0
osd data =3D /opt/ceph/data/osd$id
osd journal =3D /home/transoft/data/osd$id/journal
filestore journal writeahead =3D true
osd journal size =3D 10000=20
; if 'btrfs devs' is not specified, you're responsible for
; setting up the 'osd data' dir.  if it is not btrfs, things
; will behave up until you try to recover from a crash (which
; usually fine for basic testing).
; btrfs devs =3D /dev/sdx

[osd1]
host =3D ubuntu-osd1
osd data =3D /opt/ceph/data/osd$id
osd journal =3D /home/transoft/data/osd$id/journal
filestore journal writeahead =3D true
osd journal size =3D 10000=20
;btrfs devs =3D /dev/sdy

;[osd2]
;host =3D zeta
;btrfs devs =3D /dev/sdx

;[osd3]
;host =3D eta
;btrfs devs =3D /dev/sdy






--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
