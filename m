From: Jeegn Chen <jeegnchen@gmail.com>
Subject: Re: RGW RFC: Multiple-Data-Pool Support for a Bucket
Date: Wed, 3 Jan 2018 18:36:04 +0800
Message-ID: <CAFZHTOZvV4Za1W4bf7Szi0UEpGk-Qorp+EK9NDroMa_5JFo63A@mail.gmail.com>
References: <CAFZHTOYnOQgVsmsGXPL8dBwA-_Gc5q3fZ5V1CjfzRtQbs=tvgg@mail.gmail.com>
 <robbat2-20171226T185704-299365896Z@orbis-terrarum.net> <CAFZHTObqvWL2DG4TGKW=Q4ja5S7bhxh6g-ApmstAX5=tAkUZ5A@mail.gmail.com>
 <CAKOnar=nkN42gCcfiYh=4HW_MPi=_gVwBMDG=zDWmqFP5PXJKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:45289 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751154AbeACKgG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Jan 2018 05:36:06 -0500
Received: by mail-pf0-f178.google.com with SMTP id u19so581241pfa.12
        for <ceph-devel@vger.kernel.org>; Wed, 03 Jan 2018 02:36:06 -0800 (PST)
In-Reply-To: <CAKOnar=nkN42gCcfiYh=4HW_MPi=_gVwBMDG=zDWmqFP5PXJKA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <mbenjami@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Matt,

Inline

Thanks,
Jeegn

2018-01-02 22:05 GMT+08:00 Matt Benjamin <mbenjami@redhat.com>:
> Hi,
>
> inline
>
> On Tue, Dec 26, 2017 at 11:44 PM, Jeegn Chen <jeegnchen@gmail.com> wrote:
>> Hi Robin
>>
>> Reply in inline.
>>
>> Thanks,
>> Jeegn
>>
>> 2017-12-27 3:00 GMT+08:00 Robin H. Johnson <robbat2@gentoo.org>:
>>> On Tue, Dec 26, 2017 at 09:48:26AM +0800, Jeegn Chen wrote:
>>>> In the daily use of Ceph RGW cluster, we find some pain points when
>>>> using current one-bucket-one-data-pool implementation.
>>>> I guess one-bucket-multiple-data-pools may help (See the appended
>>>> detailed proposal).
>>>> What do you think?
>>> Overall I like
>>>
>>> Queries/concerns:
>>> - How would this interact w/ the bucket policy lifecycle code?
>> [Jeegn]: My understanding is that current lifecycle code will list all
>> objects in a bucket and delete the out-of-date object. Only the
>> deletion logic is related, which is covered by GC-related change.
>>
>>> - How would this interact w/ existing placement policy in bucket
>>>   creation?
>> [Jeegn]: The multiple-pool-support needs data_layout_type in
>> RGWZonePlacementInfo to have value SPLITTED (new) while the default
>> value of data_layout_type is UNIFIED(old). So the existing bucket
>> placement is assumed to have UNIFIED in data_layout_type . To enable
>> this functionality, the admin need to create the new placement policy
>> with  SPLITTED data_layout_type set explicitly. Only the bucket
>> created from SPLITTED placement policy will follow the new behavior
>> pattern.
>
> SINGLE_POOL and SPLIT_POOL?
[Jeegn]: You mean the naming UNIFIED and SPLITTED looks confused and
SINGLE_POOL and SPLIT_POOL are more intuitive?

>
> As Yehuda notes, there are fields related to tail placement in
> RGWObjManifest.  I wasn't aware that they were unused, or no longer
> used.  I've had a degree of concern for a while about the mix of
> complexity of representation and some assumptions in RGWObjManifest as
> it is.  I felt a tingle of danger around the idea of adding a new
> object attribute to deal with placement as a one-off, as well.  If
> only for the benefit of clarity and cleanup, I think it would be
> beneficial to try to think a few moves ahead on where logical and
> physical placement are going, how they eventually interact with
> storage class (as Robin noted here), and maybe simplification and
> removal of bits of old design dead-ends from the code.
[Jeegn]: My understanding is that tail_placement in RGWObjManifest is
used to deal
with the object copy within the the zone, especially for the cross-bucket copy.
When the source bucket and the destination bucket have different data
pools (logic in
RGWRados::copy_obj), the tail data will be copied and new RGWObjManifest will be
created based on the destination's placement policy.
When the source bucket and the destination bucket share the same data
pool, only the head is
copied along with the RGWObjManifest in it. The destination object
needs  tail_placement in
RGWObjManifest because the information of the source bucket (such as
source bucket marker)
is available there. The source bucket marker is needed as the prefix
of the name of tail objects
in rados level, which is why the destination object need the source
object's tail_placement to find
its tail objects. But even in this case, I don't see the pool
information in tail_placement is used
and the pool information in tail_placement should be due to
backward-compatibility.

So I think tail_placement is necessary in RGWObjManifest but the pool
information there is in
fact unused at all.

I don't quite understand what 'logical and physical placement' are
referring to. Could you give
more details or some examples?

>
>>
>>> - At the rgw-admin layer, what tooling should exist to migrate objects
>>>   between pools for a given bucket?
>> [Jeegn]: I don't expect the objects to be migrated between pools.Old
>> objects uploaded before the tail_pool switch will remain in the
>> original pool until they are deleted explicitly, which is the same
>> behavior in CephFS.
>
> I think I agree with Robin. It seems like that kind of tooling support
> would increase robustness and long-term serviceability.
[Jeegn]: Yes. It should useful. One use case come to my mind is that
we may want to
evict some pools so that we can release all the related servers for other use.

>
> Matt
>
>>
>>>
>>> --
>>> Robin Hugh Johnson
>>> Gentoo Linux: Dev, Infra Lead, Foundation Asst. Treasurer
>>> E-Mail   : robbat2@gentoo.org
>>> GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
>>> GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
>
> Matt Benjamin
> Red Hat, Inc.
> 315 West Huron Street, Suite 140A
> Ann Arbor, Michigan 48103
>
> http://www.redhat.com/en/technologies/storage
>
> tel.  734-821-5101
> fax.  734-769-8938
> cel.  734-216-5309
