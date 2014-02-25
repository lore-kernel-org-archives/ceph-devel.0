From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 6/6] rbd: prefix rbd writes with CEPH_OSD_OP_SETALLOCHINT
 osd op
Date: Tue, 25 Feb 2014 07:19:31 -0600
Message-ID: <530C9863.3070003@ieee.org>
References: <1393008946-7931-1-git-send-email-ilya.dryomov@inktank.com>	<1393008946-7931-7-git-send-email-ilya.dryomov@inktank.com>	<530B5E47.1020204@ieee.org> <CALFYKtB6F6xq-fpZrEZwxb+8k23Oda=W=hLEV_k+aO5aULhGPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:63332 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752227AbaBYNT2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Feb 2014 08:19:28 -0500
Received: by mail-ig0-f182.google.com with SMTP id l13so1274755iga.3
        for <ceph-devel@vger.kernel.org>; Tue, 25 Feb 2014 05:19:28 -0800 (PST)
In-Reply-To: <CALFYKtB6F6xq-fpZrEZwxb+8k23Oda=W=hLEV_k+aO5aULhGPQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 02/25/2014 06:58 AM, Ilya Dryomov wrote:
> On Mon, Feb 24, 2014 at 4:59 PM, Alex Elder <elder@ieee.org> wrote:
>> On 02/21/2014 12:55 PM, Ilya Dryomov wrote:
>>> In an effort to reduce fragmentation, prefix every rbd write with
>>> a CEPH_OSD_OP_SETALLOCHINT osd op with an expected_write_size value set
>>> to the object size (1 << order).  Backwards compatibility is taken care
>>> of on the libceph/osd side.
>>
>> If *every* write will include a hint, why even encode this as
>> a distinct opcode?  Why not just extend the definition of a
>> write operation to include the write hint data?  The server
>> side could check expected_object_size, and if 0 (or some other
>> invalid value) it means the client isn't supplying a hint.
>>
>> However, on the assumption you want this to be a distinct
>> OSD op I think you generally did the right thing.  See my
>> comments below.  For now I'm not indicating "Reviewed-by"
>> because it sounds like the nature of this change is under
>> discussion still.  And I really do think that if the hint
>> is not going to be made more generic (and possibly even if
>> it is) I'd rather see this hinting done using an extension
>> of the write operation (like I suggest above).  In this
>> case it is clearly directly tied to every write operation
>> and separating it sort of obscures that.
> 
> Yes, the assumption is that we want to do this in a separate op.  The
> hint is durable, in that it's enough to do it once, so it doesn't make
> much sense to fold it into the write op(s).  The reason every rbd write
> is prefixed is that rbd doesn't explicitly create objects and relies on
> writes creating them implicitly, so there is no place to stick a single
> hint op into.  To get around that we decided to prefix every rbd write
> with a hint (just like write and setattr ops, hint op will create an
> object implicitly if it doesn't exist).

I was thinking primarily in the RBD context and not the
OSD write more generally I guess.  I suspected it was durable
and knew why it still needs to be attached to every rbd write.

On a separate note, it seems to me we've discussed how one
could maintain a bitmap of created (known to be written) RBD
objects for an image, which could be used for layered images
to avoid the separate parent read request.  If such a thing
ever got implemented it could be used to skip the hint as well.

> I'll add the above paragraph to the commit message.

Everything else you incorporated or explained, so this looks
good to me.

Reviewed-by: Alex Elder <elder@linaro.org>

