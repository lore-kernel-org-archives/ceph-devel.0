From: Jeegn Chen <jeegnchen@gmail.com>
Subject: Re: RGW RFC: Multiple-Data-Pool Support for a Bucket
Date: Fri, 29 Dec 2017 13:01:25 +0800
Message-ID: <CAFZHTOauW9JQqdAZnCE+JiWigNAEH1n+YmYN9WO9oPDu2oHejg@mail.gmail.com>
References: <CAFZHTOYnOQgVsmsGXPL8dBwA-_Gc5q3fZ5V1CjfzRtQbs=tvgg@mail.gmail.com>
 <CAOi4hNcp6b-r2OqrExCoxNyBv9HtwivCm1xm+Jh=xu1_YJA3ZQ@mail.gmail.com>
 <CAFZHTOYrJ0VdjrU5Yne3ZKL1Go0Hb8uJ3Xdzk8NPkwJwPrdueA@mail.gmail.com>
 <CAOi4hNc5Romj5BMJgp6W=OOoW_08b27PDHoymu+00Ok_Mq14xA@mail.gmail.com>
 <CAFZHTOYwnOy6y4hL9mqEdcmxhmBsHWrX2eDZxsrwq-Ly21eT=g@mail.gmail.com> <robbat2-20171229T034038-863364066Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pl0-f44.google.com ([209.85.160.44]:43604 "EHLO
        mail-pl0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750707AbdL2FB0 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Dec 2017 00:01:26 -0500
Received: by mail-pl0-f44.google.com with SMTP id z5so22420800plo.10
        for <ceph-devel@vger.kernel.org>; Thu, 28 Dec 2017 21:01:26 -0800 (PST)
In-Reply-To: <robbat2-20171229T034038-863364066Z@orbis-terrarum.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
Cc: yuxiang fang <abcdeffyx@gmail.com>, Yehuda Sadeh-Weinraub <yehuda@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Robin

> Rough implementation:
> - For writes, the RGW zone data describes which pool maps to each
>   storage class.
>   (corner case: multipart uploads might need each part in a consistent pool)
[Jeegn]: Do you mean mean different placement polices are
corresponding to STORAGE CLASSes?

> - The bucket-index data already describes the RADOS POOL to _read_ from
>   (corner case: old buckets/objects don't have this set)
[Jeegn]: Are you referring to the tail_bucket in the RGWObjManifest,
which is somewhat a copy of placement rule? Currently, it seems to
support the copy across buckets with the same data pool and I have not
found the logic to deal with different pools. But yes, maybe we can
reuse it instead of add additional xattr to track the tail pools.

> - radosgw-admin already contains bucket/object rewrite functionality,
>   that would effectively copy from an old pool into the new pool.
>   (note: I don't think is well-documented at all)
[Jeegn]: Are you talking about "radosgw-admin bucket rewrite"? But per
check through RGWRados::rewrite_obj() and check_min_obj_stripe_size()
in the master branch, the functionality is used to migrate from
explicit-obj implementation to manifest implementation. Or you mean
some command else or some implementation wip?

Thanks,
Jeegn

2017-12-29 11:50 GMT+08:00 Robin H. Johnson <robbat2@gentoo.org>:
> Idea for integration of Jeegn Chen's idea and storage classes (thus
> lifecycle):
>
> Concept: STORAGE CLASSES are backed by one or more RADOS POOLS.
>
> This already roughly exists in placement policies.
>
> Rough implementation:
> - For writes, the RGW zone data describes which pool maps to each
>   storage class.
>   (corner case: multipart uploads might need each part in a consistent pool)
> - The bucket-index data already describes the RADOS POOL to _read_ from
>   (corner case: old buckets/objects don't have this set)
> - radosgw-admin already contains bucket/object rewrite functionality,
>   that would effectively copy from an old pool into the new pool.
>   (note: I don't think is well-documented at all)
>
> On Fri, Dec 29, 2017 at 11:08:45AM +0800, Jeegn Chen wrote:
>> The failure domain of the pools is out of control of RGW. Admins can
>> create the pools in the way their prefer. This proposal just give more
>> flexibility and possibility.
>>
>> I think multiple pools support may just be a experimental start. If it
>> works stably in production area, we may even extend it to support
>> STORAGE CLASS (The same bucket have objects in different pools
>> according to the STORAGE CLASS) in S3  in the future and then
>> leveraging lifecycle to move objects between different STORAGE CLASS
>> may also be possible (of course, more careful design may be needed
>> make the new complexity elegant).
>>
>> Thanks,
>> Jeegn
>>
>> 2017-12-27 15:51 GMT+08:00 yuxiang fang <abcdeffyx@gmail.com>:
>> > Hi Jeegn
>> >
>> > Seems a bit rigor.
>> > thanks
>> > ivan from eisoo
>> >
>> >
>> > On Wed, Dec 27, 2017 at 2:50 PM, Jeegn Chen <jeegnchen@gmail.com> wrote:
>> >> Hi Ivan,
>> >>
>> >> In the use case, we expected the Pool A and Pool B have different sets
>> >> of OSDs and different sets of hosts or racks are even recommended.
>> >>
>> >> Thanks,
>> >> Jeegn
>> >>
>> >> 2017-12-27 14:01 GMT+08:00 yuxiang fang <abcdeffyx@gmail.com>:
>> >>> Hi Jeegn
>> >>>
>> >>> It seems that new nodes have to be added to the same failure domain of
>> >>> Pool B, otherwise we can't expand the capacity.
>> >>> Then Pool B will be affected by recovery of Pool A, they are different
>> >>> Pools logically but distributed in same failure domain.
>> >>>
>> >>> thanks
>> >>> ivan from eisoo
>> >>>
>> >>>
>> >>> On Tue, Dec 26, 2017 at 9:48 AM, Jeegn Chen <jeegnchen@gmail.com> wrote:
>> >>>> Hi all,
>> >>>>
>> >>>> In the daily use of Ceph RGW cluster, we find some pain points when
>> >>>> using current one-bucket-one-data-pool implementation.
>> >>>> I guess one-bucket-multiple-data-pools may help (See the appended
>> >>>> detailed proposal).
>> >>>> What do you think?
>> >>>>
>> >>>>
>> >>>>  https://etherpad.net/p/multiple-data-pool-support-for-a-bucket
>> >>>>
>> >>>> # **Multiple Data Pool Support for a Bucket**
>> >>>>
>> >>>> ##
>> >>>>
>> >>>> ## Motivation
>> >>>>
>> >>>> Currently, a bucket in RGW only has a single data pool (extra data
>> >>>> pool is just a temporary storage for in-progressing multipart meta
>> >>>> data, which is not in our consideration). The major pain points here
>> >>>> are:
>> >>>>
>> >>>> - When the data pool is out of storage and we have to expand it, we
>> >>>> either have to tolerate the performance penalty due to high recovery
>> >>>> IO or have to wait for a long time for the rebalance to complete(This
>> >>>> situation is especially true when the original cluster is relatively
>> >>>> small and the expansion usually means doubling the size).
>> >>>>
>> >>>>
>> >>>> - Although the new nodes increase the storage capacity, they also
>> >>>> reduce the average PG number per OSD, which may make the data
>> >>>> distribution uneven. To address this ,we either have to reweight or
>> >>>> have to increase the PG number, which means another data movement.
>> >>>>
>> >>>> If a bucket can have multiple data pools and switch between them, the
>> >>>> maintenance may be easier:
>> >>>>
>> >>>> - The cluster admin can simply add new nodes, create another data pool
>> >>>> and then make buckets write to the new pool. Thus no rebalance is
>> >>>> needed and in turn the expansion is quick and almost has no observable
>> >>>> impact on the bucket user.
>> >>>>
>> >>>>
>> >>>> - Say a bucket have 2 data pools: Pool A and Pool B. Some maintence is
>> >>>> needed for the nodes of both pools. The admin can make write operation
>> >>>> go to Pool B (read cannot be switched since data is not moved),
>> >>>> operate the nodes of Pool A, then switch the write IO back to Pool A,
>> >>>> goes on to operates the nodes of Pool B, so that the maintenance
>> >>>> operations may be carried out without high write IO interference and
>> >>>> in turn the risk and difficulties are reduced.
>> >>>>
>> >>>> ## Design
>> >>>>
>> >>>> "Multiple Data Pool" is borrowed from CephFS. Any directory in CephFS
>> >>>> can have its data pool and the data pool can be replaced any time.
>> >>>> After the data pool switch, the new file written to the directory is
>> >>>> persisted into the new pool while the old file in the previous pool is
>> >>>> still accessible since metadata in meta pool has the correct
>> >>>> reference.
>> >>>>
>> >>>> The major idea to support multiple data pool for a bucket is
>> >>>>
>> >>>> - Reuse the the existing data_pool to store the head, which always has
>> >>>> 0 size but keeps the manifest referring to the data part in another
>> >>>> pool.
>> >>>>
>> >>>>
>> >>>> - Add a new concept tail_pool, which is used to store the data except the heads.
>> >>>>
>> >>>>
>> >>>> - The data_pool of a bucket (now only has the heads, is in fact a
>> >>>> metadata pool or a head pool) should not be changed but the bucket can
>> >>>> switch between different tail_pools.
>> >>>>
>> >>>> ### Change in RGWZonePlacementInfo
>> >>>>
>> >>>> - Add a new field data_layout_type to RGWZonePlacementInfo. The
>> >>>> default value for data_layout_type is 0 (name it as UNIFIED), which
>> >>>> means current implementation. Let's use value 1 (name it as SPLITTED)
>> >>>> for Multiple Data Pool Support.
>> >>>>
>> >>>>
>> >>>> - Add a new field tail_pools, which is a list of pool names.
>> >>>>
>> >>>>
>> >>>> - Add a new field current_tail_pool, which is one of the pool names in
>> >>>> tail_pools.
>> >>>>
>> >>>> ###
>> >>>>
>> >>>> ### Change in Object Head
>> >>>>
>> >>>> Add a new xattr usr.rgw.tail_pool, which refer to the pool where the
>> >>>> tail parts of the object reside.
>> >>>>
>> >>>> ### Change in Multipart Meta Object
>> >>>>
>> >>>> Add a new xattr usr.rgw.tail_pool, which refer to the pool where the
>> >>>> multiparts of the object reside. This value should be decided in
>> >>>> InitMulitpart and be followed by other operations against the same
>> >>>> upload ID of the same object.
>> >>>>
>> >>>> ### Change in Write Operations
>> >>>>
>> >>>> If a bucket's data_layout_type is SPLITTED (and has no
>> >>>> explicit_placment), only write 0-size head (including
>> >>>> usr.rgw.tail_pool and all other xattrs) to data_pool and persist the
>> >>>> tail in current_tail_pool.
>> >>>>
>> >>>> For efficiency, it is recommended to use replicated pool on SSD as data_pool.
>> >>>>
>> >>>> ### Change in Read Operations
>> >>>>
>> >>>> If a bucket's data_layout_type is SPLITTED (and has no
>> >>>> explicit_placment), read the tail parts according to usr.rgw.tail_pool
>> >>>> in the head.
>> >>>>
>> >>>> ###
>> >>>>
>> >>>> ### Change in GC
>> >>>>
>> >>>> If a bucket's data_layout_type is SPLITTED (and has no
>> >>>> explicit_placment), the correct user.rgw.tail_pool should be record in
>> >>>> GC list as well so that GC thread can remove tail parts correctly.
>> >>>>
>> >>>> ### Change in radosgw-admin
>> >>>>
>> >>>> Need new commands to modify and show modified RGWZonePlacementInfo(Add
>> >>>> new pool to tail_pools, change current_tail_pool and so on)
>> >>>>
>> >>>> Thanks,
>> >>>> Jeegn
>> >>>> --
>> >>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> >>>> the body of a message to majordomo@vger.kernel.org
>> >>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> Robin Hugh Johnson
> Gentoo Linux: Dev, Infra Lead, Foundation Treasurer
> E-Mail   : robbat2@gentoo.org
> GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
> GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136
