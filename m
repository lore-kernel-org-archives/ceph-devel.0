From: Sage Weil <sage@inktank.com>
Subject: Re: [RFC PATCH 0/6] Understanding delays due to throttling under
 very heavy write load
Date: Wed, 20 Feb 2013 16:12:18 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302201551580.26205@cobra.newdream.net>
References: <1328111668-10068-1-git-send-email-jaschut@sandia.gov> <CAF3hT9DV46n0TwWOVC0LsCdd921uus3kzQfPLuMNEATjpYzT3g@mail.gmail.com> <4F29CDAA.408@sandia.gov> <CAF3hT9BZEP_FWS=qt8ivA++aDpPGGFzuD_PtMcvDRS2aDEN+hw@mail.gmail.com> <4F2AABF5.6050803@sandia.gov>
 <CAF3hT9BNc4n4HBNEqsf+d6-Rjv7TC8nJ1VponJCBVpLB8=_F5Q@mail.gmail.com> <4F47AEE3.5080305@sandia.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48573 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990Ab3BUAMS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Feb 2013 19:12:18 -0500
In-Reply-To: <4F47AEE3.5080305@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, ceph-devel@vger.kernel.org, sri@basam.org

Hi Jim,

I'm resurrecting an ancient thread here, but: we've just observed this on 
another big cluster and remembered that this hasn't actually been fixed.

I think the right solution is to make an option that will setsockopt on 
SO_RECVBUF to some value (say, 256KB).  I pushed a branch that does this, 
wip-tcp.  Do you mind checking to see if this addresses the issue (without 
manually adjusting things in /proc)?

And perhaps we should consider making this default to 256KB...

Thanks!
sage



On Fri, 24 Feb 2012, Jim Schutt wrote:

> On 02/02/2012 10:52 AM, Gregory Farnum wrote:
> > On Thu, Feb 2, 2012 at 7:29 AM, Jim Schutt<jaschut@sandia.gov>  wrote:
> > > I'm currently running 24 OSDs/server, one 1TB 7200 RPM SAS drive
> > > per OSD.  During a test I watch both OSD servers with both
> > > vmstat and iostat.
> > > 
> > > During a "good" period, vmstat says the server is sustaining>  2 GB/s
> > > for multiple tens of seconds.  Since I use replication factor 2, that
> > > means that server is sustaining>  500 MB/s aggregate client throughput,
> > > right?  During such a period vmstat also reports ~10% CPU idle.
> > > 
> > > During a "bad" period, vmstat says the server is doing ~200 MB/s,
> > > with lots of idle cycles.  It is during these periods that
> > > messages stuck in the policy throttler build up such long
> > > wait times.  Sometimes I see really bad periods with aggregate
> > > throughput per server<  100 MB/s.
> > > 
> > > The typical pattern I see is that a run starts with tens of seconds
> > > of aggregate throughput>  2 GB/s.  Then it drops and bounces around
> > > 500 - 1000 MB/s, with occasional excursions under 100 MB/s.  Then
> > > it ramps back up near 2 GB/s again.
> > 
> > Hmm. 100MB/s is awfully low for this theory, but have you tried to
> > correlate the drops in throughput with the OSD journals running out of
> > space? I assume from your setup that they're sharing the disk with the
> > store (although it works either way), and your description makes me
> > think that throughput is initially constrained by sequential journal
> > writes but then the journal runs out of space and the OSD has to wait
> > for the main store to catch up (with random IO), and that sends the IO
> > patterns all to hell. (If you can say that random 4MB IOs are
> > hellish.)
> > I'm also curious about memory usage as a possible explanation for the
> > more dramatic drops.
> 
> I've finally figured out what is going on with this behaviour.
> Memory usage was on the right track.
> 
> It turns out to be an unfortunate interaction between the
> number of OSDs/server, number of clients, TCP socket buffer
> autotuning, the policy throttler, and limits on the total
> memory used by the TCP stack (net/ipv4/tcp_mem sysctl).
> 
> What happens is that for throttled reader threads, the
> TCP stack will continue to receive data as long as there
> is available socket buffer, and the sender has data to send.
> 
> As each reader thread receives successive messages, the
> TCP socket buffer autotuning increases the size of the
> socket buffer.  Eventually, due to the number of OSDs
> per server and the number of clients trying to write,
> all the memory the TCP stack is allowed by net/ipv4/tcp_mem
> to use is consumed by the socket buffers of throttled
> reader threads.  When this happens, TCP processing is affected
> to the point that the TCP stack cannot send ACKs on behalf
> of the reader threads that aren't throttled.  At that point
> the OSD stalls until the TCP retransmit count on some connection
> is exceeded, causing it to be reset.
> 
> Since my OSD servers don't run anything else, the simplest
> solution for me is to turn off socket buffer autotuning
> (net/ipv4/tcp_moderate_rcvbuf), and set the default socket
> buffer size to something reasonable.  256k seems to be
> working well for me right now.
> 
> -- Jim
> 
> > -Greg
> > 
> > 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
