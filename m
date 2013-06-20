From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: mon crash
Date: Thu, 20 Jun 2013 12:03:34 +0100
Message-ID: <51C2E186.6070604@inktank.com>
References: <6035A0D088A63A46850C3988ED045A4B5C2183F2@BITCOM1.int.sbss.com.au> <alpine.DEB.2.00.1306190900030.27900@cobra.newdream.net> <6035A0D088A63A46850C3988ED045A4B5C219BA2@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56318 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965184Ab3FTLDW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Jun 2013 07:03:22 -0400
Received: by mail-bk0-f46.google.com with SMTP id na10so2801943bkb.5
        for <ceph-devel@vger.kernel.org>; Thu, 20 Jun 2013 04:03:20 -0700 (PDT)
In-Reply-To: <6035A0D088A63A46850C3988ED045A4B5C219BA2@BITCOM1.int.sbss.com.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Harper <james.harper@bendigoit.com.au>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 06/20/2013 12:31 AM, James Harper wrote:
>>
>> On Wed, 19 Jun 2013, James Harper wrote:
>>> Every time I start up one of my mons it crashes. Two others are running
>>> but there seems to be long delays (=several seconds) when doing mon
>>> status (maybe this is the behaviour when one mon is down?)
>>>
>>> The tail of /var/log/ceph/ceph-mon.4.log follows this email.
>>>
>>> Version is 0.61.3-1~bpo70+1 from http://ceph.com/debian-cuttlefish
>> wheezy main
>>>
>>> This was happening in a previous version, and then even before that but
>>> I thought I'd fixed it by wiping the errant mon and recreating it.
>>>
>>> Anything else I can supply that might help?
>>
>> Can you try installing the current cuttlefish branch package and see if
>> the problem is still present?  If so, we can gather logs to fully
>> diagnose.
>>
>> http://gitbuilder.ceph.com/ceph-deb-precise-x86_64-basic/ref/cuttlefish/
>>
>
> I used http://gitbuilder.ceph.com/ceph-deb-wheezy-x86_64-basic/ref/cuttlefish and mon started and joined the cluster within 30 seconds (probably much less), and appears to be running and stable.
>
> Will this patch hit the regular repository soon?

I believe cuttlefish should become 0.61.4 soon.

   -Joao

>
> Thanks
>
> James
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Joao Eduardo Luis
Software Engineer | http://inktank.com | http://ceph.com
