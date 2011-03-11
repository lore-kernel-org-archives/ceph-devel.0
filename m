From: Sage Weil <sage@newdream.net>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Fri, 11 Mar 2011 10:37:58 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1103111036450.23902@cobra.newdream.net>
References: <1297891508.25491.120.camel@sale659.sandia.gov>
 <75157CFDA63D45458FC47FB7BA6CB974@gmail.com> <1297893011.25491.124.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102161649560.11150@cobra.newdream.net>
 <Pine.LNX.4.64.1102161651380.11150@cobra.newdream.net>
 <1297957574.25491.152.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102170805080.22514@cobra.newdream.net>
 <1297985503.25491.175.camel@sale659.sandia.gov> <1299686572.4750.329.camel@sale659.sandia.gov>
 <2E7A0FAAE7EA416896A1990C7A96D59A@gmail.com> <1299695809.4750.346.camel@sale659.sandia.gov>
 <144B52A5BA504DCB992CD253287A397A@gmail.com> <1299798589.4750.372.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1103101515430.20133@cobra.newdream.net>
 <1299799936.4750.378.camel@sale659.sandia.gov> <Pine.LNX.4.64.1103101538100.20133@cobra.newdream.net>
 <1299867988.4750.394.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48085 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753171Ab1CKSfn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Mar 2011 13:35:43 -0500
In-Reply-To: <1299867988.4750.394.camel@sale659.sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 11 Mar 2011, Jim Schutt wrote:
> So none of those were osd_ping messages.
> 
> But, I still had lots of delayed acks.  Here's a couple more examples:
> 
> osd.0.log:960713:2011-03-11 10:55:32.117721 7fc4cb7fe940 -- 172.17.40.21:6802/28363 --> osd74 172.17.40.31:6808/24916 -- osd_ping(e14 as_of 14) v1 -- ?+0 0x7fc4cc16f270
> osd.0.log:960756:2011-03-11 10:55:32.118395 7fc4c96eb940 -- 172.17.40.21:6802/28363 >> 172.17.40.31:6808/24916 pipe(0x28fb580 sd=53 pgs=47 cs=1 l=0).writer encoding 289 0x7fc4cc16f270 osd_ping(e14 as_of 14) v1
> osd.0.log:960757:2011-03-11 10:55:32.118409 7fc4c96eb940 -- 172.17.40.21:6802/28363 >> 172.17.40.31:6808/24916 pipe(0x28fb580 sd=53 pgs=47 cs=1 l=0).writer sending 289 0x7fc4cc16f270
> osd.0.log:960758:2011-03-11 10:55:32.118422 7fc4c96eb940 -- 172.17.40.21:6802/28363 >> 172.17.40.31:6808/24916 pipe(0x28fb580 sd=53 pgs=47 cs=1 l=0).write_message 0x7fc4cc16f270 osd_ping(e14 as_of 14) v1

This bit has me confused:

> osd.0.log:963163:2011-03-11 10:55:32.941413 7fc4c61b6940 -- 172.17.40.21:6802/28363 >> 172.17.40.31:6808/24916 pipe(0x28fb580 sd=53 pgs=47 cs=1 l=0).reader got ack seq 289 >= 289 on 0x7fc4cc16f270 osd_ping(e14 as_of 14) v1
> osd.0.log:964273:2011-03-11 10:55:33.447526 7fc4c61b6940 RefCountedObject::put delete 0x7fc4cc16f270 took 5.06013 secs!
> osd.0.log:964274:2011-03-11 10:55:33.447538 7fc4c61b6940 -- 172.17.40.21:6802/28363 >> 172.17.40.31:6808/24916 pipe(0x28fb580 sd=53 pgs=47 cs=1 l=0).handle_ack finished put on 0x7fc4cc16f270

It looks like ~ .5 seconds has gone by for that thread, but the ::put 
debug says 5 seconds.  It happens between the 'got ack seq' and 'finished 
put' lines, though, right?  

sage
