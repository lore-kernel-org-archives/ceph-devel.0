From: Noah Watkins <noahwatkins@gmail.com>
Subject: performance of reading objects in placement group operation
Date: Sat, 10 Dec 2016 15:54:09 -0800
Message-ID: <CAB2gnbUXpuWfwM-3VBkqqsazo-ko213LZyOA2azsfeeYZGAsRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:35872 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751302AbcLJXyL (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 10 Dec 2016 18:54:11 -0500
Received: by mail-oi0-f42.google.com with SMTP id v84so54948214oie.3
        for <ceph-devel@vger.kernel.org>; Sat, 10 Dec 2016 15:54:10 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

tl;dr does the osd perform any sort of optimistic fetching of objects
(not intra-object data, but rather pre-fetching of objects that have
yet to be requested by a client)?

Slightly longer question:

I've been experimenting with adding PG-level operations, and I'm stuck
tracking down a performance discrepancy between reading object data
within the context of `ReplicatedPG::do_pg_op` and reading object data
through the normal `do_op` path, only after dropping Linux page cache.

When I measure the latency of `safe_pread` in `FileStore::read` I see
that when running with a hot cache normal object reads from a client
(via `do_op`), and object reads dispatched in `do_pg_op` perform
similarly, and are fast as one would expect. But running on a cold
cache (OSD restart plus drop_caches), I see that a small fraction of
reads via `do_op` have a high latency as would be expected having to
hit disk, but a very large fraction of object reads through `do_pg_op`
are expensive. This seems to suggest that there is some sort of
pre-fetching occurring, but I cannot find any sort of pre-fetching
mechanism. Is the OSD pre-fetching, or can this be explained by some
other mechanism?

-Noah
