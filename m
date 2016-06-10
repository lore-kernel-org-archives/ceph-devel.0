From: Sage Weil <sage@newdream.net>
Subject: Re: A Transformation of our Global Context
Date: Fri, 10 Jun 2016 17:20:51 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1606101716180.6221@cpach.fuggernut.com>
References: <20160610185033.GA29233@ultraspiritum.eng.arb.redhat.com> <CAJ4mKGatR70eFdKx4_RhPT3rHOp+pTz6VZBWy_mpAiK8j-TpMg@mail.gmail.com> <20160610195837.GB29233@ultraspiritum.eng.arb.redhat.com> <CAJ4mKGaSyKN+_52-+CSKhFXsL2WE+5T_Z6egpbBNaJvGs4a-Og@mail.gmail.com>
 <alpine.DEB.2.11.1606101616210.6221@cpach.fuggernut.com> <20160610210433.GA16959@ultraspiritum.eng.arb.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36781 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868AbcFJVUZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Jun 2016 17:20:25 -0400
In-Reply-To: <20160610210433.GA16959@ultraspiritum.eng.arb.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Adam C. Emerson" <aemerson@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Fri, 10 Jun 2016, Adam C. Emerson wrote:
> On 10/06/2016, Sage Weil wrote:
> > I think the crux of the issue is the debug/logging code.  Almost all
> > the other uses of cct are related to config options that are
> > per-cluster.
> 
> That is correct. I thought we might pull some things like (like the
> Crypto stuff) while we were at it but that was more "As long as I'm
> here anyway I might as well see if there's anything more to do..."
> 
> > And with logging... it seems like even this is really a per-cluster
> > (well, per entity) thing.  Sorting through a log file that combines
> > output from two different objecters sounds horrific, and when we
> > cram multiple OSDs into one process, we're going to want them to
> > still feed into different log files.
> 
> This is a good point that I had not considered. Though, I'm not sure
> if the un-separated case is that much better. I think part of the
> savings we would want from multi-OSD work (at least in principle) is
> to be able to have them share messengers and other overhead. In that
> case giving each OSD its own fully fledged CephContext doesn't make
> sense, I don't think.

The messengers aren't tied to CephContext, so I don't think this changes 
things in that regard.  I'm guessing we'll end up with something where 
each entity has a thing that implements the Messenger interface but many 
of those are sharing all their resources behind the scenes (thread pools, 
multiplexing their connections, etc.).  We'll have to figure out how the 
config options related to messenger itself are handled, but I think that 
oddity needs to be done explicitly anyway.  We wouldn't for instance, want 
to assume that all clusters in the same process must share the same 
messenger options.  (Maybe we invent an entity that governs the shared 
resources (process.NNN) and somehow direct config options/admin socket 
commands/whatever toward that?  Who knows.)

> Some form of sterring might work, perhaps making the log system smart
> enough to shove things around based on subsystem or an entity
> identifier or something.
> 
> > How bad is the cct plumbing patch?  I fear this might still be the
> > best path forward...
> 
> It's not great? Really at all. I wrote it and I don't like it. I
> could pull it up and smack it into shape and make sure it passes tests
> if it were necessary.

Is it pushed somewhere?  Maybe much of the pain is related to the clock 
thing...

sage
