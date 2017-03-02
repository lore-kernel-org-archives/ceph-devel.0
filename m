From: Matthew Sedam <sedammatthew@gmail.com>
Subject: Re: explicitly mapping pgs in OSDMap
Date: Wed, 1 Mar 2017 21:09:15 -0600
Message-ID: <CABPQP67RrSL6-naFj2MvJKcPRbCWkJDbWaRyN9rGdojiXcD0Xg@mail.gmail.com>
References: <alpine.DEB.2.11.1703011932530.651@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:35081 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752514AbdCBDJR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Mar 2017 22:09:17 -0500
Received: by mail-it0-f52.google.com with SMTP id 203so111134731ith.0
        for <ceph-devel@vger.kernel.org>; Wed, 01 Mar 2017 19:09:16 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1703011932530.651@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org

Sage,

Hi! I am a potential GSOC 2017 student, and I am interested in the
Ceph-mgr: Smarter Reweight_by_Utilization project. However, when
reading this I wondered if this proposed idea would make my GSOC
project effectively null and void. Could you elaborate on this?

Matthew Sedam

On Wed, Mar 1, 2017 at 1:44 PM, Sage Weil <sweil@redhat.com> wrote:
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
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
