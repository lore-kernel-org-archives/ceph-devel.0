From: Wido den Hollander <wido@widodh.nl>
Subject: Re: rbd 0.48 storage support for kvm proxmox distribution available
Date: Wed, 05 Sep 2012 11:11:27 +0200
Message-ID: <5047173F.9030501@widodh.nl>
References: <cf402294-b0f9-4b8c-8b08-6a51aa64cab4@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:35537 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753211Ab2IEJLa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Sep 2012 05:11:30 -0400
In-Reply-To: <cf402294-b0f9-4b8c-8b08-6a51aa64cab4@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel@vger.kernel.org

On 09/05/2012 06:31 AM, Alexandre DERUMIER wrote:
> Hi List,
>
> We have added rbd 0.48 support to the proxmox 2.1 kvm distribution
> http://www.proxmox.com/products/proxmox-ve
>
>
> Proxmox setup:
>
> edit the /etc/pve/storage.cfg and add the configuration (gui creation is not available yet)
>
> rbd: mycephcluster
>         monhost 192.168.0.1:6789;192.168.0.2:6789;192.168.0.3:6789
>         pool rbd
>         username admin
>         authsupported cephx;none
>         content images
>

Proxmox doesn't use libvirt, does it?

Any plans to implement the RBD caching?

Nice work though!

Wido

>
> then you need to copy the keyring file from ceph to proxmox
>
> scp cephserver1:/etc/ceph/client.admin.keyring /etc/pve/priv/ceph/mycephcluster.keyring
>
>
>
> For now, you can add/delete/resize rbd volumes from gui.
> Snapshots/cloning will be added soon (when layering will be available)
>
>
> Regards,
>
> Alexandre Derumier
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

