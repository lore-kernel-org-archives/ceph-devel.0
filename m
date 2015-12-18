From: Robert LeBlanc <robert@leblancnet.us>
Subject: Weighted Priority Op Queue
Date: Fri, 18 Dec 2015 09:24:22 -0700
Message-ID: <CAANLjFokLZSHLwgVvqpm9ajgTEHwp+piwFeWdNAyd_ecdiff1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f54.google.com ([209.85.213.54]:35298 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753966AbbLRQYX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Dec 2015 11:24:23 -0500
Received: by mail-vk0-f54.google.com with SMTP id a189so68209496vkh.2
        for <ceph-devel@vger.kernel.org>; Fri, 18 Dec 2015 08:24:22 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: Sage Weil <sweil@redhat.com>, Samuel Just <sjust@redhat.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

I adjusted the algorithm from the Weighted Round Robin Queue and
resolved the SSD performance issue. Since it is different, I've
renamed it so that it doesn't cause confusion later.

My tests are all showing a performance improvement of 3-17%. The
enqueue and dequeue latencies are the same or just slightly better
than Prioritized Queue, but the distribution of OPs is much more fair
especially in the contention situations (more enqueue than dequeue).
The new queue is always right on the expected distribution in all
cases, even with highly skewed ops (higher priority ops have low
costs/size and low priority ops have high costs/size).

I could probably get a little more performance out of it by using
intrusive containers, but since I'm getting the same latency with
better overall performance gains, I wanted to get this in and tested.
I can create another PR later if intrusive containers provide more
performance.

The PR is at https://github.com/ceph/ceph/pull/6964

I've closed the previous RP (https://github.com/ceph/ceph/pull/6781)
as this one supersedes it. Any feedback is appreciated.

Thanks,
- ----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.3.2
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJWdDMuCRDmVDuy+mK58QAAet0P/iRkGILB96Ryy6HPYZny
ODzzn1ld/LkwK/JmVsWti48tOZbnG91WhxQIAQMeha5GeRAcv/Ie2OBZe7Y4
Jo4tCaXbPGwZ9sk1kxjwTm4SYHKwCYf0vuyOVIT2+On0BrXUPfDFPFBHpUwY
nDUkyZTi6YCo9W7qgST7AQJHI9wAeb0SlClAsBN3vd8JOoZfuWuA6+hNP6q5
tI6RueXXy8LgbiIiNmm5MvAJQg/7I+rWs2JZyyyu0BaBSm3GPY15LPpIWa7F
zg0+ax8pb5J0Ug4fSwzG7iKKNhO/TSC32bC2kRWPThQCmVQ6mUmrBWW311vK
ZpFRAPy6mXCVKysFqZFxav5BFagkQZO470Vjej4riYHxRa4QdGOkjZODAb6+
2GN+wtQH76dVsxm4mOGi4sUFJ5QLjk+nTDILIS5uh3x7nJ94UbqAetzgQA7m
bAVQocMb5B0JZb6vHjg4TkwQ2pVgzBWxYQX7Lum3hm3DDVhm4BPbU0juCZaO
o2XD6KgM40mxJmsjmyL/siCUV8wqZDamoHMAyljIr0hfkvBR+AB9a6B2+1iE
DIIBX/blM7lSQRHIOrBj/FRBeplGbGP2cBXS0v4+N3l5jGFgk4Aisf1KPr22
qaGbxv6pteMJhbpeBf4bOTeU8spwHmpAxmLINYECUk6ySoYJNva9T+IYsBiQ
EoPN
=bQwT
-----END PGP SIGNATURE-----
