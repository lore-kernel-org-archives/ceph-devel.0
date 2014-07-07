From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Cache tier READ_FORWARD transition
Date: Mon, 07 Jul 2014 16:02:26 -0500
Message-ID: <53BB0AE2.6000903@inktank.com>
References: <53BACB03.5010603@redhat.com> <alpine.DEB.2.00.1407070934120.23451@cobra.newdream.net> <53BAF752.3080005@inktank.com> <alpine.DEB.2.00.1407071242050.24973@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:52718 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbaGGVC1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Jul 2014 17:02:27 -0400
Received: by mail-ig0-f181.google.com with SMTP id h15so4834935igd.8
        for <ceph-devel@vger.kernel.org>; Mon, 07 Jul 2014 14:02:26 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1407071242050.24973@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Luis Pabon <lpabon@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 07/07/2014 02:43 PM, Sage Weil wrote:
> On Mon, 7 Jul 2014, Mark Nelson wrote:
>> On 07/07/2014 02:29 PM, Sage Weil wrote:
>>> On Mon, 7 Jul 2014, Luis Pabon wrote:
>>>> Hi all,
>>>>       I am working on OSDMonitor.cc:5325 and wanted to confirm the
>>>> following
>>>> read_forward cache tier transition:
>>>>
>>>>       readforward -> forward || writeback || (any && num_objects_dirty ==
>>>> 0)
>>>>       forward -> writeback || readforward || (any && num_objects_dirty ==
>>>> 0)
>>>>       writeback -> readforward || forward
>>>>
>>>> Is this the correct cache tier state transition?
>>>
>>> That looks right to me.
>>>
>>> By the way, I had a thought after we spoke that we probably want something
>>> that is somewhere inbetween the current writeback behavior (promote on
>>> first read) and the read_forward behavior (never promote on read).  I
>>> suspect a good all-around policy is something like promote on second read?
>>> This should probably be rolled into the writeback mode as a tunable...
>>
>> That would be a good start I think.  What about some kind of scheme that also
>> favours promoting small objects over larger ones?  It could be as simple as
>> increasing the number of reads necessary to do a promotion based on the object
>> size.
>>
>> ie something like:
>>
>> <= 64k object = 1 read
>> <= 512k object = 2 read
>> else 3 read
>>
>> That would make the behaviour for default RBD object sizes always 3 read, but
>> could keep big objects out of the cache tier for RGW.
>
> We don't have enough information to do that right now, since on a miss we
> redirect the client instead of proxying them and never learn what the
> actual object size is.
>
> If/after we start doing proxying for the reads, then lots of other stuff
> becomes possible... but I think we'll need to be careful about choosing
> where to add complexity.

Ok, that makes sense.  Ignoring RGW for the moment, on the RBD side can 
we infer about the object sizes based on the image order?  Can we 
provide a hint in some way?  I guess my assumptions specifically for RBD 
are:

1) For large reads from any object:

very low promotion priority since spinning disks can do this fast. Can 
get just from the read len?

2) For small reads from (presumed) large objects

sequential IO: Probably not at all (especially if we have big enough 
read ahead on base pool OSD fs)?  Can we  save/check previous read 
pos(s) of the same object in addition to a previous attempt?  Too complex?

random IO: Maybe even 3rd read attempt?  The worst reads will come out 
of buffer cache anyway.  Given how expensive promotion is for large 
objects, it seems to me we need to promote very slowly and infrequently.

3) reads from (presumed) small objects.

Do the promotion right away since the promotion is small and the SSDs 
can do small writes faster than the spinning disks can do small reads?

