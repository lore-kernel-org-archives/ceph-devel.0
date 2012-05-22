From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: how to debug slow rbd block device
Date: Tue, 22 May 2012 21:40:56 +0200
Message-ID: <4FBBEBC8.1000205@profihost.ag>
References: <4FBB8A5B.9010500@profihost.ag> <B141A2FBE87F4859AF931D71A339468E@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:45841 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753253Ab2EVTk6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 May 2012 15:40:58 -0400
In-Reply-To: <B141A2FBE87F4859AF931D71A339468E@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <greg@inktank.com>
Cc: ceph-devel@vger.kernel.org

Am 22.05.2012 21:35, schrieb Greg Farnum:
> What does your test look like? With multiple large IOs in flight we can regularly fill up a 1GbE link on our test clusters. With smaller or fewer IOs in flight performance degrades accordingly.

iperf shows 950Mbit/s so this is OK (from KVM host to OSDs)

sorry:
dd if=/dev/zero of=test bs=4M count=1000; dd if=test of=/dev/null bs=4M 
count=1000;
1000+0 records in
1000+0 records out
4194304000 bytes (4,2 GB) copied, 99,7352 s, 42,1 MB/s

1000+0 records in
1000+0 records out
4194304000 bytes (4,2 GB) copied, 47,4493 s, 88,4 MB/s

Greets
Stefan

> On Tuesday, May 22, 2012 at 5:45 AM, Stefan Priebe - Profihost AG wrote:
>
>> Hi list,
>>
>> my ceph block testcluster is now running fine.
>>
>> Setup:
>> 4x ceph servers
>> - 3x mon with /mon on local os SATA disk
>> - 4x OSD with /journal on tmpfs and /srv on intel ssd
>>
>> all of them use 2x 1Gbit/s lacp trunk.
>>
>> 1x KVM Host system (2x 1Gbit/s lacp trunk)
>>
>> With one KVM i do not get more than 40MB/s and my network link is just
>> at 40% of 1Gbit/s.
>>
>> Is this expected? If not where can i start searching / debugging?
>>
>> Thanks,
>> Stefan
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org (mailto:majordomo@vger.kernel.org)
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>
>
>
