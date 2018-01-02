From: Matt Benjamin <mbenjami@redhat.com>
Subject: Re: RGW RFC: Multiple-Data-Pool Support for a Bucket
Date: Tue, 2 Jan 2018 09:05:12 -0500
Message-ID: <CAKOnar=nkN42gCcfiYh=4HW_MPi=_gVwBMDG=zDWmqFP5PXJKA@mail.gmail.com>
References: <CAFZHTOYnOQgVsmsGXPL8dBwA-_Gc5q3fZ5V1CjfzRtQbs=tvgg@mail.gmail.com>
 <robbat2-20171226T185704-299365896Z@orbis-terrarum.net> <CAFZHTObqvWL2DG4TGKW=Q4ja5S7bhxh6g-ApmstAX5=tAkUZ5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:36723 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751479AbeABOFN (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Jan 2018 09:05:13 -0500
Received: by mail-io0-f171.google.com with SMTP id i143so28909876ioa.3
        for <ceph-devel@vger.kernel.org>; Tue, 02 Jan 2018 06:05:13 -0800 (PST)
In-Reply-To: <CAFZHTObqvWL2DG4TGKW=Q4ja5S7bhxh6g-ApmstAX5=tAkUZ5A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeegn Chen <jeegnchen@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

inline

On Tue, Dec 26, 2017 at 11:44 PM, Jeegn Chen <jeegnchen@gmail.com> wrote:
> Hi Robin
>
> Reply in inline.
>
> Thanks,
> Jeegn
>
> 2017-12-27 3:00 GMT+08:00 Robin H. Johnson <robbat2@gentoo.org>:
>> On Tue, Dec 26, 2017 at 09:48:26AM +0800, Jeegn Chen wrote:
>>> In the daily use of Ceph RGW cluster, we find some pain points when
>>> using current one-bucket-one-data-pool implementation.
>>> I guess one-bucket-multiple-data-pools may help (See the appended
>>> detailed proposal).
>>> What do you think?
>> Overall I like
>>
>> Queries/concerns:
>> - How would this interact w/ the bucket policy lifecycle code?
> [Jeegn]: My understanding is that current lifecycle code will list all
> objects in a bucket and delete the out-of-date object. Only the
> deletion logic is related, which is covered by GC-related change.
>
>> - How would this interact w/ existing placement policy in bucket
>>   creation?
> [Jeegn]: The multiple-pool-support needs data_layout_type in
> RGWZonePlacementInfo to have value SPLITTED (new) while the default
> value of data_layout_type is UNIFIED(old). So the existing bucket
> placement is assumed to have UNIFIED in data_layout_type . To enable
> this functionality, the admin need to create the new placement policy
> with  SPLITTED data_layout_type set explicitly. Only the bucket
> created from SPLITTED placement policy will follow the new behavior
> pattern.

SINGLE_POOL and SPLIT_POOL?

As Yehuda notes, there are fields related to tail placement in
RGWObjManifest.  I wasn't aware that they were unused, or no longer
used.  I've had a degree of concern for a while about the mix of
complexity of representation and some assumptions in RGWObjManifest as
it is.  I felt a tingle of danger around the idea of adding a new
object attribute to deal with placement as a one-off, as well.  If
only for the benefit of clarity and cleanup, I think it would be
beneficial to try to think a few moves ahead on where logical and
physical placement are going, how they eventually interact with
storage class (as Robin noted here), and maybe simplification and
removal of bits of old design dead-ends from the code.

>
>> - At the rgw-admin layer, what tooling should exist to migrate objects
>>   between pools for a given bucket?
> [Jeegn]: I don't expect the objects to be migrated between pools.Old
> objects uploaded before the tail_pool switch will remain in the
> original pool until they are deleted explicitly, which is the same
> behavior in CephFS.

I think I agree with Robin. It seems like that kind of tooling support
would increase robustness and long-term serviceability.

Matt

>
>>
>> --
>> Robin Hugh Johnson
>> Gentoo Linux: Dev, Infra Lead, Foundation Asst. Treasurer
>> E-Mail   : robbat2@gentoo.org
>> GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
>> GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 

Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-821-5101
fax.  734-769-8938
cel.  734-216-5309
