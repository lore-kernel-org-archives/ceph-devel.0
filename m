From: Sage Weil <sweil@redhat.com>
Subject: Re: 'mon_addr' vs 'public_addr'
Date: Tue, 23 Feb 2016 13:16:49 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1602231315450.7555@cpach.fuggernut.com>
References: <56CC9FFD.2030801@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45988 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754531AbcBWSRT (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 23 Feb 2016 13:17:19 -0500
In-Reply-To: <56CC9FFD.2030801@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joao Eduardo Luis <joao@suse.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, 'Gregory Farnum' <gfarnum@redhat.com>

On Tue, 23 Feb 2016, Joao Eduardo Luis wrote:
> Hi all,
> 
> does anyone remember the rationale behind not simply relying on
> 'public_addr' instead of 'mon_addr' for the monitors?
> 
> I keep coming back to this, and I keep thinking this must be an artefact
> of some long-gone era, during which public_addr maybe didn't exist? I

Yes.

> tried to backtrace its inception and ended up all the way in af870763
> back from 2009, but the commit itself didn't help much.
> 
> Any thoughts?

It's slightly tricky because we need to make mon addr still work.. but we 
can move all the docs refer to public_addr instead and make mon_addr 
override that if it is non-empty.

sage
