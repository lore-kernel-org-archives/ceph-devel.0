From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: recommanded cache setting for rbd image
Date: Tue, 06 Nov 2012 08:34:15 +0100
Message-ID: <5098BD77.1050202@profihost.ag>
References: <5097D2DD.2000006@profihost.ag> <50985257.3040304@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:39190 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495Ab2KFHeS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Nov 2012 02:34:18 -0500
In-Reply-To: <50985257.3040304@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 06.11.2012 00:57, schrieb Josh Durgin:
> On 11/05/2012 06:53 AM, Stefan Priebe - Profihost AG wrote:
>> Hello list,
>>
>> right now i'm testing rbd block devices with kvm using Default cache (no
>> cache).
>>
>> Is there any recommanded value for RBD? (i don't wanna loose data)
>
> It acts like a well-behaved disk cache (i.e. it respects
> flushes/barriers from the guest), so it's no more likely to cause data
> loss than a local hard disk in the event of an unexpected shutdown.
>
> I recommend running it in writeback mode (the default when rbd cache =
> true). The best cache size will depend on your workload and hardware.

Thanks i'll check how this influence my disks and storage.

Thanks!

Stefan
