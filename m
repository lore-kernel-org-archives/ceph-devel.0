From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: [ceph-users] Any suggestion to deal with slow request?
Date: Thu, 7 Jan 2016 09:43:55 -0700
Message-ID: <CAANLjFrTf1CCm=zWJSpFU78WeODhfVeqbr7RxOz3Df4ojABZug@mail.gmail.com>
References: <568DE39D.6060409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f43.google.com ([209.85.213.43]:34915 "EHLO
	mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961AbcAGQn4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Jan 2016 11:43:56 -0500
Received: by mail-vk0-f43.google.com with SMTP id k1so177028101vkb.2
        for <ceph-devel@vger.kernel.org>; Thu, 07 Jan 2016 08:43:56 -0800 (PST)
In-Reply-To: <568DE39D.6060409@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jevon Qiao <scaleqiao@gmail.com>
Cc: Ceph-User <ceph-users@ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

What is the file system on the OSDs? Anything interesting in
iostat/atop? What are the drives backing the OSDs? A few more details
would be helpful.
- ----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Wed, Jan 6, 2016 at 9:03 PM, Jevon Qiao  wrote:
> Hi Cephers,
>
> We have a Ceph cluster running 0.80.9, which consists of 36 OSDs with 3
> replicas. Recently, some OSDs keep reporting slow request and the cluster
> has a performance downgrade.
>
> From the log of one OSD, I observe that all the slow requests are resulted
> from waiting for the replicas to complete. And the replication OSDs are not
> always some specific ones but could be any other two OSDs.
>
> 2016-01-06 08:17:11.887016 7f175ef25700  0 log [WRN] : slow request 1.162776
> seconds old, received at 2016-01-06 08:17:11.887092:
> osd_op(client.13302933.0:839452 rbd_data.c2659c728b0ddb.0000000000000024
> [stat,set-alloc-hint object_size 16777216 write_size 16777216,write
> 12099584~8192] 3.abd08522 ack+ondisk+write e4661) v4 currently waiting for
> subops from 24,31
>
> I dumped out the historic Ops of the OSD and noticed the following
> information:
> 1) wait about 8 seconds for the replies from the replica OSDs.
>                     { "time": "2016-01-06 08:17:03.879264",
>                       "event": "op_applied"},
>                     { "time": "2016-01-06 08:17:11.684598",
>                       "event": "sub_op_applied_rec"},
>                     { "time": "2016-01-06 08:17:11.687016",
>                       "event": "sub_op_commit_rec"},
>
> 2) spend more than 3 seconds in writeq and 2 seconds to write the journal.
>                   { "time": "2016-01-06 08:19:16.887519",
>                       "event": "commit_queued_for_journal_write"},
>                     { "time": "2016-01-06 08:19:20.109339",
>                       "event": "write_thread_in_journal_buffer"},
>                     { "time": "2016-01-06 08:19:22.177952",
>                       "event": "journaled_completion_queued"},
>
> Any ideas or suggestions?
>
> BTW, I checked the underlying network with iperf, it works fine.
>
> Thanks,
> Jevon
>
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.3.2
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJWjpXHCRDmVDuy+mK58QAAG7EP/Rho9KKiV1ipfzWja48T
GOcXZECZZKRZTRO2GZR7jdxMj7ZfEVkm+JDo+i6ZWp6PrNwMDGA10t3ehkPQ
FToE6O9Fj42heJGELUGYYVZVLif9d875ZHzjrUSUyPKM+Np6+N4FIjX9v0EV
U1D7Kv6RCKHdnhuOm0LE/PWuUlgTTCzo50ujWP0lyCtsgRQoN/5ednz6HfsA
ba4yiv8sl2g0/Qhd5KDXMqYKWJS26u3ST3nN8Pn7XI9AR+J7y79yGwrWiwre
qMlSkuLOIrjyXmj2jhobEcOpyd9EOTq6/giKtgWc9p1Nu9+ypaQJNSomSF9T
X2Stg5UKkl/cSG4m/5gUXOoO5fVzTxXOmiq7QcSQEXSE1LJO8+X1iWo7XcAD
WUY001kZQNHxVNEexg/xDAvh348MsaKz39QKc79IlyFojM2sv4LS/65W9ZUp
rh6CWnyLBLutLDg6Z1Gb3Aj8ThmOaMkCjE4O5GvgjiYqLgrcCYxuc558hVcx
2ywb+yb5xC8Y2mP1hUG7Zc2WVHtKoZKtUhOZvH5D2DpUBd4gOPdMbWyvi96o
2DNkN/zszlQMP1FHEWcmjd0zOauoxtVCKsUXGfzwAHha4Jn1hX/UyRt5ryM1
y9GBsTg7CeL1zIXYlNFlKn9039ySCNzjkxncxV4KVcRMTX/Ydp1xQquGUIw0
0Ytw
=0D5S
-----END PGP SIGNATURE-----
