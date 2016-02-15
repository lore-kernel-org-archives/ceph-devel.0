From: Markus Blank-Burian <burian@muenster.de>
Subject: RE: High CPU usage in Tiering Agent
Date: Mon, 15 Feb 2016 14:05:31 +0100
Message-ID: <DUB403-EAS199B9DC7E2E0C50A9037026D5AC0@phx.gbl>
References: <DUB403-EAS22267EA4719FB866706912FD5A90@phx.gbl> <alpine.DEB.2.11.1602121312170.4107@cpach.fuggernut.com> <DUB403-EAS146B9358CF393BC59C36360D5A90@phx.gbl> <alpine.DEB.2.11.1602121515270.4107@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from dub004-omc4s18.hotmail.com ([157.55.2.93]:53555 "EHLO
	DUB004-OMC4S18.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751114AbcBONFe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Mon, 15 Feb 2016 08:05:34 -0500
In-Reply-To: <alpine.DEB.2.11.1602121515270.4107@cpach.fuggernut.com>
Content-Language: de
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: 'Sage Weil' <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org

All OSDs now run with the patch. Logfiles look good (agent flushes in low
mode with 2 ops and then waits), cpu / disk usage normal. Thanks for the
quick response!

Markus

-----Original Message-----
From: Sage Weil [mailto:sweil@redhat.com] 
Sent: Freitag, 12. Februar 2016 21:24
To: Markus Blank-Burian <burian@muenster.de>
Cc: ceph-devel@vger.kernel.org
Subject: RE: High CPU usage in Tiering Agent

On Fri, 12 Feb 2016, Markus Blank-Burian wrote:
> In my tests, as a workaround I have set osd_agent_max_low_ops == 
> osd_agent_max_ops. As expected, while in low flush mode the agent now 
> only iterates the objects until it finds something to flush, then 
> waits.. and does nothing when at idle. I can see this from the log 
> files. So if there is no side effect to this fix, I can test it later on
our production system.
> For any advanced solution further reducing the agents load, I have too 
> little knowledge about the internals. Just read through the code the 
> first time today to find out what's going on.

Okay, I looked at this some more and see the issue now.  It's a bit
confusing because the low/high thing is flush based but the agent does
evicts too.  This basically means we may fail to keep up to max evict ops in
flight when in low mode, but that seems just fine to me.

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
> > directories over and over. The metadata was all cached, so there was 
> > no
> disk activity.
> > 
> > If we have e.g. flush-mode low and evict-mode idle, then there are 
> > only osd_agent_max_low_ops concurrent requests allowed, but the 
> > check in OSDService::agent_entry only waits, if agent_ops >= 
> > osd_agent_max_ops. It would be straight forward to add an additional 
> > check for osd_agent_max_low_ops. Would there be any issues with the 
> > modifications in the attached patch?
> 
> That sounds reasonable to me.  Does it address the core problem though?  
> It sounds like what we really need is to limit the amount of non-op 
> work the agent does...
> 
> sage
> 
> 
