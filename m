From: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] improve qemu-img conversion performance
Date: Thu, 08 Sep 2011 16:13:18 +0200
Message-ID: <4E68CD7E.2050704@redhat.com>
References: <cover.1315436097.git.yehuda@hq.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:25768 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933032Ab1IHOKZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 8 Sep 2011 10:10:25 -0400
In-Reply-To: <cover.1315436097.git.yehuda@hq.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@hq.newdream.net>
Cc: qemu-devel@nongnu.org, ceph-devel@vger.kernel.org, sage@newdream.net, yehudasa@gmail.com

Am 08.09.2011 01:06, schrieb Yehuda Sadeh:
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

This doesn't seem to be against git master or the block tree. Please rebase.

I think that commit a22f123c may obsolete your patch 2/2.

Kevin
