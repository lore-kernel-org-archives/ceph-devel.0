From: John Spray <jspray@redhat.com>
Subject: Re: Smarter blacklisting?
Date: Wed, 19 Apr 2017 13:02:57 +0100
Message-ID: <CALe9h7e6qY_yqzsFzsGNNVi2DG_JwNEti=gP-pkB_LZiXu5_ig@mail.gmail.com>
References: <CALe9h7dh2=BYjSdSuPXKE457TWg06xrw6QOjmbk_tLvU5fd69w@mail.gmail.com>
 <alpine.DEB.2.11.1704181638530.6579@piezo.novalocal> <CAJ4mKGZxf3RcZGub7PKkpDV_GDZPBXACtX1tVwxdw2SpS1cooA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:33484 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933408AbdDSMDa (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Apr 2017 08:03:30 -0400
Received: by mail-wm0-f42.google.com with SMTP id y18so17471424wmh.0
        for <ceph-devel@vger.kernel.org>; Wed, 19 Apr 2017 05:03:24 -0700 (PDT)
In-Reply-To: <CAJ4mKGZxf3RcZGub7PKkpDV_GDZPBXACtX1tVwxdw2SpS1cooA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Sage Weil <sage@newdream.net>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Apr 18, 2017 at 7:36 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
> On Tue, Apr 18, 2017 at 12:41 PM, Sage Weil <sage@newdream.net> wrote:
>> On Tue, 18 Apr 2017, John Spray wrote:
>>> Currently, when we add an address to the blacklist, we leave it in
>>> there for a set period of time (24 minutes by default, which I suspect
>>> might have been meant to be 24 hours), and then expire it.
>>>
>>> Clearly there are two problems with that:
>>>  * We leave things in the list for much longer than necessary most of
>>> the time, when a blacklisted client/node comes back reasonably soon
>>> after a restart
>>>  * We are never 100% guaranteed that a long-halted client won't come
>>> back after its blacklist entry has expired (e.g. a paused VM with
>>> dirty pages, wakes up a day later and writes back to OSDs).
>>>
>>> These mostly haven't been too much trouble in practice, but we may be
>>> (optionally) doing a lot more blacklisting on cephfs systems soon[1],
>>> and cephfs clients are perhaps more likely to be VMs than RBD hosts.
>>>
>>> One thought is to have an alternative type of backlist entry that does
>>> not have an expiration, but instead is automatically removed when we
>>> see a client authenticate with the same auth id, from the same IP
>>> address as the blacklist entry, but with a different nonce.
>>>
>>> Flushing out any blacklist entries from a host that never came back
>>> would be an administrative operation, or we could do it automatically
>>> on a *super* long expiration time (like a month), and in other cases
>>> like if the auth identity associated with the blacklist entry was
>>> removed.
>>>
>>> Any thoughts?
>>
>> I like it!  I'm not sure it needs to be a different type of entry,
>> though... we can just set the expiration to one month, and then have some
>> other bit of code remove it early based on the heuristic.
>>
>> I suspect the main logistical issue is who pays attention to the new auth
>> or mount request from the client.  And where the cleanup heuristic
>> lives..
>
> I'd also be a little concerned about building up blacklist entries
> over a long time period. Right now they just live in the OSDMap (as a
> set?), and if we're keeping them for a month that could be an awful
> lot of them. We may need to see if we can pull it out into a separate
> structure, or at least encode them more efficiently in incrementals.

I was already pondering where the more detailed blacklist info (e.g.
ids of clients) should go, as it's not something that actually needs
to be shared with all the normal OSDMap subscribers (it's only the
entity that does the blacklist removal that needs to see that).  It's
already not ideal imho that we expose the list of all blacklisted
clients to all the other clients -- in general they shouldn't be able
to e.g. learn one another's addresses like this.

However, the list of blacklisted addresses of course needs to be in
the osdmap, if you're not in the list that's visible to OSDs, you're
not really blacklisted (blacklist updates are already transmitted
incrementally).

We could impose a maximum blacklist size, and automatically remove the
oldest entries beyond that threshold.  However, in practice the system
needs to be able to handle a blacklist of size O(number of clients),
so I'm not sure what we would set that limit to.

Anyway, there can be some separation of concerns here -- in the first
instance we could have a change that adds the intelligent blacklist
cleaning without increasing the overall expiry time, and then later
something that increases the expiry time and adds better mechanisms
for handling unexpected growth in the size of the blacklist.

> But I'd definitely like if we did something to try and clean them up
> based on reconnecting clients. I can think of a few different ways to
> go:
> 1) OSDs request entries be removed when they see a blacklist.
> 2) Servers report connected clients to the manager and it compares
> them to the blacklist.
> 3) Clients which reconnect submit requests to the monitor directly.
>
> What approach were you thinking of, John?

The mon already sees every client start (when its MonClient comes up
and authenticates), so I would generate blacklist removals in the
monitor when a client opens a session.  As a cluster map update it
would flow through the mon anyway, so probably not much value trying
to do it anywhere else.

John

> -Greg
