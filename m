From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: FS / Kernel question choosing the correct kernel version
Date: Tue, 26 Jun 2012 18:15:02 +0200
Message-ID: <4FE9E006.6030404@profihost.ag>
References: <4FE60A65.2030800@profihost.ag> <Pine.LNX.4.64.1206251506070.22491@cobra.newdream.net> <4FE97BE8.6010603@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:52655 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758580Ab2FZQPG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jun 2012 12:15:06 -0400
In-Reply-To: <4FE97BE8.6010603@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "hch@infradead.org >> Christoph Hellwig" <hch@infradead.org>

Am 26.06.2012 11:07, schrieb Stefan Priebe:
> Am 26.06.2012 00:11, schrieb Sage Weil:
>> On Sat, 23 Jun 2012, Stefan Priebe wrote:
>>> Hi,
>>>
>>> i got stuck while selecting the right FS for ceph / RBD.
>>>
>>> XFS:
>>> - deadlock / hung task under 3.0.34 in xfs_ilock / xfs_buf_lock while
>>> syncfs
>>
>> There was an ilock fix that went into 3.4, IIRC.  Have you tried vanilla
>> 3.4?  We are seeing some lockdep noise currently, but no deadlocks yet.
>
> Will test 3.4.4 soon.

With btrfs i have 13-14.000 iops while doing random 4k writes from kvm. 
With XFS and 3.4.4 i have 814 ;-( and got a lot of slow request noise in 
ceph.log ;-( so 814 iops are not an option to me. Or is there anything 
special i've to respect while using XFS.

Greets
Stefan
