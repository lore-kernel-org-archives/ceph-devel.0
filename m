From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: RBD attach via libvirt to kvm vm - VM kernel hang
Date: Wed, 28 Mar 2012 09:24:10 -0700
Message-ID: <4F733B2A.7050902@dreamhost.com>
References: <CAMwB3Tj4F1H_TnYsJVDELnod5z=DKwtdGiZExiVrMaJDycKvEw@mail.gmail.com> <CAORUGqAWnFz5uMOH=SAXb+n=ysMF9vvgGK-fqn0gdm5eDo9woA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:44654 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758258Ab2C1QYM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Mar 2012 12:24:12 -0400
In-Reply-To: <CAORUGqAWnFz5uMOH=SAXb+n=ysMF9vvgGK-fqn0gdm5eDo9woA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: =?UTF-8?B?U8WCYXdvbWlyIFNrb3dyb24=?= <szibis@gmail.com>, ceph-devel@vger.kernel.org

On 03/28/2012 09:13 AM, Tommi Virtanen wrote:
> 2012/3/28 S=C5=82awomir Skowron<szibis@gmail.com>:
>> VM on-01 with config like in attachment (dumpxml) - hang, after
>> attaching rbd device with kernel_bug in attachment.
>
> [   68.630913] BUG: unable to handle kernel NULL pointer dereference
> at 0000000000000049
> [   68.632016] IP: [<ffffffff8130a6a5>] pci_find_capability+0x15/0x60
> ...
> [   68.632016] Call Trace:
> [   68.632016]  [<ffffffff8131a9f7>] pci_set_payload+0xa7/0x140
> [   68.632016]  [<ffffffff8131ae38>] pci_configure_slot.part.6+0x18/0=
x100
> [   68.632016]  [<ffffffff8131af52>] pci_configure_slot+0x32/0x40
> [   68.632016]  [<ffffffffa003a7e8>] enable_device+0x188/0x9a0 [acpip=
hp]
> [   68.632016]  [<ffffffff81307349>] ? pci_bus_read_config_dword+0x89=
/0xa0
> ...
>
> Well, that sure looks like a bug. I can't tell whether it's in QEmu,
> the QEmu rbd driver, or what. Josh, have you seen a crash like this?

I've not seen a crash like this before. I'm not aware of RBD being
treated differently from other block devices in the pci layer in qemu,
so I'd guess this is a qemu or guest kernel bug.

Does attaching a non-rbd disk (still using the virtio driver) cause the
same problem? If not, what distro and kernel version is the guest
running?
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
