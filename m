From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Fri, 11 Mar 2011 15:21:12 -0700
Message-ID: <1299882072.4750.434.camel@sale659.sandia.gov>
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
 <1299867988.4750.394.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1103111036450.23902@cobra.newdream.net>
 <1299877982.4750.415.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1103111333190.23902@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:48951 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149Ab1CKWVU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Mar 2011 17:21:20 -0500
In-Reply-To: <Pine.LNX.4.64.1103111333190.23902@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Fri, 2011-03-11 at 14:37 -0700, Sage Weil wrote:
> On Fri, 11 Mar 2011, Jim Schutt wrote:
> > 
> > On Fri, 2011-03-11 at 11:37 -0700, Sage Weil wrote:
> > > On Fri, 11 Mar 2011, Jim Schutt wrote:
> > > > So none of those were osd_ping messages.
> > > > 
> > > > But, I still had lots of delayed acks.  Here's a couple more examples:
> > > > 
> > > > osd.0.log:960713:2011-03-11 10:55:32.117721 7fc4cb7fe940 -- 172.17.40.21:6802/28363 --> osd74 172.17.40.31:6808/24916 -- osd_ping(e14 as_of 14) v1 -- ?+0 0x7fc4cc16f270
> > > > osd.0.log:960756:2011-03-11 10:55:32.118395 7fc4c96eb940 -- 172.17.40.21:6802/28363 >> 172.17.40.31:6808/24916 pipe(0x28fb580 sd=53 pgs=47 cs=1 l=0).writer encoding 289 0x7fc4cc16f270 osd_ping(e14 as_of 14) v1
> > > > osd.0.log:960757:2011-03-11 10:55:32.118409 7fc4c96eb940 -- 172.17.40.21:6802/28363 >> 172.17.40.31:6808/24916 pipe(0x28fb580 sd=53 pgs=47 cs=1 l=0).writer sending 289 0x7fc4cc16f270
> > > > osd.0.log:960758:2011-03-11 10:55:32.118422 7fc4c96eb940 -- 172.17.40.21:6802/28363 >> 172.17.40.31:6808/24916 pipe(0x28fb580 sd=53 pgs=47 cs=1 l=0).write_message 0x7fc4cc16f270 osd_ping(e14 as_of 14) v1
> > > 
> > > This bit has me confused:
> > > 
> > > > osd.0.log:963163:2011-03-11 10:55:32.941413 7fc4c61b6940 -- 172.17.40.21:6802/28363 >> 172.17.40.31:6808/24916 pipe(0x28fb580 sd=53 pgs=47 cs=1 l=0).reader got ack seq 289 >= 289 on 0x7fc4cc16f270 osd_ping(e14 as_of 14) v1
> > > > osd.0.log:964273:2011-03-11 10:55:33.447526 7fc4c61b6940 RefCountedObject::put delete 0x7fc4cc16f270 took 5.06013 secs!
> > > > osd.0.log:964274:2011-03-11 10:55:33.447538 7fc4c61b6940 -- 172.17.40.21:6802/28363 >> 172.17.40.31:6808/24916 pipe(0x28fb580 sd=53 pgs=47 cs=1 l=0).handle_ack finished put on 0x7fc4cc16f270
> > > 
> > > It looks like ~ .5 seconds has gone by for that thread, but the ::put 
> > > debug says 5 seconds.  It happens between the 'got ack seq' and 'finished 
> > > put' lines, though, right?  
> > 
> > OK, with Greg's utime_t double fix, I git no hits on
> > 
> > # egrep -Hn --color -e "->put took" osd.*.log
> > 
> > 
> > But, I still get lots of stalled :RefCountedObject::put delete:
> > 
> > # grep -Hn RefCountedObject::put osd.*.log | egrep "took [1-9]\." | wc -l
> > 8911
> > 
> > # grep -Hn RefCountedObject::put osd.*.log | egrep "took [0-9][0-9]\." | wc -l
> > 415
> 
> Hmm!  That does seem to point at the allocator, doesn't it.
> 
> Other threads are doing work during this long interval?  Including freeing 
> memory, presumably, since basically everything uses the heap one way or 
> another.  If it's the allocator, it's somehow affecting one thread only, 
> which is pretty crazy.

As an example,  consider this period:

osd.34.log:1083828:2011-03-11 12:38:33.091345 7f8972f6f940 -- 172.17.40.25:6808/8345 >> 172.17.40.30:6814/8599 pipe(0x7f897c186c70 sd=109 pgs=64 cs=1 l=0).reader got ack seq 326 >= 326 on 0x7f897c47cd00 osd_ping(e5 as_of 5) v1
osd.34.log:1096768:2011-03-11 12:38:57.143061 7f8972f6f940 RefCountedObject::put delete 0x7f897c47cd00 took 23.9321 secs!
osd.34.log:1096769:2011-03-11 12:38:57.143079 7f8972f6f940 -- 172.17.40.25:6808/8345 >> 172.17.40.30:6814/8599 pipe(0x7f897c186c70 sd=109 pgs=64 cs=1 l=0).handle_ack finished put on 0x7f897c47cd00

In that period 225 unique threads ran, 10887 lines of logging
were generated, of which 9985 contained "pipe".  So, lots of
network activity.  6881 lines of log contained "reader", 
1715 lines of log contained "writer".

And, one other instance of a stalled delete:

# egrep -Hn -B 1000000 "^2011-03-11 12:38:57.023162" osd.34.log | egrep -A 1000000 "^osd[^ ]*011-03-11 12:38:33.055826" | grep "put delete"
osd.34.log-1094490-2011-03-11 12:38:57.022896 7f8975c9c940 RefCountedObject::put delete 0x7f897c3484e0 took 16.0578 secs!
osd.34.log-1094501-2011-03-11 12:38:57.023129 7f8972c6c940 RefCountedObject::put delete 0x7f897c4ca050 took 23.9673 secs!

In fact, check this out:

osd.34.log:1021637:2011-03-11 12:38:16.680723 7f897a2e2940 RefCountedObject::put delete 0x7f897c27ed20 took 0.697538 secs!
osd.34.log:1021641:2011-03-11 12:38:16.680776 7f8982327940 RefCountedObject::put delete 0x7f897c3a4450 took 0.67412 secs!
osd.34.log:1021649:2011-03-11 12:38:16.680899 7f896e727940 RefCountedObject::put delete 0x7f897c414ad0 took 0.654786 secs!
osd.34.log:1021667:2011-03-11 12:38:16.681150 7f8972666940 RefCountedObject::put delete 0x7f897c26a810 took 0.71042 secs!
osd.34.log:1021681:2011-03-11 12:38:16.681374 7f897b9f9940 RefCountedObject::put delete 0x7f897c27a530 took 0.659059 secs!
osd.34.log:1021692:2011-03-11 12:38:16.681535 7f8981115940 RefCountedObject::put delete 0x7f897c414050 took 0.712788 secs!
osd.34.log:1021717:2011-03-11 12:38:16.681886 7f8972e6e940 RefCountedObject::put delete 0x7f897c39c1d0 took 0.712481 secs!
osd.34.log:1021744:2011-03-11 12:38:16.682309 7f8980408940 RefCountedObject::put delete 0x7f897c436050 took 0.718925 secs!
osd.34.log:1041356:2011-03-11 12:38:20.835840 7f8972969940 RefCountedObject::put delete 0x27e4960 took 0.653973 secs!
osd.34.log:1041376:2011-03-11 12:38:20.838095 7f8972666940 RefCountedObject::put delete 0x7f894c09e740 took 0.749359 secs!
osd.34.log:1041476:2011-03-11 12:38:20.848764 7f8972060940 RefCountedObject::put delete 0x2ce42e0 took 0.819086 secs!
osd.34.log:1041732:2011-03-11 12:38:20.861206 7f8981418940 RefCountedObject::put delete 0x7f897c3d1530 took 0.566482 secs!
osd.34.log:1068451:2011-03-11 12:38:28.167331 7f896fa3a940 RefCountedObject::put delete 0x7f895482f400 took 1.70164 secs!
osd.34.log:1094490:2011-03-11 12:38:57.022896 7f8975c9c940 RefCountedObject::put delete 0x7f897c3484e0 took 16.0578 secs!
osd.34.log:1094501:2011-03-11 12:38:57.023129 7f8972c6c940 RefCountedObject::put delete 0x7f897c4ca050 took 23.9673 secs!
osd.34.log:1095007:2011-03-11 12:38:57.041197 7f8975999940 RefCountedObject::put delete 0x7f897c13aa20 took 18.3308 secs!
osd.34.log:1095020:2011-03-11 12:38:57.041461 7f8971e5e940 RefCountedObject::put delete 0x7f897c4ca210 took 23.9684 secs!
osd.34.log:1095023:2011-03-11 12:38:57.041506 7f8970b4b940 RefCountedObject::put delete 0x7f897c4ca790 took 23.9683 secs!
osd.34.log:1095028:2011-03-11 12:38:57.041585 7f8973474940 RefCountedObject::put delete 0x7f897c4ca5d0 took 23.9673 secs!
osd.34.log:1095042:2011-03-11 12:38:57.041870 7f8979ddd940 RefCountedObject::put delete 0x7f897c4c4dc0 took 23.9619 secs!
osd.34.log:1095047:2011-03-11 12:38:57.041955 7f897b9f9940 RefCountedObject::put delete 0x7f897c4ca3d0 took 23.9488 secs!
osd.34.log:1095050:2011-03-11 12:38:57.042000 7f897a2e2940 RefCountedObject::put delete 0x7f897c47cac0 took 23.8742 secs!
osd.34.log:1095053:2011-03-11 12:38:57.042048 7f8979fdf940 RefCountedObject::put delete 0x7f897c4c44c0 took 23.7631 secs!
osd.34.log:1095055:2011-03-11 12:38:57.042083 7f8982327940 RefCountedObject::put delete 0x7f897c3e96d0 took 17.3037 secs!
osd.34.log:1095058:2011-03-11 12:38:57.042139 7f8978bcb940 RefCountedObject::put delete 0x7f894c8894a0 took 15.7804 secs!
osd.34.log:1095062:2011-03-11 12:38:57.042210 7f8975898940 RefCountedObject::put delete 0x7f894c00c010 took 15.5001 secs!
osd.34.log:1095284:2011-03-11 12:38:57.050616 7f897b6f6940 RefCountedObject::put delete 0x7f897c32e050 took 17.5251 secs!
osd.34.log:1095302:2011-03-11 12:38:57.050974 7f8973171940 RefCountedObject::put delete 0x7f897c4c4b80 took 16.4301 secs!
osd.34.log:1095425:2011-03-11 12:38:57.052941 7f8980408940 RefCountedObject::put delete 0x7f897c0ef9f0 took 13.3016 secs!
osd.34.log:1095433:2011-03-11 12:38:57.053154 7f8981418940 RefCountedObject::put delete 0x7f897c4c4700 took 23.7634 secs!
osd.34.log:1095438:2011-03-11 12:38:57.053243 7f897bafa940 RefCountedObject::put delete 0x7f897c4c42c0 took 23.737 secs!
osd.34.log:1095444:2011-03-11 12:38:57.053343 7f896e828940 RefCountedObject::put delete 0x7f894c4010a0 took 15.5752 secs!
osd.34.log:1095748:2011-03-11 12:38:57.087529 7f89769a9940 RefCountedObject::put delete 0x7f897c251aa0 took 15.4771 secs!
osd.34.log:1095770:2011-03-11 12:38:57.088979 7f896ea2a940 RefCountedObject::put delete 0x7f897c24a550 took 15.6479 secs!
osd.34.log:1095795:2011-03-11 12:38:57.089647 7f89797d7940 RefCountedObject::put delete 0x7f897c4c4940 took 23.9601 secs!
osd.34.log:1095852:2011-03-11 12:38:57.091027 7f89777b7940 RefCountedObject::put delete 0x7f894c83d640 took 12.1841 secs!
osd.34.log:1096768:2011-03-11 12:38:57.143061 7f8972f6f940 RefCountedObject::put delete 0x7f897c47cd00 took 23.9321 secs!
osd.34.log:1097052:2011-03-11 12:38:57.147997 7f898080c940 RefCountedObject::put delete 0x7f894c4142a0 took 16.1565 secs!


> 
> Is it difficult for you to try this with tcmalloc?  That'll tell us 
> something.

I don't think so.  But, I'm out next week so won't get to
it until Mar 21 :(

> 
> One other possibility would be to try to catch this "in the act" and send 
> it a SIGABRT to get a core dump.  Then we can look in more detail at what 
> this (and other) threads are up to.  I'm not sure how easy this is to 
> catch on a particular node...

So it occurs to me that one call to Message::put() entails many 
calls to buffer::ptr::release(), depending on what the message 
is, right?  Maybe time the "delete _raw" in there and assert() 
if it's too long?

-- Jim

> 
> sage
> 


