From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Restart of clustered mds file system fails?
Date: Tue, 23 Nov 2010 14:50:46 -0700
Message-ID: <1290549046.15814.54.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:57195 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798Ab0KWVu5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Nov 2010 16:50:57 -0500
Received: from sentry.sandia.gov (sentry.sandia.gov [132.175.109.20])
	by sentry-three.sandia.gov (Postfix) with ESMTP id 10DFC517381
	for <ceph-devel@vger.kernel.org>; Tue, 23 Nov 2010 14:50:51 -0700 (MST)
Received: from mail.sandia.gov (cas2.sandia.gov [134.253.165.160]) by
 mailgate.sandia.gov (8.14.4/8.14.4) with ESMTP id oANLoag7012498 for
 <ceph-devel@vger.kernel.org>; Tue, 23 Nov 2010 14:50:37 -0700
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


Hi,

I've been working with a file system with 7 mon instances,
and 7 mds instances, on current unstable (fc212548aea1).

I start it up, let it stabilize (all the osds get to
the same epoch), shut it down, then restart it.

Not very long after the restart, 6 of the 7 mds instances
disappear, with no core files and no stack trace in the logs.

The last few lines of output from ceph -w look like this:

2010-11-23 14:37:20.504569    pg v88: 3432 pgs: 3432 active; 138 KB data, 177 MB used, 3032 GB / 3032 GB avail; 12/234 degraded (5.128%)
2010-11-23 14:37:20.739372    pg v89: 3432 pgs: 3432 active; 138 KB data, 167 MB used, 3032 GB / 3032 GB avail; 12/234 degraded (5.128%)
2010-11-23 14:37:21.033669    pg v90: 3432 pgs: 3432 active; 138 KB data, 154 MB used, 3032 GB / 3032 GB avail; 12/234 degraded (5.128%)
2010-11-23 14:37:21.353834    pg v91: 3432 pgs: 3432 active; 138 KB data, 139 MB used, 3032 GB / 3032 GB avail; 12/234 degraded (5.128%)
2010-11-23 14:37:21.478496   mds e33: 7/7/7 up {0=up:replay,1=up:replay,2=up:resolve,3=up:replay,4=up:resolve,5=up:resolve,6=up:replay}
2010-11-23 14:37:21.709432   log 2010-11-23 14:37:21.403836 mon0 172.17.40.34:6789/0 25 : [INF] mds2 172.17.40.34:6800/7571 up:resolve
2010-11-23 14:37:21.827792    pg v92: 3432 pgs: 3432 active; 138 KB data, 134 MB used, 3032 GB / 3032 GB avail; 10/234 degraded (4.274%)
2010-11-23 14:37:22.197558    pg v93: 3432 pgs: 3432 active; 139 KB data, 128 MB used, 3032 GB / 3032 GB avail; 10/234 degraded (4.274%)
2010-11-23 14:37:22.484411    pg v94: 3432 pgs: 3432 active; 139 KB data, 116 MB used, 3032 GB / 3032 GB avail; 10/234 degraded (4.274%)
2010-11-23 14:37:22.766665    pg v95: 3432 pgs: 3432 active; 139 KB data, 102316 KB used, 3032 GB / 3032 GB avail; 10/234 degraded (4.274%)
2010-11-23 14:37:25.261067   mds e34: 7/7/7 up {0=up:resolve,1=up:replay,2=up:resolve,3=up:replay,4=up:resolve,5=up:resolve,6=up:replay}
2010-11-23 14:37:25.398455   log 2010-11-23 14:37:25.236187 mon0 172.17.40.34:6789/0 26 : [INF] mds0 172.17.40.40:6800/7567 up:resolve
2010-11-23 14:37:25.592960   mds e35: 7/7/7 up {0=up:resolve,1=up:replay,2=up:resolve,3=up:replay,4=up:resolve,5=up:resolve,6=up:resolve}
2010-11-23 14:37:25.774941   log 2010-11-23 14:37:25.603505 mon0 172.17.40.34:6789/0 27 : [INF] mds6 172.17.40.35:6800/7935 up:resolve
2010-11-23 14:37:29.273125   mds e36: 7/7/7 up {0=up:resolve,1=up:replay,2=up:resolve,3=up:resolve,4=up:resolve,5=up:resolve,6=up:resolve}
2010-11-23 14:37:29.410528   log 2010-11-23 14:37:29.247681 mon0 172.17.40.34:6789/0 28 : [INF] mds3 172.17.40.37:6800/996 up:resolve
2010-11-23 14:37:29.612511   mds e37: 7/7/7 up {0=up:resolve,1=up:resolve,2=up:resolve,3=up:resolve,4=up:resolve,5=up:resolve,6=up:resolve}
2010-11-23 14:37:29.799629   mds e38: 7/7/7 up {0=up:reconnect,1=up:resolve,2=up:resolve,3=up:resolve,4=up:resolve,5=up:resolve,6=up:resolve}
2010-11-23 14:37:29.824094   log 2010-11-23 14:37:29.618299 mon0 172.17.40.34:6789/0 29 : [INF] mds1 172.17.40.39:6800/8550 up:resolve
2010-11-23 14:37:30.119613   log 2010-11-23 14:37:29.760648 mon0 172.17.40.34:6789/0 30 : [INF] mds0 172.17.40.40:6800/7567 up:reconnect
2010-11-23 14:37:30.216568   mds e39: 7/7/7 up {0=up:rejoin,1=up:resolve,2=up:resolve,3=up:resolve,4=up:resolve,5=up:resolve,6=up:resolve}
2010-11-23 14:37:30.434163   log 2010-11-23 14:37:30.208227 mon0 172.17.40.34:6789/0 31 : [INF] mds0 172.17.40.40:6800/7567 up:rejoin
2010-11-23 14:37:46.274801   mds e40: 7/7/7 up {0=up:rejoin,1=up:resolve,2=up:resolve(laggy or crashed),3=up:resolve(laggy or crashed),4=up:resolve(laggy or crashed),5=up:resolve,6=up:resolve}
2010-11-23 14:37:51.303591   mds e41: 7/7/7 up {0=up:rejoin,1=up:resolve(laggy or crashed),2=up:resolve(laggy or crashed),3=up:resolve(laggy or crashed),4=up:resolve(laggy or crashed),5=up:resolve(laggy or crashed),6=up:resolve(laggy or crashed)}

The last few lines of the disappearing mds instance logs
look like this; in particular 5 of the 6 that disappeared
were all doing the "handle resolve from mds1"

2010-11-23 14:37:29.621030 41b7c940 -- 172.17.40.36:6800/7413 <== mds1 172.17.40.39:6800/8550 2 ==== mds_resolve(1+0 subtrees +0 slave requests) v1 ==== 28+0+0 (1837742466 0 0) 0x1a6eb60
2010-11-23 14:37:29.621046 41b7c940 mds4.cache handle_resolve from mds1
2010-11-23 14:37:29.621055 41b7c940 mds4.cache show_subtrees
2010-11-23 14:37:29.621065 41b7c940 mds4.cache |__ 4    auth [dir 104 ~mds4/ [2,head] auth v=1 cv=0/0 dir_auth=4 state=1073741824 f(v0 2=1+1) n(v0 2=1+1) hs=0+0,ss=0+0 | subtree 0x1a76f10]
2010-11-23 14:37:29.621087 41b7c940 mds4.cache maybe_resolve_finish got all resolves+resolve_acks, done.
2010-11-23 14:37:29.621099 41b7c940 mds4.cache disambiguate_imports
2010-11-23 14:37:29.621109 41b7c940 mds4.cache show_subtrees
2010-11-23 14:37:29.621118 41b7c940 mds4.cache |__ 4    auth [dir 104 ~mds4/ [2,head] auth v=1 cv=0/0 dir_auth=4 state=1073741824 f(v0 2=1+1) n(v0 2=1+1) hs=0+0,ss=0+0 | subtree 0x1a76f10]
2010-11-23 14:37:29.621136 41b7c940 mds4.cache trim_unlinked_inodes
2010-11-23 14:37:29.621147 41b7c940 mds4.cache recalc_auth_bits
2010-11-23 14:37:29.621157 41b7c940 mds4.cache  subtree auth=1 for [dir 104 ~mds4/ [2,head] auth v=1 cv=0/0 dir_auth=4 state=1073741824 f(v0 2=1+1) n(v0 2=1+1) hs=0+0,ss=0+0 | subtree 0x1a76f10]
2010-11-23 14:37:29.621172 41b7c940 mds4.cache show_subtrees
2010-11-23 14:37:29.621182 41b7c940 mds4.cache |__ 4    auth [dir 104 ~mds4/ [2,head] auth v=1 cv=0/0 dir_auth=4 state=1073741824 f(v0 2=1+1) n(v0 2=1+1) hs=0+0,ss=0+0 | subtree 0x1a76f10]
2010-11-23 14:37:29.621198 41b7c940 mds4.cache show_cache
2010-11-23 14:37:29.621205 41b7c940 mds4.cache  unlinked [inode 1 [...2,head] / rep@0.0 v1 snaprealm=0x7fa750010d90 f() n() (iversion lock) 0x7fa750015270]
2010-11-23 14:37:29.621222 41b7c940 mds4.cache  unlinked [inode 104 [...2,head] ~mds4/ auth v1 snaprealm=0x1a6f450 f() n() (iversion lock) | dirfrag 0x7fa750015b00]
2010-11-23 14:37:29.621239 41b7c940 mds4.cache   dirfrag [dir 104 ~mds4/ [2,head] auth v=1 cv=0/0 dir_auth=4 state=1073741824 f(v0 2=1+1) n(v0 2=1+1) hs=0+0,ss=0+0 | subtree 0x1a76f10]
2010-11-23 14:37:29.621256 41b7c940 mds4.cache trim_non_auth
2010-11-23 14:37:29.621283 41b7c940 mds4.cache  ... [inode 1 [...2,head] / rep@0.0 v1 snaprealm=0x7fa750010d90 f() n() (iversion lock) 0x7fa750015270]


The above behavior is repeatable, except usually it's just
5 of 7 mds instances that die, and the last thing in their
logs is always a handle_resolve from the same peer mds.

What's new in this case is that 6th instance disappearing;
its log had this to say:

2010-11-23 14:37:29.621961 42aea940 mds1.cache handle_resolve from mds0
2010-11-23 14:37:29.621975 42aea940 mds1.cache show_subtrees
2010-11-23 14:37:29.621985 42aea940 mds1.cache |__ 1    auth [dir 101 ~mds1/ [2,head] auth v=1 cv=0/0 dir_auth=1 state=1073741824 f(v0 2=1+1) n(v0 2=1+1) hs=0+0,ss=0+0 | subtree 0x1255140]
2010-11-23 14:37:29.622003 42aea940 mds1.cache maybe_resolve_finish still waiting for more resolves, got (0,6), need (0,2,3,4,5,6)
2010-11-23 14:37:29.622016 42aea940 -- 172.17.40.39:6800/8550 dispatch_throttle_release 44 to dispatch throttler 156/104857600
2010-11-23 14:37:29.622028 42aea940 -- 172.17.40.39:6800/8550 <== mds2 172.17.40.34:6800/7571 4 ==== mds_resolve(1+0 subtrees +0 slave requests) v1 ==== 28+0+0 (2796914913 0 0) 0x1265200
2010-11-23 14:37:29.622043 42aea940 mds1.cache handle_resolve from mds2
2010-11-23 14:37:29.622052 42aea940 mds1.cache show_subtrees
2010-11-23 14:37:29.622061 42aea940 mds1.cache |__ 1    auth [dir 101 ~mds1/ [2,head] auth v=1 cv=0/0 dir_auth=1 state=1073741824 f(v0 2=1+1) n(v0 2=1+1) hs=0+0,ss=0+0 | subtree 0x1255140]
2010-11-23 14:37:29.622077 42aea940 mds1.cache maybe_resolve_finish still waiting for more resolves, got (0,2,6), need (0,2,3,4,5,6)
2010-11-23 14:37:29.622090 42aea940 -- 172.17.40.39:6800/8550 dispatch_throttle_release 28 to dispatch throttler 112/104857600
2010-11-23 14:37:29.622101 42aea940 -- 172.17.40.39:6800/8550 <== mds4 172.17.40.36:6800/7413 3 ==== mds_resolve(1+0 subtrees +0 slave requests) v1 ==== 28+0+0 (891395286 0 0) 0x1265c50
2010-11-23 14:37:29.622116 42aea940 mds1.cache handle_resolve from mds4
2010-11-23 14:37:29.622124 42aea940 mds1.cache show_subtrees
2010-11-23 14:37:29.622134 42aea940 mds1.cache |__ 1    auth [dir 101 ~mds1/ [2,head] auth v=1 cv=0/0 dir_auth=1 state=1073741824 f(v0 2=1+1) n(v0 2=1+1) hs=0+0,ss=0+0 | subtree 0x1255140]
2010-11-23 14:37:29.622150 42aea940 mds1.cache maybe_resolve_finish still waiting for more resolves, got (0,2,4,6), need (0,2,3,4,5,6)
2010-11-23 14:37:29.622177 42aea940 -- 172.17.40.39:6800/8550 dispatch_throttle_release 28 to dispatch throttler 84/104857600
2010-11-23 14:37:29.622207 42aea940 -- 172.17.40.39:6800/8550 <== mds5 172.17.40.38:6800/7395 3 ==== mds_resolve(1+0 subtrees +0 slave requests) v1 ==== 28+0+0 (2406375000 0 0) 0x1264150
2010-11-23 14:37:29.622226 42aea940 mds1.cache handle_resolve from mds5
2010-11-23 14:37:29.622238 42aea940 mds1.cache show_subtrees
2010-11-23 14:37:29.622250 411d3940 -- 172.17.40.39:6800/8550 >> 172.17.40.34:6800/7571 pipe(0x1261690 sd=16 pgs=10 cs=1 l=0).reader couldn't read tag, Success
2010-11-23 14:37:29.622272 411d3940 -- 172.17.40.39:6800/8550 >> 172.17.40.34:6800/7571 pipe(0x1261690 sd=16 pgs=10 cs=1 l=0).fault 0: Success
2010-11-23 14:37:29.622290 452f6940 -- 172.17.40.39:6800/8550 >> 172.17.40.37:6800/996 pipe(0x1263980 sd=19 pgs=11 cs=1 l=0).writer: state = 2 policy.server=0
2010-11-23 14:37:29.622309 452f6940 -- 172.17.40.39:6800/8550 >> 172.17.40.37:6800/996 pipe(0x1263980 sd=19 pgs=11 cs=1 l=0).write_ack 3
2010-11-23 14:37:29.622326 411d3940 -- 172.17.40.39:6800/8550 >> 172.17.40.34:6800/7571 pipe(0x1261690 sd=16 pgs=10 cs=1 l=0).requeue_sent mds_resolve(1+0 subtrees +0 slave requests) v1 for resend seq 2 (2)
2010-11-23 14:37:29.622347 411d3940 -- 172.17.40.39:6800/8550 >> 172.17.40.34:6800/7571 pipe(0x1261690 sd=16 pgs=10 cs=1 l=0).fault initiating reconnect
2010-11-23 14:37:29.622364 452f6940 -- 172.17.40.39:6800/8550 >> 172.17.40.37:6800/996 pipe(0x1263980 sd=19 pgs=11 cs=1 l=0).writer: state = 2 policy.server=0
2010-11-23 14:37:29.622380 411d3940 -- 172.17.40.39:6800/8550 >> 172.17.40.34:6800/7571 pipe(0x1261690 sd=16 pgs=10 cs=2 l=0).reader done
2010-11-23 14:37:29.622400 4053e940 -- 172.17.40.39:6800/8550 >> 172.17.40.34:6800/7571 pipe(0x1261690 sd=16 pgs=10 cs=2 l=0).writer: state = 1 policy.server=0
2010-11-23 14:37:29.622419 4053e940 -- 172.17.40.39:6800/8550 >> 172.17.40.34:6800/7571 pipe(0x1261690 sd=16 pgs=10 cs=2 l=0).connect 2
2010-11-23 14:37:29.622437 42aea940 mds1.cache |__ 1    auth [dir 101 ~mds1/ [2,head] auth v=1 cv=0/0 dir_auth=1 state=1073741824 f(v0 2=1+1) n(v0 2=1+1) hs=0+0,ss=0+0 | subtree 0x1255140]
2010-11-23 14:37:29.622461 4053e940 -- 172.17.40.39:6800/8550 >> 172.17.40.34:6800/7571 pipe(0x1261690 sd=16 pgs=10 cs=2 l=0).connecting to 172.17.40.34:6800/7571
2010-11-23 14:37:29.622482 42aea940 mds1.cache maybe_resolve_finish still waiting for more resolves, got (0,2,4,5,6), need (0,2,3,4,5,6)
2010-11-23 14:37:29.622499 42aea940 -- 172.17.40.39:6800/8550 dispatch_throttle_release 28 to dispatch throttler 56/104857600
2010-11-23 14:37:29.622512 42aea940 -- 172.17.40.39:6800/8550 <== mds3 172.17.40.37:6800/996 3 ==== mds_resolve(1+0 subtrees +0 slave requests) v1 ==== 28+0+0 (486165103 0 0) 0x1264390
2010-11-23 14:37:29.622528 42aea940 mds1.cache handle_resolve from mds3
2010-11-23 14:37:29.622537 42aea940 mds1.cache show_subtrees
2010-11-23 14:37:29.622547 42aea940 mds1.cache |__ 1    auth [dir 101 ~mds1/ [2,head] auth v=1 cv=0/0 dir_auth=1 state=1073741824 f(v0 2=1+1) n(v0 2=1+1) hs=0+0,ss=0+0 | subtree 0x1255140]
2010-11-23 14:37:29.622566 4053e940 -- 172.17.40.39:6800/8550 >> 172.17.40.34:6800/7571 pipe(0x1261690 sd=16 pgs=10 cs=2 l=0).connect error 172.17.40.34:6800/7571, 111: Connection refused
2010-11-23 14:37:29.622593 4053e940 -- 172.17.40.39:6800/8550 >> 172.17.40.34:6800/7571 pipe(0x1261690 sd=16 pgs=10 cs=2 l=0).fault 111: Connection refused
2010-11-23 14:37:29.622611 4053e940 -- 172.17.40.39:6800/8550 >> 172.17.40.34:6800/7571 pipe(0x1261690 sd=16 pgs=10 cs=2 l=0).fault first fault
2010-11-23 14:37:29.622626 4053e940 -- 172.17.40.39:6800/8550 >> 172.17.40.34:6800/7571 pipe(0x1261690 sd=16 pgs=10 cs=2 l=0).writer: state = 1 policy.server=0
2010-11-23 14:37:29.622642 4053e940 -- 172.17.40.39:6800/8550 >> 172.17.40.34:6800/7571 pipe(0x1261690 sd=16 pgs=10 cs=2 l=0).connect 2
2010-11-23 14:37:29.622662 4053e940 -- 172.17.40.39:6800/8550 >> 172.17.40.34:6800/7571 pipe(0x1261690 sd=16 pgs=10 cs=2 l=0).connecting to 172.17.40.34:6800/7571
2010-11-23 14:37:29.622681 4033e940 -- 172.17.40.39:6800/8550 >> 172.17.40.36:6800/7413 pipe(0x12508b0 sd=15 pgs=8 cs=1 l=0).reader couldn't read tag, Success
2010-11-23 14:37:29.622717 42aea940 mds1.cache maybe_resolve_finish got all resolves+resolve_acks, done.
2010-11-23 14:37:29.622733 4033e940 -- 172.17.40.39:6800/8550 >> 172.17.40.36:6800/7413 pipe(0x12508b0 sd=15 pgs=8 cs=1 l=0).fault 0: Success
2010-11-23 14:37:29.622768 4033e940 -- 172.17.40.39:6800/8550 >> 172.17.40.36:6800/7413 pipe(0x12508b0 sd=15 pgs=8 cs=1 l=0).fault with nothing to send, going to standby
2010-11-23 14:37:29.622785 4053e940 -- 172.17.40.39:6800/8550 >> 172.17.40.34:6800/7571 pipe(0x1261690 sd=16 pgs=10 cs=2 l=0).connect error 172.17.40.34:6800/7571, 111: Connection refused
2010-11-23 14:37:29.622806 4053e940 -- 172.17.40.39:6800/8550 >> 172.17.40.34:6800/7571 pipe(0x1261690 sd=16 pgs=10 cs=2 l=0).fault 111: Connection refused
2010-11-23 14:37:29.622823 4053e940 -- 172.17.40.39:6800/8550 >> 172.17.40.34:6800/7571 pipe(0x1261690 sd=16 pgs=10 cs=2 l=0).fault waiting 0.200000
2010-11-23 14:37:29.622840 42aea940 mds1.cache disambiguate_imports
2010-11-23 14:37:29.622855 410d2940 -- 172.17.40.39:6800/8550 >> 172.17.40.36:6800/7413 pipe(0x12508b0 sd=15 pgs=8 cs=1 l=0).writer: state = 3 policy.server=0
2010-11-23 14:37:29.622909 44ff3940 -- 172.17.40.39:6800/8550 >> 172.17.40.35:6800/7935 pipe(0x1262680 sd=18 pgs=10 cs=1 l=0).reader couldn't read tag, Success
2010-11-23 14:37:29.622929 44ff3940 -- 172.17.40.39:6800/8550 >> 172.17.40.35:6800/7935 pipe(0x1262680 sd=18 pgs=10 cs=1 l=0).fault 0: Success
2010-11-23 14:37:29.622947 451f5940 -- 172.17.40.39:6800/8550 >> 172.17.40.37:6800/996 pipe(0x1263980 sd=19 pgs=11 cs=1 l=0).reader couldn't read tag, Success
2010-11-23 14:37:29.622965 44ff3940 -- 172.17.40.39:6800/8550 >> 172.17.40.35:6800/7935 pipe(0x1262680 sd=18 pgs=10 cs=1 l=0).fault with nothing to send, going to standby
2010-11-23 14:37:29.622988 40fd1940 -- 172.17.40.39:6800/8550 >> 172.17.40.38:6800/7395 pipe(0x124f070 sd=13 pgs=7 cs=1 l=0).reader couldn't read tag, Success
2010-11-23 14:37:29.623008 450f4940 -- 172.17.40.39:6800/8550 >> 172.17.40.35:6800/7935 pipe(0x1262680 sd=18 pgs=10 cs=1 l=0).writer: state = 3 policy.server=0
2010-11-23 14:37:29.623041 42aea940 mds1.cache show_subtrees
2010-11-23 14:37:29.623056 40fd1940 -- 172.17.40.39:6800/8550 >> 172.17.40.38:6800/7395 pipe(0x124f070 sd=13 pgs=7 cs=1 l=0).fault 0: Success
2010-11-23 14:37:29.623076 40fd1940 -- 172.17.40.39:6800/8550 >> 172.17.40.38:6800/7395 pipe(0x124f070 sd=13 pgs=7 cs=1 l=0).fault with nothing to send, going to standby
2010-11-23 14:37:29.623092 42aea940 mds1.cache |__ 1    auth [dir 101 ~mds1/ [2,head] auth v=1 cv=0/0 dir_auth=1 state=1073741824 f(v0 2=1+1) n(v0 2=1+1) hs=0+0,ss=0+0 | subtree 0x1255140]
2010-11-23 14:37:29.623115 451f5940 -- 172.17.40.39:6800/8550 >> 172.17.40.37:6800/996 pipe(0x1263980 sd=19 pgs=11 cs=1 l=0).fault 0: Success
2010-11-23 14:37:29.623134 42aea940 mds1.cache trim_unlinked_inodes
2010-11-23 14:37:29.623149 40a03940 -- 172.17.40.39:6800/8550 >> 172.17.40.38:6800/7395 pipe(0x124f070 sd=13 pgs=7 cs=1 l=0).writer: state = 3 policy.server=0
2010-11-23 14:37:29.623168 451f5940 -- 172.17.40.39:6800/8550 >> 172.17.40.37:6800/996 pipe(0x1263980 sd=19 pgs=11 cs=1 l=0).requeue_sent mds_resolve(1+0 subtrees +0 slave requests) v1 for resend seq 2 (2)
2010-11-23 14:37:29.623188 451f5940 -- 172.17.40.39:6800/8550 >> 172.17.40.37:6800/996 pipe(0x1263980 sd=19 pgs=11 cs=1 l=0).fault initiating reconnect
2010-11-23 14:37:29.623205 42aea940 mds1.cache recalc_auth_bits
2010-11-23 14:37:29.623219 42aea940 mds1.cache  subtree auth=1 for [dir 101 ~mds1/ [2,head] auth v=1 cv=0/0 dir_auth=1 state=1073741824 f(v0 2=1+1) n(v0 2=1+1) hs=0+0,ss=0+0 | subtree 0x1255140]
2010-11-23 14:37:29.623239 42aea940 mds1.cache show_subtrees
2010-11-23 14:37:29.623251 451f5940 -- 172.17.40.39:6800/8550 >> 172.17.40.37:6800/996 pipe(0x1263980 sd=19 pgs=11 cs=2 l=0).reader done
2010-11-23 14:37:29.623270 42aea940 mds1.cache |__ 1    auth [dir 101 ~mds1/ [2,head] auth v=1 cv=0/0 dir_auth=1 state=1073741824 f(v0 2=1+1) n(v0 2=1+1) hs=0+0,ss=0+0 | subtree 0x1255140]
2010-11-23 14:37:29.623305 42aea940 mds1.cache show_cache
2010-11-23 14:37:29.623316 42aea940 mds1.cache  unlinked [inode 1 [...2,head] / rep@0.0 v1 snaprealm=0x7f5ec80084d0 f() n() (iversion lock) 0x7f5ec800a3b0]
2010-11-23 14:37:29.623336 42aea940 mds1.cache  unlinked [inode 101 [...2,head] ~mds1/ auth v1 snaprealm=0x1254f30 f() n() (iversion lock) | dirfrag 0x7f5ec800ac40]
2010-11-23 14:37:29.623356 42aea940 mds1.cache   dirfrag [dir 101 ~mds1/ [2,head] auth v=1 cv=0/0 dir_auth=1 state=1073741824 f(v0 2=1+1) n(v0 2=1+1) hs=0+0,ss=0+0 | subtree 0x1255140]
2010-11-23 14:37:29.623376 452f6940 -- 172.17.40.39:6800/8550 >> 172.17.40.37:6800/996 pipe(0x1263980 sd=19 pgs=11 cs=2 l=0).writer: state = 1 policy.server=0
2010-11-23 14:37:29.623395 452f6940 -- 172.17.40.39:6800/8550 >> 172.17.40.37:6800/996 pipe(0x1263980 sd=19 pgs=11 cs=2 l=0).connect 2
2010-11-23 14:37:29.623412 42aea940 mds1.cache trim_non_auth
2010-11-23 14:37:29.623426 452f6940 -- 172.17.40.39:6800/8550 >> 172.17.40.37:6800/996 pipe(0x1263980 sd=19 pgs=11 cs=2 l=0).connecting to 172.17.40.37:6800/996
2010-11-23 14:37:29.623448 42aea940 mds1.cache  ... [inode 1 [...2,head] / rep@0.0 v1 snaprealm=0x7f5ec80084d0 f() n() (iversion lock) 0x7f5ec800a3b0]

-- Jim




