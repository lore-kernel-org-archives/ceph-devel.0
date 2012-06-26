From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: FS / Kernel question choosing the correct kernel version
Date: Tue, 26 Jun 2012 11:39:14 +0200
Message-ID: <4FE98342.70208@profihost.ag>
References: <4FE60A65.2030800@profihost.ag> <Pine.LNX.4.64.1206251506070.22491@cobra.newdream.net> <20120626081442.GA12789@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:52747 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756173Ab2FZJjR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jun 2012 05:39:17 -0400
In-Reply-To: <20120626081442.GA12789@infradead.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 26.06.2012 10:14, schrieb Christoph Hellwig:
> On Mon, Jun 25, 2012 at 03:11:17PM -0700, Sage Weil wrote:
>> On Sat, 23 Jun 2012, Stefan Priebe wrote:
>>> Hi,
>>>
>>> i got stuck while selecting the right FS for ceph / RBD.
>>>
>>> XFS:
>>> - deadlock / hung task under 3.0.34 in xfs_ilock / xfs_buf_lock while syncfs
>>
>> There was an ilock fix that went into 3.4, IIRC.  Have you tried vanilla
>> 3.4?  We are seeing some lockdep noise currently, but no deadlocks yet.
>
> Stefan, which deadlock is this, did you report it to the XFS list?

Yes i did. You are in CC

http://oss.sgi.com/archives/xfs/2012-05/msg00307.html

Stefan
