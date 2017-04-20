From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: Smarter blacklisting?
Date: Thu, 20 Apr 2017 09:09:20 -0400
Message-ID: <CA+aFP1CyAL9AA2w9Sd3Vzhj-DOcfhCHNu3AmKmCx=S36U252Tg@mail.gmail.com>
References: <CALe9h7dh2=BYjSdSuPXKE457TWg06xrw6QOjmbk_tLvU5fd69w@mail.gmail.com>
 <alpine.DEB.2.11.1704181638530.6579@piezo.novalocal> <CAJ4mKGZxf3RcZGub7PKkpDV_GDZPBXACtX1tVwxdw2SpS1cooA@mail.gmail.com>
 <CALe9h7e6qY_yqzsFzsGNNVi2DG_JwNEti=gP-pkB_LZiXu5_ig@mail.gmail.com>
 <alpine.DEB.2.11.1704191315210.6575@piezo.novalocal> <f354a27c-931d-ce64-4fa4-e4f6d802998d@redhat.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f170.google.com ([209.85.161.170]:35890 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753990AbdDTNJW (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Apr 2017 09:09:22 -0400
Received: by mail-yw0-f170.google.com with SMTP id j9so38016965ywj.3
        for <ceph-devel@vger.kernel.org>; Thu, 20 Apr 2017 06:09:21 -0700 (PDT)
In-Reply-To: <f354a27c-931d-ce64-4fa4-e4f6d802998d@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, John Spray <jspray@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Mike Christie <mchristi@redhat.com>

We didn't fully flesh it out, but I believe we were talking about
iSCSI persistent group reservations and how we could pseudo-blacklist
a (stale) client after the reservation has been updated. The current
approach to handle PGRs requires two round-trips for each IO to (1)
verify the current PGR state and (2) issue the IO if the reservation
is still active. Not only will this be slow due to the extra
round-trip -- it's taking advantage of some ambiguity in the spec with
regard to how in-flight IOs would react given a PGR update.

In order to eliminate this extra round-trip, we need some way for the
OSDs to generically enforce the PGR on each IO. The idea was that we
could have a new "user-managed epoch" sequence that would be managed
by the monitors and enforced by the OSDs. Given such a system, if I
have a target with an in-flight IO that is associated with epoch X
(e.g. via a new op at the start of the transaction) and the end-user
application issuing IO has a failover event which results in a PGR
update, the target path could request epoch X + 1 and know that from
that point on any old, in-flight IO associated with the older sequence
number could not be committed to disk.

The problem is that you would somehow need to ensure that all the
primary PGs know about the new epoch, hopefully without the need to
have librbd "ping" each of the primary PGs that could contain the
backing objects to an image. Perhaps this op could implement a small
lease window on the epoch to ensure the OSDs never have a epoch
sequence that is over X seconds old.

Jason

On Wed, Apr 19, 2017 at 7:26 PM, Josh Durgin <jdurgin@redhat.com> wrote:
> On 04/19/2017 06:16 AM, Sage Weil wrote:
>>
>> On Wed, 19 Apr 2017, John Spray wrote:
>>>
>>> I was already pondering where the more detailed blacklist info (e.g.
>>> ids of clients) should go, as it's not something that actually needs
>>> to be shared with all the normal OSDMap subscribers (it's only the
>>> entity that does the blacklist removal that needs to see that).  It's
>>> already not ideal imho that we expose the list of all blacklisted
>>> clients to all the other clients -- in general they shouldn't be able
>>> to e.g. learn one another's addresses like this.
>>
>>
>> We already break the OSDMap encoding into two sections: the first part
>> that clients care about, and the second part that is only used by OSDs.
>> (The kernel client doesn't bother to decode the second half.)
>>
>> I suspect it wouldn't take much to send abbreviated maps (and
>> incrementals) to clients that don't include that second half at all...
>
>
> I was talking to Jason and Mike about another use of more generalized
> blacklisting at Vault, but I can't remember the details - do you guys?
>
> IIRC it sounded like that use would make sense as a separate map that
> osds and clients would subscribe to.
>
> Josh



-- 
Jason
