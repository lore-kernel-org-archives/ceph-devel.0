From: Jeegn Chen <jeegnchen@gmail.com>
Subject: Re: RGW RFC: Multiple-Data-Pool Support for a Bucket
Date: Tue, 2 Jan 2018 18:19:09 +0800
Message-ID: <CAFZHTOa7tJ-rO3ofF0gGsP3w87UG0_ffeTtAH40Tn8jzRp9oJg@mail.gmail.com>
References: <CAFZHTOYnOQgVsmsGXPL8dBwA-_Gc5q3fZ5V1CjfzRtQbs=tvgg@mail.gmail.com>
 <CADRKj5TA2=wVPDR=eB8_KPjV=+FNcbHVJ9eYRTcTMgsHePJRwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:39210 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751283AbeABKTL (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Jan 2018 05:19:11 -0500
Received: by mail-pg0-f46.google.com with SMTP id 81so4633229pgf.6
        for <ceph-devel@vger.kernel.org>; Tue, 02 Jan 2018 02:19:11 -0800 (PST)
In-Reply-To: <CADRKj5TA2=wVPDR=eB8_KPjV=+FNcbHVJ9eYRTcTMgsHePJRwA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Yehuda,

My replies in line following [Jeegn]

Thanks,
Jeegn

2018-01-02 15:47 GMT+08:00 Yehuda Sadeh-Weinraub <yehuda@redhat.com>:
> On Tue, Dec 26, 2017 at 3:48 AM, Jeegn Chen <jeegnchen@gmail.com> wrote:
>> Hi all,
>>
>> In the daily use of Ceph RGW cluster, we find some pain points when
>> using current one-bucket-one-data-pool implementation.
>> I guess one-bucket-multiple-data-pools may help (See the appended
>> detailed proposal).
>> What do you think?
>>
>>
>>  https://etherpad.net/p/multiple-data-pool-support-for-a-bucket
>>
>> # **Multiple Data Pool Support for a Bucket**
>>
>> ##
>>
>> ## Motivation
>>
>> Currently, a bucket in RGW only has a single data pool (extra data
>> pool is just a temporary storage for in-progressing multipart meta
>> data, which is not in our consideration). The major pain points here
>
> Not quite, as was mentioned elsewhere, with different placement
> policies/targets you can have different pools. In any case, the 'head'
> and 'tail' pools can be different.
>> are:
>>
>> - When the data pool is out of storage and we have to expand it, we
>> either have to tolerate the performance penalty due to high recovery
>> IO or have to wait for a long time for the rebalance to complete(This
>> situation is especially true when the original cluster is relatively
>> small and the expansion usually means doubling the size).
>>
>>
>> - Although the new nodes increase the storage capacity, they also
>> reduce the average PG number per OSD, which may make the data
>> distribution uneven. To address this ,we either have to reweight or
>> have to increase the PG number, which means another data movement.
>>
>> If a bucket can have multiple data pools and switch between them, the
>> maintenance may be easier:
>>
>> - The cluster admin can simply add new nodes, create another data pool
>> and then make buckets write to the new pool. Thus no rebalance is
>> needed and in turn the expansion is quick and almost has no observable
>> impact on the bucket user.
>
> Will old buckets still write to the old pool? Old data will still be
> on the old pools anyway, so reads old old data still have that
> problem.
[Jeegn]: Do you mean old buckets created before layout_type is introduced?
The old buckets with explicit placement will not be changed. Maybe we can
create some radosgw-admin sub command to do related conversion.

>
>>
>>
>> - Say a bucket have 2 data pools: Pool A and Pool B. Some maintence is
>> needed for the nodes of both pools. The admin can make write operation
>> go to Pool B (read cannot be switched since data is not moved),
>> operate the nodes of Pool A, then switch the write IO back to Pool A,
>> goes on to operates the nodes of Pool B, so that the maintenance
>> operations may be carried out without high write IO interference and
>> in turn the risk and difficulties are reduced.
>>
>> ## Design
>>
>> "Multiple Data Pool" is borrowed from CephFS. Any directory in CephFS
>> can have its data pool and the data pool can be replaced any time.
>> After the data pool switch, the new file written to the directory is
>> persisted into the new pool while the old file in the previous pool is
>> still accessible since metadata in meta pool has the correct
>> reference.
>>
>> The major idea to support multiple data pool for a bucket is
>>
>> - Reuse the the existing data_pool to store the head, which always has
>> 0 size but keeps the manifest referring to the data part in another
>> pool.
>
> Do we even keep it now? Looking at the code now, RGWObjManifest keeps
> a tail_placement field that doesn't reference an actual pool. The pool
> is calculated from that rule. We used to be explicit, so there might
> be some fields that are kept for backward compatibility, but I'm not
> sure we can use these. Need to be careful not to mix zone specific
> data (e.g., pool names) with global data, so that when syncing objects
> in multi-site, we don't rely on placement data of one zone in another
> one.
>
[Jeegn]: Sorry for confusion. Right, tail_placement field in
RGWObjManifest is not used now.
I just mean the head also keep RGWObjManifest with RGWObjManifestRules and
the RGWObjManifestRules depict how the tail parts are composed.

>>
>>
>> - Add a new concept tail_pool, which is used to store the data except the heads.
>>
>>
>> - The data_pool of a bucket (now only has the heads, is in fact a
>> metadata pool or a head pool) should not be changed but the bucket can
>> switch between different tail_pools.
>>
>> ### Change in RGWZonePlacementInfo
>>
>> - Add a new field data_layout_type to RGWZonePlacementInfo. The
>> default value for data_layout_type is 0 (name it as UNIFIED), which
>> means current implementation. Let's use value 1 (name it as SPLITTED)
>> for Multiple Data Pool Support.
>>
>>
>> - Add a new field tail_pools, which is a list of pool names.
>>
>>
>> - Add a new field current_tail_pool, which is one of the pool names in
>> tail_pools.
>>
>> ###
>>
>> ### Change in Object Head
>>
>> Add a new xattr usr.rgw.tail_pool, which refer to the pool where the
>> tail parts of the object reside.
>
> This could work, as long as it's not part of the manifest itself.
[Jeegn]: Considering multi-site, we may need to be sure
usr.rgw.tail_pool is not replicated, right?

>
>>
>> ### Change in Multipart Meta Object
>>
>> Add a new xattr usr.rgw.tail_pool, which refer to the pool where the
>> multiparts of the object reside. This value should be decided in
>> InitMulitpart and be followed by other operations against the same
>> upload ID of the same object.
>>
>> ### Change in Write Operations
>>
>> If a bucket's data_layout_type is SPLITTED (and has no
>> explicit_placment), only write 0-size head (including
>> usr.rgw.tail_pool and all other xattrs) to data_pool and persist the
>> tail in current_tail_pool.
>
> I think the 0 sized head is orthogonal. You could still choose to keep
> data in the head.
>
[Jeegn]: I expect the 0 sized head here because we would like the pool
for head to be consumed
as slow as possible so that we don't need large capacity for it and we
don't need to expand it frequently.
And if it only have 0 size head, the ObjectStore can be setup on
relative expensive SSD and ObjectStore
parameters can be tuned for KV without considering blocks of any size.

>>
>> For efficiency, it is recommended to use replicated pool on SSD as data_pool.
>>
>> ### Change in Read Operations
>>
>> If a bucket's data_layout_type is SPLITTED (and has no
>> explicit_placment), read the tail parts according to usr.rgw.tail_pool
>> in the head.
>
> Should try to check tail_pool anyway, bucket's data_layout_type could
> have been changed. Thinking about it, the bucket data layout can be
> zone specific, not sure it's something we want to configure in the
> bucket, but maybe part of the zone (and affects all buckets within
> that zone).
[Jeegn]: Regarding data_layout_type change, are you referring to the use case
of multi-site? In that case, I think we should be sure that
usr.rgw.tail_pool is not replicated
by multi-site. Instead, sync threads of multi-site should write the
data into pools according
to the placement policy in the local zone and set usr.rgw.tail_pool properly.


>
> Yehuda
>
>>
>> ###
>>
>> ### Change in GC
>>
>> If a bucket's data_layout_type is SPLITTED (and has no
>> explicit_placment), the correct user.rgw.tail_pool should be record in
>> GC list as well so that GC thread can remove tail parts correctly.
>>
>> ### Change in radosgw-admin
>>
>> Need new commands to modify and show modified RGWZonePlacementInfo(Add
>> new pool to tail_pools, change current_tail_pool and so on)
>>
>> Thanks,
>> Jeegn
