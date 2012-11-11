From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: Limited IOP/s on Dual Xeon KVM Host
Date: Sun, 11 Nov 2012 13:04:58 +0100
Message-ID: <509F946A.7030004@profihost.ag>
References: <509E0A65.1040903@profihost.ag> <509E5979.3070508@inktank.com> <509E5B57.1050004@profihost.ag> <CABYiri8_1JVQqMHBCMqQGGg-XzfZrL7YVSYHZbQ3K92NSDGyVQ@mail.gmail.com> <509EC544.3030000@profihost.ag> <24E144B8C0207547AD09C467A8259F75577EFDD0@lisa.maurer-it.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:33552 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456Ab2KKME6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 11 Nov 2012 07:04:58 -0500
In-Reply-To: <24E144B8C0207547AD09C467A8259F75577EFDD0@lisa.maurer-it.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dietmar Maurer <dietmar@proxmox.com>
Cc: Andrey Korolyov <andrey@xdel.ru>, Mark Nelson <mark.nelson@inktank.com>, "pve-devel@pve.proxmox.com" <pve-devel@pve.proxmox.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 11.11.2012 10:14, schrieb Dietmar Maurer:
>> Got it fixed by Bios update... crazy.
>
> So you can't see any regression in IOPS with more cores?
In this subject i wasn't talking about simply more cores in VM but about 
having a Dual Xeon instead of a Single Xeon as host.

It seems Supermicro just had a bug in their X9 Dual Socket mainboard bios...

> Can you speedup things with process pinning?
> Just want to make sure that NUMA does not play any role here.
Yes i still can speed up with pinning but this also applies to a Single 
Xeon. When i pin the fio process inside VM i get 18.000 instead of 
15.000 iops.

Greets,
Stefan
