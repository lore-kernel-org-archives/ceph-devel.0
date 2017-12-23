From: Sage Weil <sage@newdream.net>
Subject: Re: Primary OSD not as first shard in PG - LRC experiment
Date: Sat, 23 Dec 2017 19:09:07 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1712231904440.14302@piezo.novalocal>
References: <CAODUPsGX3zXP0RTOs8EcPFDMTwd4=4i_yL2Pg02WqxgbB82XTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:33249 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757011AbdLWTJK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 23 Dec 2017 14:09:10 -0500
In-Reply-To: <CAODUPsGX3zXP0RTOs8EcPFDMTwd4=4i_yL2Pg02WqxgbB82XTw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Oleg Kolosov <olekol@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Sat, 23 Dec 2017, Oleg Kolosov wrote:
> Hi
> When ceph selects an OSD to act as primary, it is the first shard in
> the PG (shard[0]). When working with LRC plugin, this constraint
> greatly diminishes LRC's advantage. Ceph LRC plugin allows grouping of
> OSD, so that recovery would occur between them (local groups).
> However, since all recovery has to go through the primary OSD, in fact
> the recovery isn't really local. Only in case the primary OSD is in
> the same local group which contains the failed OSD the recovery is
> local.
> 
> I'm running LRC experiments on ceph and measure recovery by crashing a
> specific OSD. In order to bypass this and make LRC truly effective in
> my experiments, I was wondering if it is possible to manipulate the
> choice of the primary OSD.
> 
> For example, if I have a bucket which contains OSDs 0-10, and I always
> kill one of them, is it possible to force the primary also to be OSD
> 0-10 ?

Yes.  This has been a longstanding todo item for LRC but we haven't gotten 
around to doing it.  I think what's needed here is a change to the 
choose_acting logic in PG.cc that allows the EC plugin to weight in on 
which primary it prefers.  Some care will be needed to make sure this 
choice is reevaluated at the appropriate times (e.g., when backfill 
completes).  (Or possibly it won't matter since generally speaking which 
shard is primary doesn't matter after recovery.)

We'd also need to only consult the plugin after all OSDs in the shard have 
a feature bit indicating they do the same or else you can get into a loop 
where two OSDs keep giving primary back to each other.

I think the place to start is to add a method to the EC interface that 
allows the plugin to suggest a primary (or not, if it has no opinion), and 
to implement one for LRC that does the right thing.  (Some unit tests here 
would be good!)  The change to the choose_acting code would come 
next--that'll be trickier to get right but we can help!

Thanks-
sage

