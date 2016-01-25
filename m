From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: MonClient hunt interval
Date: Mon, 25 Jan 2016 06:45:17 -0800
Message-ID: <CAJ4mKGYs07FarHtvRHtZPXmY20KZCzFE2CVi3P2Gj7FQF5ESNQ@mail.gmail.com>
References: <CAOi1vP8PzDg6Hcf2Nck4_qXO1FHvJnqpE=uwF3jwp36FRLY6rQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36699 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755517AbcAYOpT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Jan 2016 09:45:19 -0500
Received: by mail-wm0-f52.google.com with SMTP id l65so66882167wmf.1
        for <ceph-devel@vger.kernel.org>; Mon, 25 Jan 2016 06:45:18 -0800 (PST)
In-Reply-To: <CAOi1vP8PzDg6Hcf2Nck4_qXO1FHvJnqpE=uwF3jwp36FRLY6rQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Jan 25, 2016 at 5:14 AM, Ilya Dryomov <idryomov@gmail.com> wrote:
> Hi Greg,
>
> With 794c86fd289b ("monc: backoff the timeout period when
> reconnecting") you made it so that the backoff is applied to the hunt
> interval.  When the session is established, the multiplier is reduced
> by 50% and that's it - I don't see any per-tick reduction or anything
> like that.
>
> If a client had some bad luck and couldn't establish the session for
> a while (so that the multiplier went all the way up to 10), its initial
> timeout upon the next connection break is going to be 15 seconds no
> matter how much time has passed in the interim.  Was that your intent?

I don't remember this, but looking at the sha I logged that behavior
in the commit message, so I'd have to say "yes". As it says, we're
trying to respond to monitor load; if they're doing so badly that we
had to increase our timeout when re-establishing a session, there's
every chance it will continue to be slow. If we reset the timeout back
to default, we'd have to go through a lot more monitor-punishing
timeout rounds on the next failure than just cutting it in half would
take.
-Greg
