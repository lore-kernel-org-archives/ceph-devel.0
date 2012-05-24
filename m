From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: how to free space from rados bench comman?
Date: Thu, 24 May 2012 09:38:39 +0200
Message-ID: <4FBDE57F.9010409@profihost.ag>
References: <4FBDDCAE.7040709@profihost.ag> <4FBDE314.7030305@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:60850 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808Ab2EXHi1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 May 2012 03:38:27 -0400
In-Reply-To: <4FBDE314.7030305@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 24.05.2012 09:28, schrieb Wido den Hollander:
> Hi,
> 
> On 24-05-12 09:01, Stefan Priebe - Profihost AG wrote:
>> Hi,
>>
>> every rados bench write uses disk space and my space fills up. How to
>> free this space again?
>>
>> Used command?
>> rados -p data bench 60 write -t 16
> 
> What does this show:
> 
> $ rados -p data ls|wc -l

~# rados -p data ls|wc -l
46631

I do not use the data pool so it is seperate ;-) i only use the rbd pool
for block devices.

So i will free the space with:
for i in `rados -p data ls`; do echo $i; rados -p data rm $i; done

Thanks!

Stefan
