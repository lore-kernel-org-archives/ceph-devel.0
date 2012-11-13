From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: improve speed with auth supported=none
Date: Tue, 13 Nov 2012 00:04:49 -0800
Message-ID: <50A1FF21.2020700@inktank.com>
References: <50A117B9.4060804@profihost.ag> <CAOLwVU=2BNvOs1SUqVrXS9Wajng5zk0mebnK3cZnZFO=rzrGbw@mail.gmail.com> <50A170BF.5030402@profihost.ag> <50A1F9F8.4030808@inktank.com> <50A1FC4D.8010000@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:43633 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754239Ab2KMIEw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Nov 2012 03:04:52 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so4878734pad.19
        for <ceph-devel@vger.kernel.org>; Tue, 13 Nov 2012 00:04:52 -0800 (PST)
In-Reply-To: <50A1FC4D.8010000@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Alexandre DERUMIER <aderumier@odiso.com>

On 11/12/2012 11:52 PM, Stefan Priebe wrote:
> Am 13.11.2012 08:42, schrieb Josh Durgin:
>> On 11/12/2012 01:57 PM, Stefan Priebe wrote:
>>> Thanks,
>>>
>>> this gives another burst for iops. I'm now at 23.000 iops ;-) So for
>>> random 4k iops ceph auth and especially the logging is a lot of
>>> overhead.
>>
>> How much difference did disabling auth make vs only disabling logging?
>
> disable debug logging: 3000 iops
> disable auth logging: 2000 iops
>
> Is anybody in the ceph team also interested in a call graph of kvm when
> VM is doing random 4k write io?

I'm interested, although I'm not sure how easy it'll be to find
bottlenecks from it. It's worth a shot.

