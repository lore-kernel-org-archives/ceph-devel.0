From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: ceph-osd cpu usage
Date: Thu, 15 Nov 2012 16:30:57 +0100
Message-ID: <50A50AB1.5090701@profihost.ag>
References: <50A4CA65.2030508@profihost.ag> <alpine.DEB.2.00.1211150710550.4011@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:59838 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755745Ab2KOPbG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Nov 2012 10:31:06 -0500
In-Reply-To: <alpine.DEB.2.00.1211150710550.4011@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 15.11.2012 16:14, schrieb Sage Weil:
> On Thu, 15 Nov 2012, Stefan Priebe - Profihost AG wrote:
>> Hello list,
>>
>> my main problem right now is that ceph does not scale for me (more vms using
>> rbd). It does not scale as the ceph-osd is using all my CPU core all the time
>> (8 cores) with just 4 SSDs. The SSDs are far away from being loaded.
>>
>> What is the best way to find out what the ceph-osd process is doing all the
>> time?
>>
>> A gperf graph is attached.
>
> Hmm, most significant time seems to be in the allocator and doing
> fsetxattr(2) (10%!).  Also some path traversal stuff.
>
> Can you try the wip-fd-simple-cache branch, which tries to spend less time
> closing and reopening files?  I'm curious how much of a different it will
> make for you for both IOPS and CPU utilization.

Will try that this evening.

> It is also possible to use leveldb for most attrs.  If you set
> 'filestore xattr use omap = true' it should put most attrs in leveldb.

Do i have to recreate the cephfs?

Stefan
