From: Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>
Subject: Re: RGW multisite sync, data sync issues
Date: Thu, 1 Jun 2017 09:00:52 -0700
Message-ID: <CADRKj5Tw8ynOLKRnUOPejUBUgkM+GjPqm_Gk69Sg2GgcL7LZQQ@mail.gmail.com>
References: <CAA1GxO2xdsB5C_MwuugjSYMnSUUzjXP1MRb9=bhHOwGKmHNkCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f176.google.com ([209.85.216.176]:36087 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751159AbdFAQAy (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Jun 2017 12:00:54 -0400
Received: by mail-qt0-f176.google.com with SMTP id f55so39762929qta.3
        for <ceph-devel@vger.kernel.org>; Thu, 01 Jun 2017 09:00:54 -0700 (PDT)
In-Reply-To: <CAA1GxO2xdsB5C_MwuugjSYMnSUUzjXP1MRb9=bhHOwGKmHNkCg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Calminder <andreas.calminder@klarna.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, May 31, 2017 at 6:49 AM, Andreas Calminder
<andreas.calminder@klarna.com> wrote:
> Hello,
> Asked on ceph-users, thought I post here as well, if anyone knows the
> ins and outs of rgw.
> I've got a sync issue with my multisite setup. There's 2 zones in 1
> zone group in 1 realm. The data sync in the non-master zone have stuck
> on Incremental sync is behind by 1 shard, this wasn't noticed until
> the radosgw instances in the master zone started dying from out of
> memory issues, all radosgw instances in the non-master zone was then
> shutdown to ensure services in the master zone while trying to
> troubleshoot the issue.
>
> From the rgw logs in the master zone I see entries like:
>
> 2017-05-29 16:10:34.717988 7fbbc1ffb700  0 ERROR: failed to sync
> object: 12354/BUCKETNAME:be8fa19b-ad79-4cd8-ac7b-1e14fdc882f6.2374181.27/dirname_1/dirname_2/filename_1.ext
> 2017-05-29 16:10:34.718016 7fbbc1ffb700  0 ERROR: failed to sync
> object: 12354/BUCKETNAME:be8fa19b-ad79-4cd8-ac7b-1e14fdc882f6.2374181.27/dirname_1/dirname_2/filename_2.ext
> 2017-05-29 16:10:34.718504 7fbbc1ffb700  0 ERROR: failed to fetch
> remote data log info: ret=-5
> 2017-05-29 16:10:34.719443 7fbbc1ffb700  0 ERROR: a sync operation
> returned error
> 2017-05-29 16:10:34.720291 7fbc167f4700  0 store->fetch_remote_obj()
> returned r=-5
>
> sync status in the non-master zone reports that the metadata is up to
> sync and that the data sync is behind on 1 shard and that the oldest
> incremental change not applied is about 2 weeks back.
>
> I'm not quite sure how to proceed, is there a way to find out the id
> of the shard and force some kind of re-sync of the data in it from the
> master zone? I'm unable to have the non-master zone rgw's running
> because it'll leave the master zone in a bad state with rgw dying
> every now and then.
>


Maybe start with looking at the sync error log:

$ radosgw-admin sync error list

Then there are radosgw-admin commands that query the different logs
statuses, and the different sync statuses. E.g.,

$ radosgw-admin bilog status
$ radosgw-admin datalog status
$ radosgw-admin mdlog status

and

$ radosgw-admin bucket sync status
$ radosgw-admin data sync status
$ radosgw-admin metadata sync status

All commands need extra params that specifies the specific resource
you're aiming at (e.g., which bucket, which data shard). You probably
don't need to deal with the metadata sync. The log status commands
should be run on the source zone, and the sync status on the
destination.

You can trigger a full resync on the various entities by the following commands:

$ radosgw-admin bucket sync init
$ radosgw-admin data sync init
$ radosgw-admin metadata sync init


Yehuda
