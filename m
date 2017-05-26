From: Andreas Calminder <andreas.calminder@klarna.com>
Subject: RGW bucket reshard fails with ERROR: bi_list(): (4) Interrupted
 system call
Date: Fri, 26 May 2017 22:28:39 +0200
Message-ID: <CAA1GxO2k7aoCBhLWkhJv+NnrTQbUH6gU1Z-6_wD9-5K5wTSX7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36648 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S944905AbdEZU3B (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 26 May 2017 16:29:01 -0400
Received: by mail-pf0-f177.google.com with SMTP id m17so20739469pfg.3
        for <ceph-devel@vger.kernel.org>; Fri, 26 May 2017 13:29:00 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,
Posted this in ceph-users earlier, thought I try here as well. Running
Jewel (10.2.7). While trying to get rid of an oversized bucket (+14M
objects) I tried to reshard the bucket index to be able to remove it
without having the rgw run out of memory.

As per the Red Hat documentation I ran
# radosgw-admin bucket reshard --bucket=oversized_bucket --num-shards=300
Noted the old instance id and waited for it to output a count of all
items, at the very end the command spits out "ERROR: bi_list(): (4)
Interrupted system call"

Now I have the new bucket instance with a sharded index (300),
seemingly unused and the old instance id of the bucket with no shards,
which seems to be active

#  radosgw-admin --cluster drceph-tcs-prod metadata get
bucket:oversized_bucket returns the old instance id in bucket_id

Two questions:

* How do I remove the new bucket id, from the failed reshard command.
Since it's not used it's confusing to have it floating around
* How do I actually reshard the oversized_bucket? - Actually, I really
don't care about the bucket, If there's a way to remove the bucket and
it's objects without altering the index, causing the radosgw to
allocate all memory available and crash, I'd rather do that.

Regards,
Andreas
