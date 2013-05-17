From: Olivier Bonvalet <ceph.list@daevel.fr>
Subject: Re: [ceph-users] PG down & incomplete
Date: Fri, 17 May 2013 23:37:09 +0200
Message-ID: <1368826629.22569.70.camel@localhost>
References: <1368569751.5157.5.camel@localhost>
	 <1368768722.22569.1.camel@localhost>
	 <CAM2gkg4znKDOp-D=z459G2MCQcGzkHrLWF_Ox8uGexZNcMUM3Q@mail.gmail.com>
	 <1368779478.22569.17.camel@localhost>
	 <CAM2gkg51tSPiH_kesF=xQi3t6oET+f0D1XgxyE_6UOZei6PO3Q@mail.gmail.com>
	 <CAM2gkg6_Vaa6X_9=JwrxnsuZ39-+hymeFHd+T6ZYh1o9LPBWxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from licorne.daevel.fr ([178.32.94.222]:56067 "EHLO
	licorne.daevel.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756851Ab3EQVhM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 May 2013 17:37:12 -0400
In-Reply-To: <CAM2gkg6_Vaa6X_9=JwrxnsuZ39-+hymeFHd+T6ZYh1o9LPBWxg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Wilkins <john.wilkins@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>

Yes, osd.10 is near full because of bad data repartition (not enought P=
G
I suppose), and the difficulty to remove snapshot without overloading
the cluster.

The problem on osd.25 was a crash during scrub... I tried to reweight
it, and set it out, without any success. I have added some OSD too.

Logs from my emails =C2=ABscrub shutdown the OSD process=C2=BB (the 15t=
h april) :


     0> 2013-04-15 09:29:53.708141 7f5a8e3cc700 -1 *** Caught signal (A=
borted) **
 in thread 7f5a8e3cc700

 ceph version 0.56.4-4-gd89ab0e (d89ab0ea6fa8d0961cad82f6a81eccbd3bbd3f=
55)
 1: /usr/bin/ceph-osd() [0x7a6289]
 2: (()+0xeff0) [0x7f5aa08faff0]
 3: (gsignal()+0x35) [0x7f5a9f3841b5]
 4: (abort()+0x180) [0x7f5a9f386fc0]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7f5a9fc18dc5]
 6: (()+0xcb166) [0x7f5a9fc17166]
 7: (()+0xcb193) [0x7f5a9fc17193]
 8: (()+0xcb28e) [0x7f5a9fc1728e]
 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const=
*)+0x7c9) [0x8f9549]
 10: (ReplicatedPG::_scrub(ScrubMap&)+0x1a78) [0x57a038]
 11: (PG::scrub_compare_maps()+0xeb8) [0x696c18]
 12: (PG::chunky_scrub()+0x2d9) [0x6c37f9]
 13: (PG::scrub()+0x145) [0x6c4e55]
 14: (OSD::ScrubWQ::_process(PG*)+0xc) [0x64048c]
 15: (ThreadPool::worker(ThreadPool::WorkThread*)+0x879) [0x815179]
 16: (ThreadPool::WorkThread::entry()+0x10) [0x817980]
 17: (()+0x68ca) [0x7f5aa08f28ca]
 18: (clone()+0x6d) [0x7f5a9f421b6d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is need=
ed to interpret this.

--- logging levels ---
   0/ 5 none
   0/ 1 lockdep
   0/ 1 context
   1/ 1 crush
   1/ 5 mds
   1/ 5 mds_balancer
   1/ 5 mds_locker
   1/ 5 mds_log
   1/ 5 mds_log_expire
   1/ 5 mds_migrator
   0/ 1 buffer
   0/ 1 timer
   0/ 1 filer
   0/ 1 striper
   0/ 1 objecter
   0/ 5 rados
   0/ 5 rbd
   0/ 5 journaler
   0/ 5 objectcacher
   0/ 5 client
   0/ 5 osd
   0/ 5 optracker
   0/ 5 objclass
   1/ 3 filestore
   1/ 3 journal
   0/ 5 ms
   1/ 5 mon
   0/10 monc
   0/ 5 paxos
   0/ 5 tp
   1/ 5 auth
   1/ 5 crypto
   1/ 1 finisher
   1/ 5 heartbeatmap
   1/ 5 perfcounter
   1/ 5 rgw
   1/ 5 hadoop
   1/ 5 javaclient
   1/ 5 asok
   1/ 1 throttle
  -1/-1 (syslog threshold)
  -1/-1 (stderr threshold)
  max_recent     10000
  max_new         1000
  log_file /var/log/ceph/osd.25.log
--- end dump of recent events ---





But now, when I start the osd.25, I obtain :

2013-05-14 08:13:37.304452 7fa0ea4e7700  0 -- :/31236 >> 10.0.0.6:6789/=
0 pipe(0x22fe470 sd=3D4 :0 s=3D1 pgs=3D0 cs=3D0 l=3D1).fault
2013-05-14 08:13:40.361570 7ff469167780  0 ceph version 0.61-11-g3b94f0=
3 (3b94f03ec58abe3d7a6d0359ff9b4d75826f3777), process ceph-osd, pid 314=
24
2013-05-14 08:13:40.403846 7ff469167780  0 filestore(/var/lib/ceph/osd/=
ceph-25) mount FIEMAP ioctl is supported and appears to work
2013-05-14 08:13:40.403873 7ff469167780  0 filestore(/var/lib/ceph/osd/=
ceph-25) mount FIEMAP ioctl is disabled via 'filestore fiemap' config o=
ption
2013-05-14 08:13:40.404296 7ff469167780  0 filestore(/var/lib/ceph/osd/=
ceph-25) mount did NOT detect btrfs
2013-05-14 08:13:40.405753 7ff469167780  0 filestore(/var/lib/ceph/osd/=
ceph-25) mount syscall(__NR_syncfs, fd) fully supported
2013-05-14 08:13:40.410164 7ff469167780  0 filestore(/var/lib/ceph/osd/=
ceph-25) mount found snaps <>
2013-05-14 08:13:40.511206 7ff469167780  0 filestore(/var/lib/ceph/osd/=
ceph-25) mount: enabling WRITEAHEAD journal mode: btrfs not detected
2013-05-14 08:13:43.146895 7ff469167780  1 journal _open /dev/sdi3 fd 1=
8: 26843545600 bytes, block size 4096 bytes, directio =3D 1, aio =3D 1
2013-05-14 08:13:43.171846 7ff469167780  1 journal _open /dev/sdi3 fd 1=
8: 26843545600 bytes, block size 4096 bytes, directio =3D 1, aio =3D 1
2013-05-14 08:13:43.172772 7ff469167780  1 journal close /dev/sdi3
2013-05-14 08:13:43.179918 7ff469167780  0 filestore(/var/lib/ceph/osd/=
ceph-25) mount FIEMAP ioctl is supported and appears to work
2013-05-14 08:13:43.179929 7ff469167780  0 filestore(/var/lib/ceph/osd/=
ceph-25) mount FIEMAP ioctl is disabled via 'filestore fiemap' config o=
ption
2013-05-14 08:13:43.180340 7ff469167780  0 filestore(/var/lib/ceph/osd/=
ceph-25) mount did NOT detect btrfs
2013-05-14 08:13:43.182242 7ff469167780  0 filestore(/var/lib/ceph/osd/=
ceph-25) mount syscall(__NR_syncfs, fd) fully supported
2013-05-14 08:13:43.182304 7ff469167780  0 filestore(/var/lib/ceph/osd/=
ceph-25) mount found snaps <>
2013-05-14 08:13:43.185621 7ff469167780  0 filestore(/var/lib/ceph/osd/=
ceph-25) mount: enabling WRITEAHEAD journal mode: btrfs not detected
2013-05-14 08:13:43.193318 7ff469167780  1 journal _open /dev/sdi3 fd 2=
6: 26843545600 bytes, block size 4096 bytes, directio =3D 1, aio =3D 1
2013-05-14 08:13:43.216180 7ff469167780  1 journal _open /dev/sdi3 fd 2=
6: 26843545600 bytes, block size 4096 bytes, directio =3D 1, aio =3D 1
2013-05-14 08:13:43.253760 7ff469167780  0 osd.25 58876 crush map has f=
eatures 262144, adjusting msgr requires for clients
2013-05-14 08:13:43.253776 7ff469167780  0 osd.25 58876 crush map has f=
eatures 262144, adjusting msgr requires for osds
2013-05-14 08:13:51.675152 7ff450075700 -1 osd/OSD.cc: In function 'OSD=
MapRef OSDService::get_map(epoch_t)' thread 7ff450075700 time 2013-05-1=
4 08:13:51.661081
osd/OSD.cc: 4838: FAILED assert(_get_map_bl(epoch, bl))

 ceph version 0.61-11-g3b94f03 (3b94f03ec58abe3d7a6d0359ff9b4d75826f377=
7)
 1: (OSDService::get_map(unsigned int)+0x918) [0x608268]
 2: (OSD::advance_pg(unsigned int, PG*, ThreadPool::TPHandle&, PG::Reco=
veryCtx*, std::set<boost::intrusive_ptr<PG>, std::less<boost::intrusive=
_ptr<PG> >, std::allocator<boost::intrusive_ptr<PG> > >*)+0x195) [0x60b=
725]
 3: (OSD::process_peering_events(std::list<PG*, std::allocator<PG*> > c=
onst&, ThreadPool::TPHandle&)+0x24b) [0x630c1b]
 4: (OSD::PeeringWQ::_process(std::list<PG*, std::allocator<PG*> > cons=
t&, ThreadPool::TPHandle&)+0x16) [0x6650b6]
 5: (ThreadPool::worker(ThreadPool::WorkThread*)+0x561) [0x813a11]
 6: (ThreadPool::WorkThread::entry()+0x10) [0x816530]
 7: (()+0x68ca) [0x7ff4686028ca]
 8: (clone()+0x6d) [0x7ff466ee0b6d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is need=
ed to interpret this.

--- begin dump of recent events ---
  -495> 2013-05-14 08:13:40.355375 7ff469167780  5 asok(0x1fbe000) regi=
ster_command perfcounters_dump hook 0x1fb2010
  -494> 2013-05-14 08:13:40.355404 7ff469167780  5 asok(0x1fbe000) regi=
ster_command 1 hook 0x1fb2010
  -493> 2013-05-14 08:13:40.355407 7ff469167780  5 asok(0x1fbe000) regi=
ster_command perf dump hook 0x1fb2010
  -492> 2013-05-14 08:13:40.355419 7ff469167780  5 asok(0x1fbe000) regi=
ster_command perfcounters_schema hook 0x1fb2010
  -491> 2013-05-14 08:13:40.355427 7ff469167780  5 asok(0x1fbe000) regi=
ster_command 2 hook 0x1fb2010
  -490> 2013-05-14 08:13:40.355439 7ff469167780  5 asok(0x1fbe000) regi=
ster_command perf schema hook 0x1fb2010
  -489> 2013-05-14 08:13:40.355442 7ff469167780  5 asok(0x1fbe000) regi=
ster_command config show hook 0x1fb2010
  -488> 2013-05-14 08:13:40.355445 7ff469167780  5 asok(0x1fbe000) regi=
ster_command config set hook 0x1fb2010
  -487> 2013-05-14 08:13:40.355455 7ff469167780  5 asok(0x1fbe000) regi=
ster_command log flush hook 0x1fb2010
  -486> 2013-05-14 08:13:40.355458 7ff469167780  5 asok(0x1fbe000) regi=
ster_command log dump hook 0x1fb2010
  -485> 2013-05-14 08:13:40.355461 7ff469167780  5 asok(0x1fbe000) regi=
ster_command log reopen hook 0x1fb2010
  -484> 2013-05-14 08:13:40.361570 7ff469167780  0 ceph version 0.61-11=
-g3b94f03 (3b94f03ec58abe3d7a6d0359ff9b4d75826f3777), process ceph-osd,=
 pid 31424
  -483> 2013-05-14 08:13:40.393749 7ff469167780  1 -- 10.0.0.3:0/0 lear=
ned my addr 10.0.0.3:0/0
  -482> 2013-05-14 08:13:40.393764 7ff469167780  1 accepter.accepter.bi=
nd my_inst.addr is 10.0.0.3:6806/31424 need_addr=3D0
  -481> 2013-05-14 08:13:40.393789 7ff469167780  1 -- 192.168.42.3:0/0 =
learned my addr 192.168.42.3:0/0
  -480> 2013-05-14 08:13:40.393795 7ff469167780  1 accepter.accepter.bi=
nd my_inst.addr is 192.168.42.3:6810/31424 need_addr=3D0
  -479> 2013-05-14 08:13:40.393815 7ff469167780  1 -- 192.168.42.3:0/0 =
learned my addr 192.168.42.3:0/0
  -478> 2013-05-14 08:13:40.393820 7ff469167780  1 accepter.accepter.bi=
nd my_inst.addr is 192.168.42.3:6811/31424 need_addr=3D0
  -477> 2013-05-14 08:13:40.394532 7ff469167780  1 finished global_init=
_daemonize
  -476> 2013-05-14 08:13:40.397912 7ff469167780  5 asok(0x1fbe000) init=
 /var/run/ceph/ceph-osd.25.asok
  -475> 2013-05-14 08:13:40.397942 7ff469167780  5 asok(0x1fbe000) bind=
_and_listen /var/run/ceph/ceph-osd.25.asok
  -474> 2013-05-14 08:13:40.397977 7ff469167780  5 asok(0x1fbe000) regi=
ster_command 0 hook 0x1fb10b8
  -473> 2013-05-14 08:13:40.397984 7ff469167780  5 asok(0x1fbe000) regi=
ster_command version hook 0x1fb10b8
  -472> 2013-05-14 08:13:40.397991 7ff469167780  5 asok(0x1fbe000) regi=
ster_command git_version hook 0x1fb10b8
  -471> 2013-05-14 08:13:40.397994 7ff469167780  5 asok(0x1fbe000) regi=
ster_command help hook 0x1fb20d0
  -470> 2013-05-14 08:13:40.398100 7ff464ca2700  5 asok(0x1fbe000) entr=
y start
  -469> 2013-05-14 08:13:40.403846 7ff469167780  0 filestore(/var/lib/c=
eph/osd/ceph-25) mount FIEMAP ioctl is supported and appears to work
  -468> 2013-05-14 08:13:40.403873 7ff469167780  0 filestore(/var/lib/c=
eph/osd/ceph-25) mount FIEMAP ioctl is disabled via 'filestore fiemap' =
config option
  -467> 2013-05-14 08:13:40.404296 7ff469167780  0 filestore(/var/lib/c=
eph/osd/ceph-25) mount did NOT detect btrfs
  -466> 2013-05-14 08:13:40.405753 7ff469167780  0 filestore(/var/lib/c=
eph/osd/ceph-25) mount syscall(__NR_syncfs, fd) fully supported
  -465> 2013-05-14 08:13:40.410164 7ff469167780  0 filestore(/var/lib/c=
eph/osd/ceph-25) mount found snaps <>
  -464> 2013-05-14 08:13:40.511206 7ff469167780  0 filestore(/var/lib/c=
eph/osd/ceph-25) mount: enabling WRITEAHEAD journal mode: btrfs not det=
ected
  -463> 2013-05-14 08:13:43.144294 7ff469167780  2 journal open /dev/sd=
i3 fsid e82dd661-2ad1-4103-92d4-26a3926d524b fs_op_seq 1524687
  -462> 2013-05-14 08:13:43.146895 7ff469167780  1 journal _open /dev/s=
di3 fd 18: 26843545600 bytes, block size 4096 bytes, directio =3D 1, ai=
o =3D 1
  -461> 2013-05-14 08:13:43.148887 7ff469167780  2 journal read_entry 3=
012567040 : seq 1524509 111324 bytes
  -460> 2013-05-14 08:13:43.148986 7ff469167780  2 journal read_entry 3=
012571136 : seq 1524510 127 bytes
  -459> 2013-05-14 08:13:43.148999 7ff469167780  2 journal read_entry 3=
012575232 : seq 1524511 55 bytes
  -458> 2013-05-14 08:13:43.149007 7ff469167780  2 journal read_entry 3=
012579328 : seq 1524512 127 bytes
  -457> 2013-05-14 08:13:43.149014 7ff469167780  2 journal read_entry 3=
012583424 : seq 1524513 55 bytes
  -456> 2013-05-14 08:13:43.149021 7ff469167780  2 journal read_entry 3=
012587520 : seq 1524514 128 bytes
  -455> 2013-05-14 08:13:43.149955 7ff469167780  2 journal read_entry 3=
012591616 : seq 1524515 56 bytes
  -454> 2013-05-14 08:13:43.149976 7ff469167780  2 journal read_entry 3=
012595712 : seq 1524516 128 bytes
  -453> 2013-05-14 08:13:43.149984 7ff469167780  2 journal read_entry 3=
012599808 : seq 1524517 56 bytes
  -452> 2013-05-14 08:13:43.149991 7ff469167780  2 journal read_entry 3=
012603904 : seq 1524518 128 bytes
  -451> 2013-05-14 08:13:43.149998 7ff469167780  2 journal read_entry 3=
012608000 : seq 1524519 56 bytes
  -450> 2013-05-14 08:13:43.150006 7ff469167780  2 journal read_entry 3=
012612096 : seq 1524520 128 bytes
  -449> 2013-05-14 08:13:43.150015 7ff469167780  2 journal read_entry 3=
012616192 : seq 1524521 56 bytes
  -448> 2013-05-14 08:13:43.150023 7ff469167780  2 journal read_entry 3=
012620288 : seq 1524522 128 bytes
  -447> 2013-05-14 08:13:43.150031 7ff469167780  2 journal read_entry 3=
012624384 : seq 1524523 56 bytes
  -446> 2013-05-14 08:13:43.150050 7ff469167780  2 journal read_entry 3=
012628480 : seq 1524524 128 bytes
  -445> 2013-05-14 08:13:43.150062 7ff469167780  2 journal read_entry 3=
012632576 : seq 1524525 56 bytes
  -444> 2013-05-14 08:13:43.150086 7ff469167780  2 journal read_entry 3=
012636672 : seq 1524526 3327 bytes
  -443> 2013-05-14 08:13:43.150104 7ff469167780  2 journal read_entry 3=
012640768 : seq 1524527 2067 bytes
  -442> 2013-05-14 08:13:43.151434 7ff469167780  2 journal read_entry 3=
012833280 : seq 1524528 192260 bytes
  -441> 2013-05-14 08:13:43.151454 7ff469167780  2 journal read_entry 3=
012837376 : seq 1524529 39 bytes
  -440> 2013-05-14 08:13:43.151470 7ff469167780  2 journal read_entry 3=
012841472 : seq 1524530 798 bytes
  -439> 2013-05-14 08:13:43.152603 7ff469167780  2 journal read_entry 3=
013038080 : seq 1524531 194372 bytes
  -438> 2013-05-14 08:13:43.152624 7ff469167780  2 journal read_entry 3=
013042176 : seq 1524532 39 bytes
  -437> 2013-05-14 08:13:43.152633 7ff469167780  2 journal read_entry 3=
013046272 : seq 1524533 798 bytes
  -436> 2013-05-14 08:13:43.153118 7ff469167780  2 journal read_entry 3=
013201920 : seq 1524534 152708 bytes
  -435> 2013-05-14 08:13:43.153137 7ff469167780  2 journal read_entry 3=
013206016 : seq 1524535 39 bytes
  -434> 2013-05-14 08:13:43.153153 7ff469167780  2 journal read_entry 3=
013210112 : seq 1524536 2380 bytes
  -433> 2013-05-14 08:13:43.153686 7ff469167780  2 journal read_entry 3=
013369856 : seq 1524537 158184 bytes
  -432> 2013-05-14 08:13:43.153708 7ff469167780  2 journal read_entry 3=
013373952 : seq 1524538 127 bytes
  -431> 2013-05-14 08:13:43.154098 7ff469167780  2 journal read_entry 3=
013378048 : seq 1524539 55 bytes
  -430> 2013-05-14 08:13:43.154126 7ff469167780  2 journal read_entry 3=
013382144 : seq 1524540 127 bytes
  -429> 2013-05-14 08:13:43.154134 7ff469167780  2 journal read_entry 3=
013386240 : seq 1524541 55 bytes
  -428> 2013-05-14 08:13:43.154141 7ff469167780  2 journal read_entry 3=
013390336 : seq 1524542 128 bytes
  -427> 2013-05-14 08:13:43.154148 7ff469167780  2 journal read_entry 3=
013394432 : seq 1524543 56 bytes
  -426> 2013-05-14 08:13:43.154155 7ff469167780  2 journal read_entry 3=
013398528 : seq 1524544 128 bytes
  -425> 2013-05-14 08:13:43.154162 7ff469167780  2 journal read_entry 3=
013402624 : seq 1524545 56 bytes
  -424> 2013-05-14 08:13:43.154169 7ff469167780  2 journal read_entry 3=
013406720 : seq 1524546 128 bytes
  -423> 2013-05-14 08:13:43.154176 7ff469167780  2 journal read_entry 3=
013410816 : seq 1524547 56 bytes
  -422> 2013-05-14 08:13:43.154190 7ff469167780  2 journal read_entry 3=
013414912 : seq 1524548 128 bytes
  -421> 2013-05-14 08:13:43.154200 7ff469167780  2 journal read_entry 3=
013419008 : seq 1524549 56 bytes
  -420> 2013-05-14 08:13:43.154211 7ff469167780  2 journal read_entry 3=
013423104 : seq 1524550 128 bytes
  -419> 2013-05-14 08:13:43.154221 7ff469167780  2 journal read_entry 3=
013427200 : seq 1524551 56 bytes
  -418> 2013-05-14 08:13:43.154228 7ff469167780  2 journal read_entry 3=
013431296 : seq 1524552 128 bytes
  -417> 2013-05-14 08:13:43.154235 7ff469167780  2 journal read_entry 3=
013435392 : seq 1524553 56 bytes
  -416> 2013-05-14 08:13:43.154245 7ff469167780  2 journal read_entry 3=
013439488 : seq 1524554 128 bytes
  -415> 2013-05-14 08:13:43.154254 7ff469167780  2 journal read_entry 3=
013443584 : seq 1524555 56 bytes
  -414> 2013-05-14 08:13:43.154274 7ff469167780  2 journal read_entry 3=
013447680 : seq 1524556 3812 bytes
  -413> 2013-05-14 08:13:43.154290 7ff469167780  2 journal read_entry 3=
013451776 : seq 1524557 1969 bytes
  -412> 2013-05-14 08:13:43.154729 7ff469167780  2 journal read_entry 3=
013562368 : seq 1524558 107588 bytes
  -411> 2013-05-14 08:13:43.154755 7ff469167780  2 journal read_entry 3=
013566464 : seq 1524559 39 bytes
  -410> 2013-05-14 08:13:43.154767 7ff469167780  2 journal read_entry 3=
013570560 : seq 1524560 3641 bytes
  -409> 2013-05-14 08:13:43.155250 7ff469167780  2 journal read_entry 3=
013697536 : seq 1524561 126404 bytes
  -408> 2013-05-14 08:13:43.155270 7ff469167780  2 journal read_entry 3=
013701632 : seq 1524562 39 bytes
  -407> 2013-05-14 08:13:43.155280 7ff469167780  2 journal read_entry 3=
013705728 : seq 1524563 2004 bytes
  -406> 2013-05-14 08:13:43.155864 7ff469167780  2 journal read_entry 3=
013840896 : seq 1524564 134672 bytes
  -405> 2013-05-14 08:13:43.155884 7ff469167780  2 journal read_entry 3=
013844992 : seq 1524565 128 bytes
  -404> 2013-05-14 08:13:43.155892 7ff469167780  2 journal read_entry 3=
013849088 : seq 1524566 56 bytes
  -403> 2013-05-14 08:13:43.155900 7ff469167780  2 journal read_entry 3=
013853184 : seq 1524567 524 bytes
  -402> 2013-05-14 08:13:43.155909 7ff469167780  2 journal read_entry 3=
013857280 : seq 1524568 2145 bytes
  -401> 2013-05-14 08:13:43.157004 7ff469167780  2 journal read_entry 3=
014049792 : seq 1524569 192272 bytes
  -400> 2013-05-14 08:13:43.157026 7ff469167780  2 journal read_entry 3=
014053888 : seq 1524570 127 bytes
  -399> 2013-05-14 08:13:43.157033 7ff469167780  2 journal read_entry 3=
014057984 : seq 1524571 55 bytes
  -398> 2013-05-14 08:13:43.157041 7ff469167780  2 journal read_entry 3=
014062080 : seq 1524572 127 bytes
  -397> 2013-05-14 08:13:43.157057 7ff469167780  2 journal read_entry 3=
014066176 : seq 1524573 55 bytes
  -396> 2013-05-14 08:13:43.157067 7ff469167780  2 journal read_entry 3=
014070272 : seq 1524574 128 bytes
  -395> 2013-05-14 08:13:43.157076 7ff469167780  2 journal read_entry 3=
014074368 : seq 1524575 56 bytes
  -394> 2013-05-14 08:13:43.157086 7ff469167780  2 journal read_entry 3=
014078464 : seq 1524576 128 bytes
  -393> 2013-05-14 08:13:43.157105 7ff469167780  2 journal read_entry 3=
014082560 : seq 1524577 56 bytes
  -392> 2013-05-14 08:13:43.157121 7ff469167780  2 journal read_entry 3=
014086656 : seq 1524578 128 bytes
  -391> 2013-05-14 08:13:43.157131 7ff469167780  2 journal read_entry 3=
014090752 : seq 1524579 56 bytes
  -390> 2013-05-14 08:13:43.157141 7ff469167780  2 journal read_entry 3=
014094848 : seq 1524580 128 bytes
  -389> 2013-05-14 08:13:43.157150 7ff469167780  2 journal read_entry 3=
014098944 : seq 1524581 56 bytes
  -388> 2013-05-14 08:13:43.157161 7ff469167780  2 journal read_entry 3=
014103040 : seq 1524582 128 bytes
  -387> 2013-05-14 08:13:43.157171 7ff469167780  2 journal read_entry 3=
014107136 : seq 1524583 56 bytes
  -386> 2013-05-14 08:13:43.157188 7ff469167780  2 journal read_entry 3=
014111232 : seq 1524584 2930 bytes
  -385> 2013-05-14 08:13:43.157200 7ff469167780  2 journal read_entry 3=
014115328 : seq 1524585 798 bytes
  -384> 2013-05-14 08:13:43.158161 7ff469167780  2 journal read_entry 3=
014307840 : seq 1524586 192260 bytes
  -383> 2013-05-14 08:13:43.158181 7ff469167780  2 journal read_entry 3=
014311936 : seq 1524587 39 bytes
  -382> 2013-05-14 08:13:43.158192 7ff469167780  2 journal read_entry 3=
014316032 : seq 1524588 798 bytes
  -381> 2013-05-14 08:13:43.158269 7ff469167780  2 journal read_entry 3=
014373376 : seq 1524589 57092 bytes
  -380> 2013-05-14 08:13:43.158279 7ff469167780  2 journal read_entry 3=
014377472 : seq 1524590 39 bytes
  -379> 2013-05-14 08:13:43.158291 7ff469167780  2 journal read_entry 3=
014381568 : seq 1524591 2106 bytes
  -378> 2013-05-14 08:13:43.159486 7ff469167780  2 journal read_entry 3=
014578176 : seq 1524592 192452 bytes
  -377> 2013-05-14 08:13:43.159506 7ff469167780  2 journal read_entry 3=
014582272 : seq 1524593 127 bytes
  -376> 2013-05-14 08:13:43.159516 7ff469167780  2 journal read_entry 3=
014586368 : seq 1524594 55 bytes
  -375> 2013-05-14 08:13:43.159527 7ff469167780  2 journal read_entry 3=
014590464 : seq 1524595 127 bytes
  -374> 2013-05-14 08:13:43.159537 7ff469167780  2 journal read_entry 3=
014594560 : seq 1524596 55 bytes
  -373> 2013-05-14 08:13:43.159554 7ff469167780  2 journal read_entry 3=
014598656 : seq 1524597 127 bytes
  -372> 2013-05-14 08:13:43.159562 7ff469167780  2 journal read_entry 3=
014602752 : seq 1524598 55 bytes
  -371> 2013-05-14 08:13:43.159577 7ff469167780  2 journal read_entry 3=
014606848 : seq 1524599 128 bytes
  -370> 2013-05-14 08:13:43.159588 7ff469167780  2 journal read_entry 3=
014610944 : seq 1524600 56 bytes
  -369> 2013-05-14 08:13:43.159597 7ff469167780  2 journal read_entry 3=
014615040 : seq 1524601 128 bytes
  -368> 2013-05-14 08:13:43.159606 7ff469167780  2 journal read_entry 3=
014619136 : seq 1524602 56 bytes
  -367> 2013-05-14 08:13:43.159615 7ff469167780  2 journal read_entry 3=
014623232 : seq 1524603 128 bytes
  -366> 2013-05-14 08:13:43.159624 7ff469167780  2 journal read_entry 3=
014627328 : seq 1524604 56 bytes
  -365> 2013-05-14 08:13:43.159634 7ff469167780  2 journal read_entry 3=
014631424 : seq 1524605 128 bytes
  -364> 2013-05-14 08:13:43.159643 7ff469167780  2 journal read_entry 3=
014635520 : seq 1524606 56 bytes
  -363> 2013-05-14 08:13:43.159652 7ff469167780  2 journal read_entry 3=
014639616 : seq 1524607 128 bytes
  -362> 2013-05-14 08:13:43.159661 7ff469167780  2 journal read_entry 3=
014643712 : seq 1524608 56 bytes
  -361> 2013-05-14 08:13:43.159671 7ff469167780  2 journal read_entry 3=
014647808 : seq 1524609 128 bytes
  -360> 2013-05-14 08:13:43.159680 7ff469167780  2 journal read_entry 3=
014651904 : seq 1524610 56 bytes
  -359> 2013-05-14 08:13:43.159704 7ff469167780  2 journal read_entry 3=
014660096 : seq 1524611 4398 bytes
  -358> 2013-05-14 08:13:43.159716 7ff469167780  2 journal read_entry 3=
014664192 : seq 1524612 798 bytes
  -357> 2013-05-14 08:13:43.160694 7ff469167780  2 journal read_entry 3=
014840320 : seq 1524613 172364 bytes
  -356> 2013-05-14 08:13:43.160714 7ff469167780  2 journal read_entry 3=
014844416 : seq 1524614 127 bytes
  -355> 2013-05-14 08:13:43.160724 7ff469167780  2 journal read_entry 3=
014848512 : seq 1524615 55 bytes
  -354> 2013-05-14 08:13:43.160737 7ff469167780  2 journal read_entry 3=
014852608 : seq 1524616 127 bytes
  -353> 2013-05-14 08:13:43.160747 7ff469167780  2 journal read_entry 3=
014856704 : seq 1524617 55 bytes
  -352> 2013-05-14 08:13:43.160757 7ff469167780  2 journal read_entry 3=
014860800 : seq 1524618 127 bytes
  -351> 2013-05-14 08:13:43.160766 7ff469167780  2 journal read_entry 3=
014864896 : seq 1524619 55 bytes
  -350> 2013-05-14 08:13:43.160775 7ff469167780  2 journal read_entry 3=
014868992 : seq 1524620 128 bytes
  -349> 2013-05-14 08:13:43.160784 7ff469167780  2 journal read_entry 3=
014873088 : seq 1524621 56 bytes
  -348> 2013-05-14 08:13:43.160793 7ff469167780  2 journal read_entry 3=
014877184 : seq 1524622 128 bytes
  -347> 2013-05-14 08:13:43.160802 7ff469167780  2 journal read_entry 3=
014881280 : seq 1524623 56 bytes
  -346> 2013-05-14 08:13:43.160812 7ff469167780  2 journal read_entry 3=
014885376 : seq 1524624 128 bytes
  -345> 2013-05-14 08:13:43.160822 7ff469167780  2 journal read_entry 3=
014889472 : seq 1524625 56 bytes
  -344> 2013-05-14 08:13:43.160835 7ff469167780  2 journal read_entry 3=
014893568 : seq 1524626 2548 bytes
  -343> 2013-05-14 08:13:43.160846 7ff469167780  2 journal read_entry 3=
014897664 : seq 1524627 2071 bytes
  -342> 2013-05-14 08:13:43.161875 7ff469167780  2 journal read_entry 3=
015102464 : seq 1524628 200708 bytes
  -341> 2013-05-14 08:13:43.161898 7ff469167780  2 journal read_entry 3=
015106560 : seq 1524629 215 bytes
  -340> 2013-05-14 08:13:43.161907 7ff469167780  2 journal read_entry 3=
015110656 : seq 1524630 55 bytes
  -339> 2013-05-14 08:13:43.161915 7ff469167780  2 journal read_entry 3=
015114752 : seq 1524631 215 bytes
  -338> 2013-05-14 08:13:43.161924 7ff469167780  2 journal read_entry 3=
015118848 : seq 1524632 55 bytes
  -337> 2013-05-14 08:13:43.161934 7ff469167780  2 journal read_entry 3=
015122944 : seq 1524633 128 bytes
  -336> 2013-05-14 08:13:43.161943 7ff469167780  2 journal read_entry 3=
015127040 : seq 1524634 56 bytes
  -335> 2013-05-14 08:13:43.162107 7ff469167780  2 journal read_entry 3=
015131136 : seq 1524635 128 bytes
  -334> 2013-05-14 08:13:43.162143 7ff469167780  2 journal read_entry 3=
015135232 : seq 1524636 56 bytes
  -333> 2013-05-14 08:13:43.162152 7ff469167780  2 journal read_entry 3=
015139328 : seq 1524637 128 bytes
  -332> 2013-05-14 08:13:43.162162 7ff469167780  2 journal read_entry 3=
015143424 : seq 1524638 56 bytes
  -331> 2013-05-14 08:13:43.162171 7ff469167780  2 journal read_entry 3=
015147520 : seq 1524639 128 bytes
  -330> 2013-05-14 08:13:43.162178 7ff469167780  2 journal read_entry 3=
015151616 : seq 1524640 56 bytes
  -329> 2013-05-14 08:13:43.162187 7ff469167780  2 journal read_entry 3=
015155712 : seq 1524641 128 bytes
  -328> 2013-05-14 08:13:43.162195 7ff469167780  2 journal read_entry 3=
015159808 : seq 1524642 56 bytes
  -327> 2013-05-14 08:13:43.162204 7ff469167780  2 journal read_entry 3=
015163904 : seq 1524643 128 bytes
  -326> 2013-05-14 08:13:43.162213 7ff469167780  2 journal read_entry 3=
015168000 : seq 1524644 56 bytes
  -325> 2013-05-14 08:13:43.162222 7ff469167780  2 journal read_entry 3=
015172096 : seq 1524645 128 bytes
  -324> 2013-05-14 08:13:43.162232 7ff469167780  2 journal read_entry 3=
015176192 : seq 1524646 56 bytes
  -323> 2013-05-14 08:13:43.162257 7ff469167780  2 journal read_entry 3=
015184384 : seq 1524647 5073 bytes
  -322> 2013-05-14 08:13:43.162272 7ff469167780  2 journal read_entry 3=
015188480 : seq 1524648 2283 bytes
  -321> 2013-05-14 08:13:43.162479 7ff469167780  2 journal read_entry 3=
015303168 : seq 1524649 111044 bytes
  -320> 2013-05-14 08:13:43.162495 7ff469167780  2 journal read_entry 3=
015307264 : seq 1524650 39 bytes
  -319> 2013-05-14 08:13:43.162540 7ff469167780  2 journal read_entry 3=
015331840 : seq 1524651 23465 bytes
  -318> 2013-05-14 08:13:43.163782 7ff469167780  2 journal read_entry 3=
015524352 : seq 1524652 192260 bytes
  -317> 2013-05-14 08:13:43.163802 7ff469167780  2 journal read_entry 3=
015528448 : seq 1524653 128 bytes
  -316> 2013-05-14 08:13:43.163813 7ff469167780  2 journal read_entry 3=
015532544 : seq 1524654 56 bytes
  -315> 2013-05-14 08:13:43.163822 7ff469167780  2 journal read_entry 3=
015536640 : seq 1524655 524 bytes
  -314> 2013-05-14 08:13:43.163830 7ff469167780  2 journal read_entry 3=
015540736 : seq 1524656 798 bytes
  -313> 2013-05-14 08:13:43.164952 7ff469167780  2 journal read_entry 3=
015737344 : seq 1524657 192464 bytes
  -312> 2013-05-14 08:13:43.164974 7ff469167780  2 journal read_entry 3=
015741440 : seq 1524658 127 bytes
  -311> 2013-05-14 08:13:43.164982 7ff469167780  2 journal read_entry 3=
015745536 : seq 1524659 55 bytes
  -310> 2013-05-14 08:13:43.164989 7ff469167780  2 journal read_entry 3=
015749632 : seq 1524660 127 bytes
  -309> 2013-05-14 08:13:43.164996 7ff469167780  2 journal read_entry 3=
015753728 : seq 1524661 55 bytes
  -308> 2013-05-14 08:13:43.165009 7ff469167780  2 journal read_entry 3=
015757824 : seq 1524662 128 bytes
  -307> 2013-05-14 08:13:43.165019 7ff469167780  2 journal read_entry 3=
015761920 : seq 1524663 56 bytes
  -306> 2013-05-14 08:13:43.165030 7ff469167780  2 journal read_entry 3=
015766016 : seq 1524664 128 bytes
  -305> 2013-05-14 08:13:43.165040 7ff469167780  2 journal read_entry 3=
015770112 : seq 1524665 56 bytes
  -304> 2013-05-14 08:13:43.165051 7ff469167780  2 journal read_entry 3=
015774208 : seq 1524666 128 bytes
  -303> 2013-05-14 08:13:43.165061 7ff469167780  2 journal read_entry 3=
015778304 : seq 1524667 56 bytes
  -302> 2013-05-14 08:13:43.165070 7ff469167780  2 journal read_entry 3=
015782400 : seq 1524668 128 bytes
  -301> 2013-05-14 08:13:43.165085 7ff469167780  2 journal read_entry 3=
015786496 : seq 1524669 56 bytes
  -300> 2013-05-14 08:13:43.165106 7ff469167780  2 journal read_entry 3=
015790592 : seq 1524670 3224 bytes
  -299> 2013-05-14 08:13:43.165120 7ff469167780  2 journal read_entry 3=
015794688 : seq 1524671 1887 bytes
  -298> 2013-05-14 08:13:43.165438 7ff469167780  2 journal read_entry 3=
015901184 : seq 1524672 106244 bytes
  -297> 2013-05-14 08:13:43.165459 7ff469167780  2 journal read_entry 3=
015905280 : seq 1524673 39 bytes
  -296> 2013-05-14 08:13:43.165468 7ff469167780  2 journal read_entry 3=
015909376 : seq 1524674 798 bytes
  -295> 2013-05-14 08:13:43.166231 7ff469167780  2 journal read_entry 3=
016101888 : seq 1524675 192260 bytes
  -294> 2013-05-14 08:13:43.166249 7ff469167780  2 journal read_entry 3=
016105984 : seq 1524676 128 bytes
  -293> 2013-05-14 08:13:43.166257 7ff469167780  2 journal read_entry 3=
016110080 : seq 1524677 56 bytes
  -292> 2013-05-14 08:13:43.166265 7ff469167780  2 journal read_entry 3=
016114176 : seq 1524678 524 bytes
  -291> 2013-05-14 08:13:43.166275 7ff469167780  2 journal read_entry 3=
016118272 : seq 1524679 2173 bytes
  -290> 2013-05-14 08:13:43.167383 7ff469167780  2 journal read_entry 3=
016298496 : seq 1524680 179216 bytes
  -289> 2013-05-14 08:13:43.167403 7ff469167780  2 journal read_entry 3=
016302592 : seq 1524681 128 bytes
  -288> 2013-05-14 08:13:43.167411 7ff469167780  2 journal read_entry 3=
016306688 : seq 1524682 56 bytes
  -287> 2013-05-14 08:13:43.167419 7ff469167780  2 journal read_entry 3=
016310784 : seq 1524683 524 bytes
  -286> 2013-05-14 08:13:43.167427 7ff469167780  2 journal read_entry 3=
016314880 : seq 1524684 798 bytes
  -285> 2013-05-14 08:13:43.167958 7ff469167780  2 journal read_entry 3=
016511488 : seq 1524685 192452 bytes
  -284> 2013-05-14 08:13:43.167977 7ff469167780  2 journal read_entry 3=
016515584 : seq 1524686 39 bytes
  -283> 2013-05-14 08:13:43.167987 7ff469167780  2 journal read_entry 3=
016519680 : seq 1524687 2079 bytes
  -282> 2013-05-14 08:13:43.168348 7ff469167780  2 journal No further v=
alid entries found, journal is most likely valid
  -281> 2013-05-14 08:13:43.168362 7ff469167780  2 journal No further v=
alid entries found, journal is most likely valid
  -280> 2013-05-14 08:13:43.168364 7ff469167780  3 journal journal_repl=
ay: end of journal, done.
  -279> 2013-05-14 08:13:43.171846 7ff469167780  1 journal _open /dev/s=
di3 fd 18: 26843545600 bytes, block size 4096 bytes, directio =3D 1, ai=
o =3D 1
  -278> 2013-05-14 08:13:43.172533 7ff461e7e700  1 FileStore::op_tp wor=
ker finish
  -277> 2013-05-14 08:13:43.172626 7ff46167d700  1 FileStore::op_tp wor=
ker finish
  -276> 2013-05-14 08:13:43.172772 7ff469167780  1 journal close /dev/s=
di3
  -275> 2013-05-14 08:13:43.173616 7ff469167780 10 monclient(hunting): =
build_initial_monmap
  -274> 2013-05-14 08:13:43.173746 7ff469167780  5 adding auth protocol=
: cephx
  -273> 2013-05-14 08:13:43.173754 7ff469167780  5 adding auth protocol=
: cephx
  -272> 2013-05-14 08:13:43.173865 7ff469167780  1 -- 10.0.0.3:6806/314=
24 messenger.start
  -271> 2013-05-14 08:13:43.173899 7ff469167780  1 -- :/0 messenger.sta=
rt
  -270> 2013-05-14 08:13:43.173916 7ff469167780  1 -- 192.168.42.3:6811=
/31424 messenger.start
  -269> 2013-05-14 08:13:43.173935 7ff469167780  1 -- 192.168.42.3:6810=
/31424 messenger.start
  -268> 2013-05-14 08:13:43.174066 7ff469167780  2 osd.25 0 mounting /v=
ar/lib/ceph/osd/ceph-25 /dev/sdi3
  -267> 2013-05-14 08:13:43.179918 7ff469167780  0 filestore(/var/lib/c=
eph/osd/ceph-25) mount FIEMAP ioctl is supported and appears to work
  -266> 2013-05-14 08:13:43.179929 7ff469167780  0 filestore(/var/lib/c=
eph/osd/ceph-25) mount FIEMAP ioctl is disabled via 'filestore fiemap' =
config option
  -265> 2013-05-14 08:13:43.180340 7ff469167780  0 filestore(/var/lib/c=
eph/osd/ceph-25) mount did NOT detect btrfs
  -264> 2013-05-14 08:13:43.182242 7ff469167780  0 filestore(/var/lib/c=
eph/osd/ceph-25) mount syscall(__NR_syncfs, fd) fully supported
  -263> 2013-05-14 08:13:43.182304 7ff469167780  0 filestore(/var/lib/c=
eph/osd/ceph-25) mount found snaps <>
  -262> 2013-05-14 08:13:43.185621 7ff469167780  0 filestore(/var/lib/c=
eph/osd/ceph-25) mount: enabling WRITEAHEAD journal mode: btrfs not det=
ected
  -261> 2013-05-14 08:13:43.190960 7ff469167780  2 journal open /dev/sd=
i3 fsid e82dd661-2ad1-4103-92d4-26a3926d524b fs_op_seq 1524687
  -260> 2013-05-14 08:13:43.193318 7ff469167780  1 journal _open /dev/s=
di3 fd 26: 26843545600 bytes, block size 4096 bytes, directio =3D 1, ai=
o =3D 1
  -259> 2013-05-14 08:13:43.195327 7ff469167780  2 journal read_entry 3=
012567040 : seq 1524509 111324 bytes
  -258> 2013-05-14 08:13:43.195410 7ff469167780  2 journal read_entry 3=
012571136 : seq 1524510 127 bytes
  -257> 2013-05-14 08:13:43.195428 7ff469167780  2 journal read_entry 3=
012575232 : seq 1524511 55 bytes
  -256> 2013-05-14 08:13:43.195436 7ff469167780  2 journal read_entry 3=
012579328 : seq 1524512 127 bytes
  -255> 2013-05-14 08:13:43.195443 7ff469167780  2 journal read_entry 3=
012583424 : seq 1524513 55 bytes
  -254> 2013-05-14 08:13:43.195450 7ff469167780  2 journal read_entry 3=
012587520 : seq 1524514 128 bytes
  -253> 2013-05-14 08:13:43.196063 7ff469167780  2 journal read_entry 3=
012591616 : seq 1524515 56 bytes
  -252> 2013-05-14 08:13:43.196078 7ff469167780  2 journal read_entry 3=
012595712 : seq 1524516 128 bytes
  -251> 2013-05-14 08:13:43.196085 7ff469167780  2 journal read_entry 3=
012599808 : seq 1524517 56 bytes
  -250> 2013-05-14 08:13:43.196092 7ff469167780  2 journal read_entry 3=
012603904 : seq 1524518 128 bytes
  -249> 2013-05-14 08:13:43.196099 7ff469167780  2 journal read_entry 3=
012608000 : seq 1524519 56 bytes
  -248> 2013-05-14 08:13:43.196106 7ff469167780  2 journal read_entry 3=
012612096 : seq 1524520 128 bytes
  -247> 2013-05-14 08:13:43.196119 7ff469167780  2 journal read_entry 3=
012616192 : seq 1524521 56 bytes
  -246> 2013-05-14 08:13:43.196128 7ff469167780  2 journal read_entry 3=
012620288 : seq 1524522 128 bytes
  -245> 2013-05-14 08:13:43.196140 7ff469167780  2 journal read_entry 3=
012624384 : seq 1524523 56 bytes
  -244> 2013-05-14 08:13:43.196150 7ff469167780  2 journal read_entry 3=
012628480 : seq 1524524 128 bytes
  -243> 2013-05-14 08:13:43.196159 7ff469167780  2 journal read_entry 3=
012632576 : seq 1524525 56 bytes
  -242> 2013-05-14 08:13:43.196179 7ff469167780  2 journal read_entry 3=
012636672 : seq 1524526 3327 bytes
  -241> 2013-05-14 08:13:43.196195 7ff469167780  2 journal read_entry 3=
012640768 : seq 1524527 2067 bytes
  -240> 2013-05-14 08:13:43.197046 7ff469167780  2 journal read_entry 3=
012833280 : seq 1524528 192260 bytes
  -239> 2013-05-14 08:13:43.197066 7ff469167780  2 journal read_entry 3=
012837376 : seq 1524529 39 bytes
  -238> 2013-05-14 08:13:43.197077 7ff469167780  2 journal read_entry 3=
012841472 : seq 1524530 798 bytes
  -237> 2013-05-14 08:13:43.198055 7ff469167780  2 journal read_entry 3=
013038080 : seq 1524531 194372 bytes
  -236> 2013-05-14 08:13:43.198076 7ff469167780  2 journal read_entry 3=
013042176 : seq 1524532 39 bytes
  -235> 2013-05-14 08:13:43.198085 7ff469167780  2 journal read_entry 3=
013046272 : seq 1524533 798 bytes
  -234> 2013-05-14 08:13:43.198532 7ff469167780  2 journal read_entry 3=
013201920 : seq 1524534 152708 bytes
  -233> 2013-05-14 08:13:43.198551 7ff469167780  2 journal read_entry 3=
013206016 : seq 1524535 39 bytes
  -232> 2013-05-14 08:13:43.198565 7ff469167780  2 journal read_entry 3=
013210112 : seq 1524536 2380 bytes
  -231> 2013-05-14 08:13:43.199227 7ff469167780  2 journal read_entry 3=
013369856 : seq 1524537 158184 bytes
  -230> 2013-05-14 08:13:43.199247 7ff469167780  2 journal read_entry 3=
013373952 : seq 1524538 127 bytes
  -229> 2013-05-14 08:13:43.199568 7ff469167780  2 journal read_entry 3=
013378048 : seq 1524539 55 bytes
  -228> 2013-05-14 08:13:43.199583 7ff469167780  2 journal read_entry 3=
013382144 : seq 1524540 127 bytes
  -227> 2013-05-14 08:13:43.199591 7ff469167780  2 journal read_entry 3=
013386240 : seq 1524541 55 bytes
  -226> 2013-05-14 08:13:43.199598 7ff469167780  2 journal read_entry 3=
013390336 : seq 1524542 128 bytes
  -225> 2013-05-14 08:13:43.199605 7ff469167780  2 journal read_entry 3=
013394432 : seq 1524543 56 bytes
  -224> 2013-05-14 08:13:43.199614 7ff469167780  2 journal read_entry 3=
013398528 : seq 1524544 128 bytes
  -223> 2013-05-14 08:13:43.199623 7ff469167780  2 journal read_entry 3=
013402624 : seq 1524545 56 bytes
  -222> 2013-05-14 08:13:43.199632 7ff469167780  2 journal read_entry 3=
013406720 : seq 1524546 128 bytes
  -221> 2013-05-14 08:13:43.199648 7ff469167780  2 journal read_entry 3=
013410816 : seq 1524547 56 bytes
  -220> 2013-05-14 08:13:43.199658 7ff469167780  2 journal read_entry 3=
013414912 : seq 1524548 128 bytes
  -219> 2013-05-14 08:13:43.199667 7ff469167780  2 journal read_entry 3=
013419008 : seq 1524549 56 bytes
  -218> 2013-05-14 08:13:43.199676 7ff469167780  2 journal read_entry 3=
013423104 : seq 1524550 128 bytes
  -217> 2013-05-14 08:13:43.199685 7ff469167780  2 journal read_entry 3=
013427200 : seq 1524551 56 bytes
  -216> 2013-05-14 08:13:43.199694 7ff469167780  2 journal read_entry 3=
013431296 : seq 1524552 128 bytes
  -215> 2013-05-14 08:13:43.199703 7ff469167780  2 journal read_entry 3=
013435392 : seq 1524553 56 bytes
  -214> 2013-05-14 08:13:43.199713 7ff469167780  2 journal read_entry 3=
013439488 : seq 1524554 128 bytes
  -213> 2013-05-14 08:13:43.199722 7ff469167780  2 journal read_entry 3=
013443584 : seq 1524555 56 bytes
  -212> 2013-05-14 08:13:43.199740 7ff469167780  2 journal read_entry 3=
013447680 : seq 1524556 3812 bytes
  -211> 2013-05-14 08:13:43.199756 7ff469167780  2 journal read_entry 3=
013451776 : seq 1524557 1969 bytes
  -210> 2013-05-14 08:13:43.200209 7ff469167780  2 journal read_entry 3=
013562368 : seq 1524558 107588 bytes
  -209> 2013-05-14 08:13:43.200227 7ff469167780  2 journal read_entry 3=
013566464 : seq 1524559 39 bytes
  -208> 2013-05-14 08:13:43.200241 7ff469167780  2 journal read_entry 3=
013570560 : seq 1524560 3641 bytes
  -207> 2013-05-14 08:13:43.200753 7ff469167780  2 journal read_entry 3=
013697536 : seq 1524561 126404 bytes
  -206> 2013-05-14 08:13:43.200771 7ff469167780  2 journal read_entry 3=
013701632 : seq 1524562 39 bytes
  -205> 2013-05-14 08:13:43.200781 7ff469167780  2 journal read_entry 3=
013705728 : seq 1524563 2004 bytes
  -204> 2013-05-14 08:13:43.201406 7ff469167780  2 journal read_entry 3=
013840896 : seq 1524564 134672 bytes
  -203> 2013-05-14 08:13:43.201426 7ff469167780  2 journal read_entry 3=
013844992 : seq 1524565 128 bytes
  -202> 2013-05-14 08:13:43.201439 7ff469167780  2 journal read_entry 3=
013849088 : seq 1524566 56 bytes
  -201> 2013-05-14 08:13:43.201447 7ff469167780  2 journal read_entry 3=
013853184 : seq 1524567 524 bytes
  -200> 2013-05-14 08:13:43.201456 7ff469167780  2 journal read_entry 3=
013857280 : seq 1524568 2145 bytes
  -199> 2013-05-14 08:13:43.202430 7ff469167780  2 journal read_entry 3=
014049792 : seq 1524569 192272 bytes
  -198> 2013-05-14 08:13:43.202450 7ff469167780  2 journal read_entry 3=
014053888 : seq 1524570 127 bytes
  -197> 2013-05-14 08:13:43.202457 7ff469167780  2 journal read_entry 3=
014057984 : seq 1524571 55 bytes
  -196> 2013-05-14 08:13:43.202465 7ff469167780  2 journal read_entry 3=
014062080 : seq 1524572 127 bytes
  -195> 2013-05-14 08:13:43.202472 7ff469167780  2 journal read_entry 3=
014066176 : seq 1524573 55 bytes
  -194> 2013-05-14 08:13:43.202480 7ff469167780  2 journal read_entry 3=
014070272 : seq 1524574 128 bytes
  -193> 2013-05-14 08:13:43.202487 7ff469167780  2 journal read_entry 3=
014074368 : seq 1524575 56 bytes
  -192> 2013-05-14 08:13:43.202494 7ff469167780  2 journal read_entry 3=
014078464 : seq 1524576 128 bytes
  -191> 2013-05-14 08:13:43.202503 7ff469167780  2 journal read_entry 3=
014082560 : seq 1524577 56 bytes
  -190> 2013-05-14 08:13:43.202512 7ff469167780  2 journal read_entry 3=
014086656 : seq 1524578 128 bytes
  -189> 2013-05-14 08:13:43.202522 7ff469167780  2 journal read_entry 3=
014090752 : seq 1524579 56 bytes
  -188> 2013-05-14 08:13:43.202529 7ff469167780  2 journal read_entry 3=
014094848 : seq 1524580 128 bytes
  -187> 2013-05-14 08:13:43.202538 7ff469167780  2 journal read_entry 3=
014098944 : seq 1524581 56 bytes
  -186> 2013-05-14 08:13:43.202547 7ff469167780  2 journal read_entry 3=
014103040 : seq 1524582 128 bytes
  -185> 2013-05-14 08:13:43.202556 7ff469167780  2 journal read_entry 3=
014107136 : seq 1524583 56 bytes
  -184> 2013-05-14 08:13:43.202576 7ff469167780  2 journal read_entry 3=
014111232 : seq 1524584 2930 bytes
  -183> 2013-05-14 08:13:43.202591 7ff469167780  2 journal read_entry 3=
014115328 : seq 1524585 798 bytes
  -182> 2013-05-14 08:13:43.203538 7ff469167780  2 journal read_entry 3=
014307840 : seq 1524586 192260 bytes
  -181> 2013-05-14 08:13:43.203558 7ff469167780  2 journal read_entry 3=
014311936 : seq 1524587 39 bytes
  -180> 2013-05-14 08:13:43.203567 7ff469167780  2 journal read_entry 3=
014316032 : seq 1524588 798 bytes
  -179> 2013-05-14 08:13:43.203643 7ff469167780  2 journal read_entry 3=
014373376 : seq 1524589 57092 bytes
  -178> 2013-05-14 08:13:43.203654 7ff469167780  2 journal read_entry 3=
014377472 : seq 1524590 39 bytes
  -177> 2013-05-14 08:13:43.203665 7ff469167780  2 journal read_entry 3=
014381568 : seq 1524591 2106 bytes
  -176> 2013-05-14 08:13:43.204727 7ff469167780  2 journal read_entry 3=
014578176 : seq 1524592 192452 bytes
  -175> 2013-05-14 08:13:43.204747 7ff469167780  2 journal read_entry 3=
014582272 : seq 1524593 127 bytes
  -174> 2013-05-14 08:13:43.204754 7ff469167780  2 journal read_entry 3=
014586368 : seq 1524594 55 bytes
  -173> 2013-05-14 08:13:43.204762 7ff469167780  2 journal read_entry 3=
014590464 : seq 1524595 127 bytes
  -172> 2013-05-14 08:13:43.204768 7ff469167780  2 journal read_entry 3=
014594560 : seq 1524596 55 bytes
  -171> 2013-05-14 08:13:43.204776 7ff469167780  2 journal read_entry 3=
014598656 : seq 1524597 127 bytes
  -170> 2013-05-14 08:13:43.204783 7ff469167780  2 journal read_entry 3=
014602752 : seq 1524598 55 bytes
  -169> 2013-05-14 08:13:43.204790 7ff469167780  2 journal read_entry 3=
014606848 : seq 1524599 128 bytes
  -168> 2013-05-14 08:13:43.204797 7ff469167780  2 journal read_entry 3=
014610944 : seq 1524600 56 bytes
  -167> 2013-05-14 08:13:43.204804 7ff469167780  2 journal read_entry 3=
014615040 : seq 1524601 128 bytes
  -166> 2013-05-14 08:13:43.204818 7ff469167780  2 journal read_entry 3=
014619136 : seq 1524602 56 bytes
  -165> 2013-05-14 08:13:43.204831 7ff469167780  2 journal read_entry 3=
014623232 : seq 1524603 128 bytes
  -164> 2013-05-14 08:13:43.204848 7ff469167780  2 journal read_entry 3=
014627328 : seq 1524604 56 bytes
  -163> 2013-05-14 08:13:43.204856 7ff469167780  2 journal read_entry 3=
014631424 : seq 1524605 128 bytes
  -162> 2013-05-14 08:13:43.204867 7ff469167780  2 journal read_entry 3=
014635520 : seq 1524606 56 bytes
  -161> 2013-05-14 08:13:43.204876 7ff469167780  2 journal read_entry 3=
014639616 : seq 1524607 128 bytes
  -160> 2013-05-14 08:13:43.204886 7ff469167780  2 journal read_entry 3=
014643712 : seq 1524608 56 bytes
  -159> 2013-05-14 08:13:43.204895 7ff469167780  2 journal read_entry 3=
014647808 : seq 1524609 128 bytes
  -158> 2013-05-14 08:13:43.204904 7ff469167780  2 journal read_entry 3=
014651904 : seq 1524610 56 bytes
  -157> 2013-05-14 08:13:43.204925 7ff469167780  2 journal read_entry 3=
014660096 : seq 1524611 4398 bytes
  -156> 2013-05-14 08:13:43.204936 7ff469167780  2 journal read_entry 3=
014664192 : seq 1524612 798 bytes
  -155> 2013-05-14 08:13:43.205919 7ff469167780  2 journal read_entry 3=
014840320 : seq 1524613 172364 bytes
  -154> 2013-05-14 08:13:43.205940 7ff469167780  2 journal read_entry 3=
014844416 : seq 1524614 127 bytes
  -153> 2013-05-14 08:13:43.205947 7ff469167780  2 journal read_entry 3=
014848512 : seq 1524615 55 bytes
  -152> 2013-05-14 08:13:43.205954 7ff469167780  2 journal read_entry 3=
014852608 : seq 1524616 127 bytes
  -151> 2013-05-14 08:13:43.205962 7ff469167780  2 journal read_entry 3=
014856704 : seq 1524617 55 bytes
  -150> 2013-05-14 08:13:43.205971 7ff469167780  2 journal read_entry 3=
014860800 : seq 1524618 127 bytes
  -149> 2013-05-14 08:13:43.205980 7ff469167780  2 journal read_entry 3=
014864896 : seq 1524619 55 bytes
  -148> 2013-05-14 08:13:43.205990 7ff469167780  2 journal read_entry 3=
014868992 : seq 1524620 128 bytes
  -147> 2013-05-14 08:13:43.205999 7ff469167780  2 journal read_entry 3=
014873088 : seq 1524621 56 bytes
  -146> 2013-05-14 08:13:43.206006 7ff469167780  2 journal read_entry 3=
014877184 : seq 1524622 128 bytes
  -145> 2013-05-14 08:13:43.206018 7ff469167780  2 journal read_entry 3=
014881280 : seq 1524623 56 bytes
  -144> 2013-05-14 08:13:43.206025 7ff469167780  2 journal read_entry 3=
014885376 : seq 1524624 128 bytes
  -143> 2013-05-14 08:13:43.206034 7ff469167780  2 journal read_entry 3=
014889472 : seq 1524625 56 bytes
  -142> 2013-05-14 08:13:43.206044 7ff469167780  2 journal read_entry 3=
014893568 : seq 1524626 2548 bytes
  -141> 2013-05-14 08:13:43.206056 7ff469167780  2 journal read_entry 3=
014897664 : seq 1524627 2071 bytes
  -140> 2013-05-14 08:13:43.207021 7ff469167780  2 journal read_entry 3=
015102464 : seq 1524628 200708 bytes
  -139> 2013-05-14 08:13:43.207044 7ff469167780  2 journal read_entry 3=
015106560 : seq 1524629 215 bytes
  -138> 2013-05-14 08:13:43.207052 7ff469167780  2 journal read_entry 3=
015110656 : seq 1524630 55 bytes
  -137> 2013-05-14 08:13:43.207059 7ff469167780  2 journal read_entry 3=
015114752 : seq 1524631 215 bytes
  -136> 2013-05-14 08:13:43.207066 7ff469167780  2 journal read_entry 3=
015118848 : seq 1524632 55 bytes
  -135> 2013-05-14 08:13:43.207076 7ff469167780  2 journal read_entry 3=
015122944 : seq 1524633 128 bytes
  -134> 2013-05-14 08:13:43.207087 7ff469167780  2 journal read_entry 3=
015127040 : seq 1524634 56 bytes
  -133> 2013-05-14 08:13:43.207097 7ff469167780  2 journal read_entry 3=
015131136 : seq 1524635 128 bytes
  -132> 2013-05-14 08:13:43.207106 7ff469167780  2 journal read_entry 3=
015135232 : seq 1524636 56 bytes
  -131> 2013-05-14 08:13:43.207114 7ff469167780  2 journal read_entry 3=
015139328 : seq 1524637 128 bytes
  -130> 2013-05-14 08:13:43.207122 7ff469167780  2 journal read_entry 3=
015143424 : seq 1524638 56 bytes
  -129> 2013-05-14 08:13:43.207130 7ff469167780  2 journal read_entry 3=
015147520 : seq 1524639 128 bytes
  -128> 2013-05-14 08:13:43.207139 7ff469167780  2 journal read_entry 3=
015151616 : seq 1524640 56 bytes
  -127> 2013-05-14 08:13:43.207146 7ff469167780  2 journal read_entry 3=
015155712 : seq 1524641 128 bytes
  -126> 2013-05-14 08:13:43.207158 7ff469167780  2 journal read_entry 3=
015159808 : seq 1524642 56 bytes
  -125> 2013-05-14 08:13:43.207165 7ff469167780  2 journal read_entry 3=
015163904 : seq 1524643 128 bytes
  -124> 2013-05-14 08:13:43.207174 7ff469167780  2 journal read_entry 3=
015168000 : seq 1524644 56 bytes
  -123> 2013-05-14 08:13:43.207181 7ff469167780  2 journal read_entry 3=
015172096 : seq 1524645 128 bytes
  -122> 2013-05-14 08:13:43.207190 7ff469167780  2 journal read_entry 3=
015176192 : seq 1524646 56 bytes
  -121> 2013-05-14 08:13:43.207211 7ff469167780  2 journal read_entry 3=
015184384 : seq 1524647 5073 bytes
  -120> 2013-05-14 08:13:43.207225 7ff469167780  2 journal read_entry 3=
015188480 : seq 1524648 2283 bytes
  -119> 2013-05-14 08:13:43.207451 7ff469167780  2 journal read_entry 3=
015303168 : seq 1524649 111044 bytes
  -118> 2013-05-14 08:13:43.207467 7ff469167780  2 journal read_entry 3=
015307264 : seq 1524650 39 bytes
  -117> 2013-05-14 08:13:43.207520 7ff469167780  2 journal read_entry 3=
015331840 : seq 1524651 23465 bytes
  -116> 2013-05-14 08:13:43.208733 7ff469167780  2 journal read_entry 3=
015524352 : seq 1524652 192260 bytes
  -115> 2013-05-14 08:13:43.208753 7ff469167780  2 journal read_entry 3=
015528448 : seq 1524653 128 bytes
  -114> 2013-05-14 08:13:43.208763 7ff469167780  2 journal read_entry 3=
015532544 : seq 1524654 56 bytes
  -113> 2013-05-14 08:13:43.208771 7ff469167780  2 journal read_entry 3=
015536640 : seq 1524655 524 bytes
  -112> 2013-05-14 08:13:43.208779 7ff469167780  2 journal read_entry 3=
015540736 : seq 1524656 798 bytes
  -111> 2013-05-14 08:13:43.209724 7ff469167780  2 journal read_entry 3=
015737344 : seq 1524657 192464 bytes
  -110> 2013-05-14 08:13:43.209744 7ff469167780  2 journal read_entry 3=
015741440 : seq 1524658 127 bytes
  -109> 2013-05-14 08:13:43.209752 7ff469167780  2 journal read_entry 3=
015745536 : seq 1524659 55 bytes
  -108> 2013-05-14 08:13:43.209759 7ff469167780  2 journal read_entry 3=
015749632 : seq 1524660 127 bytes
  -107> 2013-05-14 08:13:43.209769 7ff469167780  2 journal read_entry 3=
015753728 : seq 1524661 55 bytes
  -106> 2013-05-14 08:13:43.209780 7ff469167780  2 journal read_entry 3=
015757824 : seq 1524662 128 bytes
  -105> 2013-05-14 08:13:43.209792 7ff469167780  2 journal read_entry 3=
015761920 : seq 1524663 56 bytes
  -104> 2013-05-14 08:13:43.209802 7ff469167780  2 journal read_entry 3=
015766016 : seq 1524664 128 bytes
  -103> 2013-05-14 08:13:43.209812 7ff469167780  2 journal read_entry 3=
015770112 : seq 1524665 56 bytes
  -102> 2013-05-14 08:13:43.209821 7ff469167780  2 journal read_entry 3=
015774208 : seq 1524666 128 bytes
  -101> 2013-05-14 08:13:43.209828 7ff469167780  2 journal read_entry 3=
015778304 : seq 1524667 56 bytes
  -100> 2013-05-14 08:13:43.209835 7ff469167780  2 journal read_entry 3=
015782400 : seq 1524668 128 bytes
   -99> 2013-05-14 08:13:43.209850 7ff469167780  2 journal read_entry 3=
015786496 : seq 1524669 56 bytes
   -98> 2013-05-14 08:13:43.209864 7ff469167780  2 journal read_entry 3=
015790592 : seq 1524670 3224 bytes
   -97> 2013-05-14 08:13:43.209875 7ff469167780  2 journal read_entry 3=
015794688 : seq 1524671 1887 bytes
   -96> 2013-05-14 08:13:43.210260 7ff469167780  2 journal read_entry 3=
015901184 : seq 1524672 106244 bytes
   -95> 2013-05-14 08:13:43.210278 7ff469167780  2 journal read_entry 3=
015905280 : seq 1524673 39 bytes
   -94> 2013-05-14 08:13:43.210286 7ff469167780  2 journal read_entry 3=
015909376 : seq 1524674 798 bytes
   -93> 2013-05-14 08:13:43.210838 7ff469167780  2 journal read_entry 3=
016101888 : seq 1524675 192260 bytes
   -92> 2013-05-14 08:13:43.210856 7ff469167780  2 journal read_entry 3=
016105984 : seq 1524676 128 bytes
   -91> 2013-05-14 08:13:43.210865 7ff469167780  2 journal read_entry 3=
016110080 : seq 1524677 56 bytes
   -90> 2013-05-14 08:13:43.210873 7ff469167780  2 journal read_entry 3=
016114176 : seq 1524678 524 bytes
   -89> 2013-05-14 08:13:43.210883 7ff469167780  2 journal read_entry 3=
016118272 : seq 1524679 2173 bytes
   -88> 2013-05-14 08:13:43.211899 7ff469167780  2 journal read_entry 3=
016298496 : seq 1524680 179216 bytes
   -87> 2013-05-14 08:13:43.211919 7ff469167780  2 journal read_entry 3=
016302592 : seq 1524681 128 bytes
   -86> 2013-05-14 08:13:43.211926 7ff469167780  2 journal read_entry 3=
016306688 : seq 1524682 56 bytes
   -85> 2013-05-14 08:13:43.211934 7ff469167780  2 journal read_entry 3=
016310784 : seq 1524683 524 bytes
   -84> 2013-05-14 08:13:43.211943 7ff469167780  2 journal read_entry 3=
016314880 : seq 1524684 798 bytes
   -83> 2013-05-14 08:13:43.212475 7ff469167780  2 journal read_entry 3=
016511488 : seq 1524685 192452 bytes
   -82> 2013-05-14 08:13:43.212494 7ff469167780  2 journal read_entry 3=
016515584 : seq 1524686 39 bytes
   -81> 2013-05-14 08:13:43.212504 7ff469167780  2 journal read_entry 3=
016519680 : seq 1524687 2079 bytes
   -80> 2013-05-14 08:13:43.212810 7ff469167780  2 journal No further v=
alid entries found, journal is most likely valid
   -79> 2013-05-14 08:13:43.212829 7ff469167780  2 journal No further v=
alid entries found, journal is most likely valid
   -78> 2013-05-14 08:13:43.212831 7ff469167780  3 journal journal_repl=
ay: end of journal, done.
   -77> 2013-05-14 08:13:43.216180 7ff469167780  1 journal _open /dev/s=
di3 fd 26: 26843545600 bytes, block size 4096 bytes, directio =3D 1, ai=
o =3D 1
   -76> 2013-05-14 08:13:43.216647 7ff469167780  2 osd.25 0 boot
   -75> 2013-05-14 08:13:43.253760 7ff469167780  0 osd.25 58876 crush m=
ap has features 262144, adjusting msgr requires for clients
   -74> 2013-05-14 08:13:43.253776 7ff469167780  0 osd.25 58876 crush m=
ap has features 262144, adjusting msgr requires for osds
   -73> 2013-05-14 08:13:48.569764 7ff469167780  2 osd.25 58876 superbl=
ock: i am osd.25
   -72> 2013-05-14 08:13:48.569815 7ff469167780  1 accepter.accepter.st=
art
   -71> 2013-05-14 08:13:48.569854 7ff469167780  1 accepter.accepter.st=
art
   -70> 2013-05-14 08:13:48.569965 7ff469167780  1 accepter.accepter.st=
art
   -69> 2013-05-14 08:13:48.569985 7ff469167780 10 monclient(hunting): =
init
   -68> 2013-05-14 08:13:48.569992 7ff469167780  5 adding auth protocol=
: cephx
   -67> 2013-05-14 08:13:48.569993 7ff469167780 10 monclient(hunting): =
auth_supported 2 method cephx
   -66> 2013-05-14 08:13:48.570143 7ff469167780  2 auth: KeyRing::load:=
 loaded key file /etc/ceph/ceph.osd.25.keyring
   -65> 2013-05-14 08:13:48.570489 7ff469167780  5 asok(0x1fbe000) regi=
ster_command dump_ops_in_flight hook 0xb074b40
   -64> 2013-05-14 08:13:48.570497 7ff469167780  5 asok(0x1fbe000) regi=
ster_command dump_historic_ops hook 0xb074b40
   -63> 2013-05-14 08:13:48.570500 7ff469167780  5 asok(0x1fbe000) regi=
ster_command dump_op_pq_state hook 0xb074b40
   -62> 2013-05-14 08:13:48.570505 7ff469167780  5 asok(0x1fbe000) regi=
ster_command setomapval hook 0xac9fd40
   -61> 2013-05-14 08:13:48.570507 7ff469167780  5 asok(0x1fbe000) regi=
ster_command rmomapkey hook 0xac9fd40
   -60> 2013-05-14 08:13:48.570509 7ff469167780  5 asok(0x1fbe000) regi=
ster_command setomapheader hook 0xac9fd40
   -59> 2013-05-14 08:13:48.570512 7ff469167780  5 asok(0x1fbe000) regi=
ster_command getomap hook 0xac9fd40
   -58> 2013-05-14 08:13:48.570514 7ff469167780  5 asok(0x1fbe000) regi=
ster_command truncobj hook 0xac9fd40
   -57> 2013-05-14 08:13:48.570516 7ff469167780  5 asok(0x1fbe000) regi=
ster_command injectdataerr hook 0xac9fd40
   -56> 2013-05-14 08:13:48.570517 7ff469167780  5 asok(0x1fbe000) regi=
ster_command injectmdataerr hook 0xac9fd40
   -55> 2013-05-14 08:13:48.570573 7ff44b86c700  5 osd.25 58876 heartbe=
at: osd_stat(653 GB used, 272 GB avail, 926 GB total, peers []/[])
   -54> 2013-05-14 08:13:48.571104 7ff469167780 10 monclient(hunting): =
_reopen_session
   -53> 2013-05-14 08:13:48.571177 7ff469167780 10 monclient(hunting): =
_pick_new_mon picked mon.e con 0x2024c60 addr 10.0.0.3:6789/0
   -52> 2013-05-14 08:13:48.571201 7ff469167780 10 monclient(hunting): =
_send_mon_message to mon.e at 10.0.0.3:6789/0
   -51> 2013-05-14 08:13:48.571212 7ff469167780  1 -- 10.0.0.3:6806/314=
24 --> 10.0.0.3:6789/0 -- auth(proto 0 27 bytes epoch 0) v1 -- ?+0 0x1f=
bdd80 con 0x2024c60
   -50> 2013-05-14 08:13:48.571231 7ff469167780 10 monclient(hunting): =
renew_subs
   -49> 2013-05-14 08:13:48.571933 7ff457083700 10 monclient(hunting): =
renew_subs
   -48> 2013-05-14 08:13:51.570308 7ff45387c700 10 monclient(hunting): =
tick
   -47> 2013-05-14 08:13:51.570363 7ff45387c700  1 monclient(hunting): =
continuing hunt
   -46> 2013-05-14 08:13:51.570366 7ff45387c700 10 monclient(hunting): =
_reopen_session
   -45> 2013-05-14 08:13:51.570372 7ff45387c700  1 -- 10.0.0.3:6806/314=
24 mark_down 0x2024c60 -- 0xb2c7280
   -44> 2013-05-14 08:13:51.570554 7ff449f68700  2 -- 10.0.0.3:6806/314=
24 >> 10.0.0.3:6789/0 pipe(0xb2c7280 sd=3D27 :8988 s=3D4 pgs=3D137817 c=
s=3D1 l=3D1).reader couldn't read tag, Success
   -43> 2013-05-14 08:13:51.570610 7ff449f68700  2 -- 10.0.0.3:6806/314=
24 >> 10.0.0.3:6789/0 pipe(0xb2c7280 sd=3D27 :8988 s=3D4 pgs=3D137817 c=
s=3D1 l=3D1).fault 0: Success
   -42> 2013-05-14 08:13:51.570623 7ff45387c700 10 monclient(hunting): =
_pick_new_mon picked mon.b con 0x2024dc0 addr 10.0.0.2:6789/0
   -41> 2013-05-14 08:13:51.570644 7ff45387c700 10 monclient(hunting): =
_send_mon_message to mon.b at 10.0.0.2:6789/0
   -40> 2013-05-14 08:13:51.570648 7ff45387c700  1 -- 10.0.0.3:6806/314=
24 --> 10.0.0.2:6789/0 -- auth(proto 0 27 bytes epoch 0) v1 -- ?+0 0xb2=
c3b40 con 0x2024dc0
   -39> 2013-05-14 08:13:51.570657 7ff45387c700 10 monclient(hunting): =
renew_subs
   -38> 2013-05-14 08:13:51.571471 7ff457083700 10 monclient(hunting): =
renew_subs
   -37> 2013-05-14 08:13:51.657613 7ff457083700  1 -- 10.0.0.3:6806/314=
24 <=3D=3D mon.1 10.0.0.2:6789/0 1 =3D=3D=3D=3D mon_map v1 =3D=3D=3D=3D=
 755+0+0 (1964479241 0 0) 0xb2cb000 con 0x2024dc0
   -36> 2013-05-14 08:13:51.657694 7ff457083700 10 monclient(hunting): =
handle_monmap mon_map v1
   -35> 2013-05-14 08:13:51.657726 7ff457083700 10 monclient(hunting): =
 got monmap 7, mon.b is now rank 1
   -34> 2013-05-14 08:13:51.657732 7ff457083700 10 monclient(hunting): =
dump:
epoch 7
fsid de035250-323d-4cf6-8c4b-cf0faf6296b1
last_changed 2013-03-27 19:40:05.413825
created 2012-12-10 11:44:55.644633
0: 10.0.0.1:6789/0 mon.a
1: 10.0.0.2:6789/0 mon.b
2: 10.0.0.3:6789/0 mon.e
3: 10.0.0.5:6789/0 mon.c
4: 10.0.0.6:6789/0 mon.d

   -33> 2013-05-14 08:13:51.657777 7ff457083700  1 monclient(hunting): =
found mon.b
   -32> 2013-05-14 08:13:51.657836 7ff457083700  1 -- 10.0.0.3:6806/314=
24 <=3D=3D mon.1 10.0.0.2:6789/0 2 =3D=3D=3D=3D auth_reply(proto 2 0 Su=
ccess) v1 =3D=3D=3D=3D 33+0+0 (2634832749 0 0) 0xb2cb400 con 0x2024dc0
   -31> 2013-05-14 08:13:51.657903 7ff457083700 10 monclient: my global=
_id is 12258331
   -30> 2013-05-14 08:13:51.658092 7ff457083700 10 monclient: _send_mon=
_message to mon.b at 10.0.0.2:6789/0
   -29> 2013-05-14 08:13:51.658105 7ff457083700  1 -- 10.0.0.3:6806/314=
24 --> 10.0.0.2:6789/0 -- auth(proto 2 32 bytes epoch 0) v1 -- ?+0 0x1f=
bdd80 con 0x2024dc0
   -28> 2013-05-14 08:13:51.658953 7ff457083700  1 -- 10.0.0.3:6806/314=
24 <=3D=3D mon.1 10.0.0.2:6789/0 3 =3D=3D=3D=3D auth_reply(proto 2 0 Su=
ccess) v1 =3D=3D=3D=3D 206+0+0 (2176813729 0 0) 0xb2cb200 con 0x2024dc0
   -27> 2013-05-14 08:13:51.659076 7ff457083700 10 monclient: _send_mon=
_message to mon.b at 10.0.0.2:6789/0
   -26> 2013-05-14 08:13:51.659085 7ff457083700  1 -- 10.0.0.3:6806/314=
24 --> 10.0.0.2:6789/0 -- auth(proto 2 165 bytes epoch 0) v1 -- ?+0 0xb=
2c46c0 con 0x2024dc0
   -25> 2013-05-14 08:13:51.659797 7ff457083700  1 -- 10.0.0.3:6806/314=
24 <=3D=3D mon.1 10.0.0.2:6789/0 4 =3D=3D=3D=3D auth_reply(proto 2 0 Su=
ccess) v1 =3D=3D=3D=3D 393+0+0 (1806667289 0 0) 0xb2cb600 con 0x2024dc0
   -24> 2013-05-14 08:13:51.659864 7ff457083700 10 monclient: _send_mon=
_message to mon.b at 10.0.0.2:6789/0
   -23> 2013-05-14 08:13:51.659870 7ff457083700  1 -- 10.0.0.3:6806/314=
24 --> 10.0.0.2:6789/0 -- mon_subscribe({monmap=3D0+,osd_pg_creates=3D0=
}) v2 -- ?+0 0x1febe00 con 0x2024dc0
   -22> 2013-05-14 08:13:51.659890 7ff457083700 10 monclient: _send_mon=
_message to mon.b at 10.0.0.2:6789/0
   -21> 2013-05-14 08:13:51.659893 7ff457083700  1 -- 10.0.0.3:6806/314=
24 --> 10.0.0.2:6789/0 -- mon_subscribe({monmap=3D0+,osd_pg_creates=3D0=
}) v2 -- ?+0 0xb2c81c0 con 0x2024dc0
   -20> 2013-05-14 08:13:51.659909 7ff457083700 10 monclient: _check_au=
th_rotating renewing rotating keys (they expired before 2013-05-14 08:1=
3:21.659907)
   -19> 2013-05-14 08:13:51.659917 7ff457083700 10 monclient: _send_mon=
_message to mon.b at 10.0.0.2:6789/0
   -18> 2013-05-14 08:13:51.659919 7ff457083700  1 -- 10.0.0.3:6806/314=
24 --> 10.0.0.2:6789/0 -- auth(proto 2 2 bytes epoch 0) v1 -- ?+0 0xb2c=
3d80 con 0x2024dc0
   -17> 2013-05-14 08:13:51.660022 7ff469167780  5 monclient: authentic=
ate success, global_id 12258331
   -16> 2013-05-14 08:13:51.660040 7ff469167780 10 monclient: wait_auth=
_rotating waiting (until 2013-05-14 08:14:21.660038)
   -15> 2013-05-14 08:13:51.660209 7ff457083700  1 -- 10.0.0.3:6806/314=
24 <=3D=3D mon.1 10.0.0.2:6789/0 5 =3D=3D=3D=3D mon_map v1 =3D=3D=3D=3D=
 755+0+0 (1964479241 0 0) 0xb2cb400 con 0x2024dc0
   -14> 2013-05-14 08:13:51.660228 7ff457083700 10 monclient: handle_mo=
nmap mon_map v1
   -13> 2013-05-14 08:13:51.660242 7ff457083700 10 monclient:  got monm=
ap 7, mon.b is now rank 1
   -12> 2013-05-14 08:13:51.660246 7ff457083700 10 monclient: dump:
epoch 7
fsid de035250-323d-4cf6-8c4b-cf0faf6296b1
last_changed 2013-03-27 19:40:05.413825
created 2012-12-10 11:44:55.644633
0: 10.0.0.1:6789/0 mon.a
1: 10.0.0.2:6789/0 mon.b
2: 10.0.0.3:6789/0 mon.e
3: 10.0.0.5:6789/0 mon.c
4: 10.0.0.6:6789/0 mon.d

   -11> 2013-05-14 08:13:51.660298 7ff457083700  1 -- 10.0.0.3:6806/314=
24 <=3D=3D mon.1 10.0.0.2:6789/0 6 =3D=3D=3D=3D mon_subscribe_ack(300s)=
 v1 =3D=3D=3D=3D 20+0+0 (2197888173 0 0) 0xb2c81c0 con 0x2024dc0
   -10> 2013-05-14 08:13:51.660309 7ff457083700 10 monclient: handle_su=
bscribe_ack sent 2013-05-14 08:13:48.571239 renew after 2013-05-14 08:1=
6:18.571239
    -9> 2013-05-14 08:13:51.660338 7ff457083700  1 -- 10.0.0.3:6806/314=
24 <=3D=3D mon.1 10.0.0.2:6789/0 7 =3D=3D=3D=3D mon_map v1 =3D=3D=3D=3D=
 755+0+0 (1964479241 0 0) 0xb2cb000 con 0x2024dc0
    -8> 2013-05-14 08:13:51.660342 7ff457083700 10 monclient: handle_mo=
nmap mon_map v1
    -7> 2013-05-14 08:13:51.660349 7ff457083700 10 monclient:  got monm=
ap 7, mon.b is now rank 1
    -6> 2013-05-14 08:13:51.660353 7ff457083700 10 monclient: dump:
epoch 7
fsid de035250-323d-4cf6-8c4b-cf0faf6296b1
last_changed 2013-03-27 19:40:05.413825
created 2012-12-10 11:44:55.644633
0: 10.0.0.1:6789/0 mon.a
1: 10.0.0.2:6789/0 mon.b
2: 10.0.0.3:6789/0 mon.e
3: 10.0.0.5:6789/0 mon.c
4: 10.0.0.6:6789/0 mon.d

    -5> 2013-05-14 08:13:51.660370 7ff457083700  1 -- 10.0.0.3:6806/314=
24 <=3D=3D mon.1 10.0.0.2:6789/0 8 =3D=3D=3D=3D mon_subscribe_ack(300s)=
 v1 =3D=3D=3D=3D 20+0+0 (2197888173 0 0) 0x1febe00 con 0x2024dc0
    -4> 2013-05-14 08:13:51.660376 7ff457083700 10 monclient: handle_su=
bscribe_ack sent 0.000000, ignoring
    -3> 2013-05-14 08:13:51.660405 7ff457083700  1 -- 10.0.0.3:6806/314=
24 <=3D=3D mon.1 10.0.0.2:6789/0 9 =3D=3D=3D=3D auth_reply(proto 2 0 Su=
ccess) v1 =3D=3D=3D=3D 194+0+0 (2034468970 0 0) 0xb2cb800 con 0x2024dc0
    -2> 2013-05-14 08:13:51.660460 7ff457083700 10 monclient: _check_au=
th_rotating have uptodate secrets (they expire after 2013-05-14 08:13:2=
1.660459)
    -1> 2013-05-14 08:13:51.660583 7ff469167780 10 monclient: wait_auth=
_rotating done
     0> 2013-05-14 08:13:51.675152 7ff450075700 -1 osd/OSD.cc: In funct=
ion 'OSDMapRef OSDService::get_map(epoch_t)' thread 7ff450075700 time 2=
013-05-14 08:13:51.661081
osd/OSD.cc: 4838: FAILED assert(_get_map_bl(epoch, bl))

 ceph version 0.61-11-g3b94f03 (3b94f03ec58abe3d7a6d0359ff9b4d75826f377=
7)
 1: (OSDService::get_map(unsigned int)+0x918) [0x608268]
 2: (OSD::advance_pg(unsigned int, PG*, ThreadPool::TPHandle&, PG::Reco=
veryCtx*, std::set<boost::intrusive_ptr<PG>, std::less<boost::intrusive=
_ptr<PG> >, std::allocator<boost::intrusive_ptr<PG> > >*)+0x195) [0x60b=
725]
 3: (OSD::process_peering_events(std::list<PG*, std::allocator<PG*> > c=
onst&, ThreadPool::TPHandle&)+0x24b) [0x630c1b]
 4: (OSD::PeeringWQ::_process(std::list<PG*, std::allocator<PG*> > cons=
t&, ThreadPool::TPHandle&)+0x16) [0x6650b6]
 5: (ThreadPool::worker(ThreadPool::WorkThread*)+0x561) [0x813a11]
 6: (ThreadPool::WorkThread::entry()+0x10) [0x816530]
 7: (()+0x68ca) [0x7ff4686028ca]
 8: (clone()+0x6d) [0x7ff466ee0b6d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is need=
ed to interpret this.

--- logging levels ---
   0/ 5 none
   0/ 1 lockdep
   0/ 1 context
   1/ 1 crush
   1/ 5 mds
   1/ 5 mds_balancer
   1/ 5 mds_locker
   1/ 5 mds_log
   1/ 5 mds_log_expire
   1/ 5 mds_migrator
   0/ 1 buffer
   0/ 1 timer
   0/ 1 filer
   0/ 1 striper
   0/ 1 objecter
   0/ 5 rados
   0/ 5 rbd
   0/ 5 journaler
   0/ 5 objectcacher
   0/ 5 client
   0/ 5 osd
   0/ 5 optracker
   0/ 5 objclass
   1/ 3 filestore
   1/ 3 journal
   0/ 5 ms
   1/ 5 mon
   0/10 monc
   0/ 5 paxos
   0/ 5 tp
   1/ 5 auth
   1/ 5 crypto
   1/ 1 finisher
   1/ 5 heartbeatmap
   1/ 5 perfcounter
   1/ 5 rgw
   1/ 5 hadoop
   1/ 5 javaclient
   1/ 5 asok
   1/ 1 throttle
  -1/-1 (syslog threshold)
  -1/-1 (stderr threshold)
  max_recent     10000
  max_new         1000
  log_file /var/log/ceph/osd.25.log
--- end dump of recent events ---
2013-05-14 08:13:51.685837 7ff450075700 -1 *** Caught signal (Aborted) =
**
 in thread 7ff450075700

 ceph version 0.61-11-g3b94f03 (3b94f03ec58abe3d7a6d0359ff9b4d75826f377=
7)
 1: /usr/bin/ceph-osd() [0x7a14f9]
 2: (()+0xeff0) [0x7ff46860aff0]
 3: (gsignal()+0x35) [0x7ff466e431b5]
 4: (abort()+0x180) [0x7ff466e45fc0]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7ff4676d7dc5]
 6: (()+0xcb166) [0x7ff4676d6166]
 7: (()+0xcb193) [0x7ff4676d6193]
 8: (()+0xcb28e) [0x7ff4676d628e]
 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const=
*)+0x7c9) [0x902c89]
 10: (OSDService::get_map(unsigned int)+0x918) [0x608268]
 11: (OSD::advance_pg(unsigned int, PG*, ThreadPool::TPHandle&, PG::Rec=
overyCtx*, std::set<boost::intrusive_ptr<PG>, std::less<boost::intrusiv=
e_ptr<PG> >, std::allocator<boost::intrusive_ptr<PG> > >*)+0x195) [0x60=
b725]
 12: (OSD::process_peering_events(std::list<PG*, std::allocator<PG*> > =
const&, ThreadPool::TPHandle&)+0x24b) [0x630c1b]
 13: (OSD::PeeringWQ::_process(std::list<PG*, std::allocator<PG*> > con=
st&, ThreadPool::TPHandle&)+0x16) [0x6650b6]
 14: (ThreadPool::worker(ThreadPool::WorkThread*)+0x561) [0x813a11]
 15: (ThreadPool::WorkThread::entry()+0x10) [0x816530]
 16: (()+0x68ca) [0x7ff4686028ca]
 17: (clone()+0x6d) [0x7ff466ee0b6d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is need=
ed to interpret this.

--- begin dump of recent events ---
     0> 2013-05-14 08:13:51.685837 7ff450075700 -1 *** Caught signal (A=
borted) **
 in thread 7ff450075700

 ceph version 0.61-11-g3b94f03 (3b94f03ec58abe3d7a6d0359ff9b4d75826f377=
7)
 1: /usr/bin/ceph-osd() [0x7a14f9]
 2: (()+0xeff0) [0x7ff46860aff0]
 3: (gsignal()+0x35) [0x7ff466e431b5]
 4: (abort()+0x180) [0x7ff466e45fc0]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7ff4676d7dc5]
 6: (()+0xcb166) [0x7ff4676d6166]
 7: (()+0xcb193) [0x7ff4676d6193]
 8: (()+0xcb28e) [0x7ff4676d628e]
 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const=
*)+0x7c9) [0x902c89]
 10: (OSDService::get_map(unsigned int)+0x918) [0x608268]
 11: (OSD::advance_pg(unsigned int, PG*, ThreadPool::TPHandle&, PG::Rec=
overyCtx*, std::set<boost::intrusive_ptr<PG>, std::less<boost::intrusiv=
e_ptr<PG> >, std::allocator<boost::intrusive_ptr<PG> > >*)+0x195) [0x60=
b725]
 12: (OSD::process_peering_events(std::list<PG*, std::allocator<PG*> > =
const&, ThreadPool::TPHandle&)+0x24b) [0x630c1b]
 13: (OSD::PeeringWQ::_process(std::list<PG*, std::allocator<PG*> > con=
st&, ThreadPool::TPHandle&)+0x16) [0x6650b6]
 14: (ThreadPool::worker(ThreadPool::WorkThread*)+0x561) [0x813a11]
 15: (ThreadPool::WorkThread::entry()+0x10) [0x816530]
 16: (()+0x68ca) [0x7ff4686028ca]
 17: (clone()+0x6d) [0x7ff466ee0b6d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is need=
ed to interpret this.

--- logging levels ---
   0/ 5 none
   0/ 1 lockdep
   0/ 1 context
   1/ 1 crush
   1/ 5 mds
   1/ 5 mds_balancer
   1/ 5 mds_locker
   1/ 5 mds_log
   1/ 5 mds_log_expire
   1/ 5 mds_migrator
   0/ 1 buffer
   0/ 1 timer
   0/ 1 filer
   0/ 1 striper
   0/ 1 objecter
   0/ 5 rados
   0/ 5 rbd
   0/ 5 journaler
   0/ 5 objectcacher
   0/ 5 client
   0/ 5 osd
   0/ 5 optracker
   0/ 5 objclass
   1/ 3 filestore
   1/ 3 journal
   0/ 5 ms
   1/ 5 mon
   0/10 monc
   0/ 5 paxos
   0/ 5 tp
   1/ 5 auth
   1/ 5 crypto
   1/ 1 finisher
   1/ 5 heartbeatmap
   1/ 5 perfcounter
   1/ 5 rgw
   1/ 5 hadoop
   1/ 5 javaclient
   1/ 5 asok
   1/ 1 throttle
  -1/-1 (syslog threshold)
  -1/-1 (stderr threshold)
  max_recent     10000
  max_new         1000
  log_file /var/log/ceph/osd.25.log
--- end dump of recent events ---












Le vendredi 17 mai 2013 =C3=A0 11:36 -0700, John Wilkins a =C3=A9crit :
> Another thing... since your osd.10 is near full, your cluster may be
> fairly close to capacity for the purposes of rebalancing.  Have a loo=
k
> at:
>=20
> http://ceph.com/docs/master/rados/configuration/mon-config-ref/#stora=
ge-capacity
> http://ceph.com/docs/master/rados/troubleshooting/troubleshooting-osd=
/#no-free-drive-space
>=20
> Maybe we can get some others to look at this.  It's not clear to me
> why the other OSD crashes after you take osd.25 out. It could be
> capacity, but that shouldn't make it crash. Have you tried adding mor=
e
> OSDs to increase capacity?
>=20
>=20
>=20
> On Fri, May 17, 2013 at 11:27 AM, John Wilkins <john.wilkins@inktank.=
com> wrote:
> > It looks like you have the "noout" flag set:
> >
> > "noout flag(s) set; 1 mons down, quorum 0,1,2,3 a,b,c,e
> >    monmap e7: 5 mons at
> > {a=3D10.0.0.1:6789/0,b=3D10.0.0.2:6789/0,c=3D10.0.0.5:6789/0,d=3D10=
=2E0.0.6:6789/0,e=3D10.0.0.3:6789/0},
> > election epoch 2584, quorum 0,1,2,3 a,b,c,e
> >    osdmap e82502: 50 osds: 48 up, 48 in"
> >
> > http://ceph.com/docs/master/rados/troubleshooting/troubleshooting-o=
sd/#stopping-w-out-rebalancing
> >
> > If you have down OSDs that don't get marked out, that would certain=
ly
> > cause problems. Have you tried restarting the failed OSDs?
> >
> > What do the logs look like for osd.15 and osd.25?
> >
> > On Fri, May 17, 2013 at 1:31 AM, Olivier Bonvalet <ceph.list@daevel=
=2Efr> wrote:
> >> Hi,
> >>
> >> thanks for your answer. In fact I have several different problems,=
 which
> >> I tried to solve separatly :
> >>
> >> 1) I loose 2 OSD, and some pools have only 2 replicas. So some dat=
a was
> >> lost.
> >> 2) One monitor refuse the Cuttlefish upgrade, so I only have 4 of =
5
> >> monitors running.
> >> 3) I have 4 old inconsistent PG that I can't repair.
> >>
> >>
> >> So the status :
> >>
> >>    health HEALTH_ERR 15 pgs incomplete; 4 pgs inconsistent; 15 pgs=
 stuck
> >> inactive; 15 pgs stuck unclean; 1 near full osd(s); 19 scrub error=
s;
> >> noout flag(s) set; 1 mons down, quorum 0,1,2,3 a,b,c,e
> >>    monmap e7: 5 mons at
> >> {a=3D10.0.0.1:6789/0,b=3D10.0.0.2:6789/0,c=3D10.0.0.5:6789/0,d=3D1=
0.0.0.6:6789/0,e=3D10.0.0.3:6789/0}, election epoch 2584, quorum 0,1,2,=
3 a,b,c,e
> >>    osdmap e82502: 50 osds: 48 up, 48 in
> >>     pgmap v12807617: 7824 pgs: 7803 active+clean, 1 active+clean
> >> +scrubbing, 15 incomplete, 4 active+clean+inconsistent, 1 active+c=
lean
> >> +scrubbing+deep; 5676 GB data, 18948 GB used, 18315 GB / 37263 GB =
avail;
> >> 137KB/s rd, 1852KB/s wr, 199op/s
> >>    mdsmap e1: 0/0/1 up
> >>
> >>
> >>
> >> The tree :
> >>
> >> # id    weight  type name       up/down reweight
> >> -8      14.26   root SSDroot
> >> -27     8               datacenter SSDrbx2
> >> -26     8                       room SSDs25
> >> -25     8                               net SSD188-165-12
> >> -24     8                                       rack SSD25B09
> >> -23     8                                               host lyll
> >> 46      2                                                       os=
d.46  up      1
> >> 47      2                                                       os=
d.47  up      1
> >> 48      2                                                       os=
d.48  up      1
> >> 49      2                                                       os=
d.49  up      1
> >> -10     4.26            datacenter SSDrbx3
> >> -12     2                       room SSDs43
> >> -13     2                               net SSD178-33-122
> >> -16     2                                       rack SSD43S01
> >> -17     2                                               host kaino
> >> 42      1                                                       os=
d.42  up      1
> >> 43      1                                                       os=
d.43  up      1
> >> -22     2.26                    room SSDs45
> >> -21     2.26                            net SSD5-135-138
> >> -20     2.26                                    rack SSD45F01
> >> -19     2.26                                            host taman
> >> 44      1.13                                                    os=
d.44  up      1
> >> 45      1.13                                                    os=
d.45  up      1
> >> -9      2               datacenter SSDrbx4
> >> -11     2                       room SSDs52
> >> -14     2                               net SSD176-31-226
> >> -15     2                                       rack SSD52B09
> >> -18     2                                               host draga=
n
> >> 40      1                                                       os=
d.40  up      1
> >> 41      1                                                       os=
d.41  up      1
> >> -1      33.43   root SASroot
> >> -100    15.9            datacenter SASrbx1
> >> -90     15.9                    room SASs15
> >> -72     15.9                            net SAS188-165-15
> >> -40     8                                       rack SAS15B01
> >> -3      8                                               host bront=
es
> >> 0       1                                                       os=
d.0   up      1
> >> 1       1                                                       os=
d.1   up      1
> >> 2       1                                                       os=
d.2   up      1
> >> 3       1                                                       os=
d.3   up      1
> >> 4       1                                                       os=
d.4   up      1
> >> 5       1                                                       os=
d.5   up      1
> >> 6       1                                                       os=
d.6   up      1
> >> 7       1                                                       os=
d.7   up      1
> >> -41     7.9                                     rack SAS15B02
> >> -6      7.9                                             host alim
> >> 24      1                                                       os=
d.24  up      1
> >> 25      1                                                       os=
d.25  down    0
> >> 26      1                                                       os=
d.26  up      1
> >> 27      1                                                       os=
d.27  up      1
> >> 28      1                                                       os=
d.28  up      1
> >> 29      1                                                       os=
d.29  up      1
> >> 30      1                                                       os=
d.30  up      1
> >> 31      0.9                                                     os=
d.31  up      1
> >> -101    17.53           datacenter SASrbx2
> >> -91     17.53                   room SASs27
> >> -70     1.6                             net SAS188-165-13
> >> -44     0                                       rack SAS27B04
> >> -7      0                                               host bul
> >> -45     1.6                                     rack SAS27B06
> >> -4      1.6                                             host okko
> >> 32      0.2                                                     os=
d.32  up      1
> >> 33      0.2                                                     os=
d.33  up      1
> >> 34      0.2                                                     os=
d.34  up      1
> >> 35      0.2                                                     os=
d.35  up      1
> >> 36      0.2                                                     os=
d.36  up      1
> >> 37      0.2                                                     os=
d.37  up      1
> >> 38      0.2                                                     os=
d.38  up      1
> >> 39      0.2                                                     os=
d.39  up      1
> >> -71     15.93                           net SAS188-165-14
> >> -42     8                                       rack SAS27A03
> >> -5      8                                               host nobur=
o
> >> 8       1                                                       os=
d.8   up      1
> >> 9       1                                                       os=
d.9   up      1
> >> 18      1                                                       os=
d.18  up      1
> >> 19      1                                                       os=
d.19  up      1
> >> 20      1                                                       os=
d.20  up      1
> >> 21      1                                                       os=
d.21  up      1
> >> 22      1                                                       os=
d.22  up      1
> >> 23      1                                                       os=
d.23  up      1
> >> -43     7.93                                    rack SAS27A04
> >> -2      7.93                                            host keron
> >> 10      0.97                                                    os=
d.10  up      1
> >> 11      1                                                       os=
d.11  up      1
> >> 12      1                                                       os=
d.12  up      1
> >> 13      1                                                       os=
d.13  up      1
> >> 14      0.98                                                    os=
d.14  up      1
> >> 15      1                                                       os=
d.15  down    0
> >> 16      0.98                                                    os=
d.16  up      1
> >> 17      1                                                       os=
d.17  up      1
> >>
> >>
> >> Here I have 2 roots : SSDroot and SASroot. All my OSD/PG problems =
are on
> >> the SAS branch, and my CRUSH rules use per "net" replication.
> >>
> >> The osd.15 have a failling disk since long time, its data was corr=
ectly
> >> moved (=3D OSD was out until the cluster obtain HEALTH_OK).
> >> The osd.25 is a buggy OSD that I can't remove or change : if I bal=
ance
> >> it's PG on other OSD, then this others OSD crash. That problem occ=
ur
> >> before I loose the osd.19 : OSD was unable to mark that PG as
> >> inconsistent since it was crashing during scrub. For me, all
> >> inconsistencies come from this OSD.
> >> The osd.19 was a failling disk, that I changed.
> >>
> >>
> >> And the health detail :
> >>
> >> HEALTH_ERR 15 pgs incomplete; 4 pgs inconsistent; 15 pgs stuck ina=
ctive;
> >> 15 pgs stuck unclean; 1 near full osd(s); 19 scrub errors; noout f=
lag(s)
> >> set; 1 mons down, quorum 0,1,2,3 a,b,c,e
> >> pg 4.5c is stuck inactive since forever, current state incomplete,=
 last
> >> acting [19,30]
> >> pg 8.71d is stuck inactive since forever, current state incomplete=
, last
> >> acting [24,19]
> >> pg 8.3fa is stuck inactive since forever, current state incomplete=
, last
> >> acting [19,31]
> >> pg 8.3e0 is stuck inactive since forever, current state incomplete=
, last
> >> acting [31,19]
> >> pg 8.56c is stuck inactive since forever, current state incomplete=
, last
> >> acting [19,28]
> >> pg 8.19f is stuck inactive since forever, current state incomplete=
, last
> >> acting [31,19]
> >> pg 8.792 is stuck inactive since forever, current state incomplete=
, last
> >> acting [19,28]
> >> pg 4.0 is stuck inactive since forever, current state incomplete, =
last
> >> acting [28,19]
> >> pg 8.78a is stuck inactive since forever, current state incomplete=
, last
> >> acting [31,19]
> >> pg 8.23e is stuck inactive since forever, current state incomplete=
, last
> >> acting [32,13]
> >> pg 8.2ff is stuck inactive since forever, current state incomplete=
, last
> >> acting [6,19]
> >> pg 8.5e2 is stuck inactive since forever, current state incomplete=
, last
> >> acting [0,19]
> >> pg 8.528 is stuck inactive since forever, current state incomplete=
, last
> >> acting [31,19]
> >> pg 8.20f is stuck inactive since forever, current state incomplete=
, last
> >> acting [31,19]
> >> pg 8.372 is stuck inactive since forever, current state incomplete=
, last
> >> acting [19,24]
> >> pg 4.5c is stuck unclean since forever, current state incomplete, =
last
> >> acting [19,30]
> >> pg 8.71d is stuck unclean since forever, current state incomplete,=
 last
> >> acting [24,19]
> >> pg 8.3fa is stuck unclean since forever, current state incomplete,=
 last
> >> acting [19,31]
> >> pg 8.3e0 is stuck unclean since forever, current state incomplete,=
 last
> >> acting [31,19]
> >> pg 8.56c is stuck unclean since forever, current state incomplete,=
 last
> >> acting [19,28]
> >> pg 8.19f is stuck unclean since forever, current state incomplete,=
 last
> >> acting [31,19]
> >> pg 8.792 is stuck unclean since forever, current state incomplete,=
 last
> >> acting [19,28]
> >> pg 4.0 is stuck unclean since forever, current state incomplete, l=
ast
> >> acting [28,19]
> >> pg 8.78a is stuck unclean since forever, current state incomplete,=
 last
> >> acting [31,19]
> >> pg 8.23e is stuck unclean since forever, current state incomplete,=
 last
> >> acting [32,13]
> >> pg 8.2ff is stuck unclean since forever, current state incomplete,=
 last
> >> acting [6,19]
> >> pg 8.5e2 is stuck unclean since forever, current state incomplete,=
 last
> >> acting [0,19]
> >> pg 8.528 is stuck unclean since forever, current state incomplete,=
 last
> >> acting [31,19]
> >> pg 8.20f is stuck unclean since forever, current state incomplete,=
 last
> >> acting [31,19]
> >> pg 8.372 is stuck unclean since forever, current state incomplete,=
 last
> >> acting [19,24]
> >> pg 8.792 is incomplete, acting [19,28]
> >> pg 8.78a is incomplete, acting [31,19]
> >> pg 8.71d is incomplete, acting [24,19]
> >> pg 8.5e2 is incomplete, acting [0,19]
> >> pg 8.56c is incomplete, acting [19,28]
> >> pg 8.528 is incomplete, acting [31,19]
> >> pg 8.3fa is incomplete, acting [19,31]
> >> pg 8.3e0 is incomplete, acting [31,19]
> >> pg 8.372 is incomplete, acting [19,24]
> >> pg 8.2ff is incomplete, acting [6,19]
> >> pg 8.23e is incomplete, acting [32,13]
> >> pg 8.20f is incomplete, acting [31,19]
> >> pg 8.19f is incomplete, acting [31,19]
> >> pg 3.7c is active+clean+inconsistent, acting [24,13,39]
> >> pg 3.6b is active+clean+inconsistent, acting [28,23,5]
> >> pg 4.5c is incomplete, acting [19,30]
> >> pg 3.d is active+clean+inconsistent, acting [29,4,11]
> >> pg 4.0 is incomplete, acting [28,19]
> >> pg 3.1 is active+clean+inconsistent, acting [28,19,5]
> >> osd.10 is near full at 85%
> >> 19 scrub errors
> >> noout flag(s) set
> >> mon.d (rank 4) addr 10.0.0.6:6789/0 is down (out of quorum)
> >>
> >>
> >> Pools 4 and 8 have only 2 replica, and pool 3 have 3 replica but
> >> inconsistent data.
> >>
> >> Thanks in advance.
> >>
> >> Le vendredi 17 mai 2013 =C3=A0 00:14 -0700, John Wilkins a =C3=A9c=
rit :
> >>> If you can follow the documentation here:
> >>> http://ceph.com/docs/master/rados/operations/monitoring-osd-pg/  =
and
> >>> http://ceph.com/docs/master/rados/troubleshooting/  to provide so=
me
> >>> additional information, we may be better able to help you.
> >>>
> >>> For example, "ceph osd tree" would help us understand the status =
of
> >>> your cluster a bit better.
> >>>
> >>> On Thu, May 16, 2013 at 10:32 PM, Olivier Bonvalet <ceph.list@dae=
vel.fr> wrote:
> >>> > Le mercredi 15 mai 2013 =C3=A0 00:15 +0200, Olivier Bonvalet a =
=C3=A9crit :
> >>> >> Hi,
> >>> >>
> >>> >> I have some PG in state down and/or incomplete on my cluster, =
because I
> >>> >> loose 2 OSD and a pool was having only 2 replicas. So of cours=
e that
> >>> >> data is lost.
> >>> >>
> >>> >> My problem now is that I can't retreive a "HEALTH_OK" status :=
 if I try
> >>> >> to remove, read or overwrite the corresponding RBD images, nea=
r all OSD
> >>> >> hang (well... they don't do anything and requests stay in a gr=
owing
> >>> >> queue, until the production will be done).
> >>> >>
> >>> >> So, what can I do to remove that corrupts images ?
> >>> >>
> >>> >> _______________________________________________
> >>> >> ceph-users mailing list
> >>> >> ceph-users@lists.ceph.com
> >>> >> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >>> >>
> >>> >
> >>> > Up. Nobody can help me on that problem ?
> >>> >
> >>> > Thanks,
> >>> >
> >>> > Olivier
> >>> >
> >>> > _______________________________________________
> >>> > ceph-users mailing list
> >>> > ceph-users@lists.ceph.com
> >>> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >>>
> >>>
> >>>
> >>> --
> >>> John Wilkins
> >>> Senior Technical Writer
> >>> Intank
> >>> john.wilkins@inktank.com
> >>> (415) 425-9599
> >>> http://inktank.com
> >>>
> >>
> >>
> >
> >
> >
> > --
> > John Wilkins
> > Senior Technical Writer
> > Intank
> > john.wilkins@inktank.com
> > (415) 425-9599
> > http://inktank.com
>=20
>=20
>=20
> --=20
> John Wilkins
> Senior Technical Writer
> Intank
> john.wilkins@inktank.com
> (415) 425-9599
> http://inktank.com
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
