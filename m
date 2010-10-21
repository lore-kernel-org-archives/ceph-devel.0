From: Sage Weil <sage@newdream.net>
Subject: Re: Fwd: [Qemu-devel] bdrv_flush for qemu block drivers nbd, rbd
 and sheepdog
Date: Thu, 21 Oct 2010 11:59:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1010211155301.18946@cobra.newdream.net>
References: <4CC04920.8040902@redhat.com> <AANLkTikHAm7opg1TzUrUWis53ENT_z6DjfT9GPeBdqA0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40563 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755875Ab0JUS4t (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Oct 2010 14:56:49 -0400
In-Reply-To: <AANLkTikHAm7opg1TzUrUWis53ENT_z6DjfT9GPeBdqA0@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <chb@muc.de>
Cc: ceph-devel@vger.kernel.org, Kevin Wolf <kwolf@redhat.com>

On Thu, 21 Oct 2010, Christian Brunner wrote:
> Hi,
> 
> is there a flush operation in librados? - I guess the only way to
> handle this, would be waiting until all aio requests are finished?

There is no flush currently.  But librados does no caching, so in this 
case at least silenting upgrading to cache=writethrough should work.

If that's a problem, we can implement a flush.  Just let us know.

sage



> 
> Regards,
> Christian
> 
> ---------- Forwarded message ----------
> From: Kevin Wolf <kwolf@redhat.com>
> Date: 2010/10/21
> Subject: [Qemu-devel] bdrv_flush for qemu block drivers nbd, rbd and sheepdog
> To: Christian Brunner <chb@muc.de>, Laurent Vivier
> <Laurent@vivier.eu>, MORITA Kazutaka <morita.kazutaka@lab.ntt.co.jp>
> Cc: Qemu-devel@nongnu.org
> 
> 
> Hi all,
> 
> I'm currently looking into adding a return value to qemu's bdrv_flush
> function and I noticed that your block drivers (nbd, rbd and sheepdog)
> don't implement bdrv_flush at all. bdrv_flush is going to return
> -ENOTSUP for any block driver not implementing this, effectively
> breaking these three drivers for anything but cache=unsafe.
> 
> Is there a specific reason why your drivers don't implement this? I
> think I remember that one of the drivers always provides
> cache=writethough semantics. It would be okay to silently "upgrade" to
> cache=writethrough, so in this case I'd just need to add an empty
> bdrv_flush implementation.
> 
> Otherwise, we really cannot allow any option except cache=unsafe because
> that's the semantics provided by the driver.
> 
> In any case, I think it would be a good idea to implement a real
> bdrv_flush function to allow the write-back cache modes cache=off and
> cache=writeback in order to improve performance over writethrough.
> 
> Is this possible with your protocols, or can the protocol be changed to
> consider this? Any hints on how to proceed?
> 
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
