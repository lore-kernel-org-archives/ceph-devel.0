From: Sage Weil <sage@newdream.net>
Subject: RE: Ceph watchdog-like thing to reduce IO block during process goes
 down by abort()
Date: Thu, 24 Mar 2016 16:55:14 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1603241646390.18774@cpach.fuggernut.com>
References: <27d3bfba39234f83b8441abc4e9aea92@R01UKEXCASM222.r01.fujitsu.local> <CACJqLyax9Nntz09qJF2E_jjtoVa2moJxzW5T42bHVFGLop31Ug@mail.gmail.com> <6845351a143d41a3932b37efddcc1f75@R01UKEXCASM222.r01.fujitsu.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59530 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbcCXUz3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Mar 2016 16:55:29 -0400
In-Reply-To: <6845351a143d41a3932b37efddcc1f75@R01UKEXCASM222.r01.fujitsu.local>
Content-ID: <alpine.DEB.2.11.1603241647211.18774@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Igor.Podoski@ts.fujitsu.com" <Igor.Podoski@ts.fujitsu.com>
Cc: Haomai Wang <haomaiwang@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 24 Mar 2016, Igor.Podoski@ts.fujitsu.com wrote:
> Ok, so back to slightly modified Sage idea:
> 
> Osd before abort() could write its ID (from **argv) to ceph-watchdog 
> named pipe. Only one could be hazard here - case when all osd's want to 
> notify watchdog in the same time. As I wrote before it would not be a 
> 'watchdog' process, but 'process down notify', so question is do we need 
> watchdog like thing for some other stuff (in the feature) or process 
> down notify will be sufficient?

I was imagining something that works the other way around, where the 
watchdog is very simple:

 - osd (or any daemon) opens a unix domain socket and identifies 
itself. e.g. "I am osd.123 at 1.2.3.4:6823"
 - if the socket is closed, the watchdog notifies the mon that there was a 
failure
 - the osd (or other daemon) can optionally send a message over the socket 
changing it's identifier (e.g, if the osd rebinds to a new ip).

This way the watchdog doesn't *do* anything except wait for new 
connections or for connections to close.  No polling of PIDs or anything 
like that.

We could figure out where the most common failures are (e.g., op thread 
timeout, or EIO), but I think in practice that will be hard--there are 
lots of places where as assert return values are 0.  An external watchdog, 
OTOH, would capture *all* of those cases, and the bugs.

The main concern I have is that the model doesn't work well when you have 
one daemon per host (e.g., microserver on an HDD).  Well, it works, but 
you double the number of monitor sessions.  Maybe that's okay, 
though--it's just an open TCP connection to a mon.

sage
