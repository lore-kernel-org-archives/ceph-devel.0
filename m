From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Smarter blacklisting?
Date: Tue, 18 Apr 2017 14:36:29 -0400
Message-ID: <CAJ4mKGZxf3RcZGub7PKkpDV_GDZPBXACtX1tVwxdw2SpS1cooA@mail.gmail.com>
References: <CALe9h7dh2=BYjSdSuPXKE457TWg06xrw6QOjmbk_tLvU5fd69w@mail.gmail.com>
 <alpine.DEB.2.11.1704181638530.6579@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:35027 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753933AbdDRSgd (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Apr 2017 14:36:33 -0400
Received: by mail-it0-f54.google.com with SMTP id 70so15411962ita.0
        for <ceph-devel@vger.kernel.org>; Tue, 18 Apr 2017 11:36:32 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1704181638530.6579@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Apr 18, 2017 at 12:41 PM, Sage Weil <sage@newdream.net> wrote:
> On Tue, 18 Apr 2017, John Spray wrote:
>> Currently, when we add an address to the blacklist, we leave it in
>> there for a set period of time (24 minutes by default, which I suspect
>> might have been meant to be 24 hours), and then expire it.
>>
>> Clearly there are two problems with that:
>>  * We leave things in the list for much longer than necessary most of
>> the time, when a blacklisted client/node comes back reasonably soon
>> after a restart
>>  * We are never 100% guaranteed that a long-halted client won't come
>> back after its blacklist entry has expired (e.g. a paused VM with
>> dirty pages, wakes up a day later and writes back to OSDs).
>>
>> These mostly haven't been too much trouble in practice, but we may be
>> (optionally) doing a lot more blacklisting on cephfs systems soon[1],
>> and cephfs clients are perhaps more likely to be VMs than RBD hosts.
>>
>> One thought is to have an alternative type of backlist entry that does
>> not have an expiration, but instead is automatically removed when we
>> see a client authenticate with the same auth id, from the same IP
>> address as the blacklist entry, but with a different nonce.
>>
>> Flushing out any blacklist entries from a host that never came back
>> would be an administrative operation, or we could do it automatically
>> on a *super* long expiration time (like a month), and in other cases
>> like if the auth identity associated with the blacklist entry was
>> removed.
>>
>> Any thoughts?
>
> I like it!  I'm not sure it needs to be a different type of entry,
> though... we can just set the expiration to one month, and then have some
> other bit of code remove it early based on the heuristic.
>
> I suspect the main logistical issue is who pays attention to the new auth
> or mount request from the client.  And where the cleanup heuristic
> lives..

I'd also be a little concerned about building up blacklist entries
over a long time period. Right now they just live in the OSDMap (as a
set?), and if we're keeping them for a month that could be an awful
lot of them. We may need to see if we can pull it out into a separate
structure, or at least encode them more efficiently in incrementals.

But I'd definitely like if we did something to try and clean them up
based on reconnecting clients. I can think of a few different ways to
go:
1) OSDs request entries be removed when they see a blacklist.
2) Servers report connected clients to the manager and it compares
them to the blacklist.
3) Clients which reconnect submit requests to the monitor directly.

What approach were you thinking of, John?
-Greg
