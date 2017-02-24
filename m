From: John Spray <jspray@redhat.com>
Subject: Re: blacklisting etc
Date: Fri, 24 Feb 2017 11:28:13 +0000
Message-ID: <CALe9h7cb33S1K212GWmnBGxVHZpq=wckBO8rRGr_YePvYxGH2w@mail.gmail.com>
References: <CALe9h7c8YtA3YPUkwtOQzvqu-DTQpFXAHxvjUOdd-Ywx_9ccNg@mail.gmail.com>
 <1487763001.2886.1.camel@redhat.com> <CALe9h7e1fnnYw+_b68hm=XhdVXXMNY30WkcHk-geRBXqh7jbjQ@mail.gmail.com>
 <alpine.DEB.2.11.1702222056210.15623@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36053 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751082AbdBXL2g (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Feb 2017 06:28:36 -0500
Received: by mail-wm0-f51.google.com with SMTP id v77so12091370wmv.1
        for <ceph-devel@vger.kernel.org>; Fri, 24 Feb 2017 03:28:35 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1702222056210.15623@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Jeff Layton <jlayton@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Feb 22, 2017 at 8:57 PM, Sage Weil <sweil@redhat.com> wrote:
> On Wed, 22 Feb 2017, John Spray wrote:
>> On Wed, Feb 22, 2017 at 11:30 AM, Jeff Layton <jlayton@redhat.com> wrote:
>> > On Wed, 2017-02-22 at 10:57 +0000, John Spray wrote:
>> >> I meant to mention yesterday, I have a branch with the
>> >> mds-obeys-blacklist behaviour here:
>> >> https://github.com/jcsp/ceph/tree/wip-17980
>> >>
>> >
>> > Thanks, I'll take a look.
>> >
>> >> For the other side (blacklisting clients from the MDS), I also
>> >> remembered that we currently we have a precedent for special-casing an
>> >> mds->OSDMonitor operation, in the form of the MRemoveSnaps message.
>> >>
>> >> I think the options we currently have for blacklisting clients from the MDS are:
>> >>  A) Add a new MBlacklist message a la MRemoveSnaps
>> >>  B) Send a MMonCommand and special case the auth on the mon side to
>> >> allow any mds.* entity to run "osd blacklist add" without needing the
>> >> usual caps
>> >>  C) Send a MMonCommand and ask users/scripts setting up Ceph to
>> >> explicitly include the mon cap to run the blacklist command.
>> >>  D) Piggy-back a list of clients to evict on MMDSBeacon, where the MDS
>> >> daemon would trim that list once it saw that the blacklist had been
>> >> updated to include those clients.
>> >>
>> >> D is a bit circuitous, but I think it could be interesting as it would
>> >> let the mon exercise some discretion on whether to do the client
>> >> blacklisting or not, rather than giving the MDSs such power.
>> >>
>> >>
>> >
>> > Ugh...I had started working on an approach similar to B/C above, but
>> > missed the fact that the mds.* user would need the mon cap. That is a
>> > potential problem.
>> >
>> > A sounds fairly straightforward, and since all of this would require an
>> > updated MDS and monitor anyway, it might be the best approach.
>> >
>> > D sounds clever, but "fiddly". Under what circumstances would you want
>> > the monitor to ignore a request from an MDS to blacklist a client?
>>
>> Not sure, potentially things like implementing a "noevict" flag or
>> something that would let admins temporarily put any evictions on hold
>> when they know they're about to e.g. bounce a network switch --
>> obviously that would have to mean that MDSs were using the blacklist
>> as the only path for eviction, rather than evicting in SessionMap and
>> then also blacklisting.  It would also be possible to implement that
>> by just having the MDS daemons respect a flag in the MDS map though,
>> so maybe not the strongest case.
>>
>> Or maybe we could have some configuration that allowed admins to
>> selectively protect certain privileged clients from being
>> auto-evicted, that checked targets for eviction/blacklist against that
>> map.  However, again, if we stored that list in the MDSMap then there
>> is nothing preventing implementing that logic MDS side too.
>>
>> Come to think of it though, I'm being silly, because in case A we
>> could also have that message handled by mdsmonitor if we ever wanted
>> to have any special logic around handling it, so any special logic
>> would really be orthogonal to an A vs. D choice anyway.
>
> Yeah, I'd go with A.
>
> And for the 'noevict' case, that logic could also live in the MDS instead
> of the mon.

So on closer inspection I realised that adding a new message class
wasn't as neat as it first seemed -- the MRemoveSnaps is reliable
because it gets resent on new osdmaps if it hadn't taken effect, so
doesn't need normal resend logic.  Also, MRemoveSnaps was already
authenticating using an "osd pool rmsnap" MonCap, so it's
straightforward to grant the equivalent cap for blacklists, and then
send a normal MonCommand to get the resend logic for free.

Work in progress is here: https://github.com/jcsp/ceph/commits/wip-17980

John
