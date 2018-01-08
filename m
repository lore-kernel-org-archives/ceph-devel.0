From: Ugis <ugis22@gmail.com>
Subject: Fwd: importance of steps when adding osds
Date: Mon, 8 Jan 2018 18:51:15 +0200
Message-ID: <CAE63xUN72dJ4RFFWE=gzt5r1S2eBiL=ozjgYo9yPiDKrhtdWEg@mail.gmail.com>
References: <CAE63xUMo=98kD8V4kj7Oh=0eyhRnH35mAJpM8t7kAiSq3WQn3A@mail.gmail.com>
 <alpine.DEB.2.11.1801081422450.24931@piezo.novalocal> <CAE63xUPun2uPnM4qREaY4-P4oJAQTucqki=wDc2P6mWtrucy5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:43937 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932675AbeAHQvQ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Jan 2018 11:51:16 -0500
Received: by mail-io0-f178.google.com with SMTP id w188so15006408iod.10
        for <ceph-devel@vger.kernel.org>; Mon, 08 Jan 2018 08:51:16 -0800 (PST)
In-Reply-To: <CAE63xUPun2uPnM4qREaY4-P4oJAQTucqki=wDc2P6mWtrucy5g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Sage,

That answered my uncertainty precisely, thanks!

Regarding docs: this summary would fit in here
http://docs.ceph.com/docs/master/rados/operations/add-or-rm-osds/#adding-osds
That is logically ceph.com -> Ceph Storage Cluster -> Operations ->
Adding/Removing OSDs -> that could be added as section for Adding
OSDs, called like "Adding multiple OSDs at once".


Ugis

2018-01-08 16:28 GMT+02:00 Sage Weil <sage@newdream.net>:
> Hi Ugis,
>
> On Mon, 8 Jan 2018, Ugis wrote:
>> Hi,
>>
>> Suggestion first: ceph.com  site could have some best practice rules
>> for adding new OSDs. Googling regarding this topic reveals that people
>> have questions like:
>> - may I add serveral OSDSs at once?
>
> Yes
>
>> - may I completely change crushmap online so that pgs get completely relocated?
>
> Yes
>
>> - what config parameters help to reduce backfill load?
>
> osd_max_backfill (default: 1) controls how many concurrent backfill (or
> recovery) operations an OSD will work on concurrently.  (It is actually 2x
> this value, since we track recoveries for with teh OSD is primary
> separately from those for which it is a replica participant; this is to
> avoid deadlock in our relatively simplistic approach to reservation.)
>
> Suggestions for where this type of summary info would fit into the docs
> structure would be helpful!
>
>> Until that still have this theoretical question on CRUSH algorithm.
>> We have ceph cluster with 5 osd hosts, CRUSH rule orders ceph to put
>> replicas one copy per host.
>>
>> If we add 2 osds simultaneously in different hosts - how CRUSH
>> guarantees that some existing pg that now should be located on those
>> new 2 osds does not get unavailable? Should be something with epochs I
>> suppose?
>>
>> Have found thread mentioning that people have tested completely
>> remapping pgs http://lists.ceph.com/pipermail/ceph-users-ceph.com/2017-July/019577.html
>> Still it is not clear what are the theoretical constraints on adding
>> bunches of OSDs (except backfill load). For example if pg gets
>> relocated several times in a row(in case osds get added not waiting
>> degradation to resolve) - how long that chain of previously allocated
>> pgs can be?
>
> The key thing to keep in mind here is that CRUSH only tells us where
> things "should" be as of a given point in time.  RADOS is responsible for
> keeping track of where things are and have been recently, and making a
> safe migration to the desired location.  Generally speaking the amount of
> history it will remember is unbounded--you could feed the cluster a
> million CRUSH map changes faster than it can move data and it won't stop
> you.  In theory, the amount of state that has to be tracked is bounded by
> the size of the cluster... in the truly degenerate case it will think that
> every PG existed at some point on every other OSD.  In practice (as of
> luminous) the amount of state needed to is very small due to the recent
> PastIntervals work (see this blog for some more background if you're
> interested:
> http://ceph.com/community/new-luminous-pg-overdose-protection/)
>
> Hope that helps!
> sage
