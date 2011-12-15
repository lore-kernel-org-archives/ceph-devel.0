From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Random blocks when accessing rbd images
Date: Thu, 15 Dec 2011 17:45:30 +0100
Message-ID: <4EEA242A.9010108@widodh.nl>
References: <1404301.on6okQVZ04@pc10> <4EEA1309.9030602@grnet.gr> <3807778.ycpoZxnZL4@pc10> <CACLRD_1LPhCC3szKfsj_pZ6-5rr=pr+P8KyWO76CxU6x0K17mA@mail.gmail.com> <4EEA2174.2060002@widodh.nl> <4EEA2299.6070601@tuxadero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:39667 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932525Ab1LOQp3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Dec 2011 11:45:29 -0500
In-Reply-To: <4EEA2299.6070601@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Mailand <martin@tuxadero.com>
Cc: ceph-devel@vger.kernel.org

On 12/15/2011 05:38 PM, Martin Mailand wrote:
> Hi Wido,
> but wasn't that fixed a few weeks ago?

I'm not sure. I think I saw it not so long ago.

My cluster just got a upgrade to 0.39, so everything got a restart. I'll 
keep an eye out for blocking scrubs.

Wido

>
> -martin
>
> Am 15.12.2011 17:33, schrieb Wido den Hollander:
>> Yes, from what I've seen it will block indefinitely until you restart
>> one of the OSDs who are member of the PG.
>>
>> Wido
>

