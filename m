From: Robert LeBlanc <robert@leblancnet.us>
Subject: Cluster reliability
Date: Tue, 14 Jul 2015 11:17:41 -0600
Message-ID: <CAANLjFp7WtdP6BE6RCKHpfmV7gWhEH01JZA54VJ+JnFcGEa3rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:35383 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740AbbGNRRm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Jul 2015 13:17:42 -0400
Received: by wiga1 with SMTP id a1so105763087wig.0
        for <ceph-devel@vger.kernel.org>; Tue, 14 Jul 2015 10:17:41 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

I'm trying to understand the real world reliability of Ceph to provide
some data to our upper management and may be valuable to others
investigating Ceph.

Things I'm trying to understand:
1. How many clusters are in production?
2. How long has the cluster(s) been in production?
3. The size of the cluster(s) (# OSDs TB of raw disk space).
4. Has there been a data loss event?
5. Has there been a data near-loss event (some manual process was
required to recover some or all of the cluster data, but not from
backup as that would be considered a loss event)?
6. How much data was involved in loss/near-loss event?
7. How long to recover to cluster to performing all I/O (not
necessarily healthy).
8. What was the root cause of the loss/near-loss event?

From what I've read on the mailing lists, it seems that most data loss
event are around a design decisions to have 2 or less copies and
experiencing multiple drive issues. Others seem to be related to human
error, and I'm only aware of one instance where an upgrade caused a
data availability issue.

If you would take a few minutes to send me this information, I can
summarize the findings and report back to the list.

Thank you,
- ----------------
Robert LeBlanc
GPG Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v0.13.1
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJVpUQtCRDmVDuy+mK58QAA3d8P/3tSSFXInMDLde9IZFfE
jNjbN4zudF+ikNgBlOXFcU6vRIJyxj3V7Od+6PehLjyadmz+9Ju7KajRPb4z
gdoAF6cqmWvu+urJ8AZ4Av0wdK6xRpWA3Dmz9VcdPOGOBztKB8ZC1L3htqty
ysns5jgyzrFWPfWRGM0A/OC2r0JeAn2xDazZ3y2Gfhpi9sT7YqrqZj17MfdV
S3MXNoHoVZFRSgS9jXJ0C1f1DKjR+kaoED3k+mJiiV/sR+RjK5OQi7tvU96L
lWWPcOM02HJlfO//4cKXIqb4cs/p30y+VG4bh74c+svw5rq7SSAe0BFALZJY
p9TyFUGQjp8BjA7ZwyT7UmqBPbwAbGRwToGOup9T2ZHbUW66vRyGPQcdVj7M
z8PQDQWOg3AOaAgNXYNgwjTvfa5JwHHqIBhtTL8Kzt8ITteUr3N0sWNfydo6
h33sbhmv/SHmwFa267ounDj3M+MsVJq48iaHaZ+xznzYAsxfGQ0+Hv9nJxhB
+KQWYCJTJcSXPDe7Ct3eHExYcO88I1mXqxuCdimk1DfNH0IieiUUYurLFTzy
YvkJzbFaYNh/eccf7ASvt2ZjjGlrVozOijIopesaOJbJZP+Bd8FdGwc2IZXM
ofkxbEBP96gpsatlSTlk1jEzTSiq+odgp9PJ2KjqgqYO6S4rNMKKgxnUsbjz
IAJR
=MGc9
-----END PGP SIGNATURE-----
