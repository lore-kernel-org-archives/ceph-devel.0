From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH 1/1] libceph: use memalloc flags for net IO
Date: Thu, 16 Oct 2014 14:10:15 +0400
Message-ID: <CALFYKtBY7C15+Z_9ZeTUBivM9_O+myAUgvBSBAST105hNpPorg@mail.gmail.com>
References: <1413442219-28024-1-git-send-email-michaelc@cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:64070 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398AbaJPKKQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Oct 2014 06:10:16 -0400
Received: by mail-qc0-f171.google.com with SMTP id i17so2450789qcy.2
        for <ceph-devel@vger.kernel.org>; Thu, 16 Oct 2014 03:10:15 -0700 (PDT)
In-Reply-To: <1413442219-28024-1-git-send-email-michaelc@cs.wisc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: michaelc@cs.wisc.edu
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Oct 16, 2014 at 10:50 AM,  <michaelc@cs.wisc.edu> wrote:
> From: Mike Christie <michaelc@cs.wisc.edu>
>
> This patch has ceph's lib code use the memalloc flags.
>
> If the VM layer needs to write data out to free up memory to handle new
> allocation requests, the block layer must be able to make forward progress.
> To handle that requirement we use structs like mempools to reserve memory for
> objects like bios and requests.
>
> The problem is when we send/receive block layer requests over the network
> layer, net skb allocations can fail and the system can lock up.
> To solve this, the memalloc related flags were added. NBD, iSCSI
> and NFS uses these flags to tell the network/vm layer that it should
> use memory reserves to fullfill allcation requests for structs like
> skbs.

Applied with my Reviewed-by.

>
> I am running ceph in a bunch of VMs in my laptop, so this patch was
> not tested very harshly. The patch was made over Linus's tree. I tried
> to make it over the ceph-client tree but noticed it was very old (3.3
> kernel or something).

I'm guessing you tried Sage's k.org tree.  We do everything on github
(testing branch), k.org tree is used for pull requests only so master
is not updated.

https://github.com/ceph/ceph-client

Thanks,

                Ilya
