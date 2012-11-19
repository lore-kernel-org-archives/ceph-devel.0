From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: librbd discard bug problems -> i got it
Date: Mon, 19 Nov 2012 15:47:40 -0800
Message-ID: <50AAC51C.1090904@inktank.com>
References: <50AAA25F.9040908@profihost.ag> <50AAB4D6.3030304@inktank.com> <50AABDD1.5050802@profihost.ag> <50AAC1B1.9070701@inktank.com> <50AAC3CB.9090309@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55032 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753215Ab2KSXsT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Nov 2012 18:48:19 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so3823059pbc.19
        for <ceph-devel@vger.kernel.org>; Mon, 19 Nov 2012 15:48:18 -0800 (PST)
In-Reply-To: <50AAC3CB.9090309@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 11/19/2012 03:42 PM, Stefan Priebe wrote:
> Am 20.11.2012 00:33, schrieb Josh Durgin:
>> On 11/19/2012 03:16 PM, Stefan Priebe wrote:
>>> mhm qemu rbd block driver. Get's always these errors back. As
>>> rbd_aio_bh_cb is directly called from librbd the problem must be there.
>>> Strangely i can't find where rbd_aio_bh_cb get's called with -512.
>>>
>>> ANy further ideas?
>>
>> Two ideas:
>>
>> 1) Is rbd_finish_aiocb getting this same return value?
> Will check this tomorrow.
>
>
>> 2) Perhaps it's an issue with the return value wrapping around with
>> very large discards. Adding some logging of the return values of each
>> rados operation in AioCompletion::complete_request() might give us a
>> clue. These large negative return values are suspicious.
>
> Good idea. As r and rval is int it is limited. But
> AioCompletion::complete_request is adding more and more stuff to rval.
> What could be a solution? Bump rval to int64? Or wrap to around to start
> at 0 again?

The final return value is limited to int at a few levels. Probably it's
best to make discard alway return 0 on success. aio_discard should
already be doing this, but perhaps it's not in this case.

Josh
