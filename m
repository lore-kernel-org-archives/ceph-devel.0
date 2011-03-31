From: Sage Weil <sage@newdream.net>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Thu, 31 Mar 2011 09:25:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1103310920460.13796@cobra.newdream.net>
References: <4D939FF7.1070104@sandia.gov> <Pine.LNX.4.64.1103301449400.18670@cobra.newdream.net>
 <4D948CAC.6040709@sandia.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52185 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758568Ab1CaQWD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Mar 2011 12:22:03 -0400
In-Reply-To: <4D948CAC.6040709@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 31 Mar 2011, Jim Schutt wrote:
> > I was actually suggesting we try to make it core dump inside the "delete
> > this" and watching for a stall in progress and then sending SIGABRT to dump
> > core in the act.  That way we verify it really is in the allocator (and
> > maybe even see where).  That's a bit harder to set up, though!  
> 
> Right, I couldn't think of how to automate that stall detection
> during the stall, rather than after.  At least, I couldn't
> think of how to do it without incurring possibly excessive
> overhead, say by starting a timer on every "delete this".

Yeah.  I wonder if dumping core on a cosd right when it gets marked down 
would do the trick?  That should catch it ~20 seconds or whatever in the 
stall.  By watching for the "osdfoo marked down" messages from ceph -w?

> > Dumping right after may still yield some useful info, but I'm less
> > hopeful...
> 
> I thought I might try turning off all debugging, except a notice
> that the "delete this" took too long.  This is easy to do, and
> would tell us if allocator activity in support of debugging is
> affecting operations.  It doesn't lead to any ideas for
> improving the situation, though :/
> 
> Also, since I built tcmalloc from source, I thought I might
> try to figure out what operation is taking too long there.
> I'm hoping Ceph logging redirection is set up so that stdout
> or stderr from tcmalloc would show up in my log files?

Not with the default logging stuff.  However, you can run the daemons with 
'-d' and they will stay in the foreground and log to stderr.  Or -f will 
send the ceph logs to their usual locations, but the daemon won't fork and 
you can redirect stdout/stderr (with any tcmalloc stuff) wherever you 
like.

sage
