From: John Spray <jspray@redhat.com>
Subject: Re: should CephContext be a singleton?
Date: Wed, 13 Sep 2017 16:16:50 +0100
Message-ID: <CALe9h7fsx9OCa8TFFz7OXtWzEDZOVPp-ZStDx4of6EcFR-0hJA@mail.gmail.com>
References: <1505314715.4822.24.camel@redhat.com> <20170913150915.GA31125@ultraspiritum.eng.arb.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f179.google.com ([209.85.128.179]:43751 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751093AbdIMPRM (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Sep 2017 11:17:12 -0400
Received: by mail-wr0-f179.google.com with SMTP id a43so1292056wrc.0
        for <ceph-devel@vger.kernel.org>; Wed, 13 Sep 2017 08:17:12 -0700 (PDT)
In-Reply-To: <20170913150915.GA31125@ultraspiritum.eng.arb.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Wed, Sep 13, 2017 at 4:09 PM, Adam C. Emerson <aemerson@redhat.com> wrote:
> On 13/09/2017, Jeff Layton wrote:
>> It contains stuff like admin sockets, and certain threads are tied to
>> it, etc. This seems like the sort of thing that should just have a
>> single instance per process. Should we start moving things in that
>> direction, or should I look at fixing this another way?
>
> There was a general consensus of removing use of the g_ceph_context
> variable. A PR of mine removed it from the object store, OSD and
> messenger, though other things needed doing so I haven't got around to
> removing the rest.

From going back and reading the "A Transformation of our Global
Context", it seems like the idea was more around separating the truly
global stuff out, rather than getting rid of the global variable as
such?  In that thread we retained a global thing called
ProcessContext.

The separation between process global stuff and per-cluster stuff
still seems entirely sensible, I don't know how much progress was made
with that for the RGW/RBD bits that have cluster-spanning daemons?

> If you have the cycles for it, feel free to start removing it from
> elsewhere and threading CephContext* in.
>
> There isn't really a consensus on splitting out CephContext so it's
> less of a God Object but it might be worth reconsidering that at some
> point.
>
> Also the lockdep stuff may be less of an issue as we move away from
> Mutex to std::mutex. (Though I do have a debugging mutex class that
> lets people into our lockdep code if we find that is an issue. I
> /suspect/ something like helgrind might be better for finding lock
> ordering errors.)

I was wondering about this the other day, does std::mutex give us the
cycle detection some other way?  lockdep is a seriously useful thing.

John

>
> --
> Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
> IRC: Aemerson@{RedHat, OFTC}
> 0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
