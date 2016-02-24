From: Robert LeBlanc <robert@leblancnet.us>
Subject: Trying to reduce OSD start-up impact on busy clusters
Date: Wed, 24 Feb 2016 16:40:38 -0700
Message-ID: <CAANLjFoGHbiWMLbHLNSD+roBvuWYUqrwO3dpt5bUbhx77kjWkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:34318 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752706AbcBXXkj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Feb 2016 18:40:39 -0500
Received: by mail-vk0-f46.google.com with SMTP id e185so32626906vkb.1
        for <ceph-devel@vger.kernel.org>; Wed, 24 Feb 2016 15:40:39 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

I've been looking through the code the last couple of days trying to
figure out how to reduce the start-up impact of OSD on busy clusters
or OSDs that are constrained on RAM. What I see in the logs is right
after "state: booting -> active" client OPs (both client and repops)
are getting queued at the OSD even though none of the PGs are active.
This causes at least 20 seconds of latency for the first OPs to get
serviced (at least on my test cluster), and that is really bad for
RBD.

So I was looking for a way to delay the client I/O to the OSD until at
least the PG was active. It would be nice if I could even delay the
PGMap until after at least one attempt of recovery was tried so that
on busy clusters there isn't a huge backlog of OPs blocked waiting for
a long list of RepOps that have been queued from the newly started PGs
who now have client OPs to service.

My first thought was when a client OP came in and the PG was not
active, then create a pg_temp and NACK the client (I think a pg_temp
would make the client retry anyway). I thought this might be dirty and
get some client OPs out of order and in any case add latency (bad for
RBD). But on idle clusters, there wouldn't need to be a pg_temp for
each PG.

My second thought was in load_pgs create the pg_temp there so that at
start_boot it would just have the "right" PGMap to begin with and the
clients just keep using the original OSDs until later when the pg_temp
is removed after the PG has been recovered. I have a feeling that this
will not work because the other OSDs won't see that this OSD is up and
ready to start recovery/backfill. If the other OSDs can know that this
one is up because it contacts them and shares a map, will it suddenly
start sending it repops? I'm really not sure on this and could use
some help.

If I can get this pg_temp thing to work, then it is possible to try
and do much of the recovery as fast as possible before any client load
even hits it. Since only recovery OPs would be hammering the disk,
there is no need to slow it down, or at least throttle it so much.

Here is a workflow that I can see working:
1. load_pgs - create pg_temp
2. start_boot
3. walk through each PG
3a. recover the PG, if it is the second iteration, activate the PG by
removing the pg_temp
4. Loop through 3 twice, the first to catch up the PGs as fast as
possible, the second to activate them.

The idea is that hopefully the second iteration will be pretty quick
as the amount of change would be a lot less and that would mean less
recovery ops being promoted in the cluster reducing the impact
overall. Currently, I think backfills could remain the same as they
already do this pg_temp thing, but I for one wouldn't mind an option
to do all the backfills before starting any I/O on that OSD. That way
adding a brand new OSD won't have as much impact on client performance
(some impact will happen due to reads from other OSDs, but the one OSD
receiving the backfill won't have to try and service client I/O too).

If you can help me expand my understanding in this area, I would be
most grateful. If you have suggestions on how to approach the
implementation, I'd appreciate that too.

Thanks,
- ----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.3.6
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJWzj9rCRDmVDuy+mK58QAAXmUP/235O7iDg5l61e6heDeK
u9rQEUCaO9llhUnWlwjZxLkuedFqCNk9fMa7xdOsZxEWCfk8UhG0AjoBAq5m
QNnGZDeL72AHD12gZ5cpmXXx5Dfa3EdnuOJzzcAqucTp3azxbnfGj80HSw1w
fEYDP8UTVV0jJa+UyX/GHQ6TyyHn9BeZTXEDQ1CtDQvbt2V3fRmDcw7JkhXS
OezhkvykQvQ6nk3wHa+LMZHgEb2kutHgNqBTFqiQs6psrgQrBAV+UzqpH4O3
jRpCx6vEx16qQqNgwn7YJNqbKj8moQiaSpd20GAWRwonGb/ztneZsZCGkcQl
qRqRUtBMBrAZk/uxrTs3ro4nkuh061Dm6uIWaKckIcU5gTYAsWdsl8S9ihtY
35qhW/9IgWd0zdyF5txk0NZriZH245TTyBMC4HamT4EA4rzHGBoZwBvLi8XF
VwgPFE35Ks5xQj3Yv+mTRVNA/kJaCEE5OFHeAGa3Kh+VdboTRR35esLDtlet
bkoXOYobVgAXl5BQ9U2+Yi5TnnapfNLV5i0NvXf3ajyOtM2SyoehI2YFkr8E
XFmkxZi6xKud1Vvec/1d9i+nBXKZnS4DNNeSSrHdWhUq/NMClAw/BWjEPweY
B6eBJYT6h5ZenEgbGe99cTHLt433z2+upIqClqKviZ4gVEPpzodY2hEsfbej
dTRs
=BdW9
-----END PGP SIGNATURE-----
