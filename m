From: Robert LeBlanc <robert@leblancnet.us>
Subject: Weighted Priority Queue Recovery
Date: Fri, 22 Jan 2016 14:31:21 -0700
Message-ID: <CAANLjFp3dOUqF5MGde4D92s1GnnLAoFamNFiAQAvdHQfe567MA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f52.google.com ([209.85.213.52]:35981 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431AbcAVVbX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Jan 2016 16:31:23 -0500
Received: by mail-vk0-f52.google.com with SMTP id n1so48134187vkb.3
        for <ceph-devel@vger.kernel.org>; Fri, 22 Jan 2016 13:31:22 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: Sage Weil <sweil@redhat.com>, Samuel Just <sjust@redhat.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

I finally got the data all aligned and distilled for the recovery
tests of PrioritizedQueue and Weighted Priority Queue.
https://docs.google.com/spreadsheets/d/1tRCy_myvtpcuNhkuRxKInPXpFFD0mRsWxK1rPJGDF9w/edit?usp=sharing

The 4KB recovery takes a bit longer on WPQ, but the plus side is that
it hardly effects normal I/O unlike PrioritzedQueue which has a
definite hit in client I/O performance.

The 4MB recovery seems to take about the same amount of time if
PrioritizedQueue was able to actually complete recovery. The WQP tests
have more fio data after recovery, this was just because I wasn't
around to stop it right away, but it helps show the recovery client
performance vs no recovery.

I hope to have the config options Sam and I discussed ready next week,
this data massaging took a lot of time.
- ----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.3.3
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJWop+lCRDmVDuy+mK58QAAD0YQALMtqmmiY5+2q2mLwnYG
V3E3MFXtAPRU+sXVq6STP6fCFBpL6McXsq6L4/htg+5Ib8kXyYWJAM6+baI2
ONGjo3hyK8qqg7ihs/s9vO8q6nRMqLU/C1/MdVosIemV4/D+RjpdiT4ocjMg
lT0qyHE9Fw+2hIM2onSwVDMvhp9xvkQ9M2Tm1xd0EsPsB4zQlddVZJPzBb+p
s5gvFvRypx4EW2cEsNX2/i5dxrfxddquydNBV8pAqZK3uIam4onPwD8QiTe5
XLBBBIdfn/1MO31vahRI/sbVwNj878KmtvlyO+4oVTMsNNe0BkFUxip9yhvf
ltIM/SqVDzfQ5Zc+29Je3V0ZyeVkwUI7sOI3j5HhTjmxrVHEzWSqoADIrrEY
r9FTb+pePIuT9TvU8rQ7w+oxZ1+7pPd6QiUTPlgrLCTPxSBuYfiKWiBpLZo0
Uz0F2LGWbgmebLZ0Nzb50VMP5IlvHZ9NMVBxt+zPpk9AfpB/iqn2CbYDNZEr
HtfayxxLlEZAoe8A2hjC9r9CrwtywCvqtmi5B+YSO/XcZ2GEvJhjMwSIuUsD
UMCH4FyqMBrb4tmGbSdYogG3VY8d0vgHxid5VytOv++urX2rbmmmaNDV0TZl
PuebBbzMAYspQMR5CqzFCvWq0OWJC/Ts7Za3ucJcFzlSaF/wnLiM3s9JaffN
ytDW
=1r0Y
-----END PGP SIGNATURE-----
