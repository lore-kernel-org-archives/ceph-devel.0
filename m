From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Small objects in erasure-coded pool
Date: Mon, 20 Nov 2017 18:02:41 -0800
Message-ID: <CAJ4mKGZwHLgFUWinvZSg-4EhOKsW1PiEv5anUmUGWD4kb=MAvA@mail.gmail.com>
References: <01518dce-fc15-0def-958a-c916564effd6@synesis.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:44665 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751305AbdKUCCn (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Nov 2017 21:02:43 -0500
Received: by mail-io0-f182.google.com with SMTP id w127so17796654iow.11
        for <ceph-devel@vger.kernel.org>; Mon, 20 Nov 2017 18:02:43 -0800 (PST)
In-Reply-To: <01518dce-fc15-0def-958a-c916564effd6@synesis.ru>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Aleksei Gutikov <aleksey.gutikov@synesis.ru>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Nov 20, 2017 at 8:19 AM, Aleksei Gutikov
<aleksey.gutikov@synesis.ru> wrote:
> Hello,
>
> We tried to store large amount of small objects (about 5KB, at least bigger
> than 4k and smaller than 8k) in rgw that utilize ec pool
> xxx.rgw.buckets.data on ssds.
>
> osd_pool_erasure_code_stripe_unit=4096
> And we expected that data+xattrs will occupy for each object in that case
> max 12k. Maybe some fragmentation occurs, but we did not delete anything.
>
> Actually we faced space occupied by each object (from "MAX AVAIL" field from
> ceph df) is about 64k.
> Is that expected?
> What configuration option (maybe in bluestore) can improve this,
> bluestore_min_alloc_size_ssd?

What is your EC config on the pool? What is the output you're using to
judge how much space they're taking up?

If you're using hard drives, yes, I expect it to require 64KB at
minimum anyway...but I would have expected the different shards to
take up that space as well. (Though it might just hide in rocksdb and
not get counted the same way.)
-Greg
