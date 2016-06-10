From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: A Transformation of our Global Context
Date: Fri, 10 Jun 2016 18:51:38 -0400
Message-ID: <20160610225138.GA17481@ultraspiritum.eng.arb.redhat.com>
References: <20160610185033.GA29233@ultraspiritum.eng.arb.redhat.com>
 <CAJ4mKGatR70eFdKx4_RhPT3rHOp+pTz6VZBWy_mpAiK8j-TpMg@mail.gmail.com>
 <20160610195837.GB29233@ultraspiritum.eng.arb.redhat.com>
 <CAJ4mKGaSyKN+_52-+CSKhFXsL2WE+5T_Z6egpbBNaJvGs4a-Og@mail.gmail.com>
 <alpine.DEB.2.11.1606101616210.6221@cpach.fuggernut.com>
 <20160610210433.GA16959@ultraspiritum.eng.arb.redhat.com>
 <alpine.DEB.2.11.1606101716180.6221@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51336 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752555AbcFJWwM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 10 Jun 2016 18:52:12 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1606101716180.6221@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Gregory Farnum <gfarnum@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On 10/06/2016, Sage Weil wrote:
> The messengers aren't tied to CephContext, so I don't think this changes 

I'd thought each Messenger had a CephContext of its own and you'd want it to
line up with that of the person calling it if you're interested in making sure
logs go in the wrong places

> things in that regard.  I'm guessing we'll end up with something where 
> each entity has a thing that implements the Messenger interface but many 
> of those are sharing all their resources behind the scenes (thread pools, 
> multiplexing their connections, etc.).  We'll have to figure out how the 
> config options related to messenger itself are handled, but I think that 
> oddity needs to be done explicitly anyway.  We wouldn't for instance, want 
> to assume that all clusters in the same process must share the same 
> messenger options.  (Maybe we invent an entity that governs the shared 
> resources (process.NNN) and somehow direct config options/admin socket 
> commands/whatever toward that?  Who knows.)

That's also true, you can replumb things a fair bit.

> Is it pushed somewhere?  Maybe much of the pain is related to the clock 
> thing...

https://github.com/adamemerson/ceph/tree/wip-g_ceph_context-exterminate

There's more to be done on it, but that's what's there. The Clock thing might
help some, but the logging does seem to kill us.

It ended up becoming much more of a time sink than I expected it to so even if
we do end up going that route I need to do other things before I put much more
work into it. (I'm going to look at that reweighting bug for one thing.)

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
