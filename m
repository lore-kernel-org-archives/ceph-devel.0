From: Andreas Calminder <andreas.calminder@klarna.com>
Subject: Re: RGW multisite sync, data sync issues
Date: Mon, 5 Jun 2017 10:29:49 +0200
Message-ID: <CAA1GxO3Ankqs4HhgPngSoGh0h8ANZF_0cCuRM7_dwHw3WAfn5w@mail.gmail.com>
References: <CAA1GxO2xdsB5C_MwuugjSYMnSUUzjXP1MRb9=bhHOwGKmHNkCg@mail.gmail.com>
 <CADRKj5Tw8ynOLKRnUOPejUBUgkM+GjPqm_Gk69Sg2GgcL7LZQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:35697 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751492AbdFEIaL (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Jun 2017 04:30:11 -0400
Received: by mail-pg0-f41.google.com with SMTP id 8so31884709pgc.2
        for <ceph-devel@vger.kernel.org>; Mon, 05 Jun 2017 01:30:10 -0700 (PDT)
In-Reply-To: <CADRKj5Tw8ynOLKRnUOPejUBUgkM+GjPqm_Gk69Sg2GgcL7LZQQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Thank you for your response,
this made the troubleshooting a bit easier. However we've decided to
wipe the non-master cluster and just re-create it as another zone.
I'm not exactly sure how to do this though, if you guys have time for
some pointers it would be greatly appreciated. My theory is that I can
do something like this:

From the master zone remove the non-master zone from the zone group,
commit the config and then just wipe the nodes from the non-master
zone and rebuild them and set them up as a new zone in the old zone
group. My worries is that this operation somehow will jeopardize the
data in the master zone and leave me with no data.

On 1 June 2017 at 18:00, Yehuda Sadeh-Weinraub <ysadehwe@redhat.com> wrote:
> On Wed, May 31, 2017 at 6:49 AM, Andreas Calminder
> <andreas.calminder@klarna.com> wrote:
>> Hello,
>> Asked on ceph-users, thought I post here as well, if anyone knows the
>> ins and outs of rgw.
>> I've got a sync issue with my multisite setup. There's 2 zones in 1
>> zone group in 1 realm. The data sync in the non-master zone have stuck
>> on Incremental sync is behind by 1 shard, this wasn't noticed until
>> the radosgw instances in the master zone started dying from out of
>> memory issues, all radosgw instances in the non-master zone was then
>> shutdown to ensure services in the master zone while trying to
>> troubleshoot the issue.
>>
>> From the rgw logs in the master zone I see entries like:
>>
>> 2017-05-29 16:10:34.717988 7fbbc1ffb700  0 ERROR: failed to sync
>> object: 12354/BUCKETNAME:be8fa19b-ad79-4cd8-ac7b-1e14fdc882f6.2374181.27=
/dirname_1/dirname_2/filename_1.ext
>> 2017-05-29 16:10:34.718016 7fbbc1ffb700  0 ERROR: failed to sync
>> object: 12354/BUCKETNAME:be8fa19b-ad79-4cd8-ac7b-1e14fdc882f6.2374181.27=
/dirname_1/dirname_2/filename_2.ext
>> 2017-05-29 16:10:34.718504 7fbbc1ffb700  0 ERROR: failed to fetch
>> remote data log info: ret=3D-5
>> 2017-05-29 16:10:34.719443 7fbbc1ffb700  0 ERROR: a sync operation
>> returned error
>> 2017-05-29 16:10:34.720291 7fbc167f4700  0 store->fetch_remote_obj()
>> returned r=3D-5
>>
>> sync status in the non-master zone reports that the metadata is up to
>> sync and that the data sync is behind on 1 shard and that the oldest
>> incremental change not applied is about 2 weeks back.
>>
>> I'm not quite sure how to proceed, is there a way to find out the id
>> of the shard and force some kind of re-sync of the data in it from the
>> master zone? I'm unable to have the non-master zone rgw's running
>> because it'll leave the master zone in a bad state with rgw dying
>> every now and then.
>>
>
>
> Maybe start with looking at the sync error log:
>
> $ radosgw-admin sync error list
>
> Then there are radosgw-admin commands that query the different logs
> statuses, and the different sync statuses. E.g.,
>
> $ radosgw-admin bilog status
> $ radosgw-admin datalog status
> $ radosgw-admin mdlog status
>
> and
>
> $ radosgw-admin bucket sync status
> $ radosgw-admin data sync status
> $ radosgw-admin metadata sync status
>
> All commands need extra params that specifies the specific resource
> you're aiming at (e.g., which bucket, which data shard). You probably
> don't need to deal with the metadata sync. The log status commands
> should be run on the source zone, and the sync status on the
> destination.
>
> You can trigger a full resync on the various entities by the following co=
mmands:
>
> $ radosgw-admin bucket sync init
> $ radosgw-admin data sync init
> $ radosgw-admin metadata sync init
>
>
> Yehuda



--=20
Andreas Calminder
System Administrator
IT Operations Core Services

Klarna AB (publ)
Sveav=C3=A4gen 46, 111 34 Stockholm
Tel: +46 8 120 120 00
Reg no: 556737-0431
klarna.com
