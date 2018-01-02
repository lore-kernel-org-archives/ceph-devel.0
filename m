From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: RGW RFC: Multiple-Data-Pool Support for a Bucket
Date: Tue, 2 Jan 2018 09:47:50 +0200
Message-ID: <CADRKj5TA2=wVPDR=eB8_KPjV=+FNcbHVJ9eYRTcTMgsHePJRwA@mail.gmail.com>
References: <CAFZHTOYnOQgVsmsGXPL8dBwA-_Gc5q3fZ5V1CjfzRtQbs=tvgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:38828 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750736AbeABHrv (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Jan 2018 02:47:51 -0500
Received: by mail-oi0-f47.google.com with SMTP id r65so3087224oie.5
        for <ceph-devel@vger.kernel.org>; Mon, 01 Jan 2018 23:47:51 -0800 (PST)
In-Reply-To: <CAFZHTOYnOQgVsmsGXPL8dBwA-_Gc5q3fZ5V1CjfzRtQbs=tvgg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeegn Chen <jeegnchen@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Dec 26, 2017 at 3:48 AM, Jeegn Chen <jeegnchen@gmail.com> wrote:
> Hi all,
>
> In the daily use of Ceph RGW cluster, we find some pain points when
> using current one-bucket-one-data-pool implementation.
> I guess one-bucket-multiple-data-pools may help (See the appended
> detailed proposal).
> What do you think?
>
>
>  https://etherpad.net/p/multiple-data-pool-support-for-a-bucket
>
> # **Multiple Data Pool Support for a Bucket**
>
> ##
>
> ## Motivation
>
> Currently, a bucket in RGW only has a single data pool (extra data
> pool is just a temporary storage for in-progressing multipart meta
> data, which is not in our consideration). The major pain points here

Not quite, as was mentioned elsewhere, with different placement
policies/targets you can have different pools. In any case, the 'head'
and 'tail' pools can be different.
> are:
>
> - When the data pool is out of storage and we have to expand it, we
> either have to tolerate the performance penalty due to high recovery
> IO or have to wait for a long time for the rebalance to complete(This
> situation is especially true when the original cluster is relatively
> small and the expansion usually means doubling the size).
>
>
> - Although the new nodes increase the storage capacity, they also
> reduce the average PG number per OSD, which may make the data
> distribution uneven. To address this ,we either have to reweight or
> have to increase the PG number, which means another data movement.
>
> If a bucket can have multiple data pools and switch between them, the
> maintenance may be easier:
>
> - The cluster admin can simply add new nodes, create another data pool
> and then make buckets write to the new pool. Thus no rebalance is
> needed and in turn the expansion is quick and almost has no observable
> impact on the bucket user.

Will old buckets still write to the old pool? Old data will still be
on the old pools anyway, so reads old old data still have that
problem.

>
>
> - Say a bucket have 2 data pools: Pool A and Pool B. Some maintence is
> needed for the nodes of both pools. The admin can make write operation
> go to Pool B (read cannot be switched since data is not moved),
> operate the nodes of Pool A, then switch the write IO back to Pool A,
> goes on to operates the nodes of Pool B, so that the maintenance
> operations may be carried out without high write IO interference and
> in turn the risk and difficulties are reduced.
>
> ## Design
>
> "Multiple Data Pool" is borrowed from CephFS. Any directory in CephFS
> can have its data pool and the data pool can be replaced any time.
> After the data pool switch, the new file written to the directory is
> persisted into the new pool while the old file in the previous pool is
> still accessible since metadata in meta pool has the correct
> reference.
>
> The major idea to support multiple data pool for a bucket is
>
> - Reuse the the existing data_pool to store the head, which always has
> 0 size but keeps the manifest referring to the data part in another
> pool.

Do we even keep it now? Looking at the code now, RGWObjManifest keeps
a tail_placement field that doesn't reference an actual pool. The pool
is calculated from that rule. We used to be explicit, so there might
be some fields that are kept for backward compatibility, but I'm not
sure we can use these. Need to be careful not to mix zone specific
data (e.g., pool names) with global data, so that when syncing objects
in multi-site, we don't rely on placement data of one zone in another
one.

>
>
> - Add a new concept tail_pool, which is used to store the data except the heads.
>
>
> - The data_pool of a bucket (now only has the heads, is in fact a
> metadata pool or a head pool) should not be changed but the bucket can
> switch between different tail_pools.
>
> ### Change in RGWZonePlacementInfo
>
> - Add a new field data_layout_type to RGWZonePlacementInfo. The
> default value for data_layout_type is 0 (name it as UNIFIED), which
> means current implementation. Let's use value 1 (name it as SPLITTED)
> for Multiple Data Pool Support.
>
>
> - Add a new field tail_pools, which is a list of pool names.
>
>
> - Add a new field current_tail_pool, which is one of the pool names in
> tail_pools.
>
> ###
>
> ### Change in Object Head
>
> Add a new xattr usr.rgw.tail_pool, which refer to the pool where the
> tail parts of the object reside.

This could work, as long as it's not part of the manifest itself.

>
> ### Change in Multipart Meta Object
>
> Add a new xattr usr.rgw.tail_pool, which refer to the pool where the
> multiparts of the object reside. This value should be decided in
> InitMulitpart and be followed by other operations against the same
> upload ID of the same object.
>
> ### Change in Write Operations
>
> If a bucket's data_layout_type is SPLITTED (and has no
> explicit_placment), only write 0-size head (including
> usr.rgw.tail_pool and all other xattrs) to data_pool and persist the
> tail in current_tail_pool.

I think the 0 sized head is orthogonal. You could still choose to keep
data in the head.

>
> For efficiency, it is recommended to use replicated pool on SSD as data_pool.
>
> ### Change in Read Operations
>
> If a bucket's data_layout_type is SPLITTED (and has no
> explicit_placment), read the tail parts according to usr.rgw.tail_pool
> in the head.

Should try to check tail_pool anyway, bucket's data_layout_type could
have been changed. Thinking about it, the bucket data layout can be
zone specific, not sure it's something we want to configure in the
bucket, but maybe part of the zone (and affects all buckets within
that zone).

Yehuda

>
> ###
>
> ### Change in GC
>
> If a bucket's data_layout_type is SPLITTED (and has no
> explicit_placment), the correct user.rgw.tail_pool should be record in
> GC list as well so that GC thread can remove tail parts correctly.
>
> ### Change in radosgw-admin
>
> Need new commands to modify and show modified RGWZonePlacementInfo(Add
> new pool to tail_pools, change current_tail_pool and so on)
>
> Thanks,
> Jeegn
