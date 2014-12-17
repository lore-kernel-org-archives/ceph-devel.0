From: Wido den Hollander <wido@42on.com>
Subject: Re: CephFS hangs when writing 10GB files in loop
Date: Wed, 17 Dec 2014 17:43:10 +0100
Message-ID: <5491B29E.7080005@42on.com>
References: <5491B0E1.7050203@42on.com> <alpine.DEB.2.00.1412170839370.1008@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:52367 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750905AbaLQQnO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 17 Dec 2014 11:43:14 -0500
In-Reply-To: <alpine.DEB.2.00.1412170839370.1008@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 12/17/2014 05:40 PM, Sage Weil wrote:
> On Wed, 17 Dec 2014, Wido den Hollander wrote:
>> Hi,
>>
>> Today I've been playing with CephFS and the morning started great with
>> CephFS playing along just fine.
>>
>> Some information first:
>> - Ceph 0.89
>> - Linux kernel 3.18
>> - Ceph fuse 0.89
>> - One Active MDS, one Standby
>>
>> This morning I could write a 10GB file like this using the kclient:
>> $ dd if=/dev/zero of=10GB.bin bs=1M count=10240 conv=fsync
>>
>> That gave me 850MB/sec (all 10G network) and I could read the same file
>> again with 610MB/sec.
>>
>> After writing to it multiple times it suddenly started to hang.
>>
>> No real evidence on the MDS (debug mds set to 20) or anything on the
>> client. That specific operation just blocked, but I could still 'ls' the
>> filesystem in a second terminal.
>>
>> The MDS was showing in it's log that it was checking active sessions of
>> clients. It showed the active session of my single client.
>>
>> The client renewed it's caps and proceeded.
>>
>> I currently don't have any logs, but I'm just looking for a direction to
>> be pointed towards.
> 
> Hmm.  Try
> 
>  cat /sys/kernel/debug/ceph/*/mdsc
>  cat /sys/kernel/debug/ceph/*/osdc
> 

I'll check that, good point.

> to see requests in flight (you may need to mount -t debugfs none 
> /sys/kernel/debug first).  What kernel version?
> 

I tried with 3.18

Also tried with ceph-fuse 0.89, same result. It is slower, but it also
hangs at some point.

> sage
> 


-- 
Wido den Hollander
42on B.V.
Ceph trainer and consultant

Phone: +31 (0)20 700 9902
Skype: contact42on
