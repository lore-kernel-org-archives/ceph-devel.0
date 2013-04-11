From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: expected I/O / rand 4k iops
Date: Thu, 11 Apr 2013 16:28:36 +0200
Message-ID: <5166C894.70003@profihost.ag>
References: <516665D0.8080704@profihost.ag> <5166AC18.1030808@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:59077 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934936Ab3DKO2p (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Apr 2013 10:28:45 -0400
In-Reply-To: <5166AC18.1030808@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


Am 11.04.2013 14:27, schrieb Mark Nelson:
> On 04/11/2013 02:27 AM, Stefan Priebe - Profihost AG wrote:
>> Hello list,
>>
>> is there any calculation of expected I/O available?
>>
>> I've a test system running 6 hosts 4 OSDs each using SSD - i get 20.000
>> to 40.000 IOP/s not as much as i expected but OK right now.
> 
> How are you running your benchmarks Stefan?

I'm doing fio randwrite 4k from withing Qemu.

>> If i replace the SSDs on one host with spinning disks but still using
>> dedicated journal on ssd (20GB / Disk/OSDK), i'm not able to get more
>> than 300 to 400 iop/s this seems to be pretty low.
> 
> That's probably about right.  The journals really only absorb a small
> portion of the incoming writes for free, and then you end up having to
> wait on the disks behind the OSDs.

Why is it like that? I thought the OSD journal is like a small I/O
buffer merging them into bigger I/O chunks.

> If you have 4 spinning disks in the
> system, each one is only really capable of around 150-200 IOPs assuming
> typical 7200rpm units.  300-400 iops for 4 disks isn't great, but it's
> probably not totally unrealistic either.

Sure but i still have 20 SSDs so shouldn't there be only some I/O going
to the disks?

> As far as SSDs go, some folks seem to be having luck with Bcache and
> fastcache to improve performance of spinning disk backed OSDs.  I admit
> haven't had time to play with them yet but it's definitely on my list!

The bcache page is really small and i'm not sure how well it is
maintained. I may also try

https://github.com/stec-inc/EnhanceIO

which sounds really promising.

>> Everything tested using 0.56.4 and Qemu RBD.
> 
> Out of curiosity, do you have RBD cache enabled?  I noticed on my test
> setup that with 64G VM images it provide quite a bit of benefit even for
> small random writes.

Yes.

Stefan
