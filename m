From: Kevin Wolf <kwolf@redhat.com>
Subject: Re: Fwd: [Qemu-devel] bdrv_flush for qemu block drivers nbd, rbd
 and sheepdog
Date: Fri, 22 Oct 2010 10:39:47 +0200
Message-ID: <4CC14DD3.6060504@redhat.com>
References: <4CC04920.8040902@redhat.com> <AANLkTikHAm7opg1TzUrUWis53ENT_z6DjfT9GPeBdqA0@mail.gmail.com> <Pine.LNX.4.64.1010211155301.18946@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:9502 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750881Ab0JVIjM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 22 Oct 2010 04:39:12 -0400
In-Reply-To: <Pine.LNX.4.64.1010211155301.18946@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Christian Brunner <chb@muc.de>, ceph-devel@vger.kernel.org, Qemu-devel@nongnu.org

[ Adding qemu-devel to CC again ]

Am 21.10.2010 20:59, schrieb Sage Weil:
> On Thu, 21 Oct 2010, Christian Brunner wrote:
>> Hi,
>>
>> is there a flush operation in librados? - I guess the only way to
>> handle this, would be waiting until all aio requests are finished?

That's not the semantics of bdrv_flush, you don't need to wait for
running requests. You just need to make sure that all completed requests
are safe on disk so that they would persist even in case of a
crash/power failure.

> There is no flush currently.  But librados does no caching, so in this 
> case at least silenting upgrading to cache=writethrough should work.

You're making sure that the data can't be cached in the server's page
cache or volatile disk cache either, e.g. by using O_SYNC for the image
file? If so, upgrading would be safe.

> If that's a problem, we can implement a flush.  Just let us know.

Presumably providing a writeback mode with explicit flushes could
improve performance. Upgrading to writethrough is not a correctness
problem, though, so it's your decision if you want to implement it.

Kevin

>> ---------- Forwarded message ----------
>> From: Kevin Wolf <kwolf@redhat.com>
>> Date: 2010/10/21
>> Subject: [Qemu-devel] bdrv_flush for qemu block drivers nbd, rbd and sheepdog
>> To: Christian Brunner <chb@muc.de>, Laurent Vivier
>> <Laurent@vivier.eu>, MORITA Kazutaka <morita.kazutaka@lab.ntt.co.jp>
>> Cc: Qemu-devel@nongnu.org
>>
>>
>> Hi all,
>>
>> I'm currently looking into adding a return value to qemu's bdrv_flush
>> function and I noticed that your block drivers (nbd, rbd and sheepdog)
>> don't implement bdrv_flush at all. bdrv_flush is going to return
>> -ENOTSUP for any block driver not implementing this, effectively
>> breaking these three drivers for anything but cache=unsafe.
>>
>> Is there a specific reason why your drivers don't implement this? I
>> think I remember that one of the drivers always provides
>> cache=writethough semantics. It would be okay to silently "upgrade" to
>> cache=writethrough, so in this case I'd just need to add an empty
>> bdrv_flush implementation.
>>
>> Otherwise, we really cannot allow any option except cache=unsafe because
>> that's the semantics provided by the driver.
>>
>> In any case, I think it would be a good idea to implement a real
>> bdrv_flush function to allow the write-back cache modes cache=off and
>> cache=writeback in order to improve performance over writethrough.
>>
>> Is this possible with your protocols, or can the protocol be changed to
>> consider this? Any hints on how to proceed?
>>
>> Kevin
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
