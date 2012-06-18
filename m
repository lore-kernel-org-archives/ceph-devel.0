From: Wido den Hollander <wido@widodh.nl>
Subject: Re: extent rbd ls to show size and free space?
Date: Mon, 18 Jun 2012 15:10:23 +0200
Message-ID: <4FDF28BF.1090600@widodh.nl>
References: <4FDF1A31.6010606@profihost.ag> <4FDF235E.8030301@widodh.nl> <4FDF270C.7010606@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:58678 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756Ab2FRNKZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jun 2012 09:10:25 -0400
In-Reply-To: <4FDF270C.7010606@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 06/18/2012 03:03 PM, Stefan Priebe - Profihost AG wrote:
> Am 18.06.2012 14:47, schrieb Wido den Hollander:
>> Hi,
>>
>> > Hello list,
>> >
>> > are there any plans to extent rbd ls in a way that it shows, image size
>> > and free space of the pool?
>> >
>>
>> You want something like:
>>
>> $ rbd ls
>> NAME SIZE
>> alpha 50G
>> beta 400G
>> charlie 150G
>
> Yes
>
>> That is possible, but if you want to see the allocation of an image that
>> will be harder, since RBD doesn't know which objects have been written
>> to and which haven't.
>
> Sure i didn't mean that.
>
>> If you want to know the usage of the rbd pool I suggest using "rados df".
> ah OK.
>
>> The RBD tool could however be modified to show the image size if you
>> give another flag.
>>
>> $ rbd --extended ls
> That would be great.

I created an issue in the tracker for it: 
http://tracker.newdream.net/issues/2601

>
> Stefan
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html

