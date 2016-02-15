From: Robert LeBlanc <robert@leblancnet.us>
Subject: Need some help fixing an assert
Date: Mon, 15 Feb 2016 11:26:13 -0700
Message-ID: <CAANLjFopvMzfezr=UmJGG1Dzg+VV6bC7cpvuJbGJPxk0AN99WQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:32860 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217AbcBOS0O (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Feb 2016 13:26:14 -0500
Received: by mail-vk0-f53.google.com with SMTP id k196so114525764vka.0
        for <ceph-devel@vger.kernel.org>; Mon, 15 Feb 2016 10:26:13 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

I've got https://github.com/ceph/ceph/pull/7654 that I'm working on,
but I just can't track down why I'm getting the assert in Mutex::Lock.
If you can give me a push in the right direction, it would be very
helpful.

Thanks,
- ----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.3.4
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJWwhhBCRDmVDuy+mK58QAAbe0P/1g6raiPu5NipSFS1YF4
t2TJOuIlGRkyLhigmb2726VJpYg0ylmaQ7eDyppJ62ek/GIvP084nLLPfgMH
ePUnJ+uSQ5tUV2n7qveabqpEPDVWlIUVedcvZDspb9kLJB1/EyhtyXAgacit
Ny4yhQOjFQ2QdSS7WH4uz6z7F94UgLc5M+VP+mv6SHjt1Aqo+uIiRtKhUckP
9KbjQjFHk/GaZ9BHdxzINAqv+uTTii9c2cZzWKoKbsMGlcPnSCFgMSZIx/cc
/rxXWEZqdb7MnNsR1ZUYhdyAJmhX+PpivWhg+dVQzwTrrQvvlrKo76MgStnW
RWa+88JqQkVpZF93aqkhWS7SHqnOv9Yv+aQ6qg6ivVYR/bhyY0TvHI3QqF+7
aChuy0YtB4l/imXjpWtfEg5gvT9yVLl+wWeg9TFawpf2OoRlfglFmDBP0daX
AnlbwToyKjz5D3TeWxN7EChvk3vPB0tFRt+yRrcnn/4G2UE0PK3k2hX3Tc+2
fDVZkeqigTB5vDt1lFuIaUtFpRlgeC407eGgTz2qt6KHOJWmbo1NmztrFuuI
gNUp2GuwkHR9177X2iH4Dcg182foaxzJiFHvj1WFvwj9lDNawT8Rdtz12tTv
hy7CXKUhvVjxlmq85JYYhmeULX+Z8GZvpAg43/CYGQ8qmBWt72k+LM/7p0NW
Om/p
=Ml7I
-----END PGP SIGNATURE-----
