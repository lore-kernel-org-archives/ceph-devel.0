From: Sage Weil <sweil@redhat.com>
Subject: Re: random thoughts on past_intervals
Date: Fri, 9 Dec 2016 22:16:54 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1612092214330.5710@piezo.novalocal>
References: <CAN=+7FUSq49OxTbKNRO7xkay0MQAGyfZyBKnUnn+Nux-ysNVOA@mail.gmail.com> <CAN=+7FUBDFcDUVztaGh0xf2rU833HEM9ja2i1G5garSooEuJrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57428 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751121AbcLIWQ5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 9 Dec 2016 17:16:57 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2954C638
        for <ceph-devel@vger.kernel.org>; Fri,  9 Dec 2016 22:16:57 +0000 (UTC)
In-Reply-To: <CAN=+7FUBDFcDUVztaGh0xf2rU833HEM9ja2i1G5garSooEuJrw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 9 Dec 2016, Samuel Just wrote:
> In particular, we don't need PG::generate_past_intervals duplicating
> the logic in build_past_intervals_parallel since constructed PG
> objects only ever need to maintain a consistent past_intervals
> structure, never build it from scratch.

Sounds good to me.

My main question is:

> On Fri, Dec 9, 2016 at 11:59 AM, Samuel Just <sjust@redhat.com> wrote:
> > There's code for dealing with some odd past_intervals configurations
> > including doesn't go back far enough and doesn't go forward far
> > enough.  I *think* we can simplify this as follows:
> > 1) Once the PG object is constructed and in memory, past_intervals
> > extends from history.last_epoch_started to the PG's current map
> > 2) On disk, either 1) is true or the set is empty (after an import)
> >
> > On boot, the OSD generates past_intervals in parallel for any PGs
> > without them (and perhaps verifies 1) for the rest).  On receipt of a
> > Notify creating a PG, the OSD generates the past_intervals structure
> > before instantiating the PG using the same process as on boot --
> > starting with the included past_intervals if present (may not extend
> > to the current map, and so may need to be extended).

When does this actually happen?  If PGs are always in state 1, can we 
instead ensure that PG notify will always include past_intervals and that 
a received notify will never require us to go off do the (slow) work of 
loading up old maps to generate old intervals?

Then, we can focus our efforts on make the past_intervals representation 
compact (e.g., by discarding redundant intervals)...

sage
