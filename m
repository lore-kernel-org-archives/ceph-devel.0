From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: FS / Kernel question choosing the correct kernel version
Date: Tue, 26 Jun 2012 11:07:52 +0200
Message-ID: <4FE97BE8.6010603@profihost.ag>
References: <4FE60A65.2030800@profihost.ag> <Pine.LNX.4.64.1206251506070.22491@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:44044 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752176Ab2FZJHz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jun 2012 05:07:55 -0400
In-Reply-To: <Pine.LNX.4.64.1206251506070.22491@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 26.06.2012 00:11, schrieb Sage Weil:
> On Sat, 23 Jun 2012, Stefan Priebe wrote:
>> Hi,
>>
>> i got stuck while selecting the right FS for ceph / RBD.
>>
>> XFS:
>> - deadlock / hung task under 3.0.34 in xfs_ilock / xfs_buf_lock while syncfs
>
> There was an ilock fix that went into 3.4, IIRC.  Have you tried vanilla
> 3.4?  We are seeing some lockdep noise currently, but no deadlocks yet.

Will test 3.4.4 soon.

>> - under 3.5-rc3 all my machines got loaded doing nothing than waiting for XFS
>> / SSDs so ceph is really slow / unuseable
>
>> btrfs:
>> - 3.5-rc3 ceph is pretty fast and works good until i see also a deadlock while
>> doing heavy random I/Os in my rbd / kvm.
>>
>> All processes hang in btrfs_commit_transaction or
>> btrfs_commit_transaction_async
>
> We haven't seen this yet.  See my other reply; a task dump may offer some
> clues.
You can find the task dump here:
http://pastebin.com/raw.php?i=R4pztDRt

Stefan
