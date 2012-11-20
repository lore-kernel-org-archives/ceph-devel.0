From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: librbd discard bug problems -> i REALLY got it
Date: Tue, 20 Nov 2012 13:46:27 +0100
Message-ID: <50AB7BA3.1060906@profihost.ag>
References: <50AAA25F.9040908@profihost.ag> <50AAB4D6.3030304@inktank.com> <50AABDD1.5050802@profihost.ag> <50AAC1B1.9070701@inktank.com> <50AAC3CB.9090309@profihost.ag> <50AAC51C.1090904@inktank.com> <50AAC835.908@profihost.ag> <50AACE9D.8080905@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:58850 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753182Ab2KTMqb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Nov 2012 07:46:31 -0500
In-Reply-To: <50AACE9D.8080905@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Josh,

the problem was again in the qemu rbd driver.

It was using int for several return values instead of int_64. I send 2nd 
patch to the qemu list and ceph devel.

Could you please care that BOTH patches the one from yesterday AND today 
get into qemu?

Greets,
Stefan
Am 20.11.2012 01:28, schrieb Josh Durgin:
> On 11/19/2012 04:00 PM, Stefan Priebe wrote:
>> Hi Josh,
>>
>> i don't get it. Every debug line i print is a prositive fine value. BUt
>> rbd_aio_bh_cb get's called with these values. As you can see that are
>> not much values i copied all values < 0 from log for discarding a whole
>> 30GB device.
>
> Could you post the patch of the debug prints you added and the log?
