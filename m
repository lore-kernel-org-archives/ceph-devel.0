From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Fri, 11 Mar 2011 11:26:28 -0700
Message-ID: <1299867988.4750.394.camel@sale659.sandia.gov>
References: <1297891508.25491.120.camel@sale659.sandia.gov>
 <75157CFDA63D45458FC47FB7BA6CB974@gmail.com>
 <1297893011.25491.124.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102161649560.11150@cobra.newdream.net>
 <Pine.LNX.4.64.1102161651380.11150@cobra.newdream.net>
 <1297957574.25491.152.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102170805080.22514@cobra.newdream.net>
 <1297985503.25491.175.camel@sale659.sandia.gov>
 <1299686572.4750.329.camel@sale659.sandia.gov>
 <2E7A0FAAE7EA416896A1990C7A96D59A@gmail.com>
 <1299695809.4750.346.camel@sale659.sandia.gov>
 <144B52A5BA504DCB992CD253287A397A@gmail.com>
 <1299798589.4750.372.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1103101515430.20133@cobra.newdream.net>
 <1299799936.4750.378.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1103101538100.20133@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:45174 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753053Ab1CKS0i (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Mar 2011 13:26:38 -0500
In-Reply-To: <Pine.LNX.4.64.1103101538100.20133@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Thu, 2011-03-10 at 16:40 -0700, Sage Weil wrote:
> > > Hmm, maybe.  I wouldn't expect this behavior from any allocator, though!
> > >
> > > Can you drill down a bit further and see if either of these is
> > > responsible?
> > >
> > >   virtual ~Message() {
> > >     assert(nref.read() == 0);
> > >     if (connection)
> > >       connection->put();
> > >     if (throttler)
> > >       throttler->put(payload.length() + middle.length() + data.length());
> > >   }
> > >
> > > (msg/Message.h)
> >
> > Hmmm, this is the patch I'm running to produce above.
> > It seems pretty definitive to me; am I missing something?
> 
>         delete this;
> 
> is calling the virtual destructor ~MOSDPing(), and then ~Message(), and
> only then releasing the memory to the allocator.  ~MOSDPing doesn't do
> anything, but ~Message adjusts the throttler (which involves a mutex that
> *shouldn't* be contended :) and a connection->put(), which calls
> ~Connection() and then releases memory.
> 
> My money is on the throttler, but let's see!

I added this patch:

--- a/src/msg/Message.h
+++ b/src/msg/Message.h
@@ -158,8 +158,8 @@ struct RefCountedObject {
       utime_t s = g_clock.now();
       delete this;
       utime_t e = g_clock.now();
-      if (e - s > 0.5) {
-       generic_dout(1) << "RefCountedObject::put delete " << this << " took " << e - s << " secs!" << dendl;
+      if (double(e - s) > 0.5) {
+       generic_dout(1) << "RefCountedObject::put delete " << this << " took " << double(e - s) << " secs!" << dendl;
       }
     }
   }
@@ -304,10 +304,22 @@ public:
 protected:
   virtual ~Message() { 
     assert(nref.read() == 0);
-    if (connection)
+    if (connection) {
+      utime_t s = g_clock.now();
       connection->put();
-    if (throttler)
+      utime_t e = g_clock.now();
+      if (double(e - s) > 0.25) {
+       generic_dout(1) << "~Message() " << this << " connection->put took " << double(e - s) << " secs!" << dendl;
+      }
+    }
+    if (throttler) {
+      utime_t s = g_clock.now();
       throttler->put(payload.length() + middle.length() + data.length());
+      utime_t e = g_clock.now();
+      if (double(e - s) > 0.25) {
+       generic_dout(1) << "~Message() " << this << " throttler->put took " << double(e - s) << " secs!" << dendl;
+      }
+    }
   }
 public:
   Connection *get_connection() { return connection; }



I got these hits:
# egrep -Hn --color -e "throttler->put took" osd.*.log
osd.16.log:1029077:2011-03-11 10:56:05.898264 7f30a7398940 ~Message() 0x2214ea0 throttler->put took 0.39543 secs!
osd.41.log:1401766:2011-03-11 10:56:51.110989 7ffad771e940 ~Message() 0x7ffaa7c12c40 throttler->put took 0.28708 secs!
osd.41.log:1494336:2011-03-11 10:57:07.748022 7ffad9123940 ~Message() 0x1adc8c0 throttler->put took 0.87857 secs!

Here are the corresponding messages:

osd.16.log:1011274:2011-03-11 10:55:48.805427 7f3089c9e940 -- 172.17.40.23:6800/22969 >> 172.17.40.68:0/1519385907 pipe(0x20c9930 sd=161 pgs=103 cs=1 l=1).reader got message 1 0x2214ea0 osd_op(client4212.1:39 10000004a4b.00000026 [write 0~4194304 [1@-1]] 0.2815 RETRY snapc 1=[])
osd.16.log:1027713:2011-03-11 10:56:05.679653 7f30a9d9f940 -- 172.17.40.23:6800/22969 dispatch_entry pipe 0x20c9930 dequeued 0x2214ea0
osd.16.log:1027714:2011-03-11 10:56:05.679666 7f30a9d9f940 -- 172.17.40.23:6800/22969 <== client4212 172.17.40.68:0/1519385907 1 ==== osd_op(client4212.1:39 10000004a4b.00000026 [write 0~4194304 [1@-1]] 0.2815 RETRY snapc 1=[]) ==== 128+0+4194304 (4010875753 0 0) 0x2214ea0 con 0x28b9e00
osd.16.log:1027717:2011-03-11 10:56:05.679688 7f30a9d9f940 osd16 14 _dispatch 0x2214ea0 osd_op(client4212.1:39 10000004a4b.00000026 [write 0~4194304 [1@-1]] 0.2815 RETRY snapc 1=[])
osd.16.log:1027718:2011-03-11 10:56:05.679703 7f30a9d9f940 osd16 14 require_same_or_newer_map 14 (i am 14) 0x2214ea0
osd.16.log:1027722:2011-03-11 10:56:05.679768 7f30a9d9f940 osd16 14 pg[0.815( v 14'6 (0'0,14'6] n=6 ec=3 les=6 3/3/3) [16,83] r=0 luod=14'5 lcod 14'5 mlcod 0'0 active+clean] enqueue_op 0x2214ea0 osd_op(client4212.1:39 10000004a4b.00000026 [write 0~4194304 [1@-1]] 0.2815 RETRY snapc 1=[])
osd.16.log:1027725:2011-03-11 10:56:05.679793 7f30a9d9f940 -- 172.17.40.23:6800/22969 dispatch_entry done with 0x2214ea0 que_et 16.874237 op_et 0.000117 tot_et 16.874354
osd.16.log:1029077:2011-03-11 10:56:05.898264 7f30a7398940 ~Message() 0x2214ea0 throttler->put took 0.39543 secs!
osd.16.log:1029078:2011-03-11 10:56:05.898287 7f30a7398940 osd16 14 dequeue_op 0x2214ea0 finish

osd.41.log:1400466:2011-03-11 10:56:50.926741 7ffab79cb940 -- 172.17.40.27:6803/25508 >> 172.17.40.97:0/893403283 pipe(0x7ffabc6eba50 sd=156 pgs=194 cs=1 l=1).reader got message 2 0x7ffaa7c12c40 osd_op(client4251.1:250 1000000cf3d.000000f4 [write 0~4194304 [1@-1]] 0.2c5b RETRY snapc 1=[])
osd.41.log:1401371:2011-03-11 10:56:51.069569 7ffad9924940 -- 172.17.40.27:6803/25508 dispatch_entry pipe 0x7ffabc6eba50 dequeued 0x7ffaa7c12c40
osd.41.log:1401372:2011-03-11 10:56:51.069584 7ffad9924940 -- 172.17.40.27:6803/25508 <== client4251 172.17.40.97:0/893403283 2 ==== osd_op(client4251.1:250 1000000cf3d.000000f4 [write 0~4194304 [1@-1]] 0.2c5b RETRY snapc 1=[]) ==== 128+0+4194304 (4206015051 0 0) 0x7ffaa7c12c40 con 0x7ffabc1c6640
osd.41.log:1401375:2011-03-11 10:56:51.069608 7ffad9924940 osd41 14 _dispatch 0x7ffaa7c12c40 osd_op(client4251.1:250 1000000cf3d.000000f4 [write 0~4194304 [1@-1]] 0.2c5b RETRY snapc 1=[])
osd.41.log:1401376:2011-03-11 10:56:51.069615 7ffad9924940 osd41 14 require_same_or_newer_map 14 (i am 14) 0x7ffaa7c12c40
osd.41.log:1401380:2011-03-11 10:56:51.069675 7ffad9924940 osd41 14 pg[0.c5b( v 14'8 (14'2,14'8] n=8 ec=3 les=5 3/3/3) [41,55] r=0 mlcod 14'3 active+clean] enqueue_op 0x7ffaa7c12c40 osd_op(client4251.1:250 1000000cf3d.000000f4 [write 0~4194304 [1@-1]] 0.2c5b RETRY snapc 1=[])
osd.41.log:1401383:2011-03-11 10:56:51.069704 7ffad9924940 -- 172.17.40.27:6803/25508 dispatch_entry done with 0x7ffaa7c12c40 que_et 0.142841 op_et 0.000110 tot_et 0.142951
osd.41.log:1401766:2011-03-11 10:56:51.110989 7ffad771e940 ~Message() 0x7ffaa7c12c40 throttler->put took 0.28708 secs!
osd.41.log:1401782:2011-03-11 10:56:51.111711 7ffad771e940 osd41 14 dequeue_op 0x7ffaa7c12c40 finish

osd.41.log:1406682:2011-03-11 10:56:52.368878 7ffab55a9940 -- 172.17.40.27:6803/25508 >> 172.17.40.49:0/530169199 pipe(0x1b03a90 sd=209 pgs=137 cs=1 l=1).reader got message 6 0x1adc8c0 osd_op(client4200.1:460 10000000bbb.000001c5 [write 0~4194304 [1@-1]] 0.a5b1 RETRY snapc 1=[])
osd.41.log:1439271:2011-03-11 10:56:59.443761 7ffad9924940 -- 172.17.40.27:6803/25508 dispatch_entry pipe 0x1b03a90 dequeued 0x1adc8c0
osd.41.log:1439272:2011-03-11 10:56:59.443782 7ffad9924940 -- 172.17.40.27:6803/25508 <== client4200 172.17.40.49:0/530169199 6 ==== osd_op(client4200.1:460 10000000bbb.000001c5 [write 0~4194304 [1@-1]] 0.a5b1 RETRY snapc 1=[]) ==== 128+0+4194304 (3016272799 0 0) 0x1adc8c0 con 0x8114be0
osd.41.log:1439275:2011-03-11 10:56:59.443806 7ffad9924940 osd41 21 _dispatch 0x1adc8c0 osd_op(client4200.1:460 10000000bbb.000001c5 [write 0~4194304 [1@-1]] 0.a5b1 RETRY snapc 1=[])
osd.41.log:1439276:2011-03-11 10:56:59.443816 7ffad9924940 osd41 21 require_same_or_newer_map 15 (i am 21) 0x1adc8c0
osd.41.log:1439306:2011-03-11 10:56:59.449276 7ffad9924940 -- 172.17.40.27:6803/25508 dispatch_entry done with 0x1adc8c0 que_et 7.074903 op_et 0.005482 tot_et 7.080385
osd.41.log:1493847:2011-03-11 10:57:07.658838 7ffad9123940 osd41 28 _dispatch 0x1adc8c0 osd_op(client4200.1:460 10000000bbb.000001c5 [write 0~4194304 [1@-1]] 0.a5b1 RETRY snapc 1=[])
osd.41.log:1493848:2011-03-11 10:57:07.658848 7ffad9123940 osd41 28 require_same_or_newer_map 15 (i am 28) 0x1adc8c0
osd.41.log:1494336:2011-03-11 10:57:07.748022 7ffad9123940 ~Message() 0x1adc8c0 throttler->put took 0.87857 secs!
osd.41.log:1494337:2011-03-11 10:57:07.748043 7ffad9123940 RefCountedObject::put delete 0x1adc8c0 took 0.87917 secs!


So none of those were osd_ping messages.

But, I still had lots of delayed acks.  Here's a couple more examples:

osd.0.log:960713:2011-03-11 10:55:32.117721 7fc4cb7fe940 -- 172.17.40.21:6802/28363 --> osd74 172.17.40.31:6808/24916 -- osd_ping(e14 as_of 14) v1 -- ?+0 0x7fc4cc16f270
osd.0.log:960756:2011-03-11 10:55:32.118395 7fc4c96eb940 -- 172.17.40.21:6802/28363 >> 172.17.40.31:6808/24916 pipe(0x28fb580 sd=53 pgs=47 cs=1 l=0).writer encoding 289 0x7fc4cc16f270 osd_ping(e14 as_of 14) v1
osd.0.log:960757:2011-03-11 10:55:32.118409 7fc4c96eb940 -- 172.17.40.21:6802/28363 >> 172.17.40.31:6808/24916 pipe(0x28fb580 sd=53 pgs=47 cs=1 l=0).writer sending 289 0x7fc4cc16f270
osd.0.log:960758:2011-03-11 10:55:32.118422 7fc4c96eb940 -- 172.17.40.21:6802/28363 >> 172.17.40.31:6808/24916 pipe(0x28fb580 sd=53 pgs=47 cs=1 l=0).write_message 0x7fc4cc16f270 osd_ping(e14 as_of 14) v1
osd.0.log:963163:2011-03-11 10:55:32.941413 7fc4c61b6940 -- 172.17.40.21:6802/28363 >> 172.17.40.31:6808/24916 pipe(0x28fb580 sd=53 pgs=47 cs=1 l=0).reader got ack seq 289 >= 289 on 0x7fc4cc16f270 osd_ping(e14 as_of 14) v1
osd.0.log:964273:2011-03-11 10:55:33.447526 7fc4c61b6940 RefCountedObject::put delete 0x7fc4cc16f270 took 5.06013 secs!
osd.0.log:964274:2011-03-11 10:55:33.447538 7fc4c61b6940 -- 172.17.40.21:6802/28363 >> 172.17.40.31:6808/24916 pipe(0x28fb580 sd=53 pgs=47 cs=1 l=0).handle_ack finished put on 0x7fc4cc16f270

osd.0.log:964311:2011-03-11 10:55:33.448063 7fc4cb7fe940 -- 172.17.40.21:6802/28363 --> osd77 172.17.40.31:6817/25216 -- osd_ping(e14 as_of 14) v1 -- ?+0 0x7fc4cc2f9a90
osd.0.log:964356:2011-03-11 10:55:33.448883 7fc4ba5a5940 -- 172.17.40.21:6802/28363 >> 172.17.40.31:6817/25216 pipe(0x27abca0 sd=108 pgs=81 cs=1 l=0).writer encoding 277 0x7fc4cc2f9a90 osd_ping(e14 as_of 14) v1
osd.0.log:964357:2011-03-11 10:55:33.448896 7fc4ba5a5940 -- 172.17.40.21:6802/28363 >> 172.17.40.31:6817/25216 pipe(0x27abca0 sd=108 pgs=81 cs=1 l=0).writer sending 277 0x7fc4cc2f9a90
osd.0.log:964358:2011-03-11 10:55:33.448907 7fc4ba5a5940 -- 172.17.40.21:6802/28363 >> 172.17.40.31:6817/25216 pipe(0x27abca0 sd=108 pgs=81 cs=1 l=0).write_message 0x7fc4cc2f9a90 osd_ping(e14 as_of 14) v1
osd.0.log:972337:2011-03-11 10:55:34.976054 7fc4ba8a8940 -- 172.17.40.21:6802/28363 >> 172.17.40.31:6817/25216 pipe(0x27abca0 sd=108 pgs=81 cs=1 l=0).reader got ack seq 278 >= 277 on 0x7fc4cc2f9a90 osd_ping(e14 as_of 14) v1
osd.0.log:977785:2011-03-11 10:55:45.119599 7fc4ba8a8940 RefCountedObject::put delete 0x7fc4cc2f9a90 took 11.4353 secs!
osd.0.log:977786:2011-03-11 10:55:45.119612 7fc4ba8a8940 -- 172.17.40.21:6802/28363 >> 172.17.40.31:6817/25216 pipe(0x27abca0 sd=108 pgs=81 cs=1 l=0).handle_ack finished put on 0x7fc4cc2f9a90

Seems like this pretty much rules out anything but the memory allocator,
but maybe I'm still missing something?

-- Jim

> 
> sage
> 


