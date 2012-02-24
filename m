From: "=?UTF-8?B?0JTQtdC90LjRgdC60LAt0YDQtdC00LjRgdC60LA=?="
	<slim@inbox.lv>
Subject: Re: ceph does not work
Date: Fri, 24 Feb 2012 13:33:43 +0200
Message-ID: <1330083223.4f4775972d367@mail.inbox.lv>
References: <CAF3hT9ALuVKcdQgsO-oJTP=KX9gnxGdSLLVjsvv69js=j+KXuA@mail.gmail.com>
 <CAORUGqCLqz9ty8KshwN1QDjt9etq+N=fsFFy5MGkFbRngOrovA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from shark1.inbox.lv ([89.111.3.81]:47411 "EHLO shark1.inbox.lv"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751604Ab2BXLdq convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Feb 2012 06:33:46 -0500
In-Reply-To: <CAORUGqCLqz9ty8KshwN1QDjt9etq+N=fsFFy5MGkFbRngOrovA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>, ceph-devel@vger.kernel.org
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>

running cluster of 3 nodes:

lv-test-2 ~ # ceph -s           =20
2012-02-24 13:10:35.481248    pg v726: 594 pgs: 594 active+clean; 120 M=
B data, 683 MB used, 35448 MB / 37967 MB avail
2012-02-24 13:10:35.484463   mds e177: 3/3/3 up {0=3Dshark1=3Dup:active=
,1=3Dlv-test-1=3Dup:active,2=3Dlv-test-2=3Dup:active}
2012-02-24 13:10:35.484529   osd e64: 3 osds: 3 up, 3 in
2012-02-24 13:10:35.484630   log 2012-02-24 13:09:50.009333 osd.1 10.0.=
1.246:6801/3929 29 : [INF] 2.5d scrub ok
2012-02-24 13:10:35.484907   mon e1: 3 mons at {lv-test-1=3D10.0.1.246:=
6789/0,lv-test-2=3D10.0.1.247:6789/0,shark1=3D10.0.1.81:6789/0}

mounting by fuse:
lv-test1 ~ # mount
ceph-fuse on /uploads type fuse.ceph-fuse (rw,nosuid,nodev,allow_other,=
default_permissions)

simulating write:
lv-test-1 ~ # cp -r /usr/src/linux-3.2.2-hardened-r1/ /uploads/

killing one node:
lv-test-2 ~ # killall ceph-mon ceph-mds  ceph-osd
=46eb 24 13:11:17 lv-test-2 mon.lv-test-2[3474]: *** Caught signal (Ter=
minated) **
=46eb 24 13:11:17 lv-test-2 in thread 3195ce76760. Shutting down.
=46eb 24 13:11:17 lv-test-2 mds.lv-test-2[3553]: *** Caught signal (Ter=
minated) **
=46eb 24 13:11:17 lv-test-2 in thread 2ee100bb760. Shutting down.
=46eb 24 13:11:17 lv-test-2 osd.2[3654]: *** Caught signal (Terminated)=
 **
=46eb 24 13:11:17 lv-test-2 in thread 28f75487760. Shutting down.
=46eb 24 13:11:35 lv-test-2 client.admin[3885]: 3a6a385b700 monclient: =
hunting for new mon
=46eb 24 13:11:35 lv-test-2 client.admin[3885]: 3a6a385b700 client.5017=
 ms_handle_reset on 10.0.1.246:6789/0

=46eb 24 13:11:17 lv-test-1 mon.lv-test-1[3751]: 2d62330a700 -- 10.0.1.=
246:6789/0 >> 10.0.1.247:6789/0 pipe(0x522b9ba080 sd=3D9 pgs=3D37 cs=3D=
1 l=3D0
).fault with nothing to send, going to standby
=46eb 24 13:11:17 lv-test-1 mds.lv-test-1[3830]: 2e3b9bd0700 -- 10.0.1.=
246:6800/3829 >> 10.0.1.247:6800/3552 pipe(0x5faea44c0 sd=3D13 pgs=3D13=
 cs
=3D1 l=3D0).fault with nothing to send, going to standby
=46eb 24 13:11:17 lv-test-1 client.admin[3151]: 2a9fbe55700 -- 10.0.1.2=
46:0/3151 >> 10.0.1.247:6800/3552 pipe(0x2a9ec00f560 sd=3D0 pgs=3D9 cs=3D=
3 l
=3D0).fault with nothing to send, going to standby
=46eb 24 13:11:17 lv-test-1 osd.1[3930]: 2a51b9f1700 osd.1 64 OSD::ms_h=
andle_reset()
=46eb 24 13:11:17 lv-test-1 osd.1[3930]: 2a51b9f1700 osd.1 64 OSD::ms_h=
andle_reset() s=3D0x22b4580700
=46eb 24 13:11:17 lv-test-1 client.admin[3151]: 2a9fd95b700 client.4617=
 ms_handle_reset on 10.0.1.247:6801/3653
=46eb 24 13:11:17 lv-test-1 osd.1[3930]: 2a510df7700 -- 10.0.1.246:6803=
/3929 >> 10.0.1.247:0/3654 pipe(0x2a50c005000 sd=3D24 pgs=3D4 cs=3D1 l=3D=
0).fa
ult with nothing to send, going to standby
=46eb 24 13:11:18 lv-test-1 osd.1[3930]: 2a5184e6700 -- 10.0.1.246:6802=
/3929 >> 10.0.1.247:6802/3653 pipe(0x2a5145e9c50 sd=3D19 pgs=3D3 cs=3D1=
 l=3D0)
=2Efault with nothing to send, going to standby
=46eb 24 13:11:18 lv-test-1 mds.lv-test-1[3830]: 2e3bcadc700 mds.1.5 ms=
_handle_reset on 10.0.1.247:6801/3653
=46eb 24 13:11:18 lv-test-1 osd.1[3930]: 2a5183e5700 -- 10.0.1.246:0/39=
30 >> 10.0.1.247:6803/3653 pipe(0x2a5145eaeb0 sd=3D20 pgs=3D16 cs=3D1 l=
=3D0).f
ault with nothing to send, going to standby
=46eb 24 13:11:34 lv-test-1 osd.1[3930]: 2a5229ff700 osd.1 64 heartbeat=
_check: no heartbeat from osd.0 since 2012-02-24 13:11:14.122485 (cutof=
f 2012-02-24 13:11:14.366355)
=46eb 24 13:11:34 lv-test-1 osd.1[3930]: 2a5117fa700 osd.1 64 heartbeat=
_check: no heartbeat from osd.0 since 2012-02-24 13:11:14.122485 (cutof=
f 2012-02-24 13:11:14.826382)
=46eb 24 13:11:35 lv-test-1 osd.1[3930]: 2a5229ff700 osd.1 64 heartbeat=
_check: no heartbeat from osd.0 since 2012-02-24 13:11:14.122485 (cutof=
f 2012-02-24 13:11:15.369660)
=46eb 24 13:11:35 lv-test-1 osd.1[3930]: 2a51b9f1700 monclient: hunting=
 for new mon
=46eb 24 13:11:35 lv-test-1 osd.1[3930]: 2a51b9f1700 osd.1 64 OSD::ms_h=
andle_reset()
=46eb 24 13:11:36 lv-test-1 osd.1[3930]: 2a5117fa700 osd.1 64 heartbeat=
_check: no heartbeat from osd.0 since 2012-02-24 13:11:14.122485 (cutof=
f 2012-02-24 13:11:16.129635)
=46eb 24 13:11:36 lv-test-1 osd.1[3930]: 2a5229ff700 osd.1 64 heartbeat=
_check: no heartbeat from osd.0 since 2012-02-24 13:11:14.122485 (cutof=
f 2012-02-24 13:11:16.372900)

copy hangs (cannot be killed by kill -9), /uploads is not accessible

lv-test-1 ~ # time ceph -s

^C*** Caught signal (Interrupt) **
 in thread 2da010af760. Shutting down.


real    3m16.481s
user    0m0.037s
sys     0m0.013s

lv-test-2 ~ # time ceph -s=20


^C*** Caught signal (Interrupt) **
 in thread 314b193c760. Shutting down.


real    0m35.401s
user    0m0.017s
sys     0m0.007s

so cluster hanged and not responding anymore

lets bring up back killed node:

lv-test-2 ~ # /etc/init.d/ceph restart
lv-test-2 ~ # ceph -s
2012-02-24 13:20:01.996366    pg v734: 594 pgs: 594 active+clean; 120 M=
B data, 683 MB used, 35448 MB / 37967 MB avail
2012-02-24 13:20:01.999207   mds e177: 3/3/3 up {0=3Dshark1=3Dup:active=
,1=3Dlv-test-1=3Dup:active,2=3Dlv-test-2=3Dup:active}
2012-02-24 13:20:01.999268   osd e64: 3 osds: 3 up, 3 in
2012-02-24 13:20:01.999368   log 2012-02-24 13:11:02.267947 osd.1 10.0.=
1.246:6801/3929 41 : [INF] 2.89 scrub ok
2012-02-24 13:20:01.999612   mon e1: 3 mons at {lv-test-1=3D10.0.1.246:=
6789/0,lv-test-2=3D10.0.1.247:6789/0,shark1=3D10.0.1.81:6789/0}

lv-test-2 ~ # ceph -s
2012-02-24 13:20:44.984214    pg v742: 594 pgs: 594 active+clean; 144 M=
B data, 714 MB used, 35417 MB / 37967 MB avail
2012-02-24 13:20:44.986505   mds e182: 3/3/3 up {0=3Dlv-test-2=3Dup:res=
olve,1=3Dlv-test-1=3Dup:active,2=3Dlv-test-2=3Dup:active(laggy or crash=
ed)}
2012-02-24 13:20:44.986697   osd e68: 3 osds: 1 up, 3 in
2012-02-24 13:20:44.986918   log 2012-02-24 13:20:42.606730 mon.1 10.0.=
1.246:6789/0 27 : [INF] mds.1 10.0.1.246:6800/3829 up:active
2012-02-24 13:20:44.987118   mon e1: 3 mons at {lv-test-1=3D10.0.1.246:=
6789/0,lv-test-2=3D10.0.1.247:6789/0,shark1=3D10.0.1.81:6789/0}

=46eb 24 13:23:28 lv-test-2 mds.lv-test-2[4608]: 2a93085f700 -- 10.0.1.=
247:6800/4607 >> 10.0.1.247:6800/3552 pipe(0x19d6f37b40 sd=3D12 pgs=3D0=
 cs=3D0 l=3D0).connect claims to be 10.0.1.247:6800/4607 not 10.0.1.247=
:6800/3552 - wrong node!

=46eb 24 13:24:13 lv-test-1 client.admin[3151]: 2a9fc158700 -- 10.0.1.2=
46:0/3151 >> 10.0.1.247:6800/3552 pipe(0x2a9ec00f560 sd=3D0 pgs=3D9 cs=3D=
4 l=3D0).connect claims to be 10.0.1.247:6800/4607 not 10.0.1.247:6800/=
3552 - wrong node!
=46eb 24 13:24:14 lv-test-1 mds.lv-test-1[3830]: 2e3b981b700 -- 10.0.1.=
246:6800/3829 >> 10.0.1.247:6800/3552 pipe(0x5faea44c0 sd=3D8 pgs=3D13 =
cs=3D2 l=3D0).connect claims to be 10.0.1.247:6800/4607 not 10.0.1.247:=
6800/3552 - wrong node!


lv-test-1 ~ # ceph -s
2012-02-24 13:24:36.558927    pg v762: 594 pgs: 594 active+clean; 144 M=
B data, 741 MB used, 35390 MB / 37967 MB avail
2012-02-24 13:24:36.560927   mds e195: 3/3/3 up {0=3Dlv-test-2=3Dup:res=
olve,1=3Dlv-test-1=3Dup:active,2=3Dlv-test-2=3Dup:active(laggy or crash=
ed)}
2012-02-24 13:24:36.560988   osd e70: 3 osds: 2 up, 3 in
2012-02-24 13:24:36.561092   log 2012-02-24 13:24:29.691540 osd.2 10.0.=
1.247:6801/4706 17 : [INF] 0.77 scrub ok
2012-02-24 13:24:36.561201   mon e1: 3 mons at {lv-test-1=3D10.0.1.246:=
6789/0,lv-test-2=3D10.0.1.247:6789/0,shark1=3D10.0.1.81:6789/0}


mount point still inaccessible. Thats all, that sucks


is there proven scenario to build cluster of 3 nodes with replication t=
hat tolerates shutdown of two nodes without lockups of read/write proce=
ss ?



=D0=A6=D0=B8=D1=82=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D0=BD=D0=B8=D0=B5 "Tom=
mi Virtanen" <tommi.virtanen@dreamhost.com>:
> On Thu, Feb 23, 2012 at 11:07, Gregory Farnum
> <gregory.farnum@dreamhost.com> wrote:
>>>> 3 nodes, each running mon, mds & osd with replication level 3 for =
data & met
>>>>adata pools.
> ...
>> Actually the OSDs will happily (well, not happily; the will complain=
=2E
>> But they will run) run in degraded mode. However, if you have 3 acti=
ve
>> MDSes and you kill one of them without a standby available, you will
>> lose access to part of your tree. That's probably what happened
>> here...
>=20
> So let's try that angle. Slim, can you share the output of "ceph -s" =
with us
>?

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
