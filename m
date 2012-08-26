From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Ideal hardware spec?
Date: Sun, 26 Aug 2012 08:29:40 -0500
Message-ID: <503A24C4.5060807@inktank.com>
References: <20120822135530.GB10015@csail.mit.edu> <5034E9F3.10001@widodh.nl> <20120822154615.GF10015@csail.mit.edu> <5035FF18.3030209@widodh.nl> <CABYiri_-73UyTKHcHWDZdjqb=rozjraVzxd166NZV2ir53tduA@mail.gmail.com> <503A056E.2020804@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45895 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751457Ab2HZN3p (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 26 Aug 2012 09:29:45 -0400
Received: by ialo24 with SMTP id o24so6399770ial.19
        for <ceph-devel@vger.kernel.org>; Sun, 26 Aug 2012 06:29:45 -0700 (PDT)
In-Reply-To: <503A056E.2020804@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: Andrey Korolyov <andrey@xdel.ru>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 08/26/2012 06:15 AM, Wido den Hollander wrote:
> CC'ing this one back to the list.
>
> On 08/25/2012 09:58 PM, Andrey Korolyov wrote:
>>>
>>> They should be much more reliable than regular USB sticks due to
>>> their SLC
>>> memory.
>>>
>>> You could also take a look at these:
>>> http://www.transcend-info.com/industry/products_details.asp?CatNo=2&SerNo=14&ModNo=28&Func1No=1
>>>
>>>
>>>
>>
>> Did you tried yet those or simular sticks for CEPH journal? Right now
>> I am using Intel 313`s, which is very fast and have durability/price
>> ratio a far higher than any imaginable MLC, but they occupying one HDD
>> slot which is a quite impractical.
>>
>
> No, I haven't tried, but I think it won't work.
>
> These kind of SLC chips don't do random writes that great, you'll
> probably get something like 4MB/sec in random writes.
>
> Bigger SSDs have more cells to spread the writes over, those small
> sticks don't.
>
> The Intel 3XX or 5XX serie should work just fine for journaling, I'd
> however recommend you change the Host Protected Area to ~50% of the
> available capacity to prevent write-degradation over time.
>
> Wido
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html

Not just write degradation, but undersubscribing the SSDs should 
hopefully help them last a little longer under such a heavy write 
workload.  We are doing 3 10GB journals per 180GB Intel 520 on our 
supermicro test node.

Mark
