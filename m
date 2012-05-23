From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: how to debug slow rbd block device
Date: Wed, 23 May 2012 10:15:34 +0200
Message-ID: <4FBC9CA6.1030206@profihost.ag>
References: <4FBB8A5B.9010500@profihost.ag> <B141A2FBE87F4859AF931D71A339468E@inktank.com> <4FBBEBC8.1000205@profihost.ag> <1C70F3FB753C4AEC97247E04FAE3C733@inktank.com> <4FBBF74C.9020608@profihost.ag> <45F1742481D84E7A90951816DB23609F@inktank.com> <4FBBFE7B.4060406@profihost.ag> <65E9589544C4489F93761035433ADC01@inktank.com> <4FBC811F.5060004@profihost.ag> <4FBC83F3.7070400@inktank.com> <CABYiri8LESPay495HX2s03nL0drOKqWgnXDQW3K71CQJ4MzuzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:39963 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756004Ab2EWIP1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 May 2012 04:15:27 -0400
In-Reply-To: <CABYiri8LESPay495HX2s03nL0drOKqWgnXDQW3K71CQJ4MzuzQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: Josh Durgin <josh.durgin@inktank.com>, Greg Farnum <greg@inktank.com>, ceph-devel@vger.kernel.org

Am 23.05.2012 09:22, schrieb Andrey Korolyov:
> Hi,
> 
> For Stefan:
> 
> Increasing socket memory gave me about some percents on fio tests
> inside VM(I have measured
> 'max-iops-until-ceph-throws-message-about-delayed-write' parameter).
> What is more important, osd process, if possible, should be pinned to
> dedicated core or two, and all other processes should not use this
> core(you may do it via cg or manually), because even one four-core
> non-pinned VM process during test causes a drop of osd` throughput
> almost twice, same for any other heavy process on the host.
Tried that using taskset but i didn't get any noticable boost. Also the
kernel already prevents jumping from core 2 core whenever possible. As
these machines are dedicated to osd there is no other load.

> net.core.rmem_max = 16777216
> net.core.wmem_max = 16777216
> net.ipv4.tcp_rmem = 4096 87380 16777216
> net.ipv4.tcp_wmem = 4096 65536 16777216
This gaves me around 3-4 MB/s.

Stefan
