From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: poor OSD performance using kernel 3.4
Date: Wed, 30 May 2012 08:22:26 +0200
Message-ID: <4FC5BCA2.90404@profihost.ag>
References: <5970d59f-9531-4f60-8600-3e1268824c83@mailpro> <4FC49B12.8020004@profihost.ag> <4FC4D1A8.1080001@univ-nantes.fr> <4FC4E0A9.8010008@profihost.ag> <4FC50C4A.4090101@inktank.com> <4FC53AC4.5020600@profihost.ag> <4FC54299.3050502@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:37405 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753618Ab2E3GWX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 May 2012 02:22:23 -0400
In-Reply-To: <4FC54299.3050502@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Yann Dupont <Yann.Dupont@univ-nantes.fr>, ceph-devel@vger.kernel.org

Am 29.05.2012 23:41, schrieb Mark Nelson:

> When you are using 1 thread, you are hitting a ~40MB/s limit (probably
> networking related) before the data gets to the journal.
1GB/s is capable of at least 130Mb/s and i get 130MB/s with 3.0.30 using
16 threads. I don't get why i should hit a limit here.

> Because (in
> this case) the filestore data disk can handle that throughput,
> everything looks nice and consistent.
osd bench and fio and dd tells me the underlying disks can handle
260MB/s (Intel SSD).

> In this case, that 40MB/s limit with 1 thread has increased.  Now more
> data is getting fed into the journal than the filestore can write out to
> disk.  Eventually writes stall while the data is being written out.

I don't want to argue but why should this only happen with 3.4.0 and NOT
with 3.0.30. Even though it does not matter which underlying FS i use.
It is the same with XFS AND btrfs.

Stefan
