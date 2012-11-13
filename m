From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: improve speed with auth supported=none
Date: Mon, 12 Nov 2012 23:42:48 -0800
Message-ID: <50A1F9F8.4030808@inktank.com>
References: <50A117B9.4060804@profihost.ag> <CAOLwVU=2BNvOs1SUqVrXS9Wajng5zk0mebnK3cZnZFO=rzrGbw@mail.gmail.com> <50A170BF.5030402@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:36145 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347Ab2KMHmw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Nov 2012 02:42:52 -0500
Received: by mail-da0-f46.google.com with SMTP id n41so3102461dak.19
        for <ceph-devel@vger.kernel.org>; Mon, 12 Nov 2012 23:42:52 -0800 (PST)
In-Reply-To: <50A170BF.5030402@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Alexandre DERUMIER <aderumier@odiso.com>

On 11/12/2012 01:57 PM, Stefan Priebe wrote:
> Thanks,
>
> this gives another burst for iops. I'm now at 23.000 iops ;-) So for
> random 4k iops ceph auth and especially the logging is a lot of overh=
ead.

How much difference did disabling auth make vs only disabling logging?

Josh

> Greets,
> Stefan
> Am 12.11.2012 19:26, schrieb S=E9bastien Han:
>> I guess you can refer to that link on the list:
>> http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/9776
>>
>> btw do you get 5000 iop/s on the rbd kernel or on a vm disk?
>>
>> cheers.
>>
>>
>> On Mon, Nov 12, 2012 at 4:37 PM, Stefan Priebe - Profihost AG
>> <s.priebe@profihost.ag> wrote:
>>> Hello list,
>>>
>>> i'm still trying to improve ceph speed. Disable logging on host and=
 rbd
>>> client gives me additional 5000 iop/s which is great.
>>>
>>> But i also wanted to try disabling authentication using:
>>> auth supported=3Dnone
>>>
>>> How does this work? Do i just have to place this line under global
>>> section
>>> in ceph.conf?
>>>
>>> Greets,
>>> Stefan

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
