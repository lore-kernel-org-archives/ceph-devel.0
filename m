From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Random blocks when accessing rbd images
Date: Thu, 15 Dec 2011 17:33:56 +0100
Message-ID: <4EEA2174.2060002@widodh.nl>
References: <1404301.on6okQVZ04@pc10> <4EEA1309.9030602@grnet.gr> <3807778.ycpoZxnZL4@pc10> <CACLRD_1LPhCC3szKfsj_pZ6-5rr=pr+P8KyWO76CxU6x0K17mA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:39294 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758951Ab1LOQd4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Dec 2011 11:33:56 -0500
In-Reply-To: <CACLRD_1LPhCC3szKfsj_pZ6-5rr=pr+P8KyWO76CxU6x0K17mA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On 12/15/2011 05:30 PM, Samuel Just wrote:
> 'ceph pg dump' will tell you the status (active/clean/scrubbing/etc)
> for each pg.  Does the same pg remain in state active+clean+scrubbing
> for more than 10 minutes?

Yes, from what I've seen it will block indefinitely until you restart 
one of the OSDs who are member of the PG.

Wido

> -Sam
>
> On Thu, Dec 15, 2011 at 7:45 AM, Guido Winkelmann
> <guido-ceph@thisisnotatest.de>  wrote:
>> Am Donnerstag, 15. Dezember 2011, 17:32:25 schrieben Sie:
>>> On 12/15/2011 05:07 PM, Guido Winkelmann wrote:
>>>> Hi,
>>>>
>>>> I've got a small ceph cluster with one mon, one mds and two osds (all on
>>>> the same machine, for now), that I want to use as a block- and file
>>>> storage backend for qemu machine virtualisation.
>>>>
>>>> I found that read access to some of the rbd images, or parts of some of
>>>> them sometimes blocks indefinitely, usually after the image has been
>>>> sitting around untouched for a while, for example over night. This has
>>>> the effect that virtual machines that try to access their disks as well
>>>> as rbd commands like "rbd cp" will just hang indefinitely.
>>>>
>>>>   I found that these blocks can usually be "fixed" by restarting one of
>>>>   the>
>>>> osds.
>>>>
>>>> The last time this happened, ceph -s reported one of the osds to be in
>>>> state "active+clean+scrubbing". (I'm afraid I don't have the complete
>>>> output from ceph -s anymore.)
>>>>
>>>> Does anybody have any idea what could be going wrong here?
>>>
>>> I think it's fixed in v0.39
>>
>> I'm already using 0.39, so, no. (Should have mentioned that to start with...)
>>
>>         Guido
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

