From: John Spray <jspray@redhat.com>
Subject: Re: "debug ms = 0/5" logging ...
Date: Thu, 19 Oct 2017 13:06:24 +0100
Message-ID: <CALe9h7ey7ADZ6jSk29qqy-yBMVJAD1codOuaBGgn03ursadExg@mail.gmail.com>
References: <1508413648.27011.5.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f169.google.com ([209.85.128.169]:56953 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751579AbdJSMGp (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Oct 2017 08:06:45 -0400
Received: by mail-wr0-f169.google.com with SMTP id r79so8076718wrb.13
        for <ceph-devel@vger.kernel.org>; Thu, 19 Oct 2017 05:06:45 -0700 (PDT)
In-Reply-To: <1508413648.27011.5.camel@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Dillaman, Jason" <dillaman@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Oct 19, 2017 at 12:47 PM, Jason Dillaman <jdillama@redhat.com> wrote:
> While the default messenger logging setting has always been an
> impediment to high queue-depth, high IOPS workloads, in Luminous it
> appears to have slowed down librbd small block IOPS by an additional 10-
> 15%. When compared against cases where the messenger logs are disabled,
> it's more than a 40% IOPS degradation to have the messenger logs
> enabled.
>
> From some quick "perf" runs, the Luminous delta seems to be from from a
> few places: (1) hobject_t is now used in the OSD messages, and it's more
> expensive to construct[2] and print; (2) log messages are longer in
> length; and (3) async messenger is more verbose per message at log level
> 1 compared to simple messenger.
>
> I'd hate to advocate the sledge-hammer approach to say everyone should
> deploy librbd with "debug ms = 0" -- especially since I've relied on
> decoding the in-memory log messages from core dumps as a pseudo-librbd
> flight recorder in the past.
>
> This seems like an area that could use some team discussion and thought.
> Perhaps it would be possible to re-use tracepoint hooks where we keep
> the last X traces in-memory so that they can be dumped and/or are
> available in the core file. In theory that would at least reduce the
> expense of converting these trace-like log messages to expensive human
> readable strings.

What you suggest with tracepoints seems very sensible to me.

The extreme policy would be to say that all debug logging is really
just tracepoints done inefficiently -- in the case of Ceph we probably
only really care on that OSD IO path though.

John

>
> Thoughts?
>
> [1] http://tracker.ceph.com/issues/21846
> [2] http://tracker.ceph.com/issues/21845
>
> --
> Jason
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
