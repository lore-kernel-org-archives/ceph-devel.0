From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: how to debug slow rbd block device
Date: Tue, 22 May 2012 21:27:10 +0200
Message-ID: <4FBBE88E.1000904@profihost.ag>
References: <4FBB8A5B.9010500@profihost.ag> <CABYiri_A-Ge6nQMG5NJuwj3h=vFYJmhj9LzdfPdWe_SRMCrx-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:53350 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760262Ab2EVT1N (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 May 2012 15:27:13 -0400
In-Reply-To: <CABYiri_A-Ge6nQMG5NJuwj3h=vFYJmhj9LzdfPdWe_SRMCrx-w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: ceph-devel@vger.kernel.org

Am 22.05.2012 16:52, schrieb Andrey Korolyov:
> Hi,
>
> I`ve run in almost same problem about two months ago, and there is a
> couple of corner cases: near-default tcp parameters, small journal
> size, disks that are not backed by controller with NVRAM cache and
> high load on osd` cpu caused by side processes. Finally, I have able
> to achieve 115Mb/s for large linear writes on raw rbd block inside VM
> with journal on tmpfs and osds on RAID0 built on top of three sata
> disks.

which tcp parameters could you recommand? The journal size is 1Gb on 
tmpfs right now. Instead of 3 sata disks i'm using one intel ssd. the 
CPU is loaded by 10% on each osd max. A "ceph osd tell X bench" shows me 
260MB/s write on each OSD (intel ssd).

Greets
Stefan
