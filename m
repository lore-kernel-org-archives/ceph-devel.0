From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: Restart of clustered mds file system fails?
Date: Tue, 23 Nov 2010 14:42:20 -0800
Message-ID: <AANLkTin_q0KeV2iwZzPk785wpXWnVxEmLfpjPSNU3LZD@mail.gmail.com>
References: <1290549046.15814.54.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:59576 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752586Ab0KWWmW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Nov 2010 17:42:22 -0500
Received: by ewy5 with SMTP id 5so2789595ewy.19
        for <ceph-devel@vger.kernel.org>; Tue, 23 Nov 2010 14:42:20 -0800 (PST)
In-Reply-To: <1290549046.15814.54.camel@sale659.sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Jim:
I've managed to reproduce this (or a similar problem) locally,
although I am getting core files. If you aren't I suspect your ulimit
has been reset or isn't high enough.

This is an error I introduced when making some changes to how we do
trimming. I forgot to account for how the root inode is different, so
all MDS instances that weren't the auth on the root inode should have
crashed during the resolve phase. (I'm not sure why you were only
having 5/7 crash before, it might be that two MDSes were sharing auth
or that one of the MDSes wasn't moving through the phases as quickly
as the others.)
I've pushed a fix to the testing branch in commit
d8652de61647ae19ad0f3ec90fad00930cdd5afd; it should cherry-pick to any
recent-ish unstable just fine. :)
-Greg

On Tue, Nov 23, 2010 at 1:50 PM, Jim Schutt <jaschut@sandia.gov> wrote:
>
> Hi,
>
> I've been working with a file system with 7 mon instances,
> and 7 mds instances, on current unstable (fc212548aea1).
>
> I start it up, let it stabilize (all the osds get to
> the same epoch), shut it down, then restart it.
>
> Not very long after the restart, 6 of the 7 mds instances
> disappear, with no core files and no stack trace in the logs.
>
> The last few lines of output from ceph -w look like this:
>
> 2010-11-23 14:37:20.504569 =A0 =A0pg v88: 3432 pgs: 3432 active; 138 =
KB data, 177 MB used, 3032 GB / 3032 GB avail; 12/234 degraded (5.128%)
> 2010-11-23 14:37:20.739372 =A0 =A0pg v89: 3432 pgs: 3432 active; 138 =
KB data, 167 MB used, 3032 GB / 3032 GB avail; 12/234 degraded (5.128%)
> 2010-11-23 14:37:21.033669 =A0 =A0pg v90: 3432 pgs: 3432 active; 138 =
KB data, 154 MB used, 3032 GB / 3032 GB avail; 12/234 degraded (5.128%)
> 2010-11-23 14:37:21.353834 =A0 =A0pg v91: 3432 pgs: 3432 active; 138 =
KB data, 139 MB used, 3032 GB / 3032 GB avail; 12/234 degraded (5.128%)
> 2010-11-23 14:37:21.478496 =A0 mds e33: 7/7/7 up {0=3Dup:replay,1=3Du=
p:replay,2=3Dup:resolve,3=3Dup:replay,4=3Dup:resolve,5=3Dup:resolve,6=3D=
up:replay}
> 2010-11-23 14:37:21.709432 =A0 log 2010-11-23 14:37:21.403836 mon0 17=
2.17.40.34:6789/0 25 : [INF] mds2 172.17.40.34:6800/7571 up:resolve
> 2010-11-23 14:37:21.827792 =A0 =A0pg v92: 3432 pgs: 3432 active; 138 =
KB data, 134 MB used, 3032 GB / 3032 GB avail; 10/234 degraded (4.274%)
> 2010-11-23 14:37:22.197558 =A0 =A0pg v93: 3432 pgs: 3432 active; 139 =
KB data, 128 MB used, 3032 GB / 3032 GB avail; 10/234 degraded (4.274%)
> 2010-11-23 14:37:22.484411 =A0 =A0pg v94: 3432 pgs: 3432 active; 139 =
KB data, 116 MB used, 3032 GB / 3032 GB avail; 10/234 degraded (4.274%)
> 2010-11-23 14:37:22.766665 =A0 =A0pg v95: 3432 pgs: 3432 active; 139 =
KB data, 102316 KB used, 3032 GB / 3032 GB avail; 10/234 degraded (4.27=
4%)
> 2010-11-23 14:37:25.261067 =A0 mds e34: 7/7/7 up {0=3Dup:resolve,1=3D=
up:replay,2=3Dup:resolve,3=3Dup:replay,4=3Dup:resolve,5=3Dup:resolve,6=3D=
up:replay}
> 2010-11-23 14:37:25.398455 =A0 log 2010-11-23 14:37:25.236187 mon0 17=
2.17.40.34:6789/0 26 : [INF] mds0 172.17.40.40:6800/7567 up:resolve
> 2010-11-23 14:37:25.592960 =A0 mds e35: 7/7/7 up {0=3Dup:resolve,1=3D=
up:replay,2=3Dup:resolve,3=3Dup:replay,4=3Dup:resolve,5=3Dup:resolve,6=3D=
up:resolve}
> 2010-11-23 14:37:25.774941 =A0 log 2010-11-23 14:37:25.603505 mon0 17=
2.17.40.34:6789/0 27 : [INF] mds6 172.17.40.35:6800/7935 up:resolve
> 2010-11-23 14:37:29.273125 =A0 mds e36: 7/7/7 up {0=3Dup:resolve,1=3D=
up:replay,2=3Dup:resolve,3=3Dup:resolve,4=3Dup:resolve,5=3Dup:resolve,6=
=3Dup:resolve}
> 2010-11-23 14:37:29.410528 =A0 log 2010-11-23 14:37:29.247681 mon0 17=
2.17.40.34:6789/0 28 : [INF] mds3 172.17.40.37:6800/996 up:resolve
> 2010-11-23 14:37:29.612511 =A0 mds e37: 7/7/7 up {0=3Dup:resolve,1=3D=
up:resolve,2=3Dup:resolve,3=3Dup:resolve,4=3Dup:resolve,5=3Dup:resolve,=
6=3Dup:resolve}
> 2010-11-23 14:37:29.799629 =A0 mds e38: 7/7/7 up {0=3Dup:reconnect,1=3D=
up:resolve,2=3Dup:resolve,3=3Dup:resolve,4=3Dup:resolve,5=3Dup:resolve,=
6=3Dup:resolve}
> 2010-11-23 14:37:29.824094 =A0 log 2010-11-23 14:37:29.618299 mon0 17=
2.17.40.34:6789/0 29 : [INF] mds1 172.17.40.39:6800/8550 up:resolve
> 2010-11-23 14:37:30.119613 =A0 log 2010-11-23 14:37:29.760648 mon0 17=
2.17.40.34:6789/0 30 : [INF] mds0 172.17.40.40:6800/7567 up:reconnect
> 2010-11-23 14:37:30.216568 =A0 mds e39: 7/7/7 up {0=3Dup:rejoin,1=3Du=
p:resolve,2=3Dup:resolve,3=3Dup:resolve,4=3Dup:resolve,5=3Dup:resolve,6=
=3Dup:resolve}
> 2010-11-23 14:37:30.434163 =A0 log 2010-11-23 14:37:30.208227 mon0 17=
2.17.40.34:6789/0 31 : [INF] mds0 172.17.40.40:6800/7567 up:rejoin
> 2010-11-23 14:37:46.274801 =A0 mds e40: 7/7/7 up {0=3Dup:rejoin,1=3Du=
p:resolve,2=3Dup:resolve(laggy or crashed),3=3Dup:resolve(laggy or cras=
hed),4=3Dup:resolve(laggy or crashed),5=3Dup:resolve,6=3Dup:resolve}
> 2010-11-23 14:37:51.303591 =A0 mds e41: 7/7/7 up {0=3Dup:rejoin,1=3Du=
p:resolve(laggy or crashed),2=3Dup:resolve(laggy or crashed),3=3Dup:res=
olve(laggy or crashed),4=3Dup:resolve(laggy or crashed),5=3Dup:resolve(=
laggy or crashed),6=3Dup:resolve(laggy or crashed)}
>
> The last few lines of the disappearing mds instance logs
> look like this; in particular 5 of the 6 that disappeared
> were all doing the "handle resolve from mds1"
>
> 2010-11-23 14:37:29.621030 41b7c940 -- 172.17.40.36:6800/7413 <=3D=3D=
 mds1 172.17.40.39:6800/8550 2 =3D=3D=3D=3D mds_resolve(1+0 subtrees +0=
 slave requests) v1 =3D=3D=3D=3D 28+0+0 (1837742466 0 0) 0x1a6eb60
> 2010-11-23 14:37:29.621046 41b7c940 mds4.cache handle_resolve from md=
s1
> 2010-11-23 14:37:29.621055 41b7c940 mds4.cache show_subtrees
> 2010-11-23 14:37:29.621065 41b7c940 mds4.cache |__ 4 =A0 =A0auth [dir=
 104 ~mds4/ [2,head] auth v=3D1 cv=3D0/0 dir_auth=3D4 state=3D107374182=
4 f(v0 2=3D1+1) n(v0 2=3D1+1) hs=3D0+0,ss=3D0+0 | subtree 0x1a76f10]
> 2010-11-23 14:37:29.621087 41b7c940 mds4.cache maybe_resolve_finish g=
ot all resolves+resolve_acks, done.
> 2010-11-23 14:37:29.621099 41b7c940 mds4.cache disambiguate_imports
> 2010-11-23 14:37:29.621109 41b7c940 mds4.cache show_subtrees
> 2010-11-23 14:37:29.621118 41b7c940 mds4.cache |__ 4 =A0 =A0auth [dir=
 104 ~mds4/ [2,head] auth v=3D1 cv=3D0/0 dir_auth=3D4 state=3D107374182=
4 f(v0 2=3D1+1) n(v0 2=3D1+1) hs=3D0+0,ss=3D0+0 | subtree 0x1a76f10]
> 2010-11-23 14:37:29.621136 41b7c940 mds4.cache trim_unlinked_inodes
> 2010-11-23 14:37:29.621147 41b7c940 mds4.cache recalc_auth_bits
> 2010-11-23 14:37:29.621157 41b7c940 mds4.cache =A0subtree auth=3D1 fo=
r [dir 104 ~mds4/ [2,head] auth v=3D1 cv=3D0/0 dir_auth=3D4 state=3D107=
3741824 f(v0 2=3D1+1) n(v0 2=3D1+1) hs=3D0+0,ss=3D0+0 | subtree 0x1a76f=
10]
> 2010-11-23 14:37:29.621172 41b7c940 mds4.cache show_subtrees
> 2010-11-23 14:37:29.621182 41b7c940 mds4.cache |__ 4 =A0 =A0auth [dir=
 104 ~mds4/ [2,head] auth v=3D1 cv=3D0/0 dir_auth=3D4 state=3D107374182=
4 f(v0 2=3D1+1) n(v0 2=3D1+1) hs=3D0+0,ss=3D0+0 | subtree 0x1a76f10]
> 2010-11-23 14:37:29.621198 41b7c940 mds4.cache show_cache
> 2010-11-23 14:37:29.621205 41b7c940 mds4.cache =A0unlinked [inode 1 [=
=2E..2,head] / rep@0.0 v1 snaprealm=3D0x7fa750010d90 f() n() (iversion =
lock) 0x7fa750015270]
> 2010-11-23 14:37:29.621222 41b7c940 mds4.cache =A0unlinked [inode 104=
 [...2,head] ~mds4/ auth v1 snaprealm=3D0x1a6f450 f() n() (iversion loc=
k) | dirfrag 0x7fa750015b00]
> 2010-11-23 14:37:29.621239 41b7c940 mds4.cache =A0 dirfrag [dir 104 ~=
mds4/ [2,head] auth v=3D1 cv=3D0/0 dir_auth=3D4 state=3D1073741824 f(v0=
 2=3D1+1) n(v0 2=3D1+1) hs=3D0+0,ss=3D0+0 | subtree 0x1a76f10]
> 2010-11-23 14:37:29.621256 41b7c940 mds4.cache trim_non_auth
> 2010-11-23 14:37:29.621283 41b7c940 mds4.cache =A0... [inode 1 [...2,=
head] / rep@0.0 v1 snaprealm=3D0x7fa750010d90 f() n() (iversion lock) 0=
x7fa750015270]
>
>
> The above behavior is repeatable, except usually it's just
> 5 of 7 mds instances that die, and the last thing in their
> logs is always a handle_resolve from the same peer mds.
>
> What's new in this case is that 6th instance disappearing;
> its log had this to say:
>
> 2010-11-23 14:37:29.621961 42aea940 mds1.cache handle_resolve from md=
s0
> 2010-11-23 14:37:29.621975 42aea940 mds1.cache show_subtrees
> 2010-11-23 14:37:29.621985 42aea940 mds1.cache |__ 1 =A0 =A0auth [dir=
 101 ~mds1/ [2,head] auth v=3D1 cv=3D0/0 dir_auth=3D1 state=3D107374182=
4 f(v0 2=3D1+1) n(v0 2=3D1+1) hs=3D0+0,ss=3D0+0 | subtree 0x1255140]
> 2010-11-23 14:37:29.622003 42aea940 mds1.cache maybe_resolve_finish s=
till waiting for more resolves, got (0,6), need (0,2,3,4,5,6)
> 2010-11-23 14:37:29.622016 42aea940 -- 172.17.40.39:6800/8550 dispatc=
h_throttle_release 44 to dispatch throttler 156/104857600
> 2010-11-23 14:37:29.622028 42aea940 -- 172.17.40.39:6800/8550 <=3D=3D=
 mds2 172.17.40.34:6800/7571 4 =3D=3D=3D=3D mds_resolve(1+0 subtrees +0=
 slave requests) v1 =3D=3D=3D=3D 28+0+0 (2796914913 0 0) 0x1265200
> 2010-11-23 14:37:29.622043 42aea940 mds1.cache handle_resolve from md=
s2
> 2010-11-23 14:37:29.622052 42aea940 mds1.cache show_subtrees
> 2010-11-23 14:37:29.622061 42aea940 mds1.cache |__ 1 =A0 =A0auth [dir=
 101 ~mds1/ [2,head] auth v=3D1 cv=3D0/0 dir_auth=3D1 state=3D107374182=
4 f(v0 2=3D1+1) n(v0 2=3D1+1) hs=3D0+0,ss=3D0+0 | subtree 0x1255140]
> 2010-11-23 14:37:29.622077 42aea940 mds1.cache maybe_resolve_finish s=
till waiting for more resolves, got (0,2,6), need (0,2,3,4,5,6)
> 2010-11-23 14:37:29.622090 42aea940 -- 172.17.40.39:6800/8550 dispatc=
h_throttle_release 28 to dispatch throttler 112/104857600
> 2010-11-23 14:37:29.622101 42aea940 -- 172.17.40.39:6800/8550 <=3D=3D=
 mds4 172.17.40.36:6800/7413 3 =3D=3D=3D=3D mds_resolve(1+0 subtrees +0=
 slave requests) v1 =3D=3D=3D=3D 28+0+0 (891395286 0 0) 0x1265c50
> 2010-11-23 14:37:29.622116 42aea940 mds1.cache handle_resolve from md=
s4
> 2010-11-23 14:37:29.622124 42aea940 mds1.cache show_subtrees
> 2010-11-23 14:37:29.622134 42aea940 mds1.cache |__ 1 =A0 =A0auth [dir=
 101 ~mds1/ [2,head] auth v=3D1 cv=3D0/0 dir_auth=3D1 state=3D107374182=
4 f(v0 2=3D1+1) n(v0 2=3D1+1) hs=3D0+0,ss=3D0+0 | subtree 0x1255140]
> 2010-11-23 14:37:29.622150 42aea940 mds1.cache maybe_resolve_finish s=
till waiting for more resolves, got (0,2,4,6), need (0,2,3,4,5,6)
> 2010-11-23 14:37:29.622177 42aea940 -- 172.17.40.39:6800/8550 dispatc=
h_throttle_release 28 to dispatch throttler 84/104857600
> 2010-11-23 14:37:29.622207 42aea940 -- 172.17.40.39:6800/8550 <=3D=3D=
 mds5 172.17.40.38:6800/7395 3 =3D=3D=3D=3D mds_resolve(1+0 subtrees +0=
 slave requests) v1 =3D=3D=3D=3D 28+0+0 (2406375000 0 0) 0x1264150
> 2010-11-23 14:37:29.622226 42aea940 mds1.cache handle_resolve from md=
s5
> 2010-11-23 14:37:29.622238 42aea940 mds1.cache show_subtrees
> 2010-11-23 14:37:29.622250 411d3940 -- 172.17.40.39:6800/8550 >> 172.=
17.40.34:6800/7571 pipe(0x1261690 sd=3D16 pgs=3D10 cs=3D1 l=3D0).reader=
 couldn't read tag, Success
> 2010-11-23 14:37:29.622272 411d3940 -- 172.17.40.39:6800/8550 >> 172.=
17.40.34:6800/7571 pipe(0x1261690 sd=3D16 pgs=3D10 cs=3D1 l=3D0).fault =
0: Success
> 2010-11-23 14:37:29.622290 452f6940 -- 172.17.40.39:6800/8550 >> 172.=
17.40.37:6800/996 pipe(0x1263980 sd=3D19 pgs=3D11 cs=3D1 l=3D0).writer:=
 state =3D 2 policy.server=3D0
> 2010-11-23 14:37:29.622309 452f6940 -- 172.17.40.39:6800/8550 >> 172.=
17.40.37:6800/996 pipe(0x1263980 sd=3D19 pgs=3D11 cs=3D1 l=3D0).write_a=
ck 3
> 2010-11-23 14:37:29.622326 411d3940 -- 172.17.40.39:6800/8550 >> 172.=
17.40.34:6800/7571 pipe(0x1261690 sd=3D16 pgs=3D10 cs=3D1 l=3D0).requeu=
e_sent mds_resolve(1+0 subtrees +0 slave requests) v1 for resend seq 2 =
(2)
> 2010-11-23 14:37:29.622347 411d3940 -- 172.17.40.39:6800/8550 >> 172.=
17.40.34:6800/7571 pipe(0x1261690 sd=3D16 pgs=3D10 cs=3D1 l=3D0).fault =
initiating reconnect
> 2010-11-23 14:37:29.622364 452f6940 -- 172.17.40.39:6800/8550 >> 172.=
17.40.37:6800/996 pipe(0x1263980 sd=3D19 pgs=3D11 cs=3D1 l=3D0).writer:=
 state =3D 2 policy.server=3D0
> 2010-11-23 14:37:29.622380 411d3940 -- 172.17.40.39:6800/8550 >> 172.=
17.40.34:6800/7571 pipe(0x1261690 sd=3D16 pgs=3D10 cs=3D2 l=3D0).reader=
 done
> 2010-11-23 14:37:29.622400 4053e940 -- 172.17.40.39:6800/8550 >> 172.=
17.40.34:6800/7571 pipe(0x1261690 sd=3D16 pgs=3D10 cs=3D2 l=3D0).writer=
: state =3D 1 policy.server=3D0
> 2010-11-23 14:37:29.622419 4053e940 -- 172.17.40.39:6800/8550 >> 172.=
17.40.34:6800/7571 pipe(0x1261690 sd=3D16 pgs=3D10 cs=3D2 l=3D0).connec=
t 2
> 2010-11-23 14:37:29.622437 42aea940 mds1.cache |__ 1 =A0 =A0auth [dir=
 101 ~mds1/ [2,head] auth v=3D1 cv=3D0/0 dir_auth=3D1 state=3D107374182=
4 f(v0 2=3D1+1) n(v0 2=3D1+1) hs=3D0+0,ss=3D0+0 | subtree 0x1255140]
> 2010-11-23 14:37:29.622461 4053e940 -- 172.17.40.39:6800/8550 >> 172.=
17.40.34:6800/7571 pipe(0x1261690 sd=3D16 pgs=3D10 cs=3D2 l=3D0).connec=
ting to 172.17.40.34:6800/7571
> 2010-11-23 14:37:29.622482 42aea940 mds1.cache maybe_resolve_finish s=
till waiting for more resolves, got (0,2,4,5,6), need (0,2,3,4,5,6)
> 2010-11-23 14:37:29.622499 42aea940 -- 172.17.40.39:6800/8550 dispatc=
h_throttle_release 28 to dispatch throttler 56/104857600
> 2010-11-23 14:37:29.622512 42aea940 -- 172.17.40.39:6800/8550 <=3D=3D=
 mds3 172.17.40.37:6800/996 3 =3D=3D=3D=3D mds_resolve(1+0 subtrees +0 =
slave requests) v1 =3D=3D=3D=3D 28+0+0 (486165103 0 0) 0x1264390
> 2010-11-23 14:37:29.622528 42aea940 mds1.cache handle_resolve from md=
s3
> 2010-11-23 14:37:29.622537 42aea940 mds1.cache show_subtrees
> 2010-11-23 14:37:29.622547 42aea940 mds1.cache |__ 1 =A0 =A0auth [dir=
 101 ~mds1/ [2,head] auth v=3D1 cv=3D0/0 dir_auth=3D1 state=3D107374182=
4 f(v0 2=3D1+1) n(v0 2=3D1+1) hs=3D0+0,ss=3D0+0 | subtree 0x1255140]
> 2010-11-23 14:37:29.622566 4053e940 -- 172.17.40.39:6800/8550 >> 172.=
17.40.34:6800/7571 pipe(0x1261690 sd=3D16 pgs=3D10 cs=3D2 l=3D0).connec=
t error 172.17.40.34:6800/7571, 111: Connection refused
> 2010-11-23 14:37:29.622593 4053e940 -- 172.17.40.39:6800/8550 >> 172.=
17.40.34:6800/7571 pipe(0x1261690 sd=3D16 pgs=3D10 cs=3D2 l=3D0).fault =
111: Connection refused
> 2010-11-23 14:37:29.622611 4053e940 -- 172.17.40.39:6800/8550 >> 172.=
17.40.34:6800/7571 pipe(0x1261690 sd=3D16 pgs=3D10 cs=3D2 l=3D0).fault =
first fault
> 2010-11-23 14:37:29.622626 4053e940 -- 172.17.40.39:6800/8550 >> 172.=
17.40.34:6800/7571 pipe(0x1261690 sd=3D16 pgs=3D10 cs=3D2 l=3D0).writer=
: state =3D 1 policy.server=3D0
> 2010-11-23 14:37:29.622642 4053e940 -- 172.17.40.39:6800/8550 >> 172.=
17.40.34:6800/7571 pipe(0x1261690 sd=3D16 pgs=3D10 cs=3D2 l=3D0).connec=
t 2
> 2010-11-23 14:37:29.622662 4053e940 -- 172.17.40.39:6800/8550 >> 172.=
17.40.34:6800/7571 pipe(0x1261690 sd=3D16 pgs=3D10 cs=3D2 l=3D0).connec=
ting to 172.17.40.34:6800/7571
> 2010-11-23 14:37:29.622681 4033e940 -- 172.17.40.39:6800/8550 >> 172.=
17.40.36:6800/7413 pipe(0x12508b0 sd=3D15 pgs=3D8 cs=3D1 l=3D0).reader =
couldn't read tag, Success
> 2010-11-23 14:37:29.622717 42aea940 mds1.cache maybe_resolve_finish g=
ot all resolves+resolve_acks, done.
> 2010-11-23 14:37:29.622733 4033e940 -- 172.17.40.39:6800/8550 >> 172.=
17.40.36:6800/7413 pipe(0x12508b0 sd=3D15 pgs=3D8 cs=3D1 l=3D0).fault 0=
: Success
> 2010-11-23 14:37:29.622768 4033e940 -- 172.17.40.39:6800/8550 >> 172.=
17.40.36:6800/7413 pipe(0x12508b0 sd=3D15 pgs=3D8 cs=3D1 l=3D0).fault w=
ith nothing to send, going to standby
> 2010-11-23 14:37:29.622785 4053e940 -- 172.17.40.39:6800/8550 >> 172.=
17.40.34:6800/7571 pipe(0x1261690 sd=3D16 pgs=3D10 cs=3D2 l=3D0).connec=
t error 172.17.40.34:6800/7571, 111: Connection refused
> 2010-11-23 14:37:29.622806 4053e940 -- 172.17.40.39:6800/8550 >> 172.=
17.40.34:6800/7571 pipe(0x1261690 sd=3D16 pgs=3D10 cs=3D2 l=3D0).fault =
111: Connection refused
> 2010-11-23 14:37:29.622823 4053e940 -- 172.17.40.39:6800/8550 >> 172.=
17.40.34:6800/7571 pipe(0x1261690 sd=3D16 pgs=3D10 cs=3D2 l=3D0).fault =
waiting 0.200000
> 2010-11-23 14:37:29.622840 42aea940 mds1.cache disambiguate_imports
> 2010-11-23 14:37:29.622855 410d2940 -- 172.17.40.39:6800/8550 >> 172.=
17.40.36:6800/7413 pipe(0x12508b0 sd=3D15 pgs=3D8 cs=3D1 l=3D0).writer:=
 state =3D 3 policy.server=3D0
> 2010-11-23 14:37:29.622909 44ff3940 -- 172.17.40.39:6800/8550 >> 172.=
17.40.35:6800/7935 pipe(0x1262680 sd=3D18 pgs=3D10 cs=3D1 l=3D0).reader=
 couldn't read tag, Success
> 2010-11-23 14:37:29.622929 44ff3940 -- 172.17.40.39:6800/8550 >> 172.=
17.40.35:6800/7935 pipe(0x1262680 sd=3D18 pgs=3D10 cs=3D1 l=3D0).fault =
0: Success
> 2010-11-23 14:37:29.622947 451f5940 -- 172.17.40.39:6800/8550 >> 172.=
17.40.37:6800/996 pipe(0x1263980 sd=3D19 pgs=3D11 cs=3D1 l=3D0).reader =
couldn't read tag, Success
> 2010-11-23 14:37:29.622965 44ff3940 -- 172.17.40.39:6800/8550 >> 172.=
17.40.35:6800/7935 pipe(0x1262680 sd=3D18 pgs=3D10 cs=3D1 l=3D0).fault =
with nothing to send, going to standby
> 2010-11-23 14:37:29.622988 40fd1940 -- 172.17.40.39:6800/8550 >> 172.=
17.40.38:6800/7395 pipe(0x124f070 sd=3D13 pgs=3D7 cs=3D1 l=3D0).reader =
couldn't read tag, Success
> 2010-11-23 14:37:29.623008 450f4940 -- 172.17.40.39:6800/8550 >> 172.=
17.40.35:6800/7935 pipe(0x1262680 sd=3D18 pgs=3D10 cs=3D1 l=3D0).writer=
: state =3D 3 policy.server=3D0
> 2010-11-23 14:37:29.623041 42aea940 mds1.cache show_subtrees
> 2010-11-23 14:37:29.623056 40fd1940 -- 172.17.40.39:6800/8550 >> 172.=
17.40.38:6800/7395 pipe(0x124f070 sd=3D13 pgs=3D7 cs=3D1 l=3D0).fault 0=
: Success
> 2010-11-23 14:37:29.623076 40fd1940 -- 172.17.40.39:6800/8550 >> 172.=
17.40.38:6800/7395 pipe(0x124f070 sd=3D13 pgs=3D7 cs=3D1 l=3D0).fault w=
ith nothing to send, going to standby
> 2010-11-23 14:37:29.623092 42aea940 mds1.cache |__ 1 =A0 =A0auth [dir=
 101 ~mds1/ [2,head] auth v=3D1 cv=3D0/0 dir_auth=3D1 state=3D107374182=
4 f(v0 2=3D1+1) n(v0 2=3D1+1) hs=3D0+0,ss=3D0+0 | subtree 0x1255140]
> 2010-11-23 14:37:29.623115 451f5940 -- 172.17.40.39:6800/8550 >> 172.=
17.40.37:6800/996 pipe(0x1263980 sd=3D19 pgs=3D11 cs=3D1 l=3D0).fault 0=
: Success
> 2010-11-23 14:37:29.623134 42aea940 mds1.cache trim_unlinked_inodes
> 2010-11-23 14:37:29.623149 40a03940 -- 172.17.40.39:6800/8550 >> 172.=
17.40.38:6800/7395 pipe(0x124f070 sd=3D13 pgs=3D7 cs=3D1 l=3D0).writer:=
 state =3D 3 policy.server=3D0
> 2010-11-23 14:37:29.623168 451f5940 -- 172.17.40.39:6800/8550 >> 172.=
17.40.37:6800/996 pipe(0x1263980 sd=3D19 pgs=3D11 cs=3D1 l=3D0).requeue=
_sent mds_resolve(1+0 subtrees +0 slave requests) v1 for resend seq 2 (=
2)
> 2010-11-23 14:37:29.623188 451f5940 -- 172.17.40.39:6800/8550 >> 172.=
17.40.37:6800/996 pipe(0x1263980 sd=3D19 pgs=3D11 cs=3D1 l=3D0).fault i=
nitiating reconnect
> 2010-11-23 14:37:29.623205 42aea940 mds1.cache recalc_auth_bits
> 2010-11-23 14:37:29.623219 42aea940 mds1.cache =A0subtree auth=3D1 fo=
r [dir 101 ~mds1/ [2,head] auth v=3D1 cv=3D0/0 dir_auth=3D1 state=3D107=
3741824 f(v0 2=3D1+1) n(v0 2=3D1+1) hs=3D0+0,ss=3D0+0 | subtree 0x12551=
40]
> 2010-11-23 14:37:29.623239 42aea940 mds1.cache show_subtrees
> 2010-11-23 14:37:29.623251 451f5940 -- 172.17.40.39:6800/8550 >> 172.=
17.40.37:6800/996 pipe(0x1263980 sd=3D19 pgs=3D11 cs=3D2 l=3D0).reader =
done
> 2010-11-23 14:37:29.623270 42aea940 mds1.cache |__ 1 =A0 =A0auth [dir=
 101 ~mds1/ [2,head] auth v=3D1 cv=3D0/0 dir_auth=3D1 state=3D107374182=
4 f(v0 2=3D1+1) n(v0 2=3D1+1) hs=3D0+0,ss=3D0+0 | subtree 0x1255140]
> 2010-11-23 14:37:29.623305 42aea940 mds1.cache show_cache
> 2010-11-23 14:37:29.623316 42aea940 mds1.cache =A0unlinked [inode 1 [=
=2E..2,head] / rep@0.0 v1 snaprealm=3D0x7f5ec80084d0 f() n() (iversion =
lock) 0x7f5ec800a3b0]
> 2010-11-23 14:37:29.623336 42aea940 mds1.cache =A0unlinked [inode 101=
 [...2,head] ~mds1/ auth v1 snaprealm=3D0x1254f30 f() n() (iversion loc=
k) | dirfrag 0x7f5ec800ac40]
> 2010-11-23 14:37:29.623356 42aea940 mds1.cache =A0 dirfrag [dir 101 ~=
mds1/ [2,head] auth v=3D1 cv=3D0/0 dir_auth=3D1 state=3D1073741824 f(v0=
 2=3D1+1) n(v0 2=3D1+1) hs=3D0+0,ss=3D0+0 | subtree 0x1255140]
> 2010-11-23 14:37:29.623376 452f6940 -- 172.17.40.39:6800/8550 >> 172.=
17.40.37:6800/996 pipe(0x1263980 sd=3D19 pgs=3D11 cs=3D2 l=3D0).writer:=
 state =3D 1 policy.server=3D0
> 2010-11-23 14:37:29.623395 452f6940 -- 172.17.40.39:6800/8550 >> 172.=
17.40.37:6800/996 pipe(0x1263980 sd=3D19 pgs=3D11 cs=3D2 l=3D0).connect=
 2
> 2010-11-23 14:37:29.623412 42aea940 mds1.cache trim_non_auth
> 2010-11-23 14:37:29.623426 452f6940 -- 172.17.40.39:6800/8550 >> 172.=
17.40.37:6800/996 pipe(0x1263980 sd=3D19 pgs=3D11 cs=3D2 l=3D0).connect=
ing to 172.17.40.37:6800/996
> 2010-11-23 14:37:29.623448 42aea940 mds1.cache =A0... [inode 1 [...2,=
head] / rep@0.0 v1 snaprealm=3D0x7f5ec80084d0 f() n() (iversion lock) 0=
x7f5ec800a3b0]
>
> -- Jim
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
