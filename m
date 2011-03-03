From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Thu, 3 Mar 2011 09:35:54 -0700
Message-ID: <1299170154.4750.89.camel@sale659.sandia.gov>
References: <1297891508.25491.120.camel@sale659.sandia.gov>
 <75157CFDA63D45458FC47FB7BA6CB974@gmail.com>
 <1297893011.25491.124.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102161649560.11150@cobra.newdream.net>
 <Pine.LNX.4.64.1102161651380.11150@cobra.newdream.net>
 <1297957574.25491.152.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102170805080.22514@cobra.newdream.net>
 <1298483538.25491.233.camel@sale659.sandia.gov>
 <460F770CEB1C499F8B87593762171483@gmail.com>
 <1298489031.25491.250.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1103011646140.32424@cobra.newdream.net>
 <1299079262.4750.19.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1103020909170.27567@cobra.newdream.net>
 <1299099295.4750.41.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1103021342540.27567@cobra.newdream.net>
 <1299103144.4750.49.camel@sale659.sandia.gov>
 <1299106628.4750.62.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1103022102240.32695@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:39781 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754587Ab1CCQgH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Mar 2011 11:36:07 -0500
In-Reply-To: <Pine.LNX.4.64.1103022102240.32695@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Wed, 2011-03-02 at 22:03 -0700, Sage Weil wrote:
> Hi Jim,
> 
> On Wed, 2 Mar 2011, Jim Schutt wrote:
> 
> > 
> > On Wed, 2011-03-02 at 14:59 -0700, Jim Schutt wrote:
> > > 
> > > On Wed, 2011-03-02 at 14:45 -0700, Sage Weil wrote:
> > > > On Wed, 2 Mar 2011, Jim Schutt wrote:
> > > > > 
> > > > > On Wed, 2011-03-02 at 10:10 -0700, Sage Weil wrote:
> > > > > > > I'll see if I see the same signature with master,
> > > > > > > and post logs.
> > > > > > 
> > > > > > Thanks!  Keep us posted.
> > > > > 
> > > > > Hmmm, I'm not having much luck with master (commit 
> > > > > 0fb5ef2ce92 + extra debugging) on a 96-osd filesystem;
> > > > > lots of dead OSDs during startup.
> > > > 
> > > > Commit c916905a8a14029653aae45f0a9fb6c9b4c39e05 (master) should fix this.
> > > 
> > > I try it out, thanks!
> > 
> > I don't get any more core files with master commit 67355779ecc.
> > Now my cosds just die - no stack trace in the log, no core
> > file, nothing in syslog or dmesg ...
> > 
> > I'm not sure how to track down what's happening here...
> 
> Hmm.  I'm not able to reproduce this here (tho I only have ~15 nodes 
> available at the moment).  Seeing the last bit of the logs on the crashed 
> nodes will help.

I reproduced this morning using master branch commit 1a2e2a77f35c.
Still no core files that I can find.

Here's the last 50 lines of the log for some of the early 
cosd deaths.

--------
/var/log/ceph/osd.21.log:2011-03-03 08:35:29.921947 7fa84cef0940 journal queue_completions_thru seq 23135 queueing seq 23131 0x7fa8414e8ff0
/var/log/ceph/osd.21.log:2011-03-03 08:35:29.921965 7fa84cef0940 journal queue_completions_thru seq 23135 queueing seq 23132 0x7fa84152cf90
/var/log/ceph/osd.21.log:2011-03-03 08:35:29.921978 7fa84cef0940 journal queue_completions_thru seq 23135 queueing seq 23133 0x7fa8411ee180
/var/log/ceph/osd.21.log:2011-03-03 08:35:29.921988 7fa84cef0940 journal queue_completions_thru seq 23135 queueing seq 23134 0x7fa841594f90
/var/log/ceph/osd.21.log:2011-03-03 08:35:29.922000 7fa84cef0940 journal queue_completions_thru seq 23135 queueing seq 23135 0x7fa84158cf90
/var/log/ceph/osd.21.log:2011-03-03 08:35:29.922013 7fa84cef0940 journal write_thread throttle finished 18 ops and 8724 bytes, now 4 ops and 1944 bytes
/var/log/ceph/osd.21.log:2011-03-03 08:35:29.922036 7fa84cef0940 journal room 511668223 max_size 526385152 pos 192196608 header.start 177483776 top 4096
/var/log/ceph/osd.21.log:2011-03-03 08:35:29.922044 7fa84cef0940 journal check_for_full at 192196608 : 8192 < 511668223
/var/log/ceph/osd.21.log:2011-03-03 08:35:29.922051 7fa84cef0940 journal prepare_single_write 1 will write 192196608 : seq 23136 len 486 -> 8192 (head 40 pre_pad 4056 ebl 486 post_pad 3570 tail 40) (ebl alignment 0)
/var/log/ceph/osd.21.log:2011-03-03 08:35:29.922079 7fa84cef0940 journal room 511660031 max_size 526385152 pos 192204800 header.start 177483776 top 4096
/var/log/ceph/osd.21.log:2011-03-03 08:35:29.922094 7fa84cef0940 journal check_for_full at 192204800 : 8192 < 511660031
/var/log/ceph/osd.21.log:2011-03-03 08:35:29.922102 7fa84cef0940 journal prepare_single_write 2 will write 192204800 : seq 23137 len 486 -> 8192 (head 40 pre_pad 4056 ebl 486 post_pad 3570 tail 40) (ebl alignment 0)
/var/log/ceph/osd.21.log:2011-03-03 08:35:29.922112 7fa84cef0940 journal room 511651839 max_size 526385152 pos 192212992 header.start 177483776 top 4096
/var/log/ceph/osd.21.log:2011-03-03 08:35:29.922122 7fa84cef0940 journal check_for_full at 192212992 : 8192 < 511651839
/var/log/ceph/osd.21.log:2011-03-03 08:35:29.922129 7fa84cef0940 journal prepare_single_write 3 will write 192212992 : seq 23138 len 486 -> 8192 (head 40 pre_pad 4056 ebl 486 post_pad 3570 tail 40) (ebl alignment 0)
/var/log/ceph/osd.21.log:2011-03-03 08:35:29.922153 7fa84cef0940 journal room 511643647 max_size 526385152 pos 192221184 header.start 177483776 top 4096
/var/log/ceph/osd.21.log:2011-03-03 08:35:29.922160 7fa84cef0940 journal check_for_full at 192221184 : 8192 < 511643647
/var/log/ceph/osd.21.log:2011-03-03 08:35:29.922167 7fa84cef0940 journal prepare_single_write 4 will write 192221184 : seq 23139 len 486 -> 8192 (head 40 pre_pad 4056 ebl 486 post_pad 3570 tail 40) (ebl alignment 0)
/var/log/ceph/osd.21.log:2011-03-03 08:35:29.922176 7fa84cef0940 journal prepare_multi_write queue_pos now 192229376
/var/log/ceph/osd.21.log:2011-03-03 08:35:29.922183 7fa84cef0940 journal do_write writing 192196608~32768
/var/log/ceph/osd.21.log:2011-03-03 08:35:29.930753 7fa8266e6940 -- 172.17.40.23:6817/24736 >> 172.17.40.32:6811/21905 pipe(0x7fa840e38100 sd=149 pgs=89 cs=1 l=0).reader got MSG
/var/log/ceph/osd.21.log:2011-03-03 08:35:29.930778 7fa8266e6940 -- 172.17.40.23:6817/24736 >> 172.17.40.32:6811/21905 pipe(0x7fa840e38100 sd=149 pgs=89 cs=1 l=0).reader got envelope type=70 src osd83 front=61 data=0 off 0
/var/log/ceph/osd.21.log:2011-03-03 08:35:29.930792 7fa8266e6940 -- 172.17.40.23:6817/24736 >> 172.17.40.32:6811/21905 pipe(0x7fa840e38100 sd=149 pgs=89 cs=1 l=0).reader wants 61 from dispatch throttler 0/35000000
/var/log/ceph/osd.21.log:2011-03-03 08:35:29.930807 7fa8266e6940 -- 172.17.40.23:6817/24736 >> 172.17.40.32:6811/21905 pipe(0x7fa840e38100 sd=149 pgs=89 cs=1 l=0).reader got front 61
/var/log/ceph/osd.21.log:2011-03-03 08:35:29.930821 7fa8266e6940 -- 172.17.40.23:6817/24736 >> 172.17.40.32:6811/21905 pipe(0x7fa840e38100 sd=149 pgs=89 cs=1 l=0).aborted = 0
/var/log/ceph/osd.21.log:2011-03-03 08:35:29.930832 7fa8266e6940 -- 172.17.40.23:6817/24736 >> 172.17.40.32:6811/21905 pipe(0x7fa840e38100 sd=149 pgs=89 cs=1 l=0).reader got 61 + 0 + 0 byte message
/var/log/ceph/osd.21.log:2011-03-03 08:35:29.930851 7fa8266e6940 -- 172.17.40.23:6817/24736 >> 172.17.40.32:6811/21905 pipe(0x7fa840e38100 sd=149 pgs=89 cs=1 l=0).reader got message 175 0x33397c0 osd_ping(e7 as_of 7) v1
/var/log/ceph/osd.21.log:2011-03-03 08:35:29.930864 7fa8266e6940 -- 172.17.40.23:6817/24736 >> 172.17.40.32:6811/21905 pipe(0x7fa840e38100 sd=149 pgs=89 cs=1 l=0).queue_received queuing pipe
/var/log/ceph/osd.21.log:2011-03-03 08:35:29.930879 7fa8266e6940 -- 172.17.40.23:6817/24736 >> 172.17.40.32:6811/21905 pipe(0x7fa840e38100 sd=149 pgs=89 cs=1 l=0).reader reading tag...
/var/log/ceph/osd.21.log:2011-03-03 08:35:29.930899 7fa826ded940 -- 172.17.40.23:6817/24736 >> 172.17.40.32:6811/21905 pipe(0x7fa840e38100 sd=149 pgs=89 cs=1 l=0).writer: state = 2 policy.server=0
/var/log/ceph/osd.21.log:2011-03-03 08:35:29.930921 7fa826ded940 -- 172.17.40.23:6817/24736 >> 172.17.40.32:6811/21905 pipe(0x7fa840e38100 sd=149 pgs=89 cs=1 l=0).write_ack 175
/var/log/ceph/osd.21.log:2011-03-03 08:35:29.930938 7fa826ded940 -- 172.17.40.23:6817/24736 >> 172.17.40.32:6811/21905 pipe(0x7fa840e38100 sd=149 pgs=89 cs=1 l=0).writer: state = 2 policy.server=0
/var/log/ceph/osd.21.log:2011-03-03 08:35:29.930948 7fa826ded940 -- 172.17.40.23:6817/24736 >> 172.17.40.32:6811/21905 pipe(0x7fa840e38100 sd=149 pgs=89 cs=1 l=0).writer sleeping
/var/log/ceph/osd.21.log:2011-03-03 08:35:29.930969 7fa8476e5940 -- 172.17.40.23:6817/24736 dispatch_entry pipe 0x7fa840e38100 dequeued 0x33397c0
/var/log/ceph/osd.21.log:2011-03-03 08:35:29.930983 7fa8476e5940 -- 172.17.40.23:6817/24736 <== osd83 172.17.40.32:6811/21905 175 ==== osd_ping(e7 as_of 7) v1 ==== 61+0+0 (1790669248 0 0) 0x33397c0 con 0x7fa840297d50
/var/log/ceph/osd.21.log:2011-03-03 08:35:29.930991 7fa8476e5940 osd21 7 heartbeat_dispatch 0x33397c0
/var/log/ceph/osd.21.log:2011-03-03 08:35:29.931005 7fa8476e5940 osd21 7 handle_osd_ping from osd83 got stat stat(2011-03-03 08:35:29.927476 oprate=0.135292 qlen=0 recent_qlen=0 rdlat=0 / 0 fshedin=0)
/var/log/ceph/osd.21.log:2011-03-03 08:35:29.931020 7fa8476e5940 osd21 7 _share_map_incoming osd83 172.17.40.32:6811/21905 7
/var/log/ceph/osd.21.log:2011-03-03 08:35:29.931036 7fa8476e5940 osd21 7 take_peer_stat peer osd83 stat(2011-03-03 08:35:29.927476 oprate=0.135292 qlen=0 recent_qlen=0 rdlat=0 / 0 fshedin=0)
/var/log/ceph/osd.21.log:2011-03-03 08:35:29.931052 7fa8476e5940 -- 172.17.40.23:6817/24736 dispatch_throttle_release 61 to dispatch throttler 61/35000000
/var/log/ceph/osd.21.log:2011-03-03 08:35:29.931063 7fa8476e5940 -- 172.17.40.23:6817/24736 done calling dispatch on 0x33397c0
/var/log/ceph/osd.21.log:2011-03-03 08:35:29.934258 7fa8466e3940 -- 172.17.40.23:6815/24736 >> 172.17.40.34:6789/0 pipe(0x7fa8400013a0 sd=13 pgs=2573 cs=1 l=1).reader couldn't read tag, Success
/var/log/ceph/osd.21.log:2011-03-03 08:35:29.934277 7fa8466e3940 -- 172.17.40.23:6815/24736 >> 172.17.40.34:6789/0 pipe(0x7fa8400013a0 sd=13 pgs=2573 cs=1 l=1).fault 0: Success
/var/log/ceph/osd.21.log:2011-03-03 08:35:29.934319 7fa8466e3940 -- 172.17.40.23:6815/24736 >> 172.17.40.34:6789/0 pipe(0x7fa8400013a0 sd=13 pgs=2573 cs=1 l=1).fault on lossy channel, failing
/var/log/ceph/osd.21.log:2011-03-03 08:35:29.934335 7fa8466e3940 -- 172.17.40.23:6815/24736 >> 172.17.40.34:6789/0 pipe(0x7fa8400013a0 sd=13 pgs=2573 cs=1 l=1).fail
/var/log/ceph/osd.21.log:2011-03-03 08:35:29.934351 7fa8466e3940 -- 172.17.40.23:6815/24736 >> 172.17.40.34:6789/0 pipe(0x7fa8400013a0 sd=13 pgs=2573 cs=1 l=1).stop
/var/log/ceph/osd.21.log:2011-03-03 08:35:29.934371 7fa8466e3940 -- 172.17.40.23:6815/24736 >> 172.17.40.34:6789/0 pipe(0x7fa8400013a0 sd=13 pgs=2573 cs=1 l=1).discard_queue
/var/log/ceph/osd.21.log:2011-03-03 08:35:29.934389 7fa8466e3940 -- 172.17.40.23:6815/24736 >> 172.17.40.34:6789/0 pipe(0x7fa8400013a0 sd=13 pgs=2573 cs=1 l=1). dequeued pipe 
/var/log/ceph/osd.21.log:2011-03-03 08:35:29.934404 7fa8466e3940 -- 172.17.40.23:6815/24736 >> 172.17.40.34:6789/0 pipe(0x7fa8400013a0 sd=13 pgs=2573 cs=1 l=1).  discard 0x7fa82843a390
--------
/var/log/ceph/osd.15.log:2011-03-03 08:35:29.912317 7fb3bfdd9940 -- 172.17.40.22:6823/27793 >> 172.17.40.25:6808/26003 pipe(0x1ee7a30 sd=32 pgs=59 cs=1 l=0).reader got envelope type=70 src osd34 front=61 data=0 off 0
/var/log/ceph/osd.15.log:2011-03-03 08:35:29.912332 7fb3bfdd9940 -- 172.17.40.22:6823/27793 >> 172.17.40.25:6808/26003 pipe(0x1ee7a30 sd=32 pgs=59 cs=1 l=0).reader wants 61 from dispatch throttler 0/35000000
/var/log/ceph/osd.15.log:2011-03-03 08:35:29.912365 7fb3bfdd9940 -- 172.17.40.22:6823/27793 >> 172.17.40.25:6808/26003 pipe(0x1ee7a30 sd=32 pgs=59 cs=1 l=0).reader got front 61
/var/log/ceph/osd.15.log:2011-03-03 08:35:29.912383 7fb3bfdd9940 -- 172.17.40.22:6823/27793 >> 172.17.40.25:6808/26003 pipe(0x1ee7a30 sd=32 pgs=59 cs=1 l=0).aborted = 0
/var/log/ceph/osd.15.log:2011-03-03 08:35:29.912396 7fb3bfdd9940 -- 172.17.40.22:6823/27793 >> 172.17.40.25:6808/26003 pipe(0x1ee7a30 sd=32 pgs=59 cs=1 l=0).reader got 61 + 0 + 0 byte message
/var/log/ceph/osd.15.log:2011-03-03 08:35:29.912422 7fb3bfdd9940 -- 172.17.40.22:6823/27793 >> 172.17.40.25:6808/26003 pipe(0x1ee7a30 sd=32 pgs=59 cs=1 l=0).reader got message 285 0x7fb3b4761210 osd_ping(e7 as_of 7) v1
/var/log/ceph/osd.15.log:2011-03-03 08:35:29.912442 7fb3bfdd9940 -- 172.17.40.22:6823/27793 >> 172.17.40.25:6808/26003 pipe(0x1ee7a30 sd=32 pgs=59 cs=1 l=0).queue_received queuing pipe
/var/log/ceph/osd.15.log:2011-03-03 08:35:29.912472 7fb3bfdd9940 -- 172.17.40.22:6823/27793 >> 172.17.40.25:6808/26003 pipe(0x1ee7a30 sd=32 pgs=59 cs=1 l=0).reader reading tag...
/var/log/ceph/osd.15.log:2011-03-03 08:35:29.912504 7fb3bd9b5940 -- 172.17.40.22:6823/27793 >> 172.17.40.25:6808/26003 pipe(0x1ee7a30 sd=32 pgs=59 cs=1 l=0).writer: state = 2 policy.server=0
/var/log/ceph/osd.15.log:2011-03-03 08:35:29.912529 7fb3bd9b5940 -- 172.17.40.22:6823/27793 >> 172.17.40.25:6808/26003 pipe(0x1ee7a30 sd=32 pgs=59 cs=1 l=0).write_ack 285
/var/log/ceph/osd.15.log:2011-03-03 08:35:29.912562 7fb3ca474940 -- 172.17.40.22:6823/27793 dispatch_entry pipe 0x1ee7a30 dequeued 0x7fb3b4761210
/var/log/ceph/osd.15.log:2011-03-03 08:35:29.912594 7fb3ca474940 -- 172.17.40.22:6823/27793 <== osd34 172.17.40.25:6808/26003 285 ==== osd_ping(e7 as_of 7) v1 ==== 61+0+0 (3933685369 0 0) 0x7fb3b4761210 con 0x1f05d80
/var/log/ceph/osd.15.log:2011-03-03 08:35:29.912606 7fb3ca474940 osd15 7 heartbeat_dispatch 0x7fb3b4761210
/var/log/ceph/osd.15.log:2011-03-03 08:35:29.912625 7fb3ca474940 osd15 7 handle_osd_ping from osd34 got stat stat(2011-03-03 08:35:29.911371 oprate=0 qlen=0 recent_qlen=0 rdlat=0 / 0 fshedin=0)
/var/log/ceph/osd.15.log:2011-03-03 08:35:29.912640 7fb3bd9b5940 -- 172.17.40.22:6823/27793 >> 172.17.40.25:6808/26003 pipe(0x1ee7a30 sd=32 pgs=59 cs=1 l=0).writer: state = 2 policy.server=0
/var/log/ceph/osd.15.log:2011-03-03 08:35:29.912653 7fb3bd9b5940 -- 172.17.40.22:6823/27793 >> 172.17.40.25:6808/26003 pipe(0x1ee7a30 sd=32 pgs=59 cs=1 l=0).writer sleeping
/var/log/ceph/osd.15.log:2011-03-03 08:35:29.912668 7fb3ca474940 osd15 7 _share_map_incoming osd34 172.17.40.25:6808/26003 7
/var/log/ceph/osd.15.log:2011-03-03 08:35:29.912686 7fb3ca474940 osd15 7 take_peer_stat peer osd34 stat(2011-03-03 08:35:29.911371 oprate=0 qlen=0 recent_qlen=0 rdlat=0 / 0 fshedin=0)
/var/log/ceph/osd.15.log:2011-03-03 08:35:29.912704 7fb3ca474940 -- 172.17.40.22:6823/27793 dispatch_throttle_release 61 to dispatch throttler 61/35000000
/var/log/ceph/osd.15.log:2011-03-03 08:35:29.912713 7fb3ca474940 -- 172.17.40.22:6823/27793 done calling dispatch on 0x7fb3b4761210
/var/log/ceph/osd.15.log:2011-03-03 08:35:29.932667 7fb3c9371940 -- 172.17.40.22:6823/27793 >> 172.17.40.27:6811/21226 pipe(0x1c14620 sd=13 pgs=45 cs=1 l=0).reader got MSG
/var/log/ceph/osd.15.log:2011-03-03 08:35:29.932698 7fb3c9371940 -- 172.17.40.22:6823/27793 >> 172.17.40.27:6811/21226 pipe(0x1c14620 sd=13 pgs=45 cs=1 l=0).reader got envelope type=70 src osd43 front=61 data=0 off 0
/var/log/ceph/osd.15.log:2011-03-03 08:35:29.932709 7fb3c9371940 -- 172.17.40.22:6823/27793 >> 172.17.40.27:6811/21226 pipe(0x1c14620 sd=13 pgs=45 cs=1 l=0).reader wants 61 from dispatch throttler 0/35000000
/var/log/ceph/osd.15.log:2011-03-03 08:35:29.932757 7fb3c9371940 -- 172.17.40.22:6823/27793 >> 172.17.40.27:6811/21226 pipe(0x1c14620 sd=13 pgs=45 cs=1 l=0).reader got front 61
/var/log/ceph/osd.15.log:2011-03-03 08:35:29.932769 7fb3c9371940 -- 172.17.40.22:6823/27793 >> 172.17.40.27:6811/21226 pipe(0x1c14620 sd=13 pgs=45 cs=1 l=0).aborted = 0
/var/log/ceph/osd.15.log:2011-03-03 08:35:29.932778 7fb3c9371940 -- 172.17.40.22:6823/27793 >> 172.17.40.27:6811/21226 pipe(0x1c14620 sd=13 pgs=45 cs=1 l=0).reader got 61 + 0 + 0 byte message
/var/log/ceph/osd.15.log:2011-03-03 08:35:29.932797 7fb3c9371940 -- 172.17.40.22:6823/27793 >> 172.17.40.27:6811/21226 pipe(0x1c14620 sd=13 pgs=45 cs=1 l=0).reader got message 181 0x251fff0 osd_ping(e7 as_of 7) v1
/var/log/ceph/osd.15.log:2011-03-03 08:35:29.932813 7fb3c9371940 -- 172.17.40.22:6823/27793 >> 172.17.40.27:6811/21226 pipe(0x1c14620 sd=13 pgs=45 cs=1 l=0).queue_received queuing pipe
/var/log/ceph/osd.15.log:2011-03-03 08:35:29.932831 7fb3c9371940 -- 172.17.40.22:6823/27793 >> 172.17.40.27:6811/21226 pipe(0x1c14620 sd=13 pgs=45 cs=1 l=0).reader reading tag...
/var/log/ceph/osd.15.log:2011-03-03 08:35:29.932844 7fb3ca474940 -- 172.17.40.22:6823/27793 dispatch_entry pipe 0x1c14620 dequeued 0x251fff0
/var/log/ceph/osd.15.log:2011-03-03 08:35:29.932870 7fb3ca474940 -- 172.17.40.22:6823/27793 <== osd43 172.17.40.27:6811/21226 181 ==== osd_ping(e7 as_of 7) v1 ==== 61+0+0 (3987907583 0 0) 0x251fff0 con 0x1bded80
/var/log/ceph/osd.15.log:2011-03-03 08:35:29.932882 7fb3ca474940 osd15 7 heartbeat_dispatch 0x251fff0
/var/log/ceph/osd.15.log:2011-03-03 08:35:29.932901 7fb3ca474940 osd15 7 handle_osd_ping from osd43 got stat stat(2011-03-03 08:35:29.931299 oprate=0 qlen=0 recent_qlen=0 rdlat=0 / 0 fshedin=0)
/var/log/ceph/osd.15.log:2011-03-03 08:35:29.932919 7fb3ca474940 osd15 7 _share_map_incoming osd43 172.17.40.27:6811/21226 7
/var/log/ceph/osd.15.log:2011-03-03 08:35:29.932942 7fb3ca474940 osd15 7 take_peer_stat peer osd43 stat(2011-03-03 08:35:29.931299 oprate=0 qlen=0 recent_qlen=0 rdlat=0 / 0 fshedin=0)
/var/log/ceph/osd.15.log:2011-03-03 08:35:29.932963 7fb3ca474940 -- 172.17.40.22:6823/27793 dispatch_throttle_release 61 to dispatch throttler 61/35000000
/var/log/ceph/osd.15.log:2011-03-03 08:35:29.932976 7fb3ca474940 -- 172.17.40.22:6823/27793 done calling dispatch on 0x251fff0
/var/log/ceph/osd.15.log:2011-03-03 08:35:29.933030 7fb3c0eea940 -- 172.17.40.22:6823/27793 >> 172.17.40.27:6811/21226 pipe(0x1c14620 sd=13 pgs=45 cs=1 l=0).writer: state = 2 policy.server=0
/var/log/ceph/osd.15.log:2011-03-03 08:35:29.933049 7fb3c0eea940 -- 172.17.40.22:6823/27793 >> 172.17.40.27:6811/21226 pipe(0x1c14620 sd=13 pgs=45 cs=1 l=0).write_ack 181
/var/log/ceph/osd.15.log:2011-03-03 08:35:29.933078 7fb3c0eea940 -- 172.17.40.22:6823/27793 >> 172.17.40.27:6811/21226 pipe(0x1c14620 sd=13 pgs=45 cs=1 l=0).writer: state = 2 policy.server=0
/var/log/ceph/osd.15.log:2011-03-03 08:35:29.933091 7fb3c0eea940 -- 172.17.40.22:6823/27793 >> 172.17.40.27:6811/21226 pipe(0x1c14620 sd=13 pgs=45 cs=1 l=0).writer sleeping
/var/log/ceph/osd.15.log:2011-03-03 08:35:29.933243 7fb3c9472940 -- 172.17.40.22:6821/27793 >> 172.17.40.34:6789/0 pipe(0x7fb3c4001270 sd=12 pgs=2580 cs=1 l=1).reader couldn't read tag, Success
/var/log/ceph/osd.15.log:2011-03-03 08:35:29.933263 7fb3c9472940 -- 172.17.40.22:6821/27793 >> 172.17.40.34:6789/0 pipe(0x7fb3c4001270 sd=12 pgs=2580 cs=1 l=1).fault 0: Success
/var/log/ceph/osd.15.log:2011-03-03 08:35:29.933286 7fb3c9472940 -- 172.17.40.22:6821/27793 >> 172.17.40.34:6789/0 pipe(0x7fb3c4001270 sd=12 pgs=2580 cs=1 l=1).fault on lossy channel, failing
/var/log/ceph/osd.15.log:2011-03-03 08:35:29.933313 7fb3c9472940 -- 172.17.40.22:6821/27793 >> 172.17.40.34:6789/0 pipe(0x7fb3c4001270 sd=12 pgs=2580 cs=1 l=1).fail
/var/log/ceph/osd.15.log:2011-03-03 08:35:29.933349 7fb3c9472940 -- 172.17.40.22:6821/27793 >> 172.17.40.34:6789/0 pipe(0x7fb3c4001270 sd=12 pgs=2580 cs=1 l=1).stop
/var/log/ceph/osd.15.log:2011-03-03 08:35:29.933369 7fb3c9472940 -- 172.17.40.22:6821/27793 >> 172.17.40.34:6789/0 pipe(0x7fb3c4001270 sd=12 pgs=2580 cs=1 l=1).discard_queue
/var/log/ceph/osd.15.log:2011-03-03 08:35:29.933391 7fb3c9472940 -- 172.17.40.22:6821/27793 >> 172.17.40.34:6789/0 pipe(0x7fb3c4001270 sd=12 pgs=2580 cs=1 l=1). dequeued pipe 
/var/log/ceph/osd.15.log:2011-03-03 08:35:29.933411 7fb3c9472940 -- 172.17.40.22:6821/27793 >> 172.17.40.34:6789/0 pipe(0x7fb3c4001270 sd=12 pgs=2580 cs=1 l=1).  discard 0x7fb3c4ccc890
/var/log/ceph/osd.15.log:2011-03-03 08:35:29.933436 7fb3d545c940 -- 172.17.40.22:6821/27793 >> 172.17.40.34:6789/0 pipe(0x7fb3c4001270 sd=12 pgs=2580 cs=1 l=1).do_sendmail short write did 195207, still have 91335
--------
/var/log/ceph/osd.87.log:2011-03-03 08:35:29.908735 7f28c9208940 -- 172.17.40.32:6821/22338 --> mon0 172.17.40.34:6789/0 -- pg_stats(1616 pgs v 7) v1 -- ?+0 0x7f28bd1cb940
/var/log/ceph/osd.87.log:2011-03-03 08:35:29.908767 7f28c9208940 -- 172.17.40.32:6821/22338 submit_message pg_stats(1616 pgs v 7) v1 remote, 172.17.40.34:6789/0, have pipe.
/var/log/ceph/osd.87.log:2011-03-03 08:35:29.913351 7f28b95f1940 -- 172.17.40.32:6823/22338 >> 172.17.40.25:6817/26313 pipe(0x1a1e2d0 sd=37 pgs=63 cs=1 l=0).reader got MSG
/var/log/ceph/osd.87.log:2011-03-03 08:35:29.913386 7f28b95f1940 -- 172.17.40.32:6823/22338 >> 172.17.40.25:6817/26313 pipe(0x1a1e2d0 sd=37 pgs=63 cs=1 l=0).reader got envelope type=70 src osd37 front=61 data=0 off 0
/var/log/ceph/osd.87.log:2011-03-03 08:35:29.913396 7f28b95f1940 -- 172.17.40.32:6823/22338 >> 172.17.40.25:6817/26313 pipe(0x1a1e2d0 sd=37 pgs=63 cs=1 l=0).reader wants 61 from dispatch throttler 0/35000000
/var/log/ceph/osd.87.log:2011-03-03 08:35:29.913410 7f28b95f1940 -- 172.17.40.32:6823/22338 >> 172.17.40.25:6817/26313 pipe(0x1a1e2d0 sd=37 pgs=63 cs=1 l=0).reader got front 61
/var/log/ceph/osd.87.log:2011-03-03 08:35:29.913421 7f28b95f1940 -- 172.17.40.32:6823/22338 >> 172.17.40.25:6817/26313 pipe(0x1a1e2d0 sd=37 pgs=63 cs=1 l=0).aborted = 0
/var/log/ceph/osd.87.log:2011-03-03 08:35:29.913430 7f28b95f1940 -- 172.17.40.32:6823/22338 >> 172.17.40.25:6817/26313 pipe(0x1a1e2d0 sd=37 pgs=63 cs=1 l=0).reader got 61 + 0 + 0 byte message
/var/log/ceph/osd.87.log:2011-03-03 08:35:29.913449 7f28b95f1940 -- 172.17.40.32:6823/22338 >> 172.17.40.25:6817/26313 pipe(0x1a1e2d0 sd=37 pgs=63 cs=1 l=0).reader got message 293 0x7f28bd1f2200 osd_ping(e7 as_of 7) v1
/var/log/ceph/osd.87.log:2011-03-03 08:35:29.913464 7f28b95f1940 -- 172.17.40.32:6823/22338 >> 172.17.40.25:6817/26313 pipe(0x1a1e2d0 sd=37 pgs=63 cs=1 l=0).queue_received queuing pipe
/var/log/ceph/osd.87.log:2011-03-03 08:35:29.913484 7f28b95f1940 -- 172.17.40.32:6823/22338 >> 172.17.40.25:6817/26313 pipe(0x1a1e2d0 sd=37 pgs=63 cs=1 l=0).reader reading tag...
/var/log/ceph/osd.87.log:2011-03-03 08:35:29.913525 7f28c29fb940 -- 172.17.40.32:6823/22338 dispatch_entry pipe 0x1a1e2d0 dequeued 0x7f28bd1f2200
/var/log/ceph/osd.87.log:2011-03-03 08:35:29.913554 7f28c29fb940 -- 172.17.40.32:6823/22338 <== osd37 172.17.40.25:6817/26313 293 ==== osd_ping(e7 as_of 7) v1 ==== 61+0+0 (1171319859 0 0) 0x7f28bd1f2200 con 0x19cc9c0
/var/log/ceph/osd.87.log:2011-03-03 08:35:29.913568 7f28c29fb940 osd87 7 heartbeat_dispatch 0x7f28bd1f2200
/var/log/ceph/osd.87.log:2011-03-03 08:35:29.913590 7f28c29fb940 osd87 7 handle_osd_ping from osd37 got stat stat(2011-03-03 08:35:29.906027 oprate=0 qlen=0 recent_qlen=0 rdlat=0 / 0 fshedin=0)
/var/log/ceph/osd.87.log:2011-03-03 08:35:29.913613 7f28b7ad6940 -- 172.17.40.32:6823/22338 >> 172.17.40.25:6817/26313 pipe(0x1a1e2d0 sd=37 pgs=63 cs=1 l=0).writer: state = 2 policy.server=0
/var/log/ceph/osd.87.log:2011-03-03 08:35:29.913633 7f28b7ad6940 -- 172.17.40.32:6823/22338 >> 172.17.40.25:6817/26313 pipe(0x1a1e2d0 sd=37 pgs=63 cs=1 l=0).write_ack 293
/var/log/ceph/osd.87.log:2011-03-03 08:35:29.913652 7f28c29fb940 osd87 7 _share_map_incoming osd37 172.17.40.25:6817/26313 7
/var/log/ceph/osd.87.log:2011-03-03 08:35:29.913677 7f28b7ad6940 -- 172.17.40.32:6823/22338 >> 172.17.40.25:6817/26313 pipe(0x1a1e2d0 sd=37 pgs=63 cs=1 l=0).writer: state = 2 policy.server=0
/var/log/ceph/osd.87.log:2011-03-03 08:35:29.913690 7f28b7ad6940 -- 172.17.40.32:6823/22338 >> 172.17.40.25:6817/26313 pipe(0x1a1e2d0 sd=37 pgs=63 cs=1 l=0).writer sleeping
/var/log/ceph/osd.87.log:2011-03-03 08:35:29.913707 7f28c29fb940 osd87 7 take_peer_stat peer osd37 stat(2011-03-03 08:35:29.906027 oprate=0 qlen=0 recent_qlen=0 rdlat=0 / 0 fshedin=0)
/var/log/ceph/osd.87.log:2011-03-03 08:35:29.913729 7f28c29fb940 -- 172.17.40.32:6823/22338 dispatch_throttle_release 61 to dispatch throttler 61/35000000
/var/log/ceph/osd.87.log:2011-03-03 08:35:29.913738 7f28c29fb940 -- 172.17.40.32:6823/22338 done calling dispatch on 0x7f28bd1f2200
/var/log/ceph/osd.87.log:2011-03-03 08:35:29.916731 7f28b0b67940 -- 172.17.40.32:6823/22338 >> 172.17.40.25:6808/26003 pipe(0x1a8b130 sd=91 pgs=63 cs=1 l=0).reader got MSG
/var/log/ceph/osd.87.log:2011-03-03 08:35:29.916749 7f28b0b67940 -- 172.17.40.32:6823/22338 >> 172.17.40.25:6808/26003 pipe(0x1a8b130 sd=91 pgs=63 cs=1 l=0).reader got envelope type=70 src osd34 front=61 data=0 off 0
/var/log/ceph/osd.87.log:2011-03-03 08:35:29.916760 7f28b0b67940 -- 172.17.40.32:6823/22338 >> 172.17.40.25:6808/26003 pipe(0x1a8b130 sd=91 pgs=63 cs=1 l=0).reader wants 61 from dispatch throttler 0/35000000
/var/log/ceph/osd.87.log:2011-03-03 08:35:29.916773 7f28b0b67940 -- 172.17.40.32:6823/22338 >> 172.17.40.25:6808/26003 pipe(0x1a8b130 sd=91 pgs=63 cs=1 l=0).reader got front 61
/var/log/ceph/osd.87.log:2011-03-03 08:35:29.916787 7f28b0b67940 -- 172.17.40.32:6823/22338 >> 172.17.40.25:6808/26003 pipe(0x1a8b130 sd=91 pgs=63 cs=1 l=0).aborted = 0
/var/log/ceph/osd.87.log:2011-03-03 08:35:29.916816 7f28b0b67940 -- 172.17.40.32:6823/22338 >> 172.17.40.25:6808/26003 pipe(0x1a8b130 sd=91 pgs=63 cs=1 l=0).reader got 61 + 0 + 0 byte message
/var/log/ceph/osd.87.log:2011-03-03 08:35:29.916836 7f28b0b67940 -- 172.17.40.32:6823/22338 >> 172.17.40.25:6808/26003 pipe(0x1a8b130 sd=91 pgs=63 cs=1 l=0).reader got message 283 0x7f28ac160cc0 osd_ping(e7 as_of 7) v1
/var/log/ceph/osd.87.log:2011-03-03 08:35:29.916852 7f28b0b67940 -- 172.17.40.32:6823/22338 >> 172.17.40.25:6808/26003 pipe(0x1a8b130 sd=91 pgs=63 cs=1 l=0).queue_received queuing pipe
/var/log/ceph/osd.87.log:2011-03-03 08:35:29.916868 7f28b0b67940 -- 172.17.40.32:6823/22338 >> 172.17.40.25:6808/26003 pipe(0x1a8b130 sd=91 pgs=63 cs=1 l=0).reader reading tag...
/var/log/ceph/osd.87.log:2011-03-03 08:35:29.916894 7f28c29fb940 -- 172.17.40.32:6823/22338 dispatch_entry pipe 0x1a8b130 dequeued 0x7f28ac160cc0
/var/log/ceph/osd.87.log:2011-03-03 08:35:29.916920 7f28c29fb940 -- 172.17.40.32:6823/22338 <== osd34 172.17.40.25:6808/26003 283 ==== osd_ping(e7 as_of 7) v1 ==== 61+0+0 (3933685369 0 0) 0x7f28ac160cc0 con 0x17bdd10
/var/log/ceph/osd.87.log:2011-03-03 08:35:29.916935 7f28c29fb940 osd87 7 heartbeat_dispatch 0x7f28ac160cc0
/var/log/ceph/osd.87.log:2011-03-03 08:35:29.916957 7f28c29fb940 osd87 7 handle_osd_ping from osd34 got stat stat(2011-03-03 08:35:29.911371 oprate=0 qlen=0 recent_qlen=0 rdlat=0 / 0 fshedin=0)
/var/log/ceph/osd.87.log:2011-03-03 08:35:29.916982 7f28b7bd7940 -- 172.17.40.32:6823/22338 >> 172.17.40.25:6808/26003 pipe(0x1a8b130 sd=91 pgs=63 cs=1 l=0).writer: state = 2 policy.server=0
/var/log/ceph/osd.87.log:2011-03-03 08:35:29.917003 7f28b7bd7940 -- 172.17.40.32:6823/22338 >> 172.17.40.25:6808/26003 pipe(0x1a8b130 sd=91 pgs=63 cs=1 l=0).write_ack 283
/var/log/ceph/osd.87.log:2011-03-03 08:35:29.917029 7f28c29fb940 osd87 7 _share_map_incoming osd34 172.17.40.25:6808/26003 7
/var/log/ceph/osd.87.log:2011-03-03 08:35:29.917095 7f28b7bd7940 -- 172.17.40.32:6823/22338 >> 172.17.40.25:6808/26003 pipe(0x1a8b130 sd=91 pgs=63 cs=1 l=0).writer: state = 2 policy.server=0
/var/log/ceph/osd.87.log:2011-03-03 08:35:29.917113 7f28b7bd7940 -- 172.17.40.32:6823/22338 >> 172.17.40.25:6808/26003 pipe(0x1a8b130 sd=91 pgs=63 cs=1 l=0).writer sleeping
/var/log/ceph/osd.87.log:2011-03-03 08:35:29.917197 7f28c29fb940 osd87 7 take_peer_stat peer osd34 stat(2011-03-03 08:35:29.911371 oprate=0 qlen=0 recent_qlen=0 rdlat=0 / 0 fshedin=0)
/var/log/ceph/osd.87.log:2011-03-03 08:35:29.917220 7f28c29fb940 -- 172.17.40.32:6823/22338 dispatch_throttle_release 61 to dispatch throttler 61/35000000
/var/log/ceph/osd.87.log:2011-03-03 08:35:29.917233 7f28c29fb940 -- 172.17.40.32:6823/22338 done calling dispatch on 0x7f28ac160cc0
/var/log/ceph/osd.87.log:2011-03-03 08:35:29.934853 7f28c19f9940 -- 172.17.40.32:6821/22338 >> 172.17.40.34:6789/0 pipe(0x1184ce0 sd=13 pgs=2615 cs=1 l=1).reader couldn't read tag, Success
/var/log/ceph/osd.87.log:2011-03-03 08:35:29.934880 7f28c19f9940 -- 172.17.40.32:6821/22338 >> 172.17.40.34:6789/0 pipe(0x1184ce0 sd=13 pgs=2615 cs=1 l=1).fault 0: Success
/var/log/ceph/osd.87.log:2011-03-03 08:35:29.934894 7f28c19f9940 -- 172.17.40.32:6821/22338 >> 172.17.40.34:6789/0 pipe(0x1184ce0 sd=13 pgs=2615 cs=1 l=1).fault on lossy channel, failing
/var/log/ceph/osd.87.log:2011-03-03 08:35:29.934906 7f28c19f9940 -- 172.17.40.32:6821/22338 >> 172.17.40.34:6789/0 pipe(0x1184ce0 sd=13 pgs=2615 cs=1 l=1).fail
/var/log/ceph/osd.87.log:2011-03-03 08:35:29.934917 7f28c19f9940 -- 172.17.40.32:6821/22338 >> 172.17.40.34:6789/0 pipe(0x1184ce0 sd=13 pgs=2615 cs=1 l=1).stop
/var/log/ceph/osd.87.log:2011-03-03 08:35:29.934934 7f28c18f8940 -- 172.17.40.32:6821/22338 >> 172.17.40.34:6789/0 pipe(0x1184ce0 sd=13 pgs=2615 cs=1 l=1).do_sendmail short write did 133455, still have 74755
--------
/var/log/ceph/osd.1.log:2011-03-03 08:35:30.079134 7ff76aaaa940 -- 172.17.40.21:6805/22667 >> 172.17.40.33:6808/12863 pipe(0x2c0ef30 sd=156 pgs=86 cs=1 l=0).aborted = 0
/var/log/ceph/osd.1.log:2011-03-03 08:35:30.079145 7ff76aaaa940 -- 172.17.40.21:6805/22667 >> 172.17.40.33:6808/12863 pipe(0x2c0ef30 sd=156 pgs=86 cs=1 l=0).reader got 61 + 0 + 0 byte message
/var/log/ceph/osd.1.log:2011-03-03 08:35:30.079166 7ff77a1e1940 -- 172.17.40.21:6805/22667 >> 172.17.40.31:6808/23718 pipe(0x3405a20 sd=24 pgs=55 cs=1 l=0).reader got envelope type=70 src osd74 front=61 data=0 off 0
/var/log/ceph/osd.1.log:2011-03-03 08:35:30.079185 7ff77a1e1940 -- 172.17.40.21:6805/22667 >> 172.17.40.31:6808/23718 pipe(0x3405a20 sd=24 pgs=55 cs=1 l=0).reader wants 61 from dispatch throttler 488/35000000
/var/log/ceph/osd.1.log:2011-03-03 08:35:30.079201 7ff77a1e1940 -- 172.17.40.21:6805/22667 >> 172.17.40.31:6808/23718 pipe(0x3405a20 sd=24 pgs=55 cs=1 l=0).reader got front 61
/var/log/ceph/osd.1.log:2011-03-03 08:35:30.079215 7ff77a1e1940 -- 172.17.40.21:6805/22667 >> 172.17.40.31:6808/23718 pipe(0x3405a20 sd=24 pgs=55 cs=1 l=0).aborted = 0
/var/log/ceph/osd.1.log:2011-03-03 08:35:30.079225 7ff77a1e1940 -- 172.17.40.21:6805/22667 >> 172.17.40.31:6808/23718 pipe(0x3405a20 sd=24 pgs=55 cs=1 l=0).reader got 61 + 0 + 0 byte message
/var/log/ceph/osd.1.log:2011-03-03 08:35:30.079244 7ff77a1e1940 -- 172.17.40.21:6805/22667 >> 172.17.40.31:6808/23718 pipe(0x3405a20 sd=24 pgs=55 cs=1 l=0).reader got message 307 0x38e9050 osd_ping(e7 as_of 7) v1
/var/log/ceph/osd.1.log:2011-03-03 08:35:30.079266 7ff77befe940 -- 172.17.40.21:6805/22667 >> 172.17.40.31:6808/23718 pipe(0x3405a20 sd=24 pgs=55 cs=1 l=0).writer: state = 2 policy.server=0
/var/log/ceph/osd.1.log:2011-03-03 08:35:30.079278 7ff77befe940 -- 172.17.40.21:6805/22667 >> 172.17.40.31:6808/23718 pipe(0x3405a20 sd=24 pgs=55 cs=1 l=0).write_ack 307
/var/log/ceph/osd.1.log:2011-03-03 08:35:30.079292 7ff77befe940 -- 172.17.40.21:6805/22667 >> 172.17.40.31:6808/23718 pipe(0x3405a20 sd=24 pgs=55 cs=1 l=0).writer: state = 2 policy.server=0
/var/log/ceph/osd.1.log:2011-03-03 08:35:30.079303 7ff77befe940 -- 172.17.40.21:6805/22667 >> 172.17.40.31:6808/23718 pipe(0x3405a20 sd=24 pgs=55 cs=1 l=0).writer sleeping
/var/log/ceph/osd.1.log:2011-03-03 08:35:30.079317 7ff77afef940 -- 172.17.40.21:6805/22667 >> 172.17.40.24:6823/27325 pipe(0x340fcd0 sd=17 pgs=109 cs=1 l=0).reader got MSG
/var/log/ceph/osd.1.log:2011-03-03 08:35:30.079339 7ff77b1f1940 -- 172.17.40.21:6805/22667 >> 172.17.40.32:6802/21594 pipe(0x31c97f0 sd=27 pgs=46 cs=1 l=0).reader got envelope type=70 src osd80 front=61 data=0 off 0
/var/log/ceph/osd.1.log:2011-03-03 08:35:30.079357 7ff77b1f1940 -- 172.17.40.21:6805/22667 >> 172.17.40.32:6802/21594 pipe(0x31c97f0 sd=27 pgs=46 cs=1 l=0).reader wants 61 from dispatch throttler 549/35000000
/var/log/ceph/osd.1.log:2011-03-03 08:35:30.079374 7ff77b1f1940 -- 172.17.40.21:6805/22667 >> 172.17.40.32:6802/21594 pipe(0x31c97f0 sd=27 pgs=46 cs=1 l=0).reader got front 61
/var/log/ceph/osd.1.log:2011-03-03 08:35:30.079387 7ff77b1f1940 -- 172.17.40.21:6805/22667 >> 172.17.40.32:6802/21594 pipe(0x31c97f0 sd=27 pgs=46 cs=1 l=0).aborted = 0
/var/log/ceph/osd.1.log:2011-03-03 08:35:30.079398 7ff77b1f1940 -- 172.17.40.21:6805/22667 >> 172.17.40.32:6802/21594 pipe(0x31c97f0 sd=27 pgs=46 cs=1 l=0).reader got 61 + 0 + 0 byte message
/var/log/ceph/osd.1.log:2011-03-03 08:35:30.079415 7ff7799d9940 -- 172.17.40.21:6805/22667 >> 172.17.40.32:6817/22123 pipe(0x7ff77c589230 sd=30 pgs=8 cs=1 l=0).reader got MSG
/var/log/ceph/osd.1.log:2011-03-03 08:35:30.079434 7ff7799d9940 -- 172.17.40.21:6805/22667 >> 172.17.40.32:6817/22123 pipe(0x7ff77c589230 sd=30 pgs=8 cs=1 l=0).reader got envelope type=70 src osd85 front=61 data=0 off 0
/var/log/ceph/osd.1.log:2011-03-03 08:35:30.079445 7ff7799d9940 -- 172.17.40.21:6805/22667 >> 172.17.40.32:6817/22123 pipe(0x7ff77c589230 sd=30 pgs=8 cs=1 l=0).reader wants 61 from dispatch throttler 610/35000000
/var/log/ceph/osd.1.log:2011-03-03 08:35:30.079472 7ff7799d9940 -- 172.17.40.21:6805/22667 >> 172.17.40.32:6817/22123 pipe(0x7ff77c589230 sd=30 pgs=8 cs=1 l=0).reader got front 61
/var/log/ceph/osd.1.log:2011-03-03 08:35:30.079485 7ff7799d9940 -- 172.17.40.21:6805/22667 >> 172.17.40.32:6817/22123 pipe(0x7ff77c589230 sd=30 pgs=8 cs=1 l=0).aborted = 0
/var/log/ceph/osd.1.log:2011-03-03 08:35:30.079494 7ff7799d9940 -- 172.17.40.21:6805/22667 >> 172.17.40.32:6817/22123 pipe(0x7ff77c589230 sd=30 pgs=8 cs=1 l=0).reader got 61 + 0 + 0 byte message
/var/log/ceph/osd.1.log:2011-03-03 08:35:30.079512 7ff7799d9940 -- 172.17.40.21:6805/22667 >> 172.17.40.32:6817/22123 pipe(0x7ff77c589230 sd=30 pgs=8 cs=1 l=0).reader got message 289 0x39a6220 osd_ping(e7 as_of 7) v1
/var/log/ceph/osd.1.log:2011-03-03 08:35:30.079528 7ff77a5e5940 -- 172.17.40.21:6805/22667 >> 172.17.40.32:6817/22123 pipe(0x7ff77c589230 sd=30 pgs=8 cs=1 l=0).writer: state = 2 policy.server=0
/var/log/ceph/osd.1.log:2011-03-03 08:35:30.079538 7ff77a5e5940 -- 172.17.40.21:6805/22667 >> 172.17.40.32:6817/22123 pipe(0x7ff77c589230 sd=30 pgs=8 cs=1 l=0).write_ack 289
/var/log/ceph/osd.1.log:2011-03-03 08:35:30.079551 7ff77a5e5940 -- 172.17.40.21:6805/22667 >> 172.17.40.32:6817/22123 pipe(0x7ff77c589230 sd=30 pgs=8 cs=1 l=0).writer: state = 2 policy.server=0
/var/log/ceph/osd.1.log:2011-03-03 08:35:30.079565 7ff77a5e5940 -- 172.17.40.21:6805/22667 >> 172.17.40.32:6817/22123 pipe(0x7ff77c589230 sd=30 pgs=8 cs=1 l=0).writer sleeping
/var/log/ceph/osd.1.log:2011-03-03 08:35:30.079578 7ff766464940 -- 172.17.40.21:6804/22667 >> 172.17.40.33:6801/12649 pipe(0x7ff77d7f6a90 sd=155 pgs=67 cs=1 l=0).write_ack 423
/var/log/ceph/osd.1.log:2011-03-03 08:35:30.079597 7ff766666940 -- 172.17.40.21:6804/22667 >> 172.17.40.33:6801/12649 pipe(0x7ff77d7f6a90 sd=155 pgs=67 cs=1 l=0).reader got message 424 0x7ff7705b5e60 pg_info(1 pgs e7) v1
/var/log/ceph/osd.1.log:2011-03-03 08:35:30.079619 7ff767f7f940 -- 172.17.40.21:6805/22667 >> 172.17.40.24:6814/27015 pipe(0x7ff77c74ea90 sd=141 pgs=84 cs=1 l=0).reader got MSG
/var/log/ceph/osd.1.log:2011-03-03 08:35:30.079639 7ff783751940 -- 172.17.40.21:6803/22667 >> 172.17.40.34:6789/0 pipe(0x7ff77c000ef0 sd=13 pgs=2582 cs=1 l=1).fault on lossy channel, failing
/var/log/ceph/osd.1.log:2011-03-03 08:35:30.079654 7ff783751940 -- 172.17.40.21:6803/22667 >> 172.17.40.34:6789/0 pipe(0x7ff77c000ef0 sd=13 pgs=2582 cs=1 l=1).fail
/var/log/ceph/osd.1.log:2011-03-03 08:35:30.079663 7ff783751940 -- 172.17.40.21:6803/22667 >> 172.17.40.34:6789/0 pipe(0x7ff77c000ef0 sd=13 pgs=2582 cs=1 l=1).stop
/var/log/ceph/osd.1.log:2011-03-03 08:35:30.079673 7ff783751940 -- 172.17.40.21:6803/22667 >> 172.17.40.34:6789/0 pipe(0x7ff77c000ef0 sd=13 pgs=2582 cs=1 l=1).discard_queue
/var/log/ceph/osd.1.log:2011-03-03 08:35:30.079683 7ff783751940 -- 172.17.40.21:6803/22667 >> 172.17.40.34:6789/0 pipe(0x7ff77c000ef0 sd=13 pgs=2582 cs=1 l=1). dequeued pipe 
/var/log/ceph/osd.1.log:2011-03-03 08:35:30.079694 7ff783751940 -- 172.17.40.21:6803/22667 >> 172.17.40.34:6789/0 pipe(0x7ff77c000ef0 sd=13 pgs=2582 cs=1 l=1).  discard 0x7ff7702f91f0
/var/log/ceph/osd.1.log:2011-03-03 08:35:30.080250 7ff783751940 -- 172.17.40.21:6803/22667 >> 172.17.40.34:6789/0 pipe(0x7ff77c000ef0 sd=13 pgs=2582 cs=1 l=1).  discard 0x7ff77023ef30
/var/log/ceph/osd.1.log:2011-03-03 08:35:30.080810 7ff783751940 -- 172.17.40.21:6803/22667 >> 172.17.40.34:6789/0 pipe(0x7ff77c000ef0 sd=13 pgs=2582 cs=1 l=1).  discard 0x7ff770371050
/var/log/ceph/osd.1.log:2011-03-03 08:35:30.081353 7ff783751940 -- 172.17.40.21:6803/22667 >> 172.17.40.34:6789/0 pipe(0x7ff77c000ef0 sd=13 pgs=2582 cs=1 l=1).  discard 0x7ff770402050
/var/log/ceph/osd.1.log:2011-03-03 08:35:30.081883 7ff783751940 -- 172.17.40.21:6803/22667 >> 172.17.40.34:6789/0 pipe(0x7ff77c000ef0 sd=13 pgs=2582 cs=1 l=1).  discard 0x7ff771282e90
/var/log/ceph/osd.1.log:2011-03-03 08:35:30.082366 7ff783751940 -- 172.17.40.21:6803/22667 >> 172.17.40.34:6789/0 pipe(0x7ff77c000ef0 sd=13 pgs=2582 cs=1 l=1).  discard 0x7ff7712e1050
/var/log/ceph/osd.1.log:2011-03-03 08:35:30.082901 7ff783751940 -- 172.17.40.21:6803/22667 >> 172.17.40.34:6789/0 pipe(0x7ff77c000ef0 sd=13 pgs=2582 cs=1 l=1).  discard 0x7ff770cfc050
/var/log/ceph/osd.1.log:2011-03-03 08:35:30.083368 7ff783751940 -- 172.17.40.21:6803/22667 >> 172.17.40.34:6789/0 pipe(0x7ff77c000ef0 sd=13 pgs=2582 cs=1 l=1).  discard 0x7ff770c40910
/var/log/ceph/osd.1.log:2011-03-03 08:35:30.083855 7ff783751940 -- 172.17.40.21:6803/22667 >> 172.17.40.34:6789/0 pipe(0x7ff77c000ef0 sd=13 pgs=2582 cs=1 l=1).  discard 0x7ff77007dd40
/var/log/ceph/osd.1.log:2011-03-03 08:35:30.084407 7ff783751940 -- 172.17.40.21:6803/22667 >> 172.17.40.34:6789/0 pipe(0x7ff77c000ef0 sd=13 pgs=2582 cs=1 l=1).  discard 0x7ff770f56010
/var/log/ceph/osd.1.log:2011-03-03 08:35:30.085122 7ff783650940 -- 172.17.40.21:6803/22667 >> 172.17.40.34:6789/0 pipe(0x7ff77c000ef0 sd=13 pgs=2582 cs=1 l=1).do_sendmail short write did 205176, still have 53378
/var/log/ceph/osd.1.log:2011-03-03 08:35:30.085146 7ff784f54940 -- 172.17.40.21:6804/22667 dispatch_throttle_release 316 to dispatch throttler 632/35000000
/var/log/ceph/osd.1.log:2011-03-03 08:35:30.085161 7ff784f54940 -- 172.17.40.21:6804/22667 done calling dispatch on 0x7ff7706c4590
--------
/var/log/ceph/osd.88.log:2011-03-03 08:35:45.509143 7fbd1ba60940 -- 172.17.40.33:6802/12649 done calling dispatch on 0x29ccab0
/var/log/ceph/osd.88.log:2011-03-03 08:35:45.521556 7fbd06dcd940 -- 172.17.40.33:6802/12649 >> 172.17.40.32:6814/22015 pipe(0x23aa8e0 sd=81 pgs=103 cs=1 l=0).reader got MSG
/var/log/ceph/osd.88.log:2011-03-03 08:35:45.521593 7fbd06dcd940 -- 172.17.40.33:6802/12649 >> 172.17.40.32:6814/22015 pipe(0x23aa8e0 sd=81 pgs=103 cs=1 l=0).reader got envelope type=70 src osd84 front=61 data=0 off 0
/var/log/ceph/osd.88.log:2011-03-03 08:35:45.521603 7fbd06dcd940 -- 172.17.40.33:6802/12649 >> 172.17.40.32:6814/22015 pipe(0x23aa8e0 sd=81 pgs=103 cs=1 l=0).reader wants 61 from dispatch throttler 0/35000000
/var/log/ceph/osd.88.log:2011-03-03 08:35:45.521617 7fbd06dcd940 -- 172.17.40.33:6802/12649 >> 172.17.40.32:6814/22015 pipe(0x23aa8e0 sd=81 pgs=103 cs=1 l=0).reader got front 61
/var/log/ceph/osd.88.log:2011-03-03 08:35:45.521629 7fbd06dcd940 -- 172.17.40.33:6802/12649 >> 172.17.40.32:6814/22015 pipe(0x23aa8e0 sd=81 pgs=103 cs=1 l=0).aborted = 0
/var/log/ceph/osd.88.log:2011-03-03 08:35:45.521638 7fbd06dcd940 -- 172.17.40.33:6802/12649 >> 172.17.40.32:6814/22015 pipe(0x23aa8e0 sd=81 pgs=103 cs=1 l=0).reader got 61 + 0 + 0 byte message
/var/log/ceph/osd.88.log:2011-03-03 08:35:45.521656 7fbd06dcd940 -- 172.17.40.33:6802/12649 >> 172.17.40.32:6814/22015 pipe(0x23aa8e0 sd=81 pgs=103 cs=1 l=0).reader got message 189 0x7fbd0d5d41f0 osd_ping(e7 as_of 7) v1
/var/log/ceph/osd.88.log:2011-03-03 08:35:45.521672 7fbd06dcd940 -- 172.17.40.33:6802/12649 >> 172.17.40.32:6814/22015 pipe(0x23aa8e0 sd=81 pgs=103 cs=1 l=0).queue_received queuing pipe
/var/log/ceph/osd.88.log:2011-03-03 08:35:45.521694 7fbd06dcd940 -- 172.17.40.33:6802/12649 >> 172.17.40.32:6814/22015 pipe(0x23aa8e0 sd=81 pgs=103 cs=1 l=0).reader reading tag...
/var/log/ceph/osd.88.log:2011-03-03 08:35:45.521717 7fbd1ba60940 -- 172.17.40.33:6802/12649 dispatch_entry pipe 0x23aa8e0 dequeued 0x7fbd0d5d41f0
/var/log/ceph/osd.88.log:2011-03-03 08:35:45.521741 7fbd1ba60940 -- 172.17.40.33:6802/12649 <== osd84 172.17.40.32:6814/22015 189 ==== osd_ping(e7 as_of 7) v1 ==== 61+0+0 (1356160346 0 0) 0x7fbd0d5d41f0 con 0x23aab50
/var/log/ceph/osd.88.log:2011-03-03 08:35:45.521762 7fbd1ba60940 osd88 7 heartbeat_dispatch 0x7fbd0d5d41f0
/var/log/ceph/osd.88.log:2011-03-03 08:35:45.521781 7fbd1ba60940 osd88 7 handle_osd_ping from osd84 got stat stat(2011-03-03 08:35:45.514326 oprate=0 qlen=0 recent_qlen=0 rdlat=0 / 0 fshedin=0)
/var/log/ceph/osd.88.log:2011-03-03 08:35:45.521797 7fbd1ba60940 osd88 7 _share_map_incoming osd84 172.17.40.32:6814/22015 7
/var/log/ceph/osd.88.log:2011-03-03 08:35:45.521818 7fbd1ba60940 osd88 7 take_peer_stat peer osd84 stat(2011-03-03 08:35:45.514326 oprate=0 qlen=0 recent_qlen=0 rdlat=0 / 0 fshedin=0)
/var/log/ceph/osd.88.log:2011-03-03 08:35:45.521844 7fbd1ba60940 -- 172.17.40.33:6802/12649 dispatch_throttle_release 61 to dispatch throttler 61/35000000
/var/log/ceph/osd.88.log:2011-03-03 08:35:45.521881 7fbd1ba60940 -- 172.17.40.33:6802/12649 done calling dispatch on 0x7fbd0d5d41f0
/var/log/ceph/osd.88.log:2011-03-03 08:35:45.521903 7fbd06ccc940 -- 172.17.40.33:6802/12649 >> 172.17.40.32:6814/22015 pipe(0x23aa8e0 sd=81 pgs=103 cs=1 l=0).writer: state = 2 policy.server=0
/var/log/ceph/osd.88.log:2011-03-03 08:35:45.521921 7fbd06ccc940 -- 172.17.40.33:6802/12649 >> 172.17.40.32:6814/22015 pipe(0x23aa8e0 sd=81 pgs=103 cs=1 l=0).write_ack 189
/var/log/ceph/osd.88.log:2011-03-03 08:35:45.521940 7fbd06ccc940 -- 172.17.40.33:6802/12649 >> 172.17.40.32:6814/22015 pipe(0x23aa8e0 sd=81 pgs=103 cs=1 l=0).writer: state = 2 policy.server=0
/var/log/ceph/osd.88.log:2011-03-03 08:35:45.521953 7fbd06ccc940 -- 172.17.40.33:6802/12649 >> 172.17.40.32:6814/22015 pipe(0x23aa8e0 sd=81 pgs=103 cs=1 l=0).writer sleeping
/var/log/ceph/osd.88.log:2011-03-03 08:35:45.531760 7fbd058b8940 -- 172.17.40.33:6802/12649 >> 172.17.40.30:6820/23749 pipe(0x7fbd0c17a220 sd=34 pgs=113 cs=1 l=0).reader got MSG
/var/log/ceph/osd.88.log:2011-03-03 08:35:45.531785 7fbd058b8940 -- 172.17.40.33:6802/12649 >> 172.17.40.30:6820/23749 pipe(0x7fbd0c17a220 sd=34 pgs=113 cs=1 l=0).reader got envelope type=70 src osd70 front=61 data=0 off 0
/var/log/ceph/osd.88.log:2011-03-03 08:35:45.531801 7fbd058b8940 -- 172.17.40.33:6802/12649 >> 172.17.40.30:6820/23749 pipe(0x7fbd0c17a220 sd=34 pgs=113 cs=1 l=0).reader wants 61 from dispatch throttler 0/35000000
/var/log/ceph/osd.88.log:2011-03-03 08:35:45.531828 7fbd058b8940 -- 172.17.40.33:6802/12649 >> 172.17.40.30:6820/23749 pipe(0x7fbd0c17a220 sd=34 pgs=113 cs=1 l=0).reader got front 61
/var/log/ceph/osd.88.log:2011-03-03 08:35:45.531846 7fbd058b8940 -- 172.17.40.33:6802/12649 >> 172.17.40.30:6820/23749 pipe(0x7fbd0c17a220 sd=34 pgs=113 cs=1 l=0).aborted = 0
/var/log/ceph/osd.88.log:2011-03-03 08:35:45.531860 7fbd058b8940 -- 172.17.40.33:6802/12649 >> 172.17.40.30:6820/23749 pipe(0x7fbd0c17a220 sd=34 pgs=113 cs=1 l=0).reader got 61 + 0 + 0 byte message
/var/log/ceph/osd.88.log:2011-03-03 08:35:45.531886 7fbd058b8940 -- 172.17.40.33:6802/12649 >> 172.17.40.30:6820/23749 pipe(0x7fbd0c17a220 sd=34 pgs=113 cs=1 l=0).reader got message 181 0x29ccab0 osd_ping(e7 as_of 7) v1
/var/log/ceph/osd.88.log:2011-03-03 08:35:45.531907 7fbd058b8940 -- 172.17.40.33:6802/12649 >> 172.17.40.30:6820/23749 pipe(0x7fbd0c17a220 sd=34 pgs=113 cs=1 l=0).queue_received queuing pipe
/var/log/ceph/osd.88.log:2011-03-03 08:35:45.531942 7fbd058b8940 -- 172.17.40.33:6802/12649 >> 172.17.40.30:6820/23749 pipe(0x7fbd0c17a220 sd=34 pgs=113 cs=1 l=0).reader reading tag...
/var/log/ceph/osd.88.log:2011-03-03 08:35:45.531973 7fbd01575940 -- 172.17.40.33:6802/12649 >> 172.17.40.30:6820/23749 pipe(0x7fbd0c17a220 sd=34 pgs=113 cs=1 l=0).writer: state = 2 policy.server=0
/var/log/ceph/osd.88.log:2011-03-03 08:35:45.531993 7fbd01575940 -- 172.17.40.33:6802/12649 >> 172.17.40.30:6820/23749 pipe(0x7fbd0c17a220 sd=34 pgs=113 cs=1 l=0).write_ack 181
/var/log/ceph/osd.88.log:2011-03-03 08:35:45.532007 7fbd01575940 -- 172.17.40.33:6802/12649 >> 172.17.40.30:6820/23749 pipe(0x7fbd0c17a220 sd=34 pgs=113 cs=1 l=0).writer: state = 2 policy.server=0
/var/log/ceph/osd.88.log:2011-03-03 08:35:45.532017 7fbd01575940 -- 172.17.40.33:6802/12649 >> 172.17.40.30:6820/23749 pipe(0x7fbd0c17a220 sd=34 pgs=113 cs=1 l=0).writer sleeping
/var/log/ceph/osd.88.log:2011-03-03 08:35:45.532166 7fbd1ba60940 -- 172.17.40.33:6802/12649 dispatch_entry pipe 0x7fbd0c17a220 dequeued 0x29ccab0
/var/log/ceph/osd.88.log:2011-03-03 08:35:45.532185 7fbd1ba60940 -- 172.17.40.33:6802/12649 <== osd70 172.17.40.30:6820/23749 181 ==== osd_ping(e7 as_of 7) v1 ==== 61+0+0 (3167970972 0 0) 0x29ccab0 con 0x7fbd0c17a490
/var/log/ceph/osd.88.log:2011-03-03 08:35:45.532192 7fbd1ba60940 osd88 7 heartbeat_dispatch 0x29ccab0
/var/log/ceph/osd.88.log:2011-03-03 08:35:45.532206 7fbd1ba60940 osd88 7 handle_osd_ping from osd70 got stat stat(2011-03-03 08:35:45.524509 oprate=0 qlen=0 recent_qlen=0 rdlat=0 / 0 fshedin=0)
/var/log/ceph/osd.88.log:2011-03-03 08:35:45.532217 7fbd1ba60940 osd88 7 _share_map_incoming osd70 172.17.40.30:6820/23749 7
/var/log/ceph/osd.88.log:2011-03-03 08:35:45.532233 7fbd1ba60940 osd88 7 take_peer_stat peer osd70 stat(2011-03-03 08:35:45.524509 oprate=0 qlen=0 recent_qlen=0 rdlat=0 / 0 fshedin=0)
/var/log/ceph/osd.88.log:2011-03-03 08:35:45.532246 7fbd1ba60940 -- 172.17.40.33:6802/12649 dispatch_throttle_release 61 to dispatch throttler 61/35000000
/var/log/ceph/osd.88.log:2011-03-03 08:35:45.532255 7fbd1ba60940 -- 172.17.40.33:6802/12649 done calling dispatch on 0x29ccab0
/var/log/ceph/osd.88.log:2011-03-03 08:35:45.560887 7fbd1a95d940 -- 172.17.40.33:6800/12649 >> 172.17.40.34:6789/0 pipe(0x7fbd14000a70 sd=12 pgs=2627 cs=1 l=1).reader couldn't read tag, Success
/var/log/ceph/osd.88.log:2011-03-03 08:35:45.560929 7fbd1a95d940 -- 172.17.40.33:6800/12649 >> 172.17.40.34:6789/0 pipe(0x7fbd14000a70 sd=12 pgs=2627 cs=1 l=1).fault 0: Success
/var/log/ceph/osd.88.log:2011-03-03 08:35:45.560947 7fbd1a95d940 -- 172.17.40.33:6800/12649 >> 172.17.40.34:6789/0 pipe(0x7fbd14000a70 sd=12 pgs=2627 cs=1 l=1).fault on lossy channel, failing
/var/log/ceph/osd.88.log:2011-03-03 08:35:45.560964 7fbd1a95d940 -- 172.17.40.33:6800/12649 >> 172.17.40.34:6789/0 pipe(0x7fbd14000a70 sd=12 pgs=2627 cs=1 l=1).fail
/var/log/ceph/osd.88.log:2011-03-03 08:35:45.560979 7fbd1a95d940 -- 172.17.40.33:6800/12649 >> 172.17.40.34:6789/0 pipe(0x7fbd14000a70 sd=12 pgs=2627 cs=1 l=1).stop
/var/log/ceph/osd.88.log:2011-03-03 08:35:45.560996 7fbd1a95d940 -- 172.17.40.33:6800/12649 >> 172.17.40.34:6789/0 pipe(0x7fbd14000a70 sd=12 pgs=2627 cs=1 l=1).discard_queue
/var/log/ceph/osd.88.log:2011-03-03 08:35:45.561019 7fbd1aa5e940 -- 172.17.40.33:6800/12649 >> 172.17.40.34:6789/0 pipe(0x7fbd14000a70 sd=12 pgs=2627 cs=1 l=1).do_sendmail short write did 129480, still have 364826
--------
/var/log/ceph/osd.74.log:2011-03-03 08:35:45.402368 7f34c41f2940 -- 172.17.40.31:6808/23718 done calling dispatch on 0x7f34a4341000
/var/log/ceph/osd.74.log:2011-03-03 08:35:45.477963 7f34c06e8940 -- 172.17.40.31:6808/23718 >> 172.17.40.21:6802/22558 pipe(0x258bd90 sd=26 pgs=77 cs=1 l=0).reader got MSG
/var/log/ceph/osd.74.log:2011-03-03 08:35:45.477990 7f34c06e8940 -- 172.17.40.31:6808/23718 >> 172.17.40.21:6802/22558 pipe(0x258bd90 sd=26 pgs=77 cs=1 l=0).reader got envelope type=70 src osd0 front=61 data=0 off 0
/var/log/ceph/osd.74.log:2011-03-03 08:35:45.478031 7f34c06e8940 -- 172.17.40.31:6808/23718 >> 172.17.40.21:6802/22558 pipe(0x258bd90 sd=26 pgs=77 cs=1 l=0).reader wants 61 from dispatch throttler 0/35000000
/var/log/ceph/osd.74.log:2011-03-03 08:35:45.478052 7f34c06e8940 -- 172.17.40.31:6808/23718 >> 172.17.40.21:6802/22558 pipe(0x258bd90 sd=26 pgs=77 cs=1 l=0).reader got front 61
/var/log/ceph/osd.74.log:2011-03-03 08:35:45.478069 7f34c06e8940 -- 172.17.40.31:6808/23718 >> 172.17.40.21:6802/22558 pipe(0x258bd90 sd=26 pgs=77 cs=1 l=0).aborted = 0
/var/log/ceph/osd.74.log:2011-03-03 08:35:45.478082 7f34c06e8940 -- 172.17.40.31:6808/23718 >> 172.17.40.21:6802/22558 pipe(0x258bd90 sd=26 pgs=77 cs=1 l=0).reader got 61 + 0 + 0 byte message
/var/log/ceph/osd.74.log:2011-03-03 08:35:45.478108 7f34c06e8940 -- 172.17.40.31:6808/23718 >> 172.17.40.21:6802/22558 pipe(0x258bd90 sd=26 pgs=77 cs=1 l=0).reader got message 297 0x29f3a90 osd_ping(e7 as_of 7) v1
/var/log/ceph/osd.74.log:2011-03-03 08:35:45.478129 7f34c06e8940 -- 172.17.40.31:6808/23718 >> 172.17.40.21:6802/22558 pipe(0x258bd90 sd=26 pgs=77 cs=1 l=0).queue_received queuing pipe
/var/log/ceph/osd.74.log:2011-03-03 08:35:45.478155 7f34c06e8940 -- 172.17.40.31:6808/23718 >> 172.17.40.21:6802/22558 pipe(0x258bd90 sd=26 pgs=77 cs=1 l=0).reader reading tag...
/var/log/ceph/osd.74.log:2011-03-03 08:35:45.478184 7f34c41f2940 -- 172.17.40.31:6808/23718 dispatch_entry pipe 0x258bd90 dequeued 0x29f3a90
/var/log/ceph/osd.74.log:2011-03-03 08:35:45.478203 7f34c41f2940 -- 172.17.40.31:6808/23718 <== osd0 172.17.40.21:6802/22558 297 ==== osd_ping(e7 as_of 7) v1 ==== 61+0+0 (1206220517 0 0) 0x29f3a90 con 0x23cdf00
/var/log/ceph/osd.74.log:2011-03-03 08:35:45.478235 7f34c41f2940 osd74 7 heartbeat_dispatch 0x29f3a90
/var/log/ceph/osd.74.log:2011-03-03 08:35:45.478255 7f34c41f2940 osd74 7 handle_osd_ping from osd0 got stat stat(2011-03-03 08:35:45.470964 oprate=0 qlen=0 recent_qlen=0 rdlat=0 / 0 fshedin=0)
/var/log/ceph/osd.74.log:2011-03-03 08:35:45.478282 7f34b9de4940 -- 172.17.40.31:6808/23718 >> 172.17.40.21:6802/22558 pipe(0x258bd90 sd=26 pgs=77 cs=1 l=0).writer: state = 2 policy.server=0
/var/log/ceph/osd.74.log:2011-03-03 08:35:45.478310 7f34b9de4940 -- 172.17.40.31:6808/23718 >> 172.17.40.21:6802/22558 pipe(0x258bd90 sd=26 pgs=77 cs=1 l=0).write_ack 297
/var/log/ceph/osd.74.log:2011-03-03 08:35:45.478332 7f34c41f2940 osd74 7 _share_map_incoming osd0 172.17.40.21:6802/22558 7
/var/log/ceph/osd.74.log:2011-03-03 08:35:45.478356 7f34c41f2940 osd74 7 take_peer_stat peer osd0 stat(2011-03-03 08:35:45.470964 oprate=0 qlen=0 recent_qlen=0 rdlat=0 / 0 fshedin=0)
/var/log/ceph/osd.74.log:2011-03-03 08:35:45.478387 7f34b9de4940 -- 172.17.40.31:6808/23718 >> 172.17.40.21:6802/22558 pipe(0x258bd90 sd=26 pgs=77 cs=1 l=0).writer: state = 2 policy.server=0
/var/log/ceph/osd.74.log:2011-03-03 08:35:45.478405 7f34b9de4940 -- 172.17.40.31:6808/23718 >> 172.17.40.21:6802/22558 pipe(0x258bd90 sd=26 pgs=77 cs=1 l=0).writer sleeping
/var/log/ceph/osd.74.log:2011-03-03 08:35:45.478422 7f34c41f2940 -- 172.17.40.31:6808/23718 dispatch_throttle_release 61 to dispatch throttler 61/35000000
/var/log/ceph/osd.74.log:2011-03-03 08:35:45.478433 7f34c41f2940 -- 172.17.40.31:6808/23718 done calling dispatch on 0x29f3a90
/var/log/ceph/osd.74.log:2011-03-03 08:35:45.524290 7f34b2067940 -- 172.17.40.31:6808/23718 >> 172.17.40.22:6805/27174 pipe(0x2098f30 sd=92 pgs=66 cs=1 l=0).reader got MSG
/var/log/ceph/osd.74.log:2011-03-03 08:35:45.524312 7f34b2067940 -- 172.17.40.31:6808/23718 >> 172.17.40.22:6805/27174 pipe(0x2098f30 sd=92 pgs=66 cs=1 l=0).reader got envelope type=70 src osd9 front=61 data=0 off 0
/var/log/ceph/osd.74.log:2011-03-03 08:35:45.524323 7f34b2067940 -- 172.17.40.31:6808/23718 >> 172.17.40.22:6805/27174 pipe(0x2098f30 sd=92 pgs=66 cs=1 l=0).reader wants 61 from dispatch throttler 0/35000000
/var/log/ceph/osd.74.log:2011-03-03 08:35:45.524337 7f34b2067940 -- 172.17.40.31:6808/23718 >> 172.17.40.22:6805/27174 pipe(0x2098f30 sd=92 pgs=66 cs=1 l=0).reader got front 61
/var/log/ceph/osd.74.log:2011-03-03 08:35:45.524350 7f34b2067940 -- 172.17.40.31:6808/23718 >> 172.17.40.22:6805/27174 pipe(0x2098f30 sd=92 pgs=66 cs=1 l=0).aborted = 0
/var/log/ceph/osd.74.log:2011-03-03 08:35:45.524359 7f34b2067940 -- 172.17.40.31:6808/23718 >> 172.17.40.22:6805/27174 pipe(0x2098f30 sd=92 pgs=66 cs=1 l=0).reader got 61 + 0 + 0 byte message
/var/log/ceph/osd.74.log:2011-03-03 08:35:45.524380 7f34b2067940 -- 172.17.40.31:6808/23718 >> 172.17.40.22:6805/27174 pipe(0x2098f30 sd=92 pgs=66 cs=1 l=0).reader got message 186 0x29f3a90 osd_ping(e7 as_of 7) v1
/var/log/ceph/osd.74.log:2011-03-03 08:35:45.524413 7f34b2067940 -- 172.17.40.31:6808/23718 >> 172.17.40.22:6805/27174 pipe(0x2098f30 sd=92 pgs=66 cs=1 l=0).queue_received queuing pipe
/var/log/ceph/osd.74.log:2011-03-03 08:35:45.524434 7f34b2067940 -- 172.17.40.31:6808/23718 >> 172.17.40.22:6805/27174 pipe(0x2098f30 sd=92 pgs=66 cs=1 l=0).reader reading tag...
/var/log/ceph/osd.74.log:2011-03-03 08:35:45.524450 7f34c41f2940 -- 172.17.40.31:6808/23718 dispatch_entry pipe 0x2098f30 dequeued 0x29f3a90
/var/log/ceph/osd.74.log:2011-03-03 08:35:45.524471 7f34c41f2940 -- 172.17.40.31:6808/23718 <== osd9 172.17.40.22:6805/27174 186 ==== osd_ping(e7 as_of 7) v1 ==== 61+0+0 (2221755111 0 0) 0x29f3a90 con 0x2b67a70
/var/log/ceph/osd.74.log:2011-03-03 08:35:45.524505 7f34c41f2940 osd74 7 heartbeat_dispatch 0x29f3a90
/var/log/ceph/osd.74.log:2011-03-03 08:35:45.524533 7f34c41f2940 osd74 7 handle_osd_ping from osd9 got stat stat(2011-03-03 08:35:45.516304 oprate=0 qlen=0 recent_qlen=0 rdlat=0 / 0 fshedin=0)
/var/log/ceph/osd.74.log:2011-03-03 08:35:45.524551 7f34c41f2940 osd74 7 _share_map_incoming osd9 172.17.40.22:6805/27174 7
/var/log/ceph/osd.74.log:2011-03-03 08:35:45.524578 7f34c41f2940 osd74 7 take_peer_stat peer osd9 stat(2011-03-03 08:35:45.516304 oprate=0 qlen=0 recent_qlen=0 rdlat=0 / 0 fshedin=0)
/var/log/ceph/osd.74.log:2011-03-03 08:35:45.524594 7f34c41f2940 -- 172.17.40.31:6808/23718 dispatch_throttle_release 61 to dispatch throttler 61/35000000
/var/log/ceph/osd.74.log:2011-03-03 08:35:45.524604 7f34c41f2940 -- 172.17.40.31:6808/23718 done calling dispatch on 0x29f3a90
/var/log/ceph/osd.74.log:2011-03-03 08:35:45.524731 7f34b2e75940 -- 172.17.40.31:6808/23718 >> 172.17.40.22:6805/27174 pipe(0x2098f30 sd=92 pgs=66 cs=1 l=0).writer: state = 2 policy.server=0
/var/log/ceph/osd.74.log:2011-03-03 08:35:45.524749 7f34b2e75940 -- 172.17.40.31:6808/23718 >> 172.17.40.22:6805/27174 pipe(0x2098f30 sd=92 pgs=66 cs=1 l=0).write_ack 186
/var/log/ceph/osd.74.log:2011-03-03 08:35:45.524765 7f34b2e75940 -- 172.17.40.31:6808/23718 >> 172.17.40.22:6805/27174 pipe(0x2098f30 sd=92 pgs=66 cs=1 l=0).writer: state = 2 policy.server=0
/var/log/ceph/osd.74.log:2011-03-03 08:35:45.524775 7f34b2e75940 -- 172.17.40.31:6808/23718 >> 172.17.40.22:6805/27174 pipe(0x2098f30 sd=92 pgs=66 cs=1 l=0).writer sleeping
/var/log/ceph/osd.74.log:2011-03-03 08:35:45.561000 7f34c31f0940 -- 172.17.40.31:6806/23718 >> 172.17.40.34:6789/0 pipe(0x7f34bc000ea0 sd=12 pgs=2631 cs=1 l=1).reader couldn't read tag, Success
/var/log/ceph/osd.74.log:2011-03-03 08:35:45.561022 7f34c31f0940 -- 172.17.40.31:6806/23718 >> 172.17.40.34:6789/0 pipe(0x7f34bc000ea0 sd=12 pgs=2631 cs=1 l=1).fault 0: Success
/var/log/ceph/osd.74.log:2011-03-03 08:35:45.561042 7f34c31f0940 -- 172.17.40.31:6806/23718 >> 172.17.40.34:6789/0 pipe(0x7f34bc000ea0 sd=12 pgs=2631 cs=1 l=1).fault on lossy channel, failing
/var/log/ceph/osd.74.log:2011-03-03 08:35:45.561060 7f34c31f0940 -- 172.17.40.31:6806/23718 >> 172.17.40.34:6789/0 pipe(0x7f34bc000ea0 sd=12 pgs=2631 cs=1 l=1).fail
/var/log/ceph/osd.74.log:2011-03-03 08:35:45.561078 7f34c31f0940 -- 172.17.40.31:6806/23718 >> 172.17.40.34:6789/0 pipe(0x7f34bc000ea0 sd=12 pgs=2631 cs=1 l=1).stop
/var/log/ceph/osd.74.log:2011-03-03 08:35:45.561097 7f34c31f0940 -- 172.17.40.31:6806/23718 >> 172.17.40.34:6789/0 pipe(0x7f34bc000ea0 sd=12 pgs=2631 cs=1 l=1).discard_queue
/var/log/ceph/osd.74.log:2011-03-03 08:35:45.561126 7f34cf1da940 -- 172.17.40.31:6806/23718 >> 172.17.40.34:6789/0 pipe(0x7f34bc000ea0 sd=12 pgs=2631 cs=1 l=1).do_sendmail short write did 143424, still have 8838
--------

> 
> I pushed a fix for the chdir issue, though!

Thanks!

-- Jim

> 
> Thanks-
> sage
> 


