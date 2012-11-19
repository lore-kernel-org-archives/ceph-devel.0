From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: librbd discard bug problems -> i got it
Date: Mon, 19 Nov 2012 23:45:22 +0100
Message-ID: <50AAB682.7070506@profihost.ag>
References: <50AAA25F.9040908@profihost.ag> <50AAB4D6.3030304@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:44418 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752690Ab2KSWpY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Nov 2012 17:45:24 -0500
In-Reply-To: <50AAB4D6.3030304@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Josh,

how can i log in AioRequest.h?

I need to add some debugging into:
     void complete(int r)
     {
       if (should_complete(r)) {
         if (m_hide_enoent && r == -ENOENT)
           r = 0;
         m_completion->complete(r);
         delete this;
       }
     }

Stefan

Am 19.11.2012 23:38, schrieb Josh Durgin:
> On 11/19/2012 01:19 PM, Stefan Priebe wrote:
>> Hello Josh,
>>
>> after digging three days around i got it.
>
> That's great!
>
>> The problem is in aio_discard in internal.cc. The i/o fails when AioZero
>> or AioTruncate is used.
>
> Interesting, I wouldn't have expected the bug to be there. Is
> it failing with a different error code, or just taking too long
> so the guest kernel tries to cancel it?
>
>> It works fine with AioRemove. It seems to depend on overlapping.
>> Hopefully i'm able to provide a patch this nicht.
>
> Looking forward to it!
>
> Josh
