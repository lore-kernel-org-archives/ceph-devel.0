From: =?UTF-8?B?0JLQsNGB0LjQu9C40Lkg0JDQvdCz0LDQv9C+0LI=?=
        <angapov@gmail.com>
Subject: Re: RGW bucket reshard fails with ERROR: bi_list(): (4) Interrupted
 system call
Date: Mon, 29 May 2017 08:55:43 +0300
Message-ID: <CAGtbiz1Fxj2dye6Zrjf-Oo8i1SPTfTt18Ps=rEkKbEqTRaT-AA@mail.gmail.com>
References: <CAA1GxO2k7aoCBhLWkhJv+NnrTQbUH6gU1Z-6_wD9-5K5wTSX7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:36220 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750825AbdE2Fzp (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 29 May 2017 01:55:45 -0400
Received: by mail-it0-f49.google.com with SMTP id o5so21987062ith.1
        for <ceph-devel@vger.kernel.org>; Sun, 28 May 2017 22:55:44 -0700 (PDT)
In-Reply-To: <CAA1GxO2k7aoCBhLWkhJv+NnrTQbUH6gU1Z-6_wD9-5K5wTSX7Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Calminder <andreas.calminder@klarna.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

I have almost the same problem except that "bucket reshard" gives me
"(5) Input/output error" (Red Hat Ceph Storage 2.2 or Ceph 10.2.5).
Had the discussion with Red Hat Support and they told me that it is
related to malfunctioning RGW multisite replication. Do you have
multisite configuration?

Regards, Vasily

2017-05-26 23:28 GMT+03:00 Andreas Calminder <andreas.calminder@klarna.com>:
> Hi,
> Posted this in ceph-users earlier, thought I try here as well. Running
> Jewel (10.2.7). While trying to get rid of an oversized bucket (+14M
> objects) I tried to reshard the bucket index to be able to remove it
> without having the rgw run out of memory.
>
> As per the Red Hat documentation I ran
> # radosgw-admin bucket reshard --bucket=oversized_bucket --num-shards=300
> Noted the old instance id and waited for it to output a count of all
> items, at the very end the command spits out "ERROR: bi_list(): (4)
> Interrupted system call"
>
> Now I have the new bucket instance with a sharded index (300),
> seemingly unused and the old instance id of the bucket with no shards,
> which seems to be active
>
> #  radosgw-admin --cluster drceph-tcs-prod metadata get
> bucket:oversized_bucket returns the old instance id in bucket_id
>
> Two questions:
>
> * How do I remove the new bucket id, from the failed reshard command.
> Since it's not used it's confusing to have it floating around
> * How do I actually reshard the oversized_bucket? - Actually, I really
> don't care about the bucket, If there's a way to remove the bucket and
> it's objects without altering the index, causing the radosgw to
> allocate all memory available and crash, I'd rather do that.
>
> Regards,
> Andreas
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
