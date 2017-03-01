From: Dan van der Ster <dan@vanderster.com>
Subject: Re: explicitly mapping pgs in OSDMap
Date: Wed, 1 Mar 2017 21:49:50 +0100
Message-ID: <CABZ+qqn3f2+eGfSP=fuB-eGSAyrK6eCJ2XjWiBAWyourfyrpGA@mail.gmail.com>
References: <alpine.DEB.2.11.1703011932530.651@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38833 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753394AbdCAVvv (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Mar 2017 16:51:51 -0500
Received: by mail-wm0-f45.google.com with SMTP id u199so47219045wmd.1
        for <ceph-devel@vger.kernel.org>; Wed, 01 Mar 2017 13:51:47 -0800 (PST)
Received: from mail-wr0-f181.google.com (mail-wr0-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id g23sm8452178wme.27.2017.03.01.12.50.31
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Mar 2017 12:50:31 -0800 (PST)
Received: by mail-wr0-f181.google.com with SMTP id g10so38655011wrg.2
        for <ceph-devel@vger.kernel.org>; Wed, 01 Mar 2017 12:50:31 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1703011932530.651@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Mar 1, 2017 at 8:44 PM, Sage Weil <sweil@redhat.com> wrote:
> There's been a longstanding desire to improve the balance of PGs and data
> across OSDs to better utilize storage and balance workload.  We had a few
> ideas about this in a meeting last week and I wrote up a summary/proposal
> here:
>
>         http://pad.ceph.com/p/osdmap-explicit-mapping
>
> The basic idea is to have the ability to explicitly map individual PGs
> to certain OSDs so that we can move PGs from overfull to underfull
> devices.  The idea is that the mon or mgr would do this based on some
> heuristics or policy and should result in a better distribution than teh
> current osd weight adjustments we make now with reweight-by-utilization.
>
> The other key property is that one reason why we need as many PGs as we do
> now is to get a good balance; if we can remap some of them explicitly, we
> can get a better balance with fewer.  In essense, CRUSH gives an
> approximate distribution, and then we correct to make it perfect (or close
> to it).
>
> The main challenge is less about figuring out when/how to remap PGs to
> correct balance, but figuring out when to remove those remappings after
> CRUSH map changes.  Some simple greedy strategies are obvious starting
> points (e.g., to move PGs off OSD X, first adjust or remove existing remap
> entries targetting OSD X before adding new ones), but there are a few
> ways we could structure the remap entries themselves so that they
> more gracefully disappear after a change.
>
> For example, a remap entry might move a PG from OSD A to B if it maps to
> A; if the CRUSH topology changes and the PG no longer maps to A, the entry
> would be removed or ignored.  There are a few ways to do this in the pad;
> I'm sure there are other options.
>
> I put this on the agenda for CDM tonight.  If anyone has any other ideas
> about this we'd love to hear them!
>

Hi Sage. This would be awesome! Seriously, it would let us run multi
PB clusters closer to being full -- 1% of imbalance on a 100 PB
cluster is *expensive* !!

I can't join the meeting, but here are my first thoughts on the implementation.

First, since this is a new feature, it would be cool if it supported
non-trivial topologies from the beginning -- i.e. the trivial topology
is when all OSDs should have equal PGs/weight. A non-trivial topology
is where only OSDs beneath a user-defined crush bucket are balanced.

And something I didn't understand about the remap format options --
when the cluster topology changes, couldn't we just remove all
remappings and start again? If you use some consistent method for the
remaps, shouldn't the result anyway remain similar after incremental
topology changes?

In the worst case, remaps will only form maybe 10-20% of PGs. Clearly
we don't want to shuffle those for small topology changes, but for
larger changes perhaps we can accept those to move.

-- Dan

> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
