From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: Limited IOP/s on Dual Xeon KVM Host
Date: Sat, 10 Nov 2012 19:00:02 +0300
Message-ID: <CABYiri8_1JVQqMHBCMqQGGg-XzfZrL7YVSYHZbQ3K92NSDGyVQ@mail.gmail.com>
References: <509E0A65.1040903@profihost.ag> <509E5979.3070508@inktank.com> <509E5B57.1050004@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:47688 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991Ab2KJQAX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 10 Nov 2012 11:00:23 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so5012716oag.19
        for <ceph-devel@vger.kernel.org>; Sat, 10 Nov 2012 08:00:23 -0800 (PST)
In-Reply-To: <509E5B57.1050004@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: Mark Nelson <mark.nelson@inktank.com>, "pve-devel@pve.proxmox.com" <pve-devel@pve.proxmox.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sat, Nov 10, 2012 at 5:49 PM, Stefan Priebe <s.priebe@profihost.ag> wrote:
> Am 10.11.2012 14:41, schrieb Mark Nelson:
>
>> On 11/10/2012 02:03 AM, Stefan Priebe wrote:
>>>
>>> Hello lists,
>>>
>>> on a dual Xeon KVM Host i get max 6000 IOP/s random 4k writes AND reads.
>>> On a Single Xeon KVM Host i get 17.000-18.000 IOP/s write and read. I
>>> already tried to pin the kvm process using numactl and also the fio
>>> process but it doesn't help on the dual xeon.
>>>
>>> 10GBE Network is fine. I get 9.8Gbit/s on both hosts. Kernel is also he
>>> same on both.
>>>
>>> Anybody an idea?
>>
>>
>> When you say KVM host, do you mean the underlying node or the virtual
>> machine instance?
>
> Sorry i'm talking about the vm host regarding the HW. The vm instance is
> always the same.
>
>
>> If you mean underlying node, it could be remote memory access or if you
>> are on a last gen xeon if you have dual io hubs, you could be hitting a
>> remote io hub for the network card.  I wouldn't think that would cause
>> such a big hit, but those are things to look into.
>
>
> I'm on E5-Xeon. What means io hub?

QPI path length, in other terms, numa distance(hope Mark means the
same). Yes, it is impossible to have such degradation even in worst
case on two-head node. I assume two possible things - you have pinned
many processes on the core set which including default core for the
network card` irq, please check it via /proc/interrupts, or you have
not really did pinning and qemu process losing ticks by switching
cores - it may be checked, say, by top and guest cpu bencmark. For the
network card, it may be generally recommended to move its irq affinity
to entire numa node to which it belongs.

>
>
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
