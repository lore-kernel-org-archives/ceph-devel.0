From: Yehuda Sadeh <yehuda@redhat.com>
Subject: Re: rados read ordering
Date: Mon, 8 Dec 2014 09:11:54 -0800
Message-ID: <CABBk=J9iA=iwAqOBrQ3zDpUvEDH2JA17+WJLRU2gLz_fFdF55w@mail.gmail.com>
References: <alpine.DEB.2.00.1412080855300.5263@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:34498 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831AbaLHRLz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Dec 2014 12:11:55 -0500
Received: by mail-ig0-f170.google.com with SMTP id r2so4473636igi.5
        for <ceph-devel@vger.kernel.org>; Mon, 08 Dec 2014 09:11:54 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1412080855300.5263@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Samuel Just <sjust@redhat.com>, Josh Durgin <jdurgin@redhat.com>, Jason Dillaman <dillaman@redhat.com>, zhiqiang.wang@intel.com, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Dec 8, 2014 at 9:03 AM, Sage Weil <sweil@redhat.com> wrote:
> The current RADOS behavior is that reads (on any given object) are always
> processed in the order they are submitted by the client.  This causes a
> few headaches for the cache tiering that it would be nice to avoid.  It
> also occurs to me that there are likely cases where we could go a lot
> faster by not strictly ordering things.  For example, a stat can respond
> more quickly than a large read, and some reads may hit cache while others
> go to disk.  This doesn't happen currently because of the (lame) way we do
> reads synchronously, but hope that can change too.
>
> I propose we drop this semantic.  If a client wants reads to have a strict
> ordering, they can set the existing RWORDERED flag (which also orders them
> with respect to writes).  That's not the most general thing ever, but I'm
> not sure we care about callers who want reads ordered with respect to each
> other but not writes.
>
> The real question is whether there are any users that want/need this
> currently.  I can't think of any offhand.  In several places we submit
> multiple *writes* and expect them to be strictly ordered (e.g., we
> set a completion on teh last write only).  I don't think we do this
> anywhere for reads though...
>
> Josh, Yehuda, Jason--can you think of any in RBD or RGW that would depend
> on this?
>

None that I can think of. For objects data, we already stripe it
across multiple objects, and the underlying assumption is that we're
going to get responses out of order so we make sure we commit
in-order. Guards are used on the head object, and the read is
synchronous there anyway. I can't think of any other place where we'd
have an issue.

Yehuda
