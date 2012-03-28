From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: Re: RBD attach via libvirt to kvm vm - VM kernel hang
Date: Wed, 28 Mar 2012 21:36:31 +0200
Message-ID: <6656798785653552046@unknownmsgid>
References: <CAMwB3Tj4F1H_TnYsJVDELnod5z=DKwtdGiZExiVrMaJDycKvEw@mail.gmail.com>
 <CAORUGqAWnFz5uMOH=SAXb+n=ysMF9vvgGK-fqn0gdm5eDo9woA@mail.gmail.com> <4F733B2A.7050902@dreamhost.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:34883 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758101Ab2C1Tgc convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Mar 2012 15:36:32 -0400
Received: by wibhj6 with SMTP id hj6so6796667wib.1
        for <ceph-devel@vger.kernel.org>; Wed, 28 Mar 2012 12:36:31 -0700 (PDT)
In-Reply-To: <4F733B2A.7050902@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: Tommi Virtanen <tommi.virtanen@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 28 mar 2012, at 18:24, Josh Durgin <josh.durgin@dreamhost.com> wrote=
:

> On 03/28/2012 09:13 AM, Tommi Virtanen wrote:
>> 2012/3/28 S=C5=82awomir Skowron<szibis@gmail.com>:
>>> VM on-01 with config like in attachment (dumpxml) - hang, after
>>> attaching rbd device with kernel_bug in attachment.
>>
>> [   68.630913] BUG: unable to handle kernel NULL pointer dereference
>> at 0000000000000049
>> [   68.632016] IP: [<ffffffff8130a6a5>] pci_find_capability+0x15/0x6=
0
>> ...
>> [   68.632016] Call Trace:
>> [   68.632016]  [<ffffffff8131a9f7>] pci_set_payload+0xa7/0x140
>> [   68.632016]  [<ffffffff8131ae38>] pci_configure_slot.part.6+0x18/=
0x100
>> [   68.632016]  [<ffffffff8131af52>] pci_configure_slot+0x32/0x40
>> [   68.632016]  [<ffffffffa003a7e8>] enable_device+0x188/0x9a0 [acpi=
php]
>> [   68.632016]  [<ffffffff81307349>] ? pci_bus_read_config_dword+0x8=
9/0xa0
>> ...
>>
>> Well, that sure looks like a bug. I can't tell whether it's in QEmu,
>> the QEmu rbd driver, or what. Josh, have you seen a crash like this?
>
> I've not seen a crash like this before. I'm not aware of RBD being
> treated differently from other block devices in the pci layer in qemu=
,
> so I'd guess this is a qemu or guest kernel bug.
>
> Does attaching a non-rbd disk (still using the virtio driver) cause t=
he
> same problem?

=46ile disk via virtio exist in vm config. But this configuration works
stable for some time without rbd.

We use for tests qemu-kvm 1.0.0+dfsg+rc2-1~oneiric1 with distro
libvirt, but we experience some stabilization problems with vf
functions on Intel 10GE cards. Rbd cause some problems too.
With same kernel as used now on Guest, and with this 1.0.0-rc2 kvm rbd
attaching goes smooth, but after some time, when rbd was mounted in
VM, network goes down.
Only with console/vnc we can go into VM, and then reload network.
After that everything was fine for some time, and again.
That's why we try newer libvirt, and kvm. And now vf in Intel network
card work like a charm, but after attaching rbd crash the vm as you
can see. Kernel on VM is always stay as bottom.

We try to create kernel on newer version of stable in oneiric, and try
to reproduce, but i feel that kernel is not a trigger for this bug.

> If not, what distro and kernel version is the guest
> running?

It's distro kernel 3.0.0-13-server from ubuntu oneiric with compiled
compatibility of xen. That's why is 3.0.0-13-xen.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
