From: Sage Weil <sage@newdream.net>
Subject: Re: rbd top
Date: Mon, 15 Jun 2015 06:52:34 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1506150647030.18741@cobra.newdream.net>
References: <CAANLjFp4+tkSj5=we88nGDFh0NtmX4jYc+sE__1N8L_4X30dfw@mail.gmail.com> <CAC6JEv8qB6xStrp1EL+gyDWAzVo91DvtDQKyMs9VDB2KtoVR6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38298 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940AbbFONwf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Jun 2015 09:52:35 -0400
In-Reply-To: <CAC6JEv8qB6xStrp1EL+gyDWAzVo91DvtDQKyMs9VDB2KtoVR6A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Robert LeBlanc <robert@leblancnet.us>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, 15 Jun 2015, Gregory Farnum wrote:
> On Thu, Jun 11, 2015 at 12:33 PM, Robert LeBlanc <robert@leblancnet.us> wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA256
> >
> > One feature we would like is an "rbd top" command that would be like
> > top, but show usage of RBD volumes so that we can quickly identify
> > high demand RBDs.
> >
> > Since I haven't done any programming for Ceph, I'm trying to think
> > through the best way to approach this. I don't know if there are
> > already perf counters that I can query that are at the client, RBD or
> > the Rados layers. If these counters don't exist would it be best to
> > implement them at the client layer and look for watchers on the RBD
> > and query them? Is it better to handle it at the Rados layer and
> > aggregate the I/O from all chunks? Of course this would need to scale
> > out very large.
> >
> > It seems that if the client running rbd top requests the top 'X'
> > number of objects from each OSD, then it would cut down on the data
> > that the has to be moved around and processed. It wouldn't be an
> > extremely accurate view, but might be enough.
> >
> > What are your thoughts?
> >
> > Also, what is the best way to get into the Ceph code? I've looked at
> > several things and I find myself doing a lot of searching to find
> > connecting pieces. My primary focus is not programming so picking up a
> > new code base takes me a long time because I don't know many of the
> > tricks that help people get to speed quickly.
> 
> The basic problem with a tool like this is that it requires gathering
> real-time data from either all the OSDs, or all the clients. We do
> something similar in order to display approximate IO going through the
> system as a whole, but that is based on PGStat messages which come in
> periodically and is both laggy and an approximation.
> 
> To do this, we'd need to get less-laggy data, and instead of scaling
> with the number of OSDs/PGs it would scale with the number of RBD
> volumes. You certainly couldn't send that through the monitor and I
> shudder to think about the extra load it would invoke at all layers.
> 
> How up-to-date do you need the info to be, and how accurate? Does it
> need to be queryable in the future or only online? You could perhaps
> hook into one of the more precise HitSet implementations we
> have...otherwise I think you'd need to add an online querying
> framework, perhaps through the perfcounters (which...might scale to
> something like this?) or a monitoring service (hopefully attached to
> Calamari) that receives continuous updates.

I seem to remember having a short conversation about something like this a 
few CDS's back... although I think it was 'rados top'.  IIRC the basic 
idea we had was for each OSD to track it's top clients (using some 
approximate LRU type algorithm) and then either feed this relatively small 
amount of info (say, top 10-100 clients) back to the mon for summation, 
or dump via the admin socket for calamari to aggregate.

This doesn't give you the rbd image name, but I bet we could infer that 
without too much trouble (e.g., include a recent object or two with the 
client).  Or, just assume that client id is enough (it'll include an IP 
and PID... enough info to find the /var/run/ceph admin socket or the VM 
process.

If we were going to do top clients, I think it'd make sense to also have a 
top objects list as well, so you can see what the hottest objects in the 
cluster are.

sage
