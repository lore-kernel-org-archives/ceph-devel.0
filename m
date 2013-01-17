From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH REPOST 6/6] rbd: move remaining osd op setup into rbd_osd_req_op_create()
Date: Thu, 17 Jan 2013 16:25:06 -0600
Message-ID: <50F87A42.8010402@inktank.com>
References: <50E6EF5F.9080200@inktank.com> <50E6F028.6040904@inktank.com> <50F77CC5.6070703@inktank.com> <50F7800C.4070306@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:65485 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034Ab3AQWZJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jan 2013 17:25:09 -0500
Received: by mail-ie0-f179.google.com with SMTP id k14so5561499iea.10
        for <ceph-devel@vger.kernel.org>; Thu, 17 Jan 2013 14:25:08 -0800 (PST)
In-Reply-To: <50F7800C.4070306@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/16/2013 10:37 PM, Alex Elder wrote:
> On 01/16/2013 10:23 PM, Josh Durgin wrote:
>> On 01/04/2013 07:07 AM, Alex Elder wrote:
>>> The two remaining osd ops used by rbd are CEPH_OSD_OP_WATCH and
>>> CEPH_OSD_OP_NOTIFY_ACK.  Move the setup of those operations into
>>> rbd_osd_req_op_create(), and get rid of rbd_create_rw_op() and
>>> rbd_destroy_op().
>>>
>>> Signed-off-by: Alex Elder <elder@inktank.com>

. . .

>>> +    case CEPH_OSD_OP_NOTIFY_ACK:
>>> +    case CEPH_OSD_OP_WATCH:
>>> +        /* rbd_osd_req_op_create(NOTIFY_ACK, cookie, version) */
>>> +        /* rbd_osd_req_op_create(WATCH, cookie, version, flag) */
>>> +        op->watch.cookie = va_arg(args, u64);
>>> +        op->watch.ver = va_arg(args, u64);
>>> +        op->watch.ver = cpu_to_le64(op->watch.ver);    /* XXX */
>>
>> why the /* XXX */ comment?
> 
> Because it's the only value here that is converted
> from cpu byte order.  It was added in this commit:
> 
>     a71b891bc7d77a070e723c8c53d1dd73cf931555
>     rbd: send header version when notifying
> 
> And I think was done without full understanding that it
> was being done different from all the others.  I think
> it may be wrong but I haven't really looked at it yet.
> Pulling them all into this function made this difference
> more obvious.

I've created this to track getting this issue resolved:
    http://tracker.newdream.net/issues/3847

> It was a "note to self" that I wanted to fix that.
> 
> I normally try to resolve anything like that before I
> post for review but I guess I forgot.  There may be
> others.

I'm deleting the "XXX" comment before I commit this change.

					-Alex

. . .
