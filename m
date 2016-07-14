From: Kevan Rehm <krehm@cray.com>
Subject: Re: bluestore bug#15724: bluefs _replay file with link count 0:
Date: Thu, 14 Jul 2016 19:49:07 +0000
Message-ID: <D3AD5619.B63B3%krehm@cray.com>
References: <D3AD48E4.B62F9%krehm@cray.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from esa2.cray.iphmx.com ([68.232.143.164]:40221 "EHLO
	esa2.cray.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbcGNTtN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Jul 2016 15:49:13 -0400
In-Reply-To: <D3AD48E4.B62F9%krehm@cray.com>
Content-Language: en-US
Content-ID: <6E658A88BCBE8648838F3D7559B1C4CB@namprd11.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kevan Rehm <krehm@cray.com>, "ceph-devel (ceph-devel@vger.kernel.org)" <ceph-devel@vger.kernel.org>

A bit more info missing in the previous email:

# ceph -v
ceph version 11.0.0-196-g85bb43e (85bb43e111692989d2296a389ce45377d2297=
d6f)


The dump of recent events prior to the transaction log problem is 10,00=
0
lines, so I'll just include the tail for now, if you want more, let me
know.

Kevan

   -22> 2016-07-13 00:35:43.893066 7f6d53fcc700 20 --
10.12.0.127:6804/4080 >> 10.12.0.129:0/1660564381 pipe(0x7f6d6f8c8800
sd=3D59 :6804 s=3D4 pgs=3D4 cs=3D1 l=3D1 c=3D0x7f6d783a6800).join
   -21> 2016-07-13 00:35:43.893702 7f6d53fcc700 10 --
10.12.0.127:6804/4080 reaper reaped pipe 0x7f6d6f8c8800
10.12.0.129:0/1660564381
   -20> 2016-07-13 00:35:43.893742 7f6d53fcc700 10 --
10.12.0.127:6804/4080 reaper deleted pipe 0x7f6d6f8c8800
   -19> 2016-07-13 00:35:43.893744 7f6d53fcc700 10 --
10.12.0.127:6804/4080 reaper done
   -18> 2016-07-13 00:35:44.201223 7f6d427a9700 10 monclient: tick
   -17> 2016-07-13 00:35:44.201250 7f6d427a9700 10 monclient:
_check_auth_rotating have uptodate secrets (they expire after 2016-07-1=
3
00:35:14.201237)
   -16> 2016-07-13 00:35:44.201257 7f6d427a9700 20 --
10.12.0.127:6804/4080 send_keepalive con 0x7f6d68891c00, have pipe.
   -15> 2016-07-13 00:35:44.201298 7f6d5fcae700 10 --
10.12.0.127:6804/4080 >> 10.12.0.133:6789/0 pipe(0x7f6d768c2000 sd=3D17
:49366 s=3D2 pgs=3D4915 cs=3D1 l=3D1 c=3D0x7f6d68891c00).writer: state =
=3D open
policy.server=3D0
   -14> 2016-07-13 00:35:44.201318 7f6d5fcae700 10 --
10.12.0.127:6804/4080 >> 10.12.0.133:6789/0 pipe(0x7f6d768c2000 sd=3D17
:49366 s=3D2 pgs=3D4915 cs=3D1 l=3D1 c=3D0x7f6d68891c00).write_keepaliv=
e2 14
2016-07-13 00:35:44.201316
   -13> 2016-07-13 00:35:44.201337 7f6d5fcae700 10 --
10.12.0.127:6804/4080 >> 10.12.0.133:6789/0 pipe(0x7f6d768c2000 sd=3D17
:49366 s=3D2 pgs=3D4915 cs=3D1 l=3D1 c=3D0x7f6d68891c00).writer: state =
=3D open
policy.server=3D0
   -12> 2016-07-13 00:35:44.201341 7f6d5fcae700 20 --
10.12.0.127:6804/4080 >> 10.12.0.133:6789/0 pipe(0x7f6d768c2000 sd=3D17
:49366 s=3D2 pgs=3D4915 cs=3D1 l=3D1 c=3D0x7f6d68891c00).writer sleepin=
g
   -11> 2016-07-13 00:35:44.201463 7f6d5ec90700  2 --
10.12.0.127:6804/4080 >> 10.12.0.133:6789/0 pipe(0x7f6d768c2000 sd=3D17
:49366 s=3D2 pgs=3D4915 cs=3D1 l=3D1 c=3D0x7f6d68891c00).reader got KEE=
PALIVE_ACK
   -10> 2016-07-13 00:35:44.201474 7f6d5ec90700 20 --
10.12.0.127:6804/4080 >> 10.12.0.133:6789/0 pipe(0x7f6d768c2000 sd=3D17
:49366 s=3D2 pgs=3D4915 cs=3D1 l=3D1 c=3D0x7f6d68891c00).reader reading=
 tag...
    -9> 2016-07-13 00:35:44.210392 7f6d33e61700  2 --
10.13.0.127:6804/4080 >> 10.13.0.127:6800/4072 pipe(0x7f6d782df400 sd=3D=
115
:6804 s=3D2 pgs=3D25 cs=3D3 l=3D0 c=3D0x7f6d68893700).reader couldn't r=
ead tag,
(107) Transport endpoint is not connected
    -8> 2016-07-13 00:35:44.210435 7f6d33e61700  2 --
10.13.0.127:6804/4080 >> 10.13.0.127:6800/4072 pipe(0x7f6d782df400 sd=3D=
115
:6804 s=3D2 pgs=3D25 cs=3D3 l=3D0 c=3D0x7f6d68893700).fault (107) Trans=
port endpoint
is not connected
    -7> 2016-07-13 00:35:44.210486 7f6d33e61700  0 --
10.13.0.127:6804/4080 >> 10.13.0.127:6800/4072 pipe(0x7f6d782df400 sd=3D=
115
:6804 s=3D2 pgs=3D25 cs=3D3 l=3D0 c=3D0x7f6d68893700).fault with nothin=
g to send,
going to standby
    -6> 2016-07-13 00:35:44.210494 7f6d33e61700 20 --
10.13.0.127:6804/4080 >> 10.13.0.127:6800/4072 pipe(0x7f6d782df400 sd=3D=
115
:6804 s=3D3 pgs=3D25 cs=3D3 l=3D0 c=3D0x7f6d68893700).reader sleeping d=
uring
reconnect|standby
    -5> 2016-07-13 00:35:44.210509 7f6d3577a700 10 --
10.13.0.127:6804/4080 >> 10.13.0.127:6800/4072 pipe(0x7f6d782df400 sd=3D=
115
:6804 s=3D3 pgs=3D25 cs=3D3 l=3D0 c=3D0x7f6d68893700).writer: state =3D=
 standby
policy.server=3D0
    -4> 2016-07-13 00:35:44.210522 7f6d3577a700 20 --
10.13.0.127:6804/4080 >> 10.13.0.127:6800/4072 pipe(0x7f6d782df400 sd=3D=
115
:6804 s=3D3 pgs=3D25 cs=3D3 l=3D0 c=3D0x7f6d68893700).writer sleeping
    -3> 2016-07-13 00:35:44.438101 7f6d37793700 10 osd.20 342 Store syn=
ced
    -2> 2016-07-13 00:35:44.438121 7f6d37793700 20 osd.20 342  kicking =
pg
2.278
    -1> 2016-07-13 00:35:44.438124 7f6d37793700 30 osd.20 pg_epoch: 342
pg[2.278( v 339'406 (0'0,339'406] local-les=3D338 n=3D0 ec=3D130 les/c/=
f
338/338/0 337/337/337) [20] r=3D0 lpr
=3D337 luod=3D0'0 crt=3D339'404 lcod 339'405 mlcod 0'0 active+clean] lo=
ck
     0> 2016-07-13 00:35:44.438703 7f6d37793700 -1 *** Caught signal
(Segmentation fault) **
 in thread 7f6d37793700 thread_name:signal_handler


 ceph version 11.0.0-196-g85bb43e
(85bb43e111692989d2296a389ce45377d2297d6f)
 1: (()+0x980a3a) [0x7f6d5f614a3a]
 2: (()+0xf100) [0x7f6d5d5dd100]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is need=
ed
to interpret this.



On 7/14/16, 1:49 PM, "ceph-devel-owner@vger.kernel.org on behalf of Kev=
an
Rehm" <ceph-devel-owner@vger.kernel.org on behalf of krehm@cray.com> wr=
ote:

>Greetings,
>
>Bug #15724 reports several occurrences of an OSD that will not start d=
ue
>to the message "bluefs _replay file with link count 0:".  I have also =
had
>several occurrences of this in the last couple of days, using a ceph b=
uilt
>from master a couple of weeks ago.
>
>I jacked up the bluefs debug tracing and have been working through the
>reading of the transaction log by the OSD during startup, and I can se=
e
>what appears to be a bad transaction that is causing this, see below.
>(Probably also the cause of the segmentation fault that occurred just
>before this incident.)
>
>Before I fry any more brain cells, I'd like to know if someone is alre=
ady
>fixing this, or if someone has any advice to offer, like where the pro=
blem
>most likely lies.   If not, I'll keep digging.
>
>
>Here is what we see after the transaction log has been read, the OSD g=
ets
>excited and bails:
>
>
>2016-07-13 16:03:03.933669 7fb6617c1800 20 bluefs _read got 4096
>2016-07-13 16:03:03.933671 7fb6617c1800 10 bluefs _replay 0x5cf000: st=
op:
>uuid 4ef0859e-06e8-51c2-9612-add7269b0100 !=3D super.uuid
>7eb30434-317a-4844-b8d1-6f8cb37585d1
>2016-07-13 16:03:03.933678 7fb6617c1800 10 bluefs _replay log file siz=
e
>was 0x5cf000
>2016-07-13 16:03:03.933731 7fb6617c1800 -1 bluefs _replay file with li=
nk
>count 0: file(ino 113 size 71354938 mtime 2016-07-12 17:05:53.738683 b=
dev
>1 extents=20
>[1:904921088+1048576,1:910163968+2097152,1:916455424+2097152,1:9311354=
88+2
>0
>97152,1:937426944+2097152,1:943718400+2097152,1:950009856+2097152,1:96=
0495
>6
>16+58720256])
>2016-07-13 16:03:03.933739 7fb6617c1800 -1 bluefs mount failed to repl=
ay
>log: (5) Input/output error
>2016-07-13 16:03:03.933753 7fb6617c1800 20 bluefs _stop_alloc
>2016-07-13 16:03:03.933754 7fb6617c1800 10 bitmapalloc:shutdown instan=
ce
>140421450426752
>2016-07-13 16:03:03.933924 7fb6617c1800 -1
>bluestore(/var/lib/ceph/osd/ceph-20) _open_db failed bluefs mount: (5)
>Input/output error
>
>
>Starting from the front of the log, here are the first references to i=
no
>113 in the transaction log:
>
>2016-07-13 16:03:03.900994 7fb6617c1800 20 bluefs _replay 0x562000:
>op_file_update  file(ino 113 size 0 mtime 2016-07-12 17:05:48.312770 b=
dev
>1 extents [])
>2016-07-13 16:03:03.900996 7fb6617c1800 30 bluefs _get_file ino 113 =3D
>0x7fb66aafbb90 (new)
>2016-07-13 16:03:03.900997 7fb6617c1800 20 bluefs _replay 0x562000:
>op_dir_link  db/000145.log to 113
>2016-07-13 16:03:03.900998 7fb6617c1800 30 bluefs _get_file ino 113 =3D
>0x7fb66aafbb90
>=A9
>2016-07-13 16:03:03.901047 7fb6617c1800 20 bluefs _replay 0x56e000:
>op_file_update  file(ino 113 size 23 mtime 2016-07-12 17:05:48.314814 =
bdev
>1 extents [1:904921088+1048576])
>2016-07-13 16:03:03.901048 7fb6617c1800 30 bluefs _get_file ino 113 =3D
>0x7fb66aafbb90
>
>
>Lots of op_file_updates are applied to ino 113 in the log, leading up =
to
>this final one.
>
>
>2016-07-13 16:03:03.924173 7fb6617c1800 20 bluefs _replay 0x5ab000:
>op_file_update  file(ino 113 size 71359362 mtime 2016-07-12
>17:05:49.420150 bdev 1 extents
>[1:904921088+1048576,1:910163968+2097152,1:916455424+2097152,1:9311354=
88+2
>0
>97152,1:937426944+2097152,1:943718400+2097152,1:950009856+2097152,1:96=
0495
>6
>16+58720256])
>2016-07-13 16:03:03.924176 7fb6617c1800 30 bluefs _get_file ino 113 =3D
>0x7fb66aafbb90
>
>
>Next ino 113's filename is renamed from 000145.log to 000151.log, foll=
owed
>by an update, so it must be coming from BlueRocksEnv::ReuseWritableFil=
e().
>
>
>2016-07-13 16:03:03.925181 7fb6617c1800 10 bluefs _replay 0x5b4000:
>txn(seq 77743 len 982 crc 98786513)
>2016-07-13 16:03:03.925182 7fb6617c1800 20 bluefs _replay 0x5b4000:
>op_dir_link  db/000151.log to 113
>2016-07-13 16:03:03.925183 7fb6617c1800 30 bluefs _get_file ino 113 =3D
>0x7fb66aafbb90
>2016-07-13 16:03:03.925184 7fb6617c1800 20 bluefs _replay 0x5b4000:
>op_dir_unlink  db/000145.log
>2016-07-13 16:03:03.925186 7fb6617c1800 20 bluefs _replay 0x5b4000:
>op_file_update  file(ino 113 size 71359362 mtime 2016-07-12
>17:05:53.738683 bdev 1 extents
>[1:904921088+1048576,1:910163968+2097152,1:916455424+2097152,1:9311354=
88+2
>0
>97152,1:937426944+2097152,1:943718400+2097152,1:950009856+2097152,1:96=
0495
>6
>16+58720256])
>2016-07-13 16:03:03.925197 7fb6617c1800 30 bluefs _get_file ino 113 =3D
>0x7fb66aafbb90
>
>
>In txn 77752, ino 113 and its filename get removed via a
>BlueRocksEnv::DeleteFile() call, followed by an update with the origin=
al
>allocation.  Bad news.  Don't yet know where the update is coming from=
=2E
>So now we have an ino 113 with no links, and a series of extents which=
 it
>doesn't really own.
>
>
>2016-07-13 16:03:03.929686 7fb6617c1800 20 bluefs _replay 0x5be000:
>op_file_remove 113
>2016-07-13 16:03:03.929687 7fb6617c1800 20 bluefs _replay 0x5be000:
>op_dir_unlink  db/000150.log
>=A9
>2016-07-13 16:03:03.929689 7fb6617c1800 20 bluefs _replay 0x5be000:
>op_file_update  file(ino 113 size 71354938 mtime 2016-07-12
>17:05:53.738683 bdev 1 extents
>[1:904921088+1048576,1:910163968+2097152,1:916455424+2097152,1:9311354=
88+2
>0
>97152,1:937426944+2097152,1:943718400+2097152,1:950009856+2097152,1:96=
0495
>6
>16+58720256])
>2016-07-13 16:03:03.929693 7fb6617c1800 30 bluefs _get_file ino 113 =3D
>0x7fb66aafc880 (new)
>
>
>The end result is an ino without a link, and an unhappy OSD.
>
>
>2016-07-13 16:03:03.933669 7fb6617c1800 20 bluefs _read got 4096
>2016-07-13 16:03:03.933671 7fb6617c1800 10 bluefs _replay 0x5cf000: st=
op:
>uuid 4ef0859e-06e8-51c2-9612-add7269b0100 !=3D super.uuid
>7eb30434-317a-4844-b8d1-6f8cb37585d1
>2016-07-13 16:03:03.933678 7fb6617c1800 10 bluefs _replay log file siz=
e
>was 0x5cf000
>
>2016-07-13 16:03:03.933731 7fb6617c1800 -1 bluefs _replay file with li=
nk
>count 0: file(ino 113 size 71354938 mtime 2016-07-12 17:05:53.738683 b=
dev
>1 extents=20
>[1:904921088+1048576,1:910163968+2097152,1:916455424+2097152,1:9311354=
88+2
>0
>97152,1:937426944+2097152,1:943718400+2097152,1:950009856+2097152,1:96=
0495
>6
>16+58720256])
>
>
>
>I do have the OSD logs showing the original segfault plus the error
>mentioned here, but I had to fix the block device so that I could move=
 on.
>  I can upload the logs if someone is interested, but they're large.
>
>Thanks, Kevan
>
>--
>To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
