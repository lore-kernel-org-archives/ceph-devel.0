From: Sage Weil <sweil@redhat.com>
Subject: RE: High CPU usage in Tiering Agent
Date: Fri, 12 Feb 2016 15:23:59 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1602121515270.4107@cpach.fuggernut.com>
References: <DUB403-EAS22267EA4719FB866706912FD5A90@phx.gbl> <alpine.DEB.2.11.1602121312170.4107@cpach.fuggernut.com> <DUB403-EAS146B9358CF393BC59C36360D5A90@phx.gbl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36206 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750714AbcBLUXj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 12 Feb 2016 15:23:39 -0500
In-Reply-To: <DUB403-EAS146B9358CF393BC59C36360D5A90@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Markus Blank-Burian <burian@muenster.de>
Cc: ceph-devel@vger.kernel.org

On Fri, 12 Feb 2016, Markus Blank-Burian wrote:
> In my tests, as a workaround I have set osd_agent_max_low_ops ==
> osd_agent_max_ops. As expected, while in low flush mode the agent now only
> iterates the objects until it finds something to flush, then waits.. and
> does nothing when at idle. I can see this from the log files. So if there is
> no side effect to this fix, I can test it later on our production system.
> For any advanced solution further reducing the agents load, I have too
> little knowledge about the internals. Just read through the code the first
> time today to find out what's going on.

Okay, I looked at this some more and see the issue now.  It's a bit 
confusing because the low/high thing is flush based but the agent does 
evicts too.  This basically means we may fail to keep up to max evict ops 
in flight when in low mode, but that seems just fine to me.

Can you take a look at this patch?

	https://github.com/ceph/ceph/pull/7631

Thanks!
sage

> 
> Markus
> 
> -----Original Message-----
> From: Sage Weil [mailto:sweil@redhat.com] 
> Sent: Freitag, 12. Februar 2016 19:13
> To: Markus Blank-Burian <burian@muenster.de>
> Subject: Re: High CPU usage in Tiering Agent
> 
> On Fri, 12 Feb 2016, Markus Blank-Burian wrote:
> > Hi,
> > 
> > I had an issue with major CPU usage on several OSDs. Looking further 
> > into this matter it turned out, that the tiering agent was iterating 
> > directories over and over. The metadata was all cached, so there was no
> disk activity.
> > 
> > If we have e.g. flush-mode low and evict-mode idle, then there are 
> > only osd_agent_max_low_ops concurrent requests allowed, but the check 
> > in OSDService::agent_entry only waits, if agent_ops >= 
> > osd_agent_max_ops. It would be straight forward to add an additional 
> > check for osd_agent_max_low_ops. Would there be any issues with the 
> > modifications in the attached patch?
> 
> That sounds reasonable to me.  Does it address the core problem though?  
> It sounds like what we really need is to limit the amount of non-op work the
> agent does...
> 
> sage
> 
> 
