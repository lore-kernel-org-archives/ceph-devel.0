From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: Designing a cluster guide
Date: Mon, 21 May 2012 10:22:29 +0200
Message-ID: <4FB9FB45.7020102@profihost.ag>
References: <8423c457-a8bb-4d26-a643-9573a8bb11a5@mailpro>	<4FB8A3A5.5090809@profihost.ag>	<CAJafhzRKCcSr37HjviAKRoMztv+twd5r+4Z99heUSy40G1rjag@mail.gmail.com>	<4FB8AADE.1000406@profihost.ag> <CAJafhzTv8a6auWQAw3u2zqRDi-DR9g1b9kwXYbX+kCG0=dOofg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:35630 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756318Ab2EUIWb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 May 2012 04:22:31 -0400
In-Reply-To: <CAJafhzTv8a6auWQAw3u2zqRDi-DR9g1b9kwXYbX+kCG0=dOofg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <christian@brunner-muc.de>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel@vger.kernel.org, Gregory Farnum <greg@inktank.com>

Am 20.05.2012 10:31, schrieb Christian Brunner:
>> That's exactly what i thought too but then you need a seperate ceph / rbd
>> cluster for each type.
>>
>> Which will result in a minimum of:
>> 3x mon servers per type
>> 4x osd servers per type
>> ---
>>
>> so you'll need a minimum of 12x osd systems and 9x mon systems.
> 
> You can arrange the storage types in different pools, so that you
> don't need separate mon servers (this can be done by adjusting the
> crushmap) and you could even run multiple OSDs per server.
That sounds great. Can you give me a hint how to setup pools? Right now
i have data, metadata and rbd => the default pools. But i wasn't able to
find any page in the wiki which described how to setup pools.

Thanks,
Stefan
