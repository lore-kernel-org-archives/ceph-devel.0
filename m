From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: full cluster/pool handling
Date: Thu, 24 Sep 2015 07:43:13 -0700
Message-ID: <CADRKj5S0L-tH51nsjrChP16GCc8hJaMRBOp8nOZg9XRZzQFU1A@mail.gmail.com>
References: <alpine.DEB.2.00.1509240523510.13834@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:36483 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbbIXOnO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Sep 2015 10:43:14 -0400
Received: by oibi136 with SMTP id i136so42537431oib.3
        for <ceph-devel@vger.kernel.org>; Thu, 24 Sep 2015 07:43:14 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1509240523510.13834@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Sep 24, 2015 at 5:30 AM, Sage Weil <sweil@redhat.com> wrote:
> Xuan Liu recently pointed out that there is a problem with our handling
> for full clusters/pools: we don't allow any writes when full,
> including delete operations.
>
> While fixing a separate full issue I ended up making several fixes and
> cleanups in the full handling code in
>
>         https://github.com/ceph/ceph/pull/6052
>
> The interesting part of that is that we will allow a write as long as it
> doesn't increase the overall utilizate of bytes or objects (according to
> the pg stats we're maintaining).  That will include remove ops, of cours,
> but will also allow overwrites while full, which seems fair.
>
> However, that's not quite the full story: the client side currently
> does not send any requests while the full flag is set--it waits until the
> full flags are cleared before resending things.
>
> We can modify things on the client so that it allows ops it knows will
> succeed (e.g., a simple remove op).  However, if there is another op also
> queued on that object *before* it, we should either block the remove op
> (to preserve ordering) or discard it when the remove succeeds (on the
> assumption that any effect it had is now moot).

What if it was a compound operation that truncates and writes?

>
> Is the latter option safe?
>
> Or, should we do something more clever?  Ideally it would be good if other
> allowed operations are let through, but unfortunately the client doesn't
> really know enough to tell whether it will/can succeed.  e.g., a class
> "refcount.put" call might result in a deletion (and in fact there is a
> class that does just that).  We could also send all such requests and, if

rgw (tail) object removals are using this objclass.

> we get ENOSPC, keep them queued and retry when the full flag is cleared.
> That would require a bit more complexity on the OSD side to preserve
> ordering, but it's doable...
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
