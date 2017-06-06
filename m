From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: [ceph-users] Write back mode Cach-tier behavior
Date: Mon, 5 Jun 2017 18:22:42 -0700
Message-ID: <CAJ4mKGZR_VQi+8Poyq-zGXVev2Nh3EjC88tQ_5D1qmcmgkbPyg@mail.gmail.com>
References: <8841B22B-1A20-4D79-9EAB-32D0BBFB2DD9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f50.google.com ([209.85.214.50]:36845 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751192AbdFFBWo (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Jun 2017 21:22:44 -0400
Received: by mail-it0-f50.google.com with SMTP id m47so79818050iti.1
        for <ceph-devel@vger.kernel.org>; Mon, 05 Jun 2017 18:22:44 -0700 (PDT)
In-Reply-To: <8841B22B-1A20-4D79-9EAB-32D0BBFB2DD9@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: TYLin <wooertim@gmail.com>

[ Moving to ceph-devel ]

On Sun, Jun 4, 2017 at 9:25 PM, TYLin <wooertim@gmail.com> wrote:
> Hi all,
>
> We’re using cache-tier with write-back mode but the write throughput is not
> as good as we expect. We use CephFS and create a 20GB file in it. While data
> is writing, we use iostat to get the disk statistics. From iostat, we saw
> that ssd (cache-tier) is idle most of the time and hdd (storage-tier) is
> busy all the time. From the document
>
> “When admins configure tiers with writeback mode, Ceph clients write data to
> the cache tier and receive an ACK from the cache tier. In time, the data
> written to the cache tier migrates to the storage tier and gets flushed from
> the cache tier.”
>
> So the data is write to cache-tier and then flush to storage tier when dirty
> ratio is more than 0.4? The word “in time” in the document confused me.
>
> We found that the throughput of creating a new file is slower than overwrite
> an existing file, and ssd has more write when doing overwrite. We then look
> into the source code and log. A newly created file goes to proxy_write,
> which is followed by a promote_object. Does this means that the object
> actually goes to storage pool directly and then be promoted to the
> cache-tier when creating a new file?

So I skimmed this thread and thought it was very wrong, since we don't
need to proxy when we're doing fresh writes. But looking at current
master, that does indeed appear to be the case when creating new
objects: they always get proxied (I didn't follow the whole chain, but
PrimaryLogPG::maybe_handle_cache_detail unconditionally calls
do_proxy_write() if the OSD cluster supports proxying and we aren't
must_promote!).

Was this intentional? I know we've flipped around a bit on ideal
tiering behavior but it seems like at the very least it should be
configurable — proxying then promoting is a very inefficient pattern
for workloads that involve generating lots of data, modifying it, and
then never reading it again.
-Greg
