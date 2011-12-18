From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Random blocks when accessing rbd images
Date: Sun, 18 Dec 2011 15:26:27 +0100
Message-ID: <4EEDF813.204@widodh.nl>
References: <1404301.on6okQVZ04@pc10> <4EEA1309.9030602@grnet.gr> <3807778.ycpoZxnZL4@pc10> <CACLRD_1LPhCC3szKfsj_pZ6-5rr=pr+P8KyWO76CxU6x0K17mA@mail.gmail.com> <4EEA2174.2060002@widodh.nl> <4EEA2299.6070601@tuxadero.com> <4EEA23F8.10209@tuxadero.com> <4EEB6F31.2050109@widodh.nl> <CACLRD_3pvKUmS+qtEPvQLi1hL71+4jUDMTT8mUaHpB8pYn09kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:33325 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039Ab1LRO0a (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 18 Dec 2011 09:26:30 -0500
In-Reply-To: <CACLRD_3pvKUmS+qtEPvQLi1hL71+4jUDMTT8mUaHpB8pYn09kQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On 12/16/2011 10:17 PM, Samuel Just wrote:
> In master, 061e7619aacf60a828e0ce84a108d5a0bea247c6 may fix the
> problem.  If not, 5274e88d2cb8c0449a4ecd1ff0cf8bb0af2cfc97 includes
> some asserts that may give us a clue as to how this is happening.

I've been running with bfbde5b18525406fc3b678751459e989ea5d4977 for over 
24 hours now, everything is still active+clean.

If it comes back I'll update this thread.

Thanks,

Wido

> -Sam
>
> On Fri, Dec 16, 2011 at 8:17 AM, Wido den Hollander<wido@widodh.nl>  wrote:
>> Hi,
>>
>>
>> On 12/15/2011 05:44 PM, Martin Mailand wrote:
>>>
>>> Hi,
>>> at least there is a patch that should have fixed it.
>>>
>>> http://marc.info/?l=ceph-devel&m=131955913203561&w=2
>>>
>>
>> I'm still seeing this one:
>>
>> 2011-12-16 17:14:53.638722    pg v1170309: 7808 pgs: 7807 active+clean, 1
>> active+clean+scrubbing; 15279 MB data, 47262 MB used, 73838 GB / 74520 GB
>> avail
>>
>> In this case PG "2.688" is in scrubbing state and is staying that way.
>>
>> I'm running v0.39, not the latest master.
>>
>> Any suggestions to trace this one down?
>>
>> Wido
>>
>>
>>> Am 15.12.2011 17:38, schrieb Martin Mailand:
>>>>
>>>> Hi Wido,
>>>> but wasn't that fixed a few weeks ago?
>>>>
>>>> -martin
>>>>
>>>> Am 15.12.2011 17:33, schrieb Wido den Hollander:
>>>>>
>>>>> Yes, from what I've seen it will block indefinitely until you restart
>>>>> one of the OSDs who are member of the PG.
>>>>>
>>>>> Wido
>>>>
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
