From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Random blocks when accessing rbd images
Date: Fri, 16 Dec 2011 17:17:53 +0100
Message-ID: <4EEB6F31.2050109@widodh.nl>
References: <1404301.on6okQVZ04@pc10> <4EEA1309.9030602@grnet.gr> <3807778.ycpoZxnZL4@pc10> <CACLRD_1LPhCC3szKfsj_pZ6-5rr=pr+P8KyWO76CxU6x0K17mA@mail.gmail.com> <4EEA2174.2060002@widodh.nl> <4EEA2299.6070601@tuxadero.com> <4EEA23F8.10209@tuxadero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:56887 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019Ab1LPQRy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Dec 2011 11:17:54 -0500
In-Reply-To: <4EEA23F8.10209@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Mailand <martin@tuxadero.com>
Cc: ceph-devel@vger.kernel.org

Hi,

On 12/15/2011 05:44 PM, Martin Mailand wrote:
> Hi,
> at least there is a patch that should have fixed it.
>
> http://marc.info/?l=ceph-devel&m=131955913203561&w=2
>

I'm still seeing this one:

2011-12-16 17:14:53.638722    pg v1170309: 7808 pgs: 7807 active+clean, 
1 active+clean+scrubbing; 15279 MB data, 47262 MB used, 73838 GB / 74520 
GB avail

In this case PG "2.688" is in scrubbing state and is staying that way.

I'm running v0.39, not the latest master.

Any suggestions to trace this one down?

Wido

> Am 15.12.2011 17:38, schrieb Martin Mailand:
>> Hi Wido,
>> but wasn't that fixed a few weeks ago?
>>
>> -martin
>>
>> Am 15.12.2011 17:33, schrieb Wido den Hollander:
>>> Yes, from what I've seen it will block indefinitely until you restart
>>> one of the OSDs who are member of the PG.
>>>
>>> Wido
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html

