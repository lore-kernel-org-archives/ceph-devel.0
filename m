From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: ceph-osd cpu usage
Date: Thu, 15 Nov 2012 21:26:06 +0100
Message-ID: <50A54FDE.9070403@profihost.ag>
References: <50A4CA65.2030508@profihost.ag> <alpine.DEB.2.00.1211150710550.4011@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:39177 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1768925Ab2KOU0D (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Nov 2012 15:26:03 -0500
In-Reply-To: <alpine.DEB.2.00.1211150710550.4011@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 15.11.2012 16:14, schrieb Sage Weil:
> On Thu, 15 Nov 2012, Stefan Priebe - Profihost AG wrote:
> Hmm, most significant time seems to be in the allocator and doing
> fsetxattr(2) (10%!).  Also some path traversal stuff.
Yes fsetxattr seems to be CPU hungry.

> Can you try the wip-fd-simple-cache branch, which tries to spend less time
> closing and reopening files?  I'm curious how much of a different it will
> make for you for both IOPS and CPU utilization.
It seems to give me around 1000 iops across 3 VMs.

> It is also possible to use leveldb for most attrs.  If you set
> 'filestore xattr use omap = true' it should put most attrs in leveldb.
Tried this but this raises CPU by 20%.

Any other ideas how to reduce ceph-osd while doing randwrite?

Randread gives me with 3 VMs: 60.000 iops
Randwrite gives me with 3 VMs: 25.000 iops

Stefan
