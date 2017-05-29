From: Andreas Calminder <andreas.calminder@klarna.com>
Subject: Re: RGW bucket reshard fails with ERROR: bi_list(): (4) Interrupted
 system call
Date: Mon, 29 May 2017 09:21:38 +0200
Message-ID: <CAA1GxO2A2Y-_4RuN5anHFHNSUSZY=y3d8-B7ompJ4_dm_ysMUw@mail.gmail.com>
References: <CAA1GxO2k7aoCBhLWkhJv+NnrTQbUH6gU1Z-6_wD9-5K5wTSX7Q@mail.gmail.com>
 <CAGtbiz1Fxj2dye6Zrjf-Oo8i1SPTfTt18Ps=rEkKbEqTRaT-AA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36015 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbdE2HV7 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 29 May 2017 03:21:59 -0400
Received: by mail-pf0-f172.google.com with SMTP id m17so44165609pfg.3
        for <ceph-devel@vger.kernel.org>; Mon, 29 May 2017 00:21:59 -0700 (PDT)
In-Reply-To: <CAGtbiz1Fxj2dye6Zrjf-Oo8i1SPTfTt18Ps=rEkKbEqTRaT-AA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?0JLQsNGB0LjQu9C40Lkg0JDQvdCz0LDQv9C+0LI=?= <angapov@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

As a matter of fact, yes! The sync was falling way behind on one shard
in the data sync, I had to close down the rgw's in the second site to
keep the rgw's in the master from allocating all the memory and then
getting killed by oom_killer. Not sure why the shard won't get synced,
but my guess is that it's due to a delete operation in the oversized
bucket as there was a long running rm command that was aborted after
being run for over 7 days.

Is there a way to manually resync the failing site? As it would seem I
cannot reshard the bucket until the sites are properly connected
again?

Thanks!
/andreas

On 29 May 2017 at 07:55, =D0=92=D0=B0=D1=81=D0=B8=D0=BB=D0=B8=D0=B9 =D0=90=
=D0=BD=D0=B3=D0=B0=D0=BF=D0=BE=D0=B2 <angapov@gmail.com> wrote:
> I have almost the same problem except that "bucket reshard" gives me
> "(5) Input/output error" (Red Hat Ceph Storage 2.2 or Ceph 10.2.5).
> Had the discussion with Red Hat Support and they told me that it is
> related to malfunctioning RGW multisite replication. Do you have
> multisite configuration?
>
> Regards, Vasily
>
> 2017-05-26 23:28 GMT+03:00 Andreas Calminder <andreas.calminder@klarna.co=
m>:
>> Hi,
>> Posted this in ceph-users earlier, thought I try here as well. Running
>> Jewel (10.2.7). While trying to get rid of an oversized bucket (+14M
>> objects) I tried to reshard the bucket index to be able to remove it
>> without having the rgw run out of memory.
>>
>> As per the Red Hat documentation I ran
>> # radosgw-admin bucket reshard --bucket=3Doversized_bucket --num-shards=
=3D300
>> Noted the old instance id and waited for it to output a count of all
>> items, at the very end the command spits out "ERROR: bi_list(): (4)
>> Interrupted system call"
>>
>> Now I have the new bucket instance with a sharded index (300),
>> seemingly unused and the old instance id of the bucket with no shards,
>> which seems to be active
>>
>> #  radosgw-admin --cluster drceph-tcs-prod metadata get
>> bucket:oversized_bucket returns the old instance id in bucket_id
>>
>> Two questions:
>>
>> * How do I remove the new bucket id, from the failed reshard command.
>> Since it's not used it's confusing to have it floating around
>> * How do I actually reshard the oversized_bucket? - Actually, I really
>> don't care about the bucket, If there's a way to remove the bucket and
>> it's objects without altering the index, causing the radosgw to
>> allocate all memory available and crash, I'd rather do that.
>>
>> Regards,
>> Andreas
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Andreas Calminder
System Administrator
IT Operations Core Services

Klarna AB (publ)
Sveav=C3=A4gen 46, 111 34 Stockholm
Tel: +46 8 120 120 00
Reg no: 556737-0431
klarna.com
