From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: can "rbd unmap" detect if device is mounted?
Date: Mon, 16 Jul 2012 17:43:40 -0700
Message-ID: <5004B53C.9020705@inktank.com>
References: <CACkq2mqt5ae4U_-yhNM94GYQnE_negqXqHTf3JaSZ0zsxya9Yw@mail.gmail.com> <500498FC.9070806@inktank.com> <CADvuQREm_PCatUUdgUjsUNMNBNEtB9_z9LTvo9D0Gyq7dR8XeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64246 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308Ab2GQAnn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Jul 2012 20:43:43 -0400
Received: by pbbrp8 with SMTP id rp8so10867613pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 16 Jul 2012 17:43:43 -0700 (PDT)
In-Reply-To: <CADvuQREm_PCatUUdgUjsUNMNBNEtB9_z9LTvo9D0Gyq7dR8XeQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: Travis Rhoden <trhoden@gmail.com>, ceph-devel@vger.kernel.org

On 07/16/2012 04:37 PM, Tommi Virtanen wrote:
> On Mon, Jul 16, 2012 at 3:43 PM, Josh Durgin<josh.durgin@inktank.com>  wrote:
>>> I've made this mistake a couple of times now (completely my fault,
>>> when will I learn?), and am wondering if a bit of protection can be
>>> put in place against user errors.
>> Yeah, we've been working on advisory locking. The first step is
>> just adding an option to lock via the rbd command line tool, so you
>> could script lock/map and unmap/unlock.
>
> Is his problem really about the locking?
>
> It sounded to me like, he has something (the mount) referencing a
> block device, and we're letting the block device disappear.
>
> The locking you guys have been talking about sounds like that lock
> would be held whenever the image is mapped, regardless of whether it's
> mounted or not (think mkfs).
>
>
> Should unmap even be possible while the block device is open?
> Shouldn't there be a refcount and an -EBUSY? That's what other block
> device providers do:

That would be the best solution. Looking into it, the rbd driver
is already keeping a refcount just like the loop driver (in 
block_device_operations .open/.release). The rbd driver is only using
it for the struct device though, instead of struct rbd_device. This
shouldn't be too hard to fix.

Josh
