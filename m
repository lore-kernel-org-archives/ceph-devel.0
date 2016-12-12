From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: performance of reading objects in placement group operation
Date: Mon, 12 Dec 2016 13:18:14 -0800
Message-ID: <CAJ4mKGat+U=02s0a0V-F5kENYiZPxk5KeLG_Pb9e3RMrsxRESA@mail.gmail.com>
References: <CAB2gnbUXpuWfwM-3VBkqqsazo-ko213LZyOA2azsfeeYZGAsRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:35616 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753060AbcLLVSQ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Dec 2016 16:18:16 -0500
Received: by mail-io0-f182.google.com with SMTP id h30so193835632iod.2
        for <ceph-devel@vger.kernel.org>; Mon, 12 Dec 2016 13:18:16 -0800 (PST)
In-Reply-To: <CAB2gnbUXpuWfwM-3VBkqqsazo-ko213LZyOA2azsfeeYZGAsRA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noahwatkins@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Sat, Dec 10, 2016 at 3:54 PM, Noah Watkins <noahwatkins@gmail.com> wrote:
> tl;dr does the osd perform any sort of optimistic fetching of objects
> (not intra-object data, but rather pre-fetching of objects that have
> yet to be requested by a client)?
>
> Slightly longer question:
>
> I've been experimenting with adding PG-level operations, and I'm stuck
> tracking down a performance discrepancy between reading object data
> within the context of `ReplicatedPG::do_pg_op` and reading object data
> through the normal `do_op` path, only after dropping Linux page cache.
>
> When I measure the latency of `safe_pread` in `FileStore::read` I see
> that when running with a hot cache normal object reads from a client
> (via `do_op`), and object reads dispatched in `do_pg_op` perform
> similarly, and are fast as one would expect. But running on a cold
> cache (OSD restart plus drop_caches), I see that a small fraction of
> reads via `do_op` have a high latency as would be expected having to
> hit disk, but a very large fraction of object reads through `do_pg_op`
> are expensive. This seems to suggest that there is some sort of
> pre-fetching occurring, but I cannot find any sort of pre-fetching
> mechanism. Is the OSD pre-fetching, or can this be explained by some
> other mechanism?

I don't have a lot of this in my head, but I know that the RADOS guys
are going to ask what config/flags you're using — in particular,
sortbitwise probably makes a big difference.

Also, I'm not sure exactly what ops you're doing but I wonder if in
some of these cases you're reading "sequentially" our of leveldb and
in others you're depending on data that's stored purely in the
filesystem — I think this would also depend on your current config.
Certainly you should expect data in the filesystem (the object's FS
inodes, and *probably* the ghobject_info_t if it fits in an
inode-located xattr?) to be prefetched but the leveldb to perform
better on linear scans.

At least, I think?
-Greg
