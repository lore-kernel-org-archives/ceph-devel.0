From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: less cores more iops / speed
Date: Thu, 08 Nov 2012 07:19:18 -0600
Message-ID: <509BB156.5080404@inktank.com>
References: <509ADA6A.9000807@profihost.ag> <509AF625.8040207@inktank.com> <509B03EA.9050701@inktank.com> <509B711D.3070206@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:34791 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755622Ab2KHNTP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Nov 2012 08:19:15 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so4101773iea.19
        for <ceph-devel@vger.kernel.org>; Thu, 08 Nov 2012 05:19:13 -0800 (PST)
In-Reply-To: <509B711D.3070206@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Joao Eduardo Luis <joao.luis@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 11/08/2012 02:45 AM, Stefan Priebe - Profihost AG wrote:
> Am 08.11.2012 01:59, schrieb Mark Nelson:
>> There's also the context switching overhead.  It'd be interesting to
>> know how much the writer processes were shifting around on cores.
> What do you mean by that? I'm talking about the KVM guest not about the
> ceph nodes.

in this case, is fio bouncing around between cores?

>
>> Stefan, what tool were you using to do writes?
> as always: fio ;-)

You could try using numactl to pin fio to a specific core.  Also, it may 
be interesting to try multiple concurrent fio processes, and then 
concurrent fio processes with each pinned.

>
> Stefan

