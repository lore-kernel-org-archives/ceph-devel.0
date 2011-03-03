From: Sage Weil <sage@newdream.net>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Thu, 3 Mar 2011 10:04:33 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1103031003350.25732@cobra.newdream.net>
References: <1297891508.25491.120.camel@sale659.sandia.gov>
 <75157CFDA63D45458FC47FB7BA6CB974@gmail.com> <1297893011.25491.124.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102161649560.11150@cobra.newdream.net>
 <Pine.LNX.4.64.1102161651380.11150@cobra.newdream.net>
 <1297957574.25491.152.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102170805080.22514@cobra.newdream.net>
 <1298483538.25491.233.camel@sale659.sandia.gov> <460F770CEB1C499F8B87593762171483@gmail.com>
 <1298489031.25491.250.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1103011646140.32424@cobra.newdream.net>
 <1299079262.4750.19.camel@sale659.sandia.gov> <Pine.LNX.4.64.1103020909170.27567@cobra.newdream.net>
 <1299099295.4750.41.camel@sale659.sandia.gov> <Pine.LNX.4.64.1103021342540.27567@cobra.newdream.net>
 <1299103144.4750.49.camel@sale659.sandia.gov> <1299106628.4750.62.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1103022102240.32695@cobra.newdream.net>
 <1299173302.4750.98.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58789 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753724Ab1CCSCi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Mar 2011 13:02:38 -0500
In-Reply-To: <1299173302.4750.98.camel@sale659.sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 3 Mar 2011, Jim Schutt wrote:
> 
> On Wed, 2011-03-02 at 22:03 -0700, Sage Weil wrote:
> > > I'm not sure how to track down what's happening here...
> > 
> > Hmm.  I'm not able to reproduce this here (tho I only have ~15 nodes 
> > available at the moment).  Seeing the last bit of the logs on the crashed 
> > nodes will help.
> > 

Can you confirm that the chdir is working now?  Maybe put an assert(0) in 
tick() so we can verify core dumps are working in general?

Also, can you confirm that there's nothing interesting in dmesg on these 
nodes (like OOM)?

Thanks-
sage


> 
> So this might be interesting.  In my last email, osd.15.log ended with
> 
> 2011-03-03 08:35:29.933436 7fb3d545c940 -- 172.17.40.22:6821/27793 >> 172.17.40.34:6789/0 pipe(0x7fb3c4001270 sd=12 pgs=2580 cs=1 l=1).do_sendmail short write did 195207, still have 91335
> 
> 
> It occurred to me you might like to know what thread
> 7fb3d545c940 was doing when it got that short write:
> 
> # grep 7fb3d545c940 osd.15.log | tail
> 2011-03-03 08:32:33.108190 7fb3d545c940 -- 172.17.40.22:6821/27793 >> 172.17.40.34:6789/0 pipe(0x7fb3c4001270 sd=12 pgs=2580 cs=1 l=1).writer encoding 45 0x7fb3c4ad6970 pg_stats(1228 pgs v 6) v1
> 2011-03-03 08:32:33.114972 7fb3d545c940 -- 172.17.40.22:6821/27793 >> 172.17.40.34:6789/0 pipe(0x7fb3c4001270 sd=12 pgs=2580 cs=1 l=1).writer sending 45 0x7fb3c4ad6970
> 2011-03-03 08:32:33.115001 7fb3d545c940 -- 172.17.40.22:6821/27793 >> 172.17.40.34:6789/0 pipe(0x7fb3c4001270 sd=12 pgs=2580 cs=1 l=1).write_message 0x7fb3c4ad6970
> 2011-03-03 08:34:01.154979 7fb3d545c940 -- 172.17.40.22:6821/27793 >> 172.17.40.34:6789/0 pipe(0x7fb3c4001270 sd=12 pgs=2580 cs=1 l=1).writer: state = 2 policy.server=0
> 2011-03-03 08:34:01.154991 7fb3d545c940 -- 172.17.40.22:6821/27793 >> 172.17.40.34:6789/0 pipe(0x7fb3c4001270 sd=12 pgs=2580 cs=1 l=1).write_keepalive
> 2011-03-03 08:34:01.155010 7fb3d545c940 -- 172.17.40.22:6821/27793 >> 172.17.40.34:6789/0 pipe(0x7fb3c4001270 sd=12 pgs=2580 cs=1 l=1).write_ack 29
> 2011-03-03 08:34:01.155041 7fb3d545c940 -- 172.17.40.22:6821/27793 >> 172.17.40.34:6789/0 pipe(0x7fb3c4001270 sd=12 pgs=2580 cs=1 l=1).writer encoding 46 0x7fb3c4b9fd90 pg_stats(1228 pgs v 6) v1
> 2011-03-03 08:34:01.163035 7fb3d545c940 -- 172.17.40.22:6821/27793 >> 172.17.40.34:6789/0 pipe(0x7fb3c4001270 sd=12 pgs=2580 cs=1 l=1).writer sending 46 0x7fb3c4b9fd90
> 2011-03-03 08:34:01.163069 7fb3d545c940 -- 172.17.40.22:6821/27793 >> 172.17.40.34:6789/0 pipe(0x7fb3c4001270 sd=12 pgs=2580 cs=1 l=1).write_message 0x7fb3c4b9fd90
> 2011-03-03 08:35:29.933436 7fb3d545c940 -- 172.17.40.22:6821/27793 >> 172.17.40.34:6789/0 pipe(0x7fb3c4001270 sd=12 pgs=2580 cs=1 l=1).do_sendmail short write did 195207, still have 91335
> 
> I assume this means the short write happened on sending
> pg_stats? 172.17.40.34 is where my monitor is running.
> 
> -- Jim
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
