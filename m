From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: librbd discard bug problems -> i got it
Date: Mon, 19 Nov 2012 14:48:53 -0800
Message-ID: <50AAB755.7060805@inktank.com>
References: <50AAA25F.9040908@profihost.ag> <50AAB4D6.3030304@inktank.com> <50AAB682.7070506@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:49429 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752690Ab2KSWtb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Nov 2012 17:49:31 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so776825pad.19
        for <ceph-devel@vger.kernel.org>; Mon, 19 Nov 2012 14:49:30 -0800 (PST)
In-Reply-To: <50AAB682.7070506@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 11/19/2012 02:45 PM, Stefan Priebe wrote:
> Hi Josh,
>
> how can i log in AioRequest.h?
>
> I need to add some debugging into:
>      void complete(int r)
>      {
>        if (should_complete(r)) {
>          if (m_hide_enoent && r == -ENOENT)
>            r = 0;
>          m_completion->complete(r);
>          delete this;
>        }
>      }

Move the implementation of the method out of the header and into
AioRequest.cc. Then you can use ldout like in the rest of that file.

Josh

> Am 19.11.2012 23:38, schrieb Josh Durgin:
>> On 11/19/2012 01:19 PM, Stefan Priebe wrote:
>>> Hello Josh,
>>>
>>> after digging three days around i got it.
>>
>> That's great!
>>
>>> The problem is in aio_discard in internal.cc. The i/o fails when AioZero
>>> or AioTruncate is used.
>>
>> Interesting, I wouldn't have expected the bug to be there. Is
>> it failing with a different error code, or just taking too long
>> so the guest kernel tries to cancel it?
>>
>>> It works fine with AioRemove. It seems to depend on overlapping.
>>> Hopefully i'm able to provide a patch this nicht.
>>
>> Looking forward to it!
>>
>> Josh
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

