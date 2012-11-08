From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: less cores more iops / speed
Date: Thu, 08 Nov 2012 09:45:17 +0100
Message-ID: <509B711D.3070206@profihost.ag>
References: <509ADA6A.9000807@profihost.ag> <509AF625.8040207@inktank.com> <509B03EA.9050701@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:42379 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979Ab2KHIp0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Nov 2012 03:45:26 -0500
In-Reply-To: <509B03EA.9050701@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Joao Eduardo Luis <joao.luis@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 08.11.2012 01:59, schrieb Mark Nelson:
> There's also the context switching overhead.  It'd be interesting to
> know how much the writer processes were shifting around on cores.
What do you mean by that? I'm talking about the KVM guest not about the 
ceph nodes.

> Stefan, what tool were you using to do writes?
as always: fio ;-)

Stefan
