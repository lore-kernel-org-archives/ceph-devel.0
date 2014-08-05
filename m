From: Eric Eastman <eric0e@aol.com>
Subject: Re: Ceph kRBD stuck after disk crash
Date: Tue, 5 Aug 2014 10:17:41 -0400 (EDT)
Message-ID: <8D17ECF265621C2-CFC-29C74@webmail-m231.sysops.aol.com>
References: <CAPZO0-O2eRt1t9o_aN6vZ88gwfT2MMcvjN-Y+-BiFkXHuPo3tA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from omr-d03.mx.aol.com ([205.188.109.200]:31536 "EHLO
	omr-d03.mx.aol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753650AbaHEORm convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Aug 2014 10:17:42 -0400
In-Reply-To: <CAPZO0-O2eRt1t9o_aN6vZ88gwfT2MMcvjN-Y+-BiFkXHuPo3tA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: thorwald@jumpstarter.io, ceph-devel@vger.kernel.org

This could be related to bug 8818.  See 

http://tracker.ceph.com/issues/8818



> I've just experienced a disk crash in my ceph cluster. This seems to

> have caused an error in the kernel since every I/O command sent to any

> mapped RBD is defered indefinitely, even an hour later, the OSD is

> already taken out of the cluster and ceph -s says HEALTH_OK.

> ...

> A kernel dump is provided at this pastebin link: 

http://pastebin.com/WMqmiUsM

> ...

> I'm running the linux kernel 3.15.7 and are using layered rbd devices.

>
