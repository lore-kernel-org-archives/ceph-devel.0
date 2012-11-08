From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: less cores more iops / speed
Date: Thu, 08 Nov 2012 16:14:32 +0100
Message-ID: <509BCC58.3070003@profihost.ag>
References: <509ADA6A.9000807@profihost.ag> <509AF625.8040207@inktank.com> <509B03EA.9050701@inktank.com> <509B711D.3070206@profihost.ag> <509BB156.5080404@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:51858 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751930Ab2KHPOl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Nov 2012 10:14:41 -0500
In-Reply-To: <509BB156.5080404@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Joao Eduardo Luis <joao.luis@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 08.11.2012 14:19, schrieb Mark Nelson:
> On 11/08/2012 02:45 AM, Stefan Priebe - Profihost AG wrote:
>> Am 08.11.2012 01:59, schrieb Mark Nelson:
>>> There's also the context switching overhead.  It'd be interesting to
>>> know how much the writer processes were shifting around on cores.
>> What do you mean by that? I'm talking about the KVM guest not about the
>> ceph nodes.
>
> in this case, is fio bouncing around between cores?

Thanks you're correct. If i bind fio to two cores on a 8 core VM it runs 
with 16.000 iops.

So it is a problem of KVM which let's the processes jump between cores a 
lot.

Greets,
Stefan
