From: Olivier Bonvalet <ceph.list@daevel.fr>
Subject: Re: [ceph-users] Scrub shutdown the OSD process
Date: Wed, 17 Apr 2013 11:48:44 +0200
Message-ID: <1366192124.14655.20.camel@localhost>
References: <1366018923.3018.3.camel@localhost>
	 <CAPYLRziFNxnUhyxHRUCzZBF6oQwrWt8YdxBtDrKzMMNuyuW=YQ@mail.gmail.com>
	 <1366046351.26980.0.camel@localhost>
	 <CAPYLRzjz3FVvm5OH-TBN3R8tmv8LREFYKTEX41Zk7DTLjoPXkA@mail.gmail.com>
	 <1366095376.3018.28.camel@localhost>
Reply-To: ceph-devel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from licorne.daevel.fr ([178.32.94.222]:59859 "EHLO
	licorne.daevel.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965780Ab3DQJss convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Apr 2013 05:48:48 -0400
In-Reply-To: <1366095376.3018.28.camel@localhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

Le mardi 16 avril 2013 =C3=A0 08:56 +0200, Olivier Bonvalet a =C3=A9cri=
t :
>=20
>=20
> Le lundi 15 avril 2013 =C3=A0 10:57 -0700, Gregory Farnum a =C3=A9cri=
t :
> > On Mon, Apr 15, 2013 at 10:19 AM, Olivier Bonvalet <ceph.list@daeve=
l.fr> wrote:
> > > Le lundi 15 avril 2013 =C3=A0 10:16 -0700, Gregory Farnum a =C3=A9=
crit :
> > >> Are you saying you saw this problem more than once, and so you
> > >> completely wiped the OSD in question, then brought it back into =
the
> > >> cluster, and now it's seeing this error again?
> > >
> > > Yes, it's exactly that.
> > >
> > >
> > >> Are any other OSDs experiencing this issue?
> > >
> > > No, only this one have the problem.
> >=20
> > Did you run scrubs while this node was out of the cluster? If you
> > wiped the data and this is recurring then this is apparently an iss=
ue
> > with the cluster state, not just one node, and any other primary fo=
r
> > the broken PG(s) should crash as well. Can you verify by taking thi=
s
> > one down and then doing a full scrub?
> > -Greg
> > Software Engineer #42 @ http://inktank.com | http://ceph.com
> > _______________________________________________
> > ceph-users mailing list
> > ceph-users@lists.ceph.com
> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >=20
>=20
> So, I mark this OSD as "out" to balance data and be able to re-do a
> scrum. You are probably right, since I now have 3 other OSD on the sa=
me
> host which are down.
>=20
> I still haven't any PG in error (and the cluster is in HEALTH_WARN
> status), but something goes wrong.
>=20
> In syslog I have :
>=20
> Apr 16 02:07:08 alim ceph-osd: 2013-04-16 02:07:06.742915 7fe65113170=
0 -1 filestore(/var/lib/ceph/osd/ceph-31) could not find d452999/rb.0.2=
d76b.238e1f29.00000000162d/f99//4 in index: (2) No such file or directo=
ry
> Apr 16 02:07:08 alim ceph-osd: 2013-04-16 02:07:06.742999 7fe65113170=
0 -1 filestore(/var/lib/ceph/osd/ceph-31) could not find 85242299/rb.0.=
1367.2ae8944a.000000001f9c/f98//4 in index: (2) No such file or directo=
ry
> Apr 16 03:41:11 alim ceph-osd: 2013-04-16 03:41:11.758150 7fe64f12d70=
0 -1 osd.31 48020 heartbeat_check: no reply from osd.5 since 2013-04-16=
 03:40:50.349130 (cutoff 2013-04-16 03:40:51.758149)
> Apr 16 04:27:40 alim ceph-osd: 2013-04-16 04:27:40.529492 7fe65e14b70=
0 -1 osd.31 48416 heartbeat_check: no reply from osd.26 since 2013-04-1=
6 04:27:20.203868 (cutoff 2013-04-16 04:27:20.529489)
> Apr 16 04:27:41 alim ceph-osd: 2013-04-16 04:27:41.529609 7fe65e14b70=
0 -1 osd.31 48416 heartbeat_check: no reply from osd.26 since 2013-04-1=
6 04:27:20.203868 (cutoff 2013-04-16 04:27:21.529605)
> Apr 16 05:01:43 alim ceph-osd: 2013-04-16 05:01:43.440257 7fe64f12d70=
0 -1 osd.31 48602 heartbeat_check: no reply from osd.4 since 2013-04-16=
 05:01:22.529918 (cutoff 2013-04-16 05:01:23.440257)
> Apr 16 05:01:43 alim ceph-osd: 2013-04-16 05:01:43.523985 7fe65e14b70=
0 -1 osd.31 48602 heartbeat_check: no reply from osd.4 since 2013-04-16=
 05:01:22.529918 (cutoff 2013-04-16 05:01:23.523984)
> Apr 16 05:55:28 alim ceph-osd: 2013-04-16 05:55:27.770327 7fe65e14b70=
0 -1 osd.31 48847 heartbeat_check: no reply from osd.26 since 2013-04-1=
6 05:55:07.392502 (cutoff 2013-04-16 05:55:07.770323)
> Apr 16 05:55:28 alim ceph-osd: 2013-04-16 05:55:28.497600 7fe64f12d70=
0 -1 osd.31 48847 heartbeat_check: no reply from osd.26 since 2013-04-1=
6 05:55:07.392502 (cutoff 2013-04-16 05:55:08.497598)
> Apr 16 06:04:13 alim ceph-osd: 2013-04-16 06:04:13.051839 7fe65012f70=
0 -1 osd/ReplicatedPG.cc: In function 'virtual void ReplicatedPG::_scru=
b(ScrubMap&)' thread 7fe65012f700 time 2013-04-16 06:04:12.843977#012os=
d/ReplicatedPG.cc: 7188: FAILED assert(head !=3D hobject_t())#012#012 c=
eph version 0.56.4-4-gd89ab0e (d89ab0ea6fa8d0961cad82f6a81eccbd3bbd3f55=
)#012 1: (ReplicatedPG::_scrub(ScrubMap&)+0x1a78) [0x57a038]#012 2: (PG=
::scrub_compare_maps()+0xeb8) [0x696c18]#012 3: (PG::chunky_scrub()+0x2=
d9) [0x6c37f9]#012 4: (PG::scrub()+0x145) [0x6c4e55]#012 5: (OSD::Scrub=
WQ::_process(PG*)+0xc) [0x64048c]#012 6: (ThreadPool::worker(ThreadPool=
::WorkThread*)+0x879) [0x815179]#012 7: (ThreadPool::WorkThread::entry(=
)+0x10) [0x817980]#012 8: (()+0x68ca) [0x7fe6626558ca]#012 9: (clone()+=
0x6d) [0x7fe661184b6d]#012 NOTE: a copy of the executable, or `objdump =
-rdS <executable>` is needed to interpret this.
> Apr 16 06:04:13 alim ceph-osd:      0> 2013-04-16 06:04:13.051839 7fe=
65012f700 -1 osd/ReplicatedPG.cc: In function 'virtual void ReplicatedP=
G::_scrub(ScrubMap&)' thread 7fe65012f700 time 2013-04-16 06:04:12.8439=
77#012osd/ReplicatedPG.cc: 7188: FAILED assert(head !=3D hobject_t())#0=
12#012 ceph version 0.56.4-4-gd89ab0e (d89ab0ea6fa8d0961cad82f6a81eccbd=
3bbd3f55)#012 1: (ReplicatedPG::_scrub(ScrubMap&)+0x1a78) [0x57a038]#01=
2 2: (PG::scrub_compare_maps()+0xeb8) [0x696c18]#012 3: (PG::chunky_scr=
ub()+0x2d9) [0x6c37f9]#012 4: (PG::scrub()+0x145) [0x6c4e55]#012 5: (OS=
D::ScrubWQ::_process(PG*)+0xc) [0x64048c]#012 6: (ThreadPool::worker(Th=
readPool::WorkThread*)+0x879) [0x815179]#012 7: (ThreadPool::WorkThread=
::entry()+0x10) [0x817980]#012 8: (()+0x68ca) [0x7fe6626558ca]#012 9: (=
clone()+0x6d) [0x7fe661184b6d]#012 NOTE: a copy of the executable, or `=
objdump -rdS <executable>` is needed to interpret this.
> Apr 16 06:04:13 alim ceph-osd: 2013-04-16 06:04:13.277072 7fe65012f70=
0 -1 *** Caught signal (Aborted) **#012 in thread 7fe65012f700#012#012 =
ceph version 0.56.4-4-gd89ab0e (d89ab0ea6fa8d0961cad82f6a81eccbd3bbd3f5=
5)#012 1: /usr/bin/ceph-osd() [0x7a6289]#012 2: (()+0xeff0) [0x7fe66265=
dff0]#012 3: (gsignal()+0x35) [0x7fe6610e71b5]#012 4: (abort()+0x180) [=
0x7fe6610e9fc0]#012 5: (__gnu_cxx::__verbose_terminate_handler()+0x115)=
 [0x7fe66197bdc5]#012 6: (()+0xcb166) [0x7fe66197a166]#012 7: (()+0xcb1=
93) [0x7fe66197a193]#012 8: (()+0xcb28e) [0x7fe66197a28e]#012 9: (ceph:=
:__ceph_assert_fail(char const*, char const*, int, char const*)+0x7c9) =
[0x8f9549]#012 10: (ReplicatedPG::_scrub(ScrubMap&)+0x1a78) [0x57a038]#=
012 11: (PG::scrub_compare_maps()+0xeb8) [0x696c18]#012 12: (PG::chunky=
_scrub()+0x2d9) [0x6c37f9]#012 13: (PG::scrub()+0x145) [0x6c4e55]#012 1=
4: (OSD::ScrubWQ::_process(PG*)+0xc) [0x64048c]#012 15: (ThreadPool::wo=
rker(ThreadPool::WorkThread*)+0x879) [0x815179]#012 16: (ThreadPool::Wo=
rkThread::entry()+0x10) [0x817980]#012 17: (()+0x68ca) [0x7fe6626558ca]=
#012 18: (clone()+0x6d) [0x7fe661184b6d]#012 NOTE: a copy of the execut=
able, or `objdump -rdS <executable>` is needed to interpret this.
> Apr 16 06:04:13 alim ceph-osd:      0> 2013-04-16 06:04:13.277072 7fe=
65012f700 -1 *** Caught signal (Aborted) **#012 in thread 7fe65012f700#=
012#012 ceph version 0.56.4-4-gd89ab0e (d89ab0ea6fa8d0961cad82f6a81eccb=
d3bbd3f55)#012 1: /usr/bin/ceph-osd() [0x7a6289]#012 2: (()+0xeff0) [0x=
7fe66265dff0]#012 3: (gsignal()+0x35) [0x7fe6610e71b5]#012 4: (abort()+=
0x180) [0x7fe6610e9fc0]#012 5: (__gnu_cxx::__verbose_terminate_handler(=
)+0x115) [0x7fe66197bdc5]#012 6: (()+0xcb166) [0x7fe66197a166]#012 7: (=
()+0xcb193) [0x7fe66197a193]#012 8: (()+0xcb28e) [0x7fe66197a28e]#012 9=
: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)=
+0x7c9) [0x8f9549]#012 10: (ReplicatedPG::_scrub(ScrubMap&)+0x1a78) [0x=
57a038]#012 11: (PG::scrub_compare_maps()+0xeb8) [0x696c18]#012 12: (PG=
::chunky_scrub()+0x2d9) [0x6c37f9]#012 13: (PG::scrub()+0x145) [0x6c4e5=
5]#012 14: (OSD::ScrubWQ::_process(PG*)+0xc) [0x64048c]#012 15: (Thread=
Pool::worker(ThreadPool::WorkThread*)+0x879) [0x815179]#012 16: (Thread=
Pool::WorkThread::entry()+0x10) [0x817980]#012 17: (()+0x68ca) [0x7fe66=
26558ca]#012 18: (clone()+0x6d) [0x7fe661184b6d]#012 NOTE: a copy of th=
e executable, or `objdump -rdS <executable>` is needed to interpret thi=
s.
>=20
>=20
> and last lines from osd.24.log are :
>=20
>    -10> 2013-04-16 08:08:54.991371 7f5bb4569700  2 osd.24 pg_epoch: 4=
9397 pg[3.7c( v 49397'11387809 (49355'11386808,49397'11387809] local-le=
s=3D49382 n=3D18795 ec=3D56 les/c 49382/49397 49375/49375/49375) [24,13=
,6] r=3D0 lpr=3D49375 mlcod 49397'11387808 active+clean+scrubbing+deep =
snaptrimq=3D[1f86~5,1f8c~8,2bd8~e]] scrub   osd.6 has 10 items
>     -9> 2013-04-16 08:08:54.991876 7f5bb4569700  2 osd.24 pg_epoch: 4=
9397 pg[3.7c( v 49397'11387809 (49355'11386808,49397'11387809] local-le=
s=3D49382 n=3D18795 ec=3D56 les/c 49382/49397 49375/49375/49375) [24,13=
,6] r=3D0 lpr=3D49375 mlcod 49397'11387808 active+clean+scrubbing+deep =
snaptrimq=3D[1f86~5,1f8c~8,2bd8~e]] 3.7c osd.24 inconsistent snapcolls =
on 7b52237c/rb.0.15c26.238e1f29.000000000a76/12d7//3 found  expected 12=
d7
> 3.7c osd.13 inconsistent snapcolls on 7b52237c/rb.0.15c26.238e1f29.00=
0000000a76/12d7//3 found  expected 12d7
> 3.7c osd.13: soid 7b52237c/rb.0.15c26.238e1f29.000000000a76/12d7//3 s=
ize 4194304 !=3D known size 0, digest 1360833101 !=3D known digest 0
> 3.7c osd.6 inconsistent snapcolls on 7b52237c/rb.0.15c26.238e1f29.000=
000000a76/12d7//3 found  expected 12d7
> 3.7c osd.6: soid 7b52237c/rb.0.15c26.238e1f29.000000000a76/12d7//3 si=
ze 4194304 !=3D known size 0, digest 1360833101 !=3D known digest 0
>=20
>     -8> 2013-04-16 08:08:54.991906 7f5bb4569700  0 log [ERR] : 3.7c o=
sd.24 inconsistent snapcolls on 7b52237c/rb.0.15c26.238e1f29.000000000a=
76/12d7//3 found  expected 12d7
>     -7> 2013-04-16 08:08:54.991913 7f5bb4569700  0 log [ERR] : 3.7c o=
sd.13 inconsistent snapcolls on 7b52237c/rb.0.15c26.238e1f29.000000000a=
76/12d7//3 found  expected 12d7
>     -6> 2013-04-16 08:08:54.991915 7f5bb4569700  0 log [ERR] : 3.7c o=
sd.13: soid 7b52237c/rb.0.15c26.238e1f29.000000000a76/12d7//3 size 4194=
304 !=3D known size 0, digest 1360833101 !=3D known digest 0
>     -5> 2013-04-16 08:08:54.991917 7f5bb4569700  0 log [ERR] : 3.7c o=
sd.6 inconsistent snapcolls on 7b52237c/rb.0.15c26.238e1f29.000000000a7=
6/12d7//3 found  expected 12d7
>     -4> 2013-04-16 08:08:54.991919 7f5bb4569700  0 log [ERR] : 3.7c o=
sd.6: soid 7b52237c/rb.0.15c26.238e1f29.000000000a76/12d7//3 size 41943=
04 !=3D known size 0, digest 1360833101 !=3D known digest 0
>     -3> 2013-04-16 08:08:54.991986 7f5bb4569700  0 log [ERR] : deep-s=
crub 3.7c 7b52237c/rb.0.15c26.238e1f29.000000000a76/12d7//3 on disk siz=
e (0) does not match object info size (4194304)
>     -2> 2013-04-16 08:08:54.993813 7f5bbbd78700  5 --OSD::tracker-- r=
eqid: client.1811920.1:164200641, seq: 4575, time: 2013-04-16 08:08:54.=
993812, event: op_applied, request: osd_op(client.1811920.1:164200641 r=
b.0.2d766.238e1f29.000000002c80 [write 442368~4096] 3.31aa16ec snapc 2b=
c6=3D[2bc6,2b84,2b33,2ada,2a0e,2940,285f,2775,2633,25e8,24d1,2452,2363,=
22c6,21a9,20db,1f98])
>     -1> 2013-04-16 08:08:54.993901 7f5bbbd78700  5 --OSD::tracker-- r=
eqid: client.1811920.1:164200641, seq: 4575, time: 2013-04-16 08:08:54.=
993901, event: done, request: osd_op(client.1811920.1:164200641 rb.0.2d=
766.238e1f29.000000002c80 [write 442368~4096] 3.31aa16ec snapc 2bc6=3D[=
2bc6,2b84,2b33,2ada,2a0e,2940,285f,2775,2633,25e8,24d1,2452,2363,22c6,2=
1a9,20db,1f98])
>      0> 2013-04-16 08:08:54.994227 7f5bb4569700 -1 osd/ReplicatedPG.c=
c: In function 'virtual void ReplicatedPG::_scrub(ScrubMap&)' thread 7f=
5bb4569700 time 2013-04-16 08:08:54.991990
> osd/ReplicatedPG.cc: 7188: FAILED assert(head !=3D hobject_t())
>=20
>  ceph version 0.56.4-4-gd89ab0e (d89ab0ea6fa8d0961cad82f6a81eccbd3bbd=
3f55)
>  1: (ReplicatedPG::_scrub(ScrubMap&)+0x1a78) [0x57a038]
>  2: (PG::scrub_compare_maps()+0xeb8) [0x696c18]
>  3: (PG::chunky_scrub()+0x2d9) [0x6c37f9]
>  4: (PG::scrub()+0x145) [0x6c4e55]
>  5: (OSD::ScrubWQ::_process(PG*)+0xc) [0x64048c]
>  6: (ThreadPool::worker(ThreadPool::WorkThread*)+0x879) [0x815179]
>  7: (ThreadPool::WorkThread::entry()+0x10) [0x817980]
>  8: (()+0x68ca) [0x7f5bc72908ca]
>  9: (clone()+0x6d) [0x7f5bc5dbfb6d]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is ne=
eded to interpret this.
>=20
> --- logging levels ---
>    0/ 5 none
>    0/ 1 lockdep
>    0/ 1 context
>    1/ 1 crush
>    1/ 5 mds
>    1/ 5 mds_balancer
>    1/ 5 mds_locker
>    1/ 5 mds_log
>    1/ 5 mds_log_expire
>    1/ 5 mds_migrator
>    0/ 1 buffer
>    0/ 1 timer
>    0/ 1 filer
>    0/ 1 striper
>    0/ 1 objecter
>    0/ 5 rados
>    0/ 5 rbd
>    0/ 5 journaler
>    0/ 5 objectcacher
>    0/ 5 client
>    0/ 5 osd
>    0/ 5 optracker
>    0/ 5 objclass
>    1/ 3 filestore
>    1/ 3 journal
>    0/ 5 ms
>    1/ 5 mon
>    0/10 monc
>    0/ 5 paxos
>    0/ 5 tp
>    1/ 5 auth
>    1/ 5 crypto
>    1/ 1 finisher
>    1/ 5 heartbeatmap
>    1/ 5 perfcounter
>    1/ 5 rgw
>    1/ 5 hadoop
>    1/ 5 javaclient
>    1/ 5 asok
>    1/ 1 throttle
>   -1/-1 (syslog threshold)
>   -1/-1 (stderr threshold)
>   max_recent     10000
>   max_new         1000
>   log_file /var/log/ceph/osd.24.log
> --- end dump of recent events ---
> 2013-04-16 08:08:55.163535 7f5bb4569700 -1 *** Caught signal (Aborted=
) **
>  in thread 7f5bb4569700
>=20
>  ceph version 0.56.4-4-gd89ab0e (d89ab0ea6fa8d0961cad82f6a81eccbd3bbd=
3f55)
>  1: /usr/bin/ceph-osd() [0x7a6289]
>  2: (()+0xeff0) [0x7f5bc7298ff0]
>  3: (gsignal()+0x35) [0x7f5bc5d221b5]
>  4: (abort()+0x180) [0x7f5bc5d24fc0]
>  5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7f5bc65b6dc5]
>  6: (()+0xcb166) [0x7f5bc65b5166]
>  7: (()+0xcb193) [0x7f5bc65b5193]
>  8: (()+0xcb28e) [0x7f5bc65b528e]
>  9: (ceph::__ceph_assert_fail(char const*, char const*, int, char con=
st*)+0x7c9) [0x8f9549]
>  10: (ReplicatedPG::_scrub(ScrubMap&)+0x1a78) [0x57a038]
>  11: (PG::scrub_compare_maps()+0xeb8) [0x696c18]
>  12: (PG::chunky_scrub()+0x2d9) [0x6c37f9]
>  13: (PG::scrub()+0x145) [0x6c4e55]
>  14: (OSD::ScrubWQ::_process(PG*)+0xc) [0x64048c]
>  15: (ThreadPool::worker(ThreadPool::WorkThread*)+0x879) [0x815179]
>  16: (ThreadPool::WorkThread::entry()+0x10) [0x817980]
>  17: (()+0x68ca) [0x7f5bc72908ca]
>  18: (clone()+0x6d) [0x7f5bc5dbfb6d]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is ne=
eded to interpret this.
>=20
> --- begin dump of recent events ---
>      0> 2013-04-16 08:08:55.163535 7f5bb4569700 -1 *** Caught signal =
(Aborted) **
>  in thread 7f5bb4569700
>=20
>  ceph version 0.56.4-4-gd89ab0e (d89ab0ea6fa8d0961cad82f6a81eccbd3bbd=
3f55)
>  1: /usr/bin/ceph-osd() [0x7a6289]
>  2: (()+0xeff0) [0x7f5bc7298ff0]
>  3: (gsignal()+0x35) [0x7f5bc5d221b5]
>  4: (abort()+0x180) [0x7f5bc5d24fc0]
>  5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7f5bc65b6dc5]
>  6: (()+0xcb166) [0x7f5bc65b5166]
>  7: (()+0xcb193) [0x7f5bc65b5193]
>  8: (()+0xcb28e) [0x7f5bc65b528e]
>  9: (ceph::__ceph_assert_fail(char const*, char const*, int, char con=
st*)+0x7c9) [0x8f9549]
>  10: (ReplicatedPG::_scrub(ScrubMap&)+0x1a78) [0x57a038]
>  11: (PG::scrub_compare_maps()+0xeb8) [0x696c18]
>  12: (PG::chunky_scrub()+0x2d9) [0x6c37f9]
>  13: (PG::scrub()+0x145) [0x6c4e55]
>  14: (OSD::ScrubWQ::_process(PG*)+0xc) [0x64048c]
>  15: (ThreadPool::worker(ThreadPool::WorkThread*)+0x879) [0x815179]
>  16: (ThreadPool::WorkThread::entry()+0x10) [0x817980]
>  17: (()+0x68ca) [0x7f5bc72908ca]
>  18: (clone()+0x6d) [0x7f5bc5dbfb6d]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is ne=
eded to interpret this.
>=20
> --- logging levels ---
>    0/ 5 none
>    0/ 1 lockdep
>    0/ 1 context
>    1/ 1 crush
>    1/ 5 mds
>    1/ 5 mds_balancer
>    1/ 5 mds_locker
>    1/ 5 mds_log
>    1/ 5 mds_log_expire
>    1/ 5 mds_migrator
>    0/ 1 buffer
>    0/ 1 timer
>    0/ 1 filer
>    0/ 1 striper
>    0/ 1 objecter
>    0/ 5 rados
>    0/ 5 rbd
>    0/ 5 journaler
>    0/ 5 objectcacher
>    0/ 5 client
>    0/ 5 osd
>    0/ 5 optracker
>    0/ 5 objclass
>    1/ 3 filestore
>    1/ 3 journal
>    0/ 5 ms
>    1/ 5 mon
>    0/10 monc
>    0/ 5 paxos
>    0/ 5 tp
>    1/ 5 auth
>    1/ 5 crypto
>    1/ 1 finisher
>    1/ 5 heartbeatmap
>    1/ 5 perfcounter
>    1/ 5 rgw
>    1/ 5 hadoop
>    1/ 5 javaclient
>    1/ 5 asok
>    1/ 1 throttle
>   -1/-1 (syslog threshold)
>   -1/-1 (stderr threshold)
>   max_recent     10000
>   max_new         1000
>   log_file /var/log/ceph/osd.24.log
> --- end dump of recent events ---
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com


So, what can I do to fix that ?


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
