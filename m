From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: less cores more iops / speed
Date: Wed, 07 Nov 2012 18:59:48 -0600
Message-ID: <509B0404.5010500@inktank.com>
References: <509ADA6A.9000807@profihost.ag> <509AF625.8040207@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:51785 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754519Ab2KHA7s (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Nov 2012 19:59:48 -0500
Received: by mail-ia0-f174.google.com with SMTP id y32so1559318iag.19
        for <ceph-devel@vger.kernel.org>; Wed, 07 Nov 2012 16:59:48 -0800 (PST)
In-Reply-To: <509AF625.8040207@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joao Eduardo Luis <joao.luis@inktank.com>
Cc: Stefan Priebe <s.priebe@profihost.ag>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 11/07/2012 06:00 PM, Joao Eduardo Luis wrote:
> On 11/07/2012 10:02 PM, Stefan Priebe wrote:
>> Hello again,
>>
>> I've noticed something really interesting.
>>
>> I get 5000 iops / VM for rand. 4k writes while assigning 4 cores on a
>> 2.5 Ghz Xeon.
>>
>> When i move this VM to another kvm host with 3.6Ghz i get 8000 iops
>> (still 8 cores) when i then LOWER the assigned cores from 8 to 4 i get
>> 14.500 iops. If i assign only 2 cores i get 16.000 iops...
>>
>> Why does less kvm cores mean more speed?
>
> Totally going on a limb here, but might be related to the cache maybe?
> When you have more cores your threads may bounce around the cores and
> invalidate cache entries as they go by; will less cores you might end up
> with some sort of twisted, forced cpu affinity that allows you to take
> advantage of caching.

There's also the context switching overhead.  It'd be interesting to 
know how much the writer processes were shifting around on cores. 
Stefan, what tool were you using to do writes?

>
> But I don't know, really. I would be amazed if what I just wrote had an
> ounce of truth, and would be completely astonished if that was the cause
> for such a sudden increase on iops.

Yeah, it's seems pretty surprising that there would be any significant 
effect at this level of performance.

>
>    -Joao
>
>>
>> Greets,
>> Stefan
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

