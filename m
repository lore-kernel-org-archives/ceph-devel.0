From: Andreas Calminder <andreas.calminder@klarna.com>
Subject: RGW multisite sync, data sync issues
Date: Wed, 31 May 2017 15:49:01 +0200
Message-ID: <CAA1GxO2xdsB5C_MwuugjSYMnSUUzjXP1MRb9=bhHOwGKmHNkCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:34765 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750904AbdEaNtX (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 31 May 2017 09:49:23 -0400
Received: by mail-pg0-f54.google.com with SMTP id u28so8279123pgn.1
        for <ceph-devel@vger.kernel.org>; Wed, 31 May 2017 06:49:22 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hello,
Asked on ceph-users, thought I post here as well, if anyone knows the
ins and outs of rgw.
I've got a sync issue with my multisite setup. There's 2 zones in 1
zone group in 1 realm. The data sync in the non-master zone have stuck
on Incremental sync is behind by 1 shard, this wasn't noticed until
the radosgw instances in the master zone started dying from out of
memory issues, all radosgw instances in the non-master zone was then
shutdown to ensure services in the master zone while trying to
troubleshoot the issue.

From the rgw logs in the master zone I see entries like:

2017-05-29 16:10:34.717988 7fbbc1ffb700  0 ERROR: failed to sync
object: 12354/BUCKETNAME:be8fa19b-ad79-4cd8-ac7b-1e14fdc882f6.2374181.27/dirname_1/dirname_2/filename_1.ext
2017-05-29 16:10:34.718016 7fbbc1ffb700  0 ERROR: failed to sync
object: 12354/BUCKETNAME:be8fa19b-ad79-4cd8-ac7b-1e14fdc882f6.2374181.27/dirname_1/dirname_2/filename_2.ext
2017-05-29 16:10:34.718504 7fbbc1ffb700  0 ERROR: failed to fetch
remote data log info: ret=-5
2017-05-29 16:10:34.719443 7fbbc1ffb700  0 ERROR: a sync operation
returned error
2017-05-29 16:10:34.720291 7fbc167f4700  0 store->fetch_remote_obj()
returned r=-5

sync status in the non-master zone reports that the metadata is up to
sync and that the data sync is behind on 1 shard and that the oldest
incremental change not applied is about 2 weeks back.

I'm not quite sure how to proceed, is there a way to find out the id
of the shard and force some kind of re-sync of the data in it from the
master zone? I'm unable to have the non-master zone rgw's running
because it'll leave the master zone in a bad state with rgw dying
every now and then.

Regards,
Andreas
