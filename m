From: Markus Blank-Burian <burian@muenster.de>
Subject: RE: High CPU usage in Tiering Agent
Date: Sat, 13 Feb 2016 12:44:56 +0100
Message-ID: <DUB403-EAS29005B8333CF9CF52F5810ED5AA0@phx.gbl>
References: <DUB403-EAS22267EA4719FB866706912FD5A90@phx.gbl> <alpine.DEB.2.11.1602121312170.4107@cpach.fuggernut.com> <DUB403-EAS146B9358CF393BC59C36360D5A90@phx.gbl> <alpine.DEB.2.11.1602121515270.4107@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from dub004-omc4s17.hotmail.com ([157.55.2.92]:55702 "EHLO
	DUB004-OMC4S17.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750992AbcBMLo7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Sat, 13 Feb 2016 06:44:59 -0500
In-Reply-To: <alpine.DEB.2.11.1602121515270.4107@cpach.fuggernut.com>
Content-Language: de
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: 'Sage Weil' <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org

Patch looks good, compiles and is now running on one host. During testing,
the agent queues were always empty, so there was no activity at all. Due to
a hardware upgrade, nearly all PGs are backfilling or waiting to backfill,
because of near full OSDs, so the new primaries have no data yet. Might take
a few days until I have test results.

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
