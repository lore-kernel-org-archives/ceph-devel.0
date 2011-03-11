From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Fri, 11 Mar 2011 14:13:02 -0700
Message-ID: <1299877982.4750.415.camel@sale659.sandia.gov>
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
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:43304 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755582Ab1CKVNP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Mar 2011 16:13:15 -0500
In-Reply-To: <Pine.LNX.4.64.1103111036450.23902@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Fri, 2011-03-11 at 11:37 -0700, Sage Weil wrote:
> On Fri, 11 Mar 2011, Jim Schutt wrote:
> > So none of those were osd_ping messages.
> > 
> > But, I still had lots of delayed acks.  Here's a couple more examples:
> > 
> > osd.0.log:960713:2011-03-11 10:55:32.117721 7fc4cb7fe940 -- 172.17.40.21:6802/28363 --> osd74 172.17.40.31:6808/24916 -- osd_ping(e14 as_of 14) v1 -- ?+0 0x7fc4cc16f270
> > osd.0.log:960756:2011-03-11 10:55:32.118395 7fc4c96eb940 -- 172.17.40.21:6802/28363 >> 172.17.40.31:6808/24916 pipe(0x28fb580 sd=53 pgs=47 cs=1 l=0).writer encoding 289 0x7fc4cc16f270 osd_ping(e14 as_of 14) v1
> > osd.0.log:960757:2011-03-11 10:55:32.118409 7fc4c96eb940 -- 172.17.40.21:6802/28363 >> 172.17.40.31:6808/24916 pipe(0x28fb580 sd=53 pgs=47 cs=1 l=0).writer sending 289 0x7fc4cc16f270
> > osd.0.log:960758:2011-03-11 10:55:32.118422 7fc4c96eb940 -- 172.17.40.21:6802/28363 >> 172.17.40.31:6808/24916 pipe(0x28fb580 sd=53 pgs=47 cs=1 l=0).write_message 0x7fc4cc16f270 osd_ping(e14 as_of 14) v1
> 
> This bit has me confused:
> 
> > osd.0.log:963163:2011-03-11 10:55:32.941413 7fc4c61b6940 -- 172.17.40.21:6802/28363 >> 172.17.40.31:6808/24916 pipe(0x28fb580 sd=53 pgs=47 cs=1 l=0).reader got ack seq 289 >= 289 on 0x7fc4cc16f270 osd_ping(e14 as_of 14) v1
> > osd.0.log:964273:2011-03-11 10:55:33.447526 7fc4c61b6940 RefCountedObject::put delete 0x7fc4cc16f270 took 5.06013 secs!
> > osd.0.log:964274:2011-03-11 10:55:33.447538 7fc4c61b6940 -- 172.17.40.21:6802/28363 >> 172.17.40.31:6808/24916 pipe(0x28fb580 sd=53 pgs=47 cs=1 l=0).handle_ack finished put on 0x7fc4cc16f270
> 
> It looks like ~ .5 seconds has gone by for that thread, but the ::put 
> debug says 5 seconds.  It happens between the 'got ack seq' and 'finished 
> put' lines, though, right?  

OK, with Greg's utime_t double fix, I git no hits on

# egrep -Hn --color -e "->put took" osd.*.log


But, I still get lots of stalled :RefCountedObject::put delete:

# grep -Hn RefCountedObject::put osd.*.log | egrep "took [1-9]\." | wc -l
8911

# grep -Hn RefCountedObject::put osd.*.log | egrep "took [0-9][0-9]\." | wc -l
415

Here's a few egregious examples:

osd.15.log:1182213:2011-03-11 12:38:05.008947 7fa2e99a1940 -- 172.17.40.22:6823/10039 --> osd58 172.17.40.29:6808/6327 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7fa2c8958850
osd.15.log:1182548:2011-03-11 12:38:05.033223 7fa2e32f2940 -- 172.17.40.22:6823/10039 >> 172.17.40.29:6808/6327 pipe(0x7fa2e40203c0 sd=19 pgs=59 cs=1 l=0).writer encoding 294 0x7fa2c8958850 osd_ping(e5 as_of 5) v1
osd.15.log:1182549:2011-03-11 12:38:05.033243 7fa2e32f2940 -- 172.17.40.22:6823/10039 >> 172.17.40.29:6808/6327 pipe(0x7fa2e40203c0 sd=19 pgs=59 cs=1 l=0).writer sending 294 0x7fa2c8958850
osd.15.log:1182550:2011-03-11 12:38:05.033257 7fa2e32f2940 -- 172.17.40.22:6823/10039 >> 172.17.40.29:6808/6327 pipe(0x7fa2e40203c0 sd=19 pgs=59 cs=1 l=0).write_message 0x7fa2c8958850 osd_ping(e5 as_of 5) v1
osd.15.log:1184485:2011-03-11 12:38:05.240959 7fa2daf6f940 -- 172.17.40.22:6823/10039 >> 172.17.40.29:6808/6327 pipe(0x7fa2e40203c0 sd=19 pgs=59 cs=1 l=0).reader got ack seq 294 >= 294 on 0x7fa2c8958850 osd_ping(e5 as_of 5) v1
osd.15.log:1190478:2011-03-11 12:38:17.930663 7fa2daf6f940 RefCountedObject::put delete 0x7fa2c8958850 took 12.6896 secs!
osd.15.log:1190479:2011-03-11 12:38:17.930684 7fa2daf6f940 -- 172.17.40.22:6823/10039 >> 172.17.40.29:6808/6327 pipe(0x7fa2e40203c0 sd=19 pgs=59 cs=1 l=0).handle_ack finished put on 0x7fa2c8958850

osd.34.log:1082690:2011-03-11 12:38:32.845454 7f8983d33940 -- 172.17.40.25:6808/8345 --> osd87 172.17.40.32:6823/8229 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f897c4ca050
osd.34.log:1082754:2011-03-11 12:38:32.850109 7f8973777940 -- 172.17.40.25:6808/8345 >> 172.17.40.32:6823/8229 pipe(0x7f897c21bd40 sd=102 pgs=52 cs=1 l=0).writer encoding 326 0x7f897c4ca050 osd_ping(e5 as_of 5) v1
osd.34.log:1082755:2011-03-11 12:38:32.850123 7f8973777940 -- 172.17.40.25:6808/8345 >> 172.17.40.32:6823/8229 pipe(0x7f897c21bd40 sd=102 pgs=52 cs=1 l=0).writer sending 326 0x7f897c4ca050
osd.34.log:1082756:2011-03-11 12:38:32.850135 7f8973777940 -- 172.17.40.25:6808/8345 >> 172.17.40.32:6823/8229 pipe(0x7f897c21bd40 sd=102 pgs=52 cs=1 l=0).write_message 0x7f897c4ca050 osd_ping(e5 as_of 5) v1
osd.34.log:1083617:2011-03-11 12:38:33.055826 7f8972c6c940 -- 172.17.40.25:6808/8345 >> 172.17.40.32:6823/8229 pipe(0x7f897c21bd40 sd=102 pgs=52 cs=1 l=0).reader got ack seq 326 >= 326 on 0x7f897c4ca050 osd_ping(e5 as_of 5) v1
osd.34.log:1094501:2011-03-11 12:38:57.023129 7f8972c6c940 RefCountedObject::put delete 0x7f897c4ca050 took 23.9673 secs!
osd.34.log:1094503:2011-03-11 12:38:57.023162 7f8972c6c940 -- 172.17.40.25:6808/8345 >> 172.17.40.32:6823/8229 pipe(0x7f897c21bd40 sd=102 pgs=52 cs=1 l=0).handle_ack finished put on 0x7f897c4ca050

osd.36.log:1020000:2011-03-11 12:38:31.508458 7f76551b6940 -- 172.17.40.25:6814/8529 --> osd61 172.17.40.29:6817/6627 -- osd_ping(e5 as_of 5) v1 -- ?+0 0x7f762842cef0
osd.36.log:1020336:2011-03-11 12:38:31.725684 7f764cbcb940 -- 172.17.40.25:6814/8529 >> 172.17.40.29:6817/6627 pipe(0x7f765001a9a0 sd=39 pgs=43 cs=1 l=0).writer encoding 314 0x7f762842cef0 osd_ping(e5 as_of 5) v1
osd.36.log:1020337:2011-03-11 12:38:31.725697 7f764cbcb940 -- 172.17.40.25:6814/8529 >> 172.17.40.29:6817/6627 pipe(0x7f765001a9a0 sd=39 pgs=43 cs=1 l=0).writer sending 314 0x7f762842cef0
osd.36.log:1020338:2011-03-11 12:38:31.725708 7f764cbcb940 -- 172.17.40.25:6814/8529 >> 172.17.40.29:6817/6627 pipe(0x7f765001a9a0 sd=39 pgs=43 cs=1 l=0).write_message 0x7f762842cef0 osd_ping(e5 as_of 5) v1
osd.36.log:1025062:2011-03-11 12:38:33.451183 7f764cdcd940 -- 172.17.40.25:6814/8529 >> 172.17.40.29:6817/6627 pipe(0x7f765001a9a0 sd=39 pgs=43 cs=1 l=0).reader got ack seq 314 >= 314 on 0x7f762842cef0 osd_ping(e5 as_of 5) v1
osd.36.log:1038223:2011-03-11 12:38:57.171276 7f764cdcd940 RefCountedObject::put delete 0x7f762842cef0 took 23.7201 secs!
osd.36.log:1038224:2011-03-11 12:38:57.171288 7f764cdcd940 -- 172.17.40.25:6814/8529 >> 172.17.40.29:6817/6627 pipe(0x7f765001a9a0 sd=39 pgs=43 cs=1 l=0).handle_ack finished put on 0x7f762842cef0

-- Jim

> 
> sage
> 


