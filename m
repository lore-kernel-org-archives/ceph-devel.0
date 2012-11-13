From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: improve speed with auth supported=none
Date: Tue, 13 Nov 2012 09:06:55 +0100
Message-ID: <50A1FF9F.7010705@profihost.ag>
References: <50A117B9.4060804@profihost.ag> <CAOLwVU=2BNvOs1SUqVrXS9Wajng5zk0mebnK3cZnZFO=rzrGbw@mail.gmail.com> <50A170BF.5030402@profihost.ag> <50A1F9F8.4030808@inktank.com> <50A1FC4D.8010000@profihost.ag> <50A1FF21.2020700@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:42670 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754290Ab2KMIG5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Nov 2012 03:06:57 -0500
In-Reply-To: <50A1FF21.2020700@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Alexandre DERUMIER <aderumier@odiso.com>

Am 13.11.2012 09:04, schrieb Josh Durgin:
> On 11/12/2012 11:52 PM, Stefan Priebe wrote:
>> Am 13.11.2012 08:42, schrieb Josh Durgin:
>>> On 11/12/2012 01:57 PM, Stefan Priebe wrote:
>>>> Thanks,
>>>>
>>>> this gives another burst for iops. I'm now at 23.000 iops ;-) So for
>>>> random 4k iops ceph auth and especially the logging is a lot of
>>>> overhead.
>>>
>>> How much difference did disabling auth make vs only disabling logging?
>>
>> disable debug logging: 3000 iops
>> disable auth logging: 2000 iops
>>
>> Is anybody in the ceph team also interested in a call graph of kvm when
>> VM is doing random 4k write io?
>
> I'm interested, although I'm not sure how easy it'll be to find
> bottlenecks from it. It's worth a shot.

*arg* kvm process segfaults when i use google perf tools to create / 
record one.

Any software suggestion?

Stefan
