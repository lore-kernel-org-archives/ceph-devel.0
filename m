From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: RBD attach via libvirt to kvm vm - VM kernel hang
Date: Wed, 28 Mar 2012 09:13:40 -0700
Message-ID: <CAORUGqAWnFz5uMOH=SAXb+n=ysMF9vvgGK-fqn0gdm5eDo9woA@mail.gmail.com>
References: <CAMwB3Tj4F1H_TnYsJVDELnod5z=DKwtdGiZExiVrMaJDycKvEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:35416 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758010Ab2C1QOC convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Mar 2012 12:14:02 -0400
Received: by yhmm54 with SMTP id m54so833800yhm.19
        for <ceph-devel@vger.kernel.org>; Wed, 28 Mar 2012 09:14:01 -0700 (PDT)
In-Reply-To: <CAMwB3Tj4F1H_TnYsJVDELnod5z=DKwtdGiZExiVrMaJDycKvEw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?S=C5=82awomir_Skowron?= <szibis@gmail.com>, Josh Durgin <josh.durgin@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

2012/3/28 S=C5=82awomir Skowron <szibis@gmail.com>:
> VM on-01 with config like in attachment (dumpxml) - hang, after
> attaching rbd device with kernel_bug in attachment.

[   68.630913] BUG: unable to handle kernel NULL pointer dereference
at 0000000000000049
[   68.632016] IP: [<ffffffff8130a6a5>] pci_find_capability+0x15/0x60
=2E..
[   68.632016] Call Trace:
[   68.632016]  [<ffffffff8131a9f7>] pci_set_payload+0xa7/0x140
[   68.632016]  [<ffffffff8131ae38>] pci_configure_slot.part.6+0x18/0x1=
00
[   68.632016]  [<ffffffff8131af52>] pci_configure_slot+0x32/0x40
[   68.632016]  [<ffffffffa003a7e8>] enable_device+0x188/0x9a0 [acpiphp=
]
[   68.632016]  [<ffffffff81307349>] ? pci_bus_read_config_dword+0x89/0=
xa0
=2E..

Well, that sure looks like a bug. I can't tell whether it's in QEmu,
the QEmu rbd driver, or what. Josh, have you seen a crash like this?
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
