From: Sage Weil <sweil@redhat.com>
Subject: Re: High CPU usage in Tiering Agent
Date: Fri, 12 Feb 2016 13:13:39 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1602121313220.4107@cpach.fuggernut.com>
References: <DUB403-EAS22267EA4719FB866706912FD5A90@phx.gbl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40069 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751273AbcBLSNT (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 12 Feb 2016 13:13:19 -0500
In-Reply-To: <DUB403-EAS22267EA4719FB866706912FD5A90@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Markus Blank-Burian <burian@muenster.de>
Cc: 'Ceph Development' <ceph-devel@vger.kernel.org>

On Fri, 12 Feb 2016, Markus Blank-Burian wrote:
> Hi,
> 
> I had an issue with major CPU usage on several OSDs. Looking further into
> this matter it turned out, that the tiering agent was iterating directories
> over and over. The metadata was all cached, so there was no disk activity.
> 
> If we have e.g. flush-mode low and evict-mode idle, then there are only
> osd_agent_max_low_ops concurrent requests allowed, but the check in
> OSDService::agent_entry only waits, if agent_ops >= osd_agent_max_ops. It
> would be straight forward to add an additional check for
> osd_agent_max_low_ops. Would there be any issues with the modifications in
> the attached patch?

That sounds reasonable to me.  Does it address the core problem though?  
It sounds like what we really need is to limit the amount of non-op work 
the agent does...

sage

