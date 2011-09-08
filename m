From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] improve qemu-img conversion performance
Date: Thu, 8 Sep 2011 08:56:28 +0100
Message-ID: <20110908075628.GA23849@stefanha-thinkpad.localdomain>
References: <cover.1315436097.git.yehuda@hq.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57799 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932192Ab1IHH4e (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Sep 2011 03:56:34 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so1231076fxh.19
        for <ceph-devel@vger.kernel.org>; Thu, 08 Sep 2011 00:56:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <cover.1315436097.git.yehuda@hq.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@hq.newdream.net>
Cc: qemu-devel@nongnu.org, ceph-devel@vger.kernel.org, sage@newdream.net, yehudasa@gmail.com

On Wed, Sep 07, 2011 at 04:06:51PM -0700, Yehuda Sadeh wrote:
> The following set of patches improve the qemu-img conversion process
> performance. When using a higher latency backend, small writes have a
> severe impact on the time it takes to do image conversion. 
> We switch to using async writes, and we avoid splitting writes due to
> holes when the holes are small enough.
> 
> Yehuda Sadeh (2):
>   qemu-img: async write to block device when converting image
>   qemu-img: don't skip writing small holes
> 
>  qemu-img.c |   34 +++++++++++++++++++++++++++-------
>  1 files changed, 27 insertions(+), 7 deletions(-)
> 
> -- 
> 2.7.5.1

This has nothing to do with the patch itself, but I've been curious
about the existence of both a QEMU and a Linux kernel rbd block driver.

The I/O latency with qemu-img has been an issue for rbd users.  But they
have the option of using the Linux kernel rbd block driver, where
qemu-img can take advantage of the page cache instead of performing
direct I/O.

Does this mean you intend to support both QEMU block/rbd.c and Linux
drivers/block/rbd.c?  As a user I would go with the Linux kernel driver
instead of the QEMU block driver because it offers page cache and host
block device features.  On the other hand a userspace driver is nice
because it does not require privileges.

Stefan
