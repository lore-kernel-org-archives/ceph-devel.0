From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: Trying to reduce OSD start-up impact on busy clusters
Date: Thu, 25 Feb 2016 11:11:55 -0700
Message-ID: <CAANLjFqo1=98CUU3qS8T2QK3sh3ZLEkxrYiWxKSZ99yAPSuwVg@mail.gmail.com>
References: <CAANLjFoGHbiWMLbHLNSD+roBvuWYUqrwO3dpt5bUbhx77kjWkQ@mail.gmail.com>
	<alpine.DEB.2.11.1602241902560.7555@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f54.google.com ([209.85.213.54]:36064 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932381AbcBYSL4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Feb 2016 13:11:56 -0500
Received: by mail-vk0-f54.google.com with SMTP id c3so55274241vkb.3
        for <ceph-devel@vger.kernel.org>; Thu, 25 Feb 2016 10:11:56 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1602241902560.7555@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Looking through the logs, I don't see any attempt to try and prime the
pg_temp. In the code if mon_osd_prime_pg_temp is true then it tries,
but this is false by default. I'll keep looking into this. I hope it
is something simple like this.
-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.3.6
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJWz0PjCRDmVDuy+mK58QAABYIQAMAGbrJ0d8gUJFwSxTJi
+oJkfVgtSd4u6lPwc9KG1PNROPGNF2XzCvv9KfPjhzAR6obcyOWKbPZVJDn4
fro96cOmC27XUL3nQ10FiUHoJmlqxieF0KIRQ3R1qkiCF2PpJXPBOGDrvCX9
R3djgzB7FA8iO84RaKB96MO5CTzW7Ys+DynRWv32Jpt4D8/K+eLQEkF3uvuH
eAGxhAS5RRv/ZEk+uUtPL3wTzFk/ZvcJPadJ5JpKRnIJMD0107jZ5H5ZCJGh
Kw3pqgX6SBryIGZDddDfHUBqAXbqLxH/qbIX8rHte8s7rk/CKMvcXZ3ojL65
xx7J5ZhdK13dfTW+70qWZSpsdFd2KFO57p4pB7uAZPoe6HxMj6oHRvvtJZna
DtaaIw4PuijrcMSQE7I0fv89cAHGr7rGFAUlnpqCUC4o8y4p/dN5pdWIl/x+
wXhtzWbfhaQE0ChvhzunwQp5vzyCqZNzq1TZ4tKw0vE5Wz8qFKVAvyUm7FBN
ACPbWELnNXJbdX6Bv/xsFKeyCe+1ERfg9HBeuLY/ppx9IyLIjB4TMQeIJ4Du
T08KqOgcCFvay9M2n8ufKNZQx/MYXEUpRyG2PezNeTZK+oNtg8JHiEPqFviP
YHr1F06VrGLj+lJVYqC6AwWdXK3ZDw+ydZpRXIieKZ/K5jv1jg59YbwrxzlL
w1Ew
=cLMb
-----END PGP SIGNATURE-----
----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Wed, Feb 24, 2016 at 5:12 PM, Sage Weil <sage@newdream.net> wrote:
> On Wed, 24 Feb 2016, Robert LeBlanc wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA256
>>
>> I've been looking through the code the last couple of days trying to
>> figure out how to reduce the start-up impact of OSD on busy clusters
>> or OSDs that are constrained on RAM. What I see in the logs is right
>> after "state: booting -> active" client OPs (both client and repops)
>> are getting queued at the OSD even though none of the PGs are active.
>> This causes at least 20 seconds of latency for the first OPs to get
>> serviced (at least on my test cluster), and that is really bad for
>> RBD.
>>
>> So I was looking for a way to delay the client I/O to the OSD until at
>> least the PG was active. It would be nice if I could even delay the
>> PGMap until after at least one attempt of recovery was tried so that
>> on busy clusters there isn't a huge backlog of OPs blocked waiting for
>> a long list of RepOps that have been queued from the newly started PGs
>> who now have client OPs to service.
>>
>> My first thought was when a client OP came in and the PG was not
>> active, then create a pg_temp and NACK the client (I think a pg_temp
>> would make the client retry anyway). I thought this might be dirty and
>> get some client OPs out of order and in any case add latency (bad for
>> RBD). But on idle clusters, there wouldn't need to be a pg_temp for
>> each PG.
>>
>> My second thought was in load_pgs create the pg_temp there so that at
>> start_boot it would just have the "right" PGMap to begin with and the
>> clients just keep using the original OSDs until later when the pg_temp
>> is removed after the PG has been recovered. I have a feeling that this
>> will not work because the other OSDs won't see that this OSD is up and
>> ready to start recovery/backfill. If the other OSDs can know that this
>> one is up because it contacts them and shares a map, will it suddenly
>> start sending it repops? I'm really not sure on this and could use
>> some help.
>>
>> If I can get this pg_temp thing to work, then it is possible to try
>> and do much of the recovery as fast as possible before any client load
>> even hits it. Since only recovery OPs would be hammering the disk,
>> there is no need to slow it down, or at least throttle it so much.
>>
>> Here is a workflow that I can see working:
>> 1. load_pgs - create pg_temp
>> 2. start_boot
>> 3. walk through each PG
>> 3a. recover the PG, if it is the second iteration, activate the PG by
>> removing the pg_temp
>> 4. Loop through 3 twice, the first to catch up the PGs as fast as
>> possible, the second to activate them.
>
> So, 1-3ish should sort of already be happening, but in a slightly
> different way: mon/OSDMonitor.cc should be calling the
> maybe_prime_pg_temp() and prime_pg_temp(), which should identify which PG
> mappings are about to change and install pg_temp mappings with their prior
> mappings.  That way the same OSDMap epoch that shows the OSD coming up
> *also* has the pg_temp keeping it out of the acting set.  Then, when
> peering completes and if backfill isn't necessary the mapping will be
> removed.
>
> First, I would verify that this is actually happening.. it sounds like
> maybe it isn't... and if not we should fix that.  Maybe reproduce one of
> these transitions (bringing a down OSD back up) and see what happens?
>
> But, assuming it is, I think the main thing that can be done is to change
> the peering code to do any log based recovery too to the up but not acting
> osd before removing the pg_temp mapping.  That way, when the pg_temp
> mapping is removed, it should be a very fast peering transition.
>
> I think the last thing that is probably slowing things down is that on any
> peering transition there is the up_thru update that has to be applied on
> the mon before the PG can go active.  This can be slow.  It's there so
> that a series of OSDMap changes don't get us in a situation where there
> are mappings that the map had that the OSDs never realized, the OSDs then
> failed, and we cannot peer because we're stuck trying to probe OSDs
> that never wrote data.  (This is the maybe_went_rw logic in PG.cc and
> osd_types.cc and we'll need to be very careful making optimizations here.)
>
> sage
