From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: librbd discard bug problems -> i REALLY got it
Date: Tue, 20 Nov 2012 09:09:34 -0800
Message-ID: <50ABB94E.2010003@inktank.com>
References: <50AAA25F.9040908@profihost.ag> <50AAB4D6.3030304@inktank.com> <50AABDD1.5050802@profihost.ag> <50AAC1B1.9070701@inktank.com> <50AAC3CB.9090309@profihost.ag> <50AAC51C.1090904@inktank.com> <50AAC835.908@profihost.ag> <50AACE9D.8080905@inktank.com> <50AB7BA3.1060906@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33185 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753688Ab2KTRJk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Nov 2012 12:09:40 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so1396144pad.19
        for <ceph-devel@vger.kernel.org>; Tue, 20 Nov 2012 09:09:40 -0800 (PST)
In-Reply-To: <50AB7BA3.1060906@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 11/20/2012 04:46 AM, Stefan Priebe - Profihost AG wrote:
> Hi Josh,
>
> the problem was again in the qemu rbd driver.
>
> It was using int for several return values instead of int_64. I send 2nd
> patch to the qemu list and ceph devel.
>
> Could you please care that BOTH patches the one from yesterday AND today
> get into qemu?

Great! I'll look at these later today.

> Greets,
> Stefan
> Am 20.11.2012 01:28, schrieb Josh Durgin:
>> On 11/19/2012 04:00 PM, Stefan Priebe wrote:
>>> Hi Josh,
>>>
>>> i don't get it. Every debug line i print is a prositive fine value. BUt
>>> rbd_aio_bh_cb get's called with these values. As you can see that are
>>> not much values i copied all values < 0 from log for discarding a whole
>>> 30GB device.
>>
>> Could you post the patch of the debug prints you added and the log?

