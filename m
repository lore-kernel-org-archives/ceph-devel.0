From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: RBD Kernel panic =?utf-8?b?cmJkX2Rldl9yZWZyZXNo?=
Date: Thu, 12 Feb 2015 16:19:26 +0000 (UTC)
Message-ID: <loom.20150212T171651-371@post.gmane.org>
References: <CAPZO0-PBVXKoCu3N0USFSO=8NmTj9k2Ys82zJBnFVv2Q4xEFkA@mail.gmail.com> <CABt9es8smjGVa36NPJ4XHNthsesVg14sT0np5v0xpmWojkHDUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:35595 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756283AbbBLQZF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 12 Feb 2015 11:25:05 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1YLwZb-0002cp-Sk
	for ceph-devel@vger.kernel.org; Thu, 12 Feb 2015 17:25:04 +0100
Received: from 201-67-110-109.host.sevstar.net ([201-67-110-109.host.sevstar.net])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 12 Feb 2015 17:25:03 +0100
Received: from idryomov by 201-67-110-109.host.sevstar.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 12 Feb 2015 17:25:03 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Thu, Feb 12, 2015 at 4:24 PM, Hannes Landeholm <hannes@jumpstarter.io> wrote:
> We don't have any debug symbols but here is a dump of the .ko at this address:
>
> https://gist.github.com/hannes-landeholm/b4664e2e7e37ad13177c
>
> It's likely this line (rbd_dev_refresh+0xcb)
>
> 3d5b:       4c 89 60 50             mov    %r12,0x50(%rax)
>
> %rax here is null which causes the invalid write to address 0000000000000050.
>
> I'm pretty sure it's the following line in rbd.c which is the offender
> if you look at the context (below spinlock and shr, above call to
> revalidate_disk).
>
> set_capacity(rbd_dev->disk, size);

I'll file a ticket and look into this.

Thanks,

                Ilya


