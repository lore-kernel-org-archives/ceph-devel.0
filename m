From: Hannes Landeholm <hannes@jumpstarter.io>
Subject: Re: RBD Kernel panic rbd_dev_refresh
Date: Thu, 12 Feb 2015 16:24:59 +0100
Message-ID: <CABt9es8smjGVa36NPJ4XHNthsesVg14sT0np5v0xpmWojkHDUA@mail.gmail.com>
References: <CAPZO0-PBVXKoCu3N0USFSO=8NmTj9k2Ys82zJBnFVv2Q4xEFkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:44521 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969AbbBLPZB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Feb 2015 10:25:01 -0500
Received: by lams18 with SMTP id s18so10713297lam.11
        for <ceph-devel@vger.kernel.org>; Thu, 12 Feb 2015 07:25:00 -0800 (PST)
In-Reply-To: <CAPZO0-PBVXKoCu3N0USFSO=8NmTj9k2Ys82zJBnFVv2Q4xEFkA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thorwald Lundqvist <thorwald@jumpstarter.io>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

We don't have any debug symbols but here is a dump of the .ko at this address:

https://gist.github.com/hannes-landeholm/b4664e2e7e37ad13177c

It's likely this line (rbd_dev_refresh+0xcb)

3d5b:       4c 89 60 50             mov    %r12,0x50(%rax)

%rax here is null which causes the invalid write to address 0000000000000050.

I'm pretty sure it's the following line in rbd.c which is the offender
if you look at the context (below spinlock and shr, above call to
revalidate_disk).

set_capacity(rbd_dev->disk, size);

https://github.com/torvalds/linux/blob/e69b8d414f948c242ad9f3eb2b7e24fba783dbbd/drivers/block/rbd.c#L3682

--
Hannes Landeholm
