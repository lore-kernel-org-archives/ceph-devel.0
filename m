From: Wido den Hollander <wido@widodh.nl>
Subject: Re: how to free space from rados bench comman?
Date: Thu, 24 May 2012 10:22:08 +0200
Message-ID: <4FBDEFB0.3030700@widodh.nl>
References: <4FBDDCAE.7040709@profihost.ag> <4FBDE314.7030305@widodh.nl> <4FBDE57F.9010409@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:60095 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101Ab2EXIWM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 May 2012 04:22:12 -0400
In-Reply-To: <4FBDE57F.9010409@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



On 24-05-12 09:38, Stefan Priebe - Profihost AG wrote:
> Am 24.05.2012 09:28, schrieb Wido den Hollander:
>> Hi,
>>
>> On 24-05-12 09:01, Stefan Priebe - Profihost AG wrote:
>>> Hi,
>>>
>>> every rados bench write uses disk space and my space fills up. How to
>>> free this space again?
>>>
>>> Used command?
>>> rados -p data bench 60 write -t 16
>>
>> What does this show:
>>
>> $ rados -p data ls|wc -l
>
> ~# rados -p data ls|wc -l
> 46631

That is weird, I thought the bench tool cleaned up it's "mess".

Imho it should cleanup after it's done, but there might be a reason why 
it's not. Did you abort the benchmark or did you let it do the whole run?

>
> I do not use the data pool so it is seperate ;-) i only use the rbd pool
> for block devices.
>
> So i will free the space with:
> for i in `rados -p data ls`; do echo $i; rados -p data rm $i; done

rados -p data ls|xargs -n 1 rados -p data rm

I love shorter commands ;)

Wido

>
> Thanks!
>
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
