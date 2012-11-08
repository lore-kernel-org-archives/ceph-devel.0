From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: extreme ceph-osd cpu load for rand. 4k write
Date: Thu, 08 Nov 2012 16:45:15 +0100
Message-ID: <509BD38B.8090200@profihost.ag>
References: <509AC772.5010606@profihost.ag> <509BC878.3090804@profihost.ag> <alpine.DEB.2.00.1211080658560.11845@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:56137 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464Ab2KHPpY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Nov 2012 10:45:24 -0500
In-Reply-To: <alpine.DEB.2.00.1211080658560.11845@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 08.11.2012 16:01, schrieb Sage Weil:
> On Thu, 8 Nov 2012, Stefan Priebe - Profihost AG wrote:
>> Is there any way to find out why a ceph-osd process takes around 10 times more
>> load on rand 4k writes than on 4k reads?
>
> Something like perf or oprofile is probably your best bet.  perf can be
> tedious to deploy, depending on where your kernel is coming from.
> oprofile seems to be deprecated, although I've had good results with it in
> the past.

I've recorded 10s with perf - it is now a 300MB perf.data file. Sadly 
i've no idea what todo with it next.

>   would love to see where the CPU is spending most of it's time.  This is
> on current master?
Yes

>  I expect there are still some low-hanging fruit that
> can bring CPU utilization down (or even boost iops).
Would be great to find them.

Stefan
