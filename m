From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: Limited IOP/s on Dual Xeon KVM Host
Date: Sat, 10 Nov 2012 20:16:43 +0100
Message-ID: <509EA81B.1030606@profihost.ag>
References: <509E0A65.1040903@profihost.ag> <509E5979.3070508@inktank.com> <509E5B57.1050004@profihost.ag> <CABYiri8_1JVQqMHBCMqQGGg-XzfZrL7YVSYHZbQ3K92NSDGyVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:47777 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265Ab2KJTQq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 10 Nov 2012 14:16:46 -0500
In-Reply-To: <CABYiri8_1JVQqMHBCMqQGGg-XzfZrL7YVSYHZbQ3K92NSDGyVQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: Mark Nelson <mark.nelson@inktank.com>, "pve-devel@pve.proxmox.com" <pve-devel@pve.proxmox.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 10.11.2012 17:00, schrieb Andrey Korolyov:
>>> If you mean underlying node, it could be remote memory access or if you
>>> are on a last gen xeon if you have dual io hubs, you could be hitting a
>>> remote io hub for the network card.  I wouldn't think that would cause
>>> such a big hit, but those are things to look into.
>>
>>
>> I'm on E5-Xeon. What means io hub?
>
> QPI path length, in other terms, numa distance(hope Mark means the
> same). Yes, it is impossible to have such degradation even in worst
> case on two-head node. I assume two possible things - you have pinned
> many processes on the core set which including default core for the
> network card` irq, please check it via /proc/interrupts
The 10GBE card is alligned with all it's queues to one CPU. (use intel 
irq affinity script).

> not really did pinning and qemu process losing ticks by switching
> cores - it may be checked, say, by top and guest cpu bencmark. For the
> network card, it may be generally recommended to move its irq affinity
> to entire numa node to which it belongs.
Might be but i'm seeing that the 10GBE card is also slower than on other 
systems ;-(

Stefan
