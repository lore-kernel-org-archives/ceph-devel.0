From: Kevin Wolf <kwolf@redhat.com>
Subject: Re: Fwd: [Qemu-devel] bdrv_flush for qemu block drivers nbd, rbd
 and sheepdog
Date: Mon, 25 Oct 2010 09:58:58 +0200
Message-ID: <4CC538C2.9010303@redhat.com>
References: <4CC04920.8040902@redhat.com> <AANLkTikHAm7opg1TzUrUWis53ENT_z6DjfT9GPeBdqA0@mail.gmail.com> <Pine.LNX.4.64.1010211155301.18946@cobra.newdream.net> <4CC14DD3.6060504@redhat.com> <Pine.LNX.4.64.1010220916000.24595@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44849 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751884Ab0JYH6T (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 25 Oct 2010 03:58:19 -0400
In-Reply-To: <Pine.LNX.4.64.1010220916000.24595@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Christian Brunner <chb@muc.de>, ceph-devel@vger.kernel.org, Qemu-devel@nongnu.org

Am 22.10.2010 18:22, schrieb Sage Weil:
> On Fri, 22 Oct 2010, Kevin Wolf wrote:
>> [ Adding qemu-devel to CC again ]
>>
>> Am 21.10.2010 20:59, schrieb Sage Weil:
>>> On Thu, 21 Oct 2010, Christian Brunner wrote:
>>>> Hi,
>>>>
>>>> is there a flush operation in librados? - I guess the only way to
>>>> handle this, would be waiting until all aio requests are finished?
>>
>> That's not the semantics of bdrv_flush, you don't need to wait for
>> running requests. You just need to make sure that all completed requests
>> are safe on disk so that they would persist even in case of a
>> crash/power failure.
> 
> Okay, in that case we're fine.  librados doesn't declare a write committed 
> until it is safely on disk on multiple backend nodes.  There is a 
> mechanism to get an ack sooner, but the qemu storage driver does not use 
> it.  
> 
>>> There is no flush currently.  But librados does no caching, so in this 
>>> case at least silenting upgrading to cache=writethrough should work.
>>
>> You're making sure that the data can't be cached in the server's page
>> cache or volatile disk cache either, e.g. by using O_SYNC for the image
>> file? If so, upgrading would be safe.
> 
> Right.

Okay, implementing bdrv_flush as a nop is fine then.

>>> If that's a problem, we can implement a flush.  Just let us know.
>>
>> Presumably providing a writeback mode with explicit flushes could
>> improve performance. Upgrading to writethrough is not a correctness
>> problem, though, so it's your decision if you want to implement it.
> 
> So is a bdrv_flush generated when e.g. the guest filesystem issues a 
> barrier, or would otherwise normally ask a SATA disk to flush it's cache?

Right, this is the implementation for things like the FLUSH CACHE
command in ATA. It's also used for ordering of writes to image metadata
in formats like qcow2, but that's probably an unusual scenario for the
Ceph backend.

Kevin
