From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: how to free space from rados bench comman?
Date: Thu, 24 May 2012 10:51:29 +0200
Message-ID: <4FBDF691.3070601@profihost.ag>
References: <4FBDDCAE.7040709@profihost.ag> <4FBDE314.7030305@widodh.nl> <4FBDE57F.9010409@profihost.ag> <4FBDEFB0.3030700@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:37357 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939Ab2EXIvR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 May 2012 04:51:17 -0400
In-Reply-To: <4FBDEFB0.3030700@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 24.05.2012 10:22, schrieb Wido den Hollander:
> On 24-05-12 09:38, Stefan Priebe - Profihost AG wrote:
>>
>> ~# rados -p data ls|wc -l
>> 46631
> 
> That is weird, I thought the bench tool cleaned up it's "mess".
> 
> Imho it should cleanup after it's done, but there might be a reason why
> it's not. Did you abort the benchmark or did you let it do the whole run?
No it doesn't BUG?

~# rados -p data ls
~#
~# rados -p data bench 20 write -t 16
...
~# rados -p data ls| wc -l
589

>> I do not use the data pool so it is seperate ;-) i only use the rbd pool
>> for block devices.
>>
>> So i will free the space with:
>> for i in `rados -p data ls`; do echo $i; rados -p data rm $i; done
> 
> rados -p data ls|xargs -n 1 rados -p data rm
> 
> I love shorter commands ;)
me too i just tried it without -n and hoped that this works but rados
didn't support more than 1 file per command and i didn't remembered -n1 ;)

Stefan
