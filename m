From: Sage Weil <sage@newdream.net>
Subject: RE: Cache pool latency impact
Date: Wed, 14 Jan 2015 09:13:51 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1501140913330.30431@cobra.newdream.net>
References: <68A06213B74F1742A2C48216AE1BB6B808720E8A@SACMBXIP02.sdcorp.global.sandisk.com> <alpine.DEB.2.00.1501130553270.26676@cobra.newdream.net> <68A06213B74F1742A2C48216AE1BB6B808722384@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37290 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752086AbbANRNw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Jan 2015 12:13:52 -0500
In-Reply-To: <68A06213B74F1742A2C48216AE1BB6B808722384@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Pavan Rallabhandi <Pavan.Rallabhandi@sandisk.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, 14 Jan 2015, Pavan Rallabhandi wrote:
> Thanks for the reply Sage; please ignore the same subject mails on 
> ceph-users, they seem to have got delivered today.
> 
> > Hmm, we could have a 'noagent' option (similar to noout, nobackfill, 
> > noscrub, etc.) that lets the admin tell the system to stop tiering 
> > movements, but I'm not sure that's wht you're asking for...
> 
> Was not aware of 'notieragent' flag but I was hinting at a flow control 
> type of mechanism that would help throttling the client IOs versus the 
> service time of the tiering agent to flush/evict.

There is also

	osd_agent_max_ops = 4

which is a coarse control but may be sufficient for you?

sage



> 

> Thanks,
> -Pavan.
> 
> -----Original Message-----
> From: Sage Weil [mailto:sage@newdream.net]
> Sent: Tuesday, January 13, 2015 7:31 PM
> To: Pavan Rallabhandi
> Cc: Ceph Development
> Subject: Re: Cache pool latency impact
> 
> On Tue, 13 Jan 2015, Pavan Rallabhandi wrote:
> > Hi,
> >
> > This is regarding cache pools and the impact of the flush/evict on the
> > client IO latencies.
> >
> > Am seeing a direct impact on the client IO latencies (making them
> > worse) when flush/evict is triggered on the cache pool. In a constant
> > ingress of IOs on the cache pool, the write performance is no better
> > than without cache pool, because it is limited to the speed at which
> > objects can be flushed/evicted to the backend pool.
> 
> Yeah, this is always going to be true in general.  It is a lot for work to write into the cache, read it back, write it again into the base pool, and then delete it from the cache than it is to write directly to the base pool.
> 
> > > The questions I have are:
> >
> > 1) When the flush/evict is in progress, are the writes on the cache
> > pool blocked, either at the PG or at object granularity? Though I see
> > a blocking flag honored per object context in
> > ReplicatedPG::start_flush() and most of the callers seem to set the flag to be false.
> 
> Normally they are not blocked.  The agent starts working (finding objects to flush or evict) long before we hit the cut cutoff where it starts blocking.  Once it does hit that threshold, though, things can get slow, because new cache creates aren't allowed until some eviction completes.  You don't want to be in this situation.  :)
> 
> In general, if you have a lot of data inject, caching (at least in
> firefly) isn't a terribly good idea.  The exception would probably be when you have a high skew toward recent data (say you are injecting market data, and do tons of analytics on the last 24 hours, but then the data gets colder).
> 
> I can't tell if you're in the situation where the cache pool is full and the agent is flushing/evicing anything and everything and writes are crawling (you should see a message in 'ceph health' when this happens) or that the agent is alive but working with low effort and the impact is still high.  If it's the latter I'm not sure yet what is going wrong..
> perhaps you can capture a few minutes of log from one of your OSDs?
> (debug ms = 1, debug osd = 20).
> 
> > 2) Is there any mechanism (that I might have overlooked) to avoid this
> > situation, by throttling the flush/evict operations on the fly? If
> > not, shouldn't there be one?
> 
> Hmm, we could have a 'noagent' option (similar to noout, nobackfill, noscrub, etc.) that lets the admin tell the system to stop tiering movements, but I'm not sure that's wht you're asking for...
> 
> sage
> 
> ________________________________
> 
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> 
> 
