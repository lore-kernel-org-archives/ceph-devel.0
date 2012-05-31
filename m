From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: poor OSD performance using kernel 3.4 => problem found
Date: Thu, 31 May 2012 10:04:00 +0200
Message-ID: <4FC725F0.9040207@profihost.ag>
References: <4FBE415E.8030702@profihost.ag>	<4FC54CDB.1000506@inktank.com>	<4FC5BF27.5060704@profihost.ag>	<CADdPHGs9dpSh9Oyu+5yDhyYU=Et_-zF5MuYybBuuAN5DgR433A@mail.gmail.com>	<4FC5C941.6010105@profihost.ag>	<CADdPHGuiJqZUCK-0qR_CrOo6GRhkjaCdkOhJ2boq3zD0_voTsA@mail.gmail.com>	<4FC5FEC1.90103@profihost.ag>	<4FC60FC8.207@inktank.com>	<4FC61596.3050703@profihost.ag>	<4FC62BB0.1020003@inktank.com>	<4FC66A1F.1080407@profihost.ag>	<CADdPHGuxa7TAyqXcXehb9WgKgkHwkybYTrj2oue_PKsiF+oR3A@mail.gmail.com>	<4FC68CAA.9030708@profihost.ag>	<CADdPHGutEwoDc=Kcrqcx2ZMO=dqhuoT5iLoP-WxqD+e5ZUmBRA@mail.gmail.com>	<4FC7197D.5010406@profihost.ag> <CADdPHGv0YjxDQFnZML-55jDj7XxHxaxUZ_FeQ=ReKK6Rs7NNhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:46185 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753452Ab2EaIDx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 May 2012 04:03:53 -0400
In-Reply-To: <CADdPHGv0YjxDQFnZML-55jDj7XxHxaxUZ_FeQ=ReKK6Rs7NNhw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Majer <stefan.majer@gmail.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, yehuda@inktank.com, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 31.05.2012 09:27, schrieb Stefan Majer:
> we have set them in /etc/sysctl.conf to:
> net.ipv4.tcp_mem = 10000000 10000000 10000000

This does not help ;-(

> wow, this was fast !
> if i understand this commit correct it simply skips a in-kernel
> configuration of network related sysctl parameters, especialy
> net.ipv4.tcp_mem

I also tied this one:
net.ipv4.tcp_rmem = 4096 524287 16777216
net.ipv4.tcp_wmem = 4096 524287 16777216
# grabbed values from 3.0.X
net.ipv4.tcp_mem = 1162962      1550617 2325924

still - no help -. But if i use 3.4 and revert the commit it works fine.
But i wasn't able to find which other parts are influenced by this limit
while browsing through the source.

I only found:
net.ipv4.tcp_mem
and
net.ipv4.tcp_rmem
and
net.ipv4.tcp_wmem

Greets
Stefan
