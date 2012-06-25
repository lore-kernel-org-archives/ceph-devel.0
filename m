From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Qemu fails to open RBD image when auth_supported is not set to
 'none'
Date: Mon, 25 Jun 2012 17:45:31 +0200
Message-ID: <4FE8879B.7020103@widodh.nl>
References: <4FE881A1.5070504@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:53653 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755339Ab2FYPpd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Jun 2012 11:45:33 -0400
Received: from [IPv6:2a00:f10:113:1:386f:2b24:235:7e53] (unknown [IPv6:2a00:f10:113:1:386f:2b24:235:7e53])
	by smtp01.mail.pcextreme.nl (Postfix) with ESMTPSA id AC7137616B
	for <ceph-devel@vger.kernel.org>; Mon, 25 Jun 2012 17:45:31 +0200 (CEST)
In-Reply-To: <4FE881A1.5070504@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 06/25/2012 05:20 PM, Wido den Hollander wrote:
> Hi,
>
> I just tried to start a VM with libvirt with the following disk:
>
> <disk type='network' device='disk'>
>    <driver name='qemu' type='raw' cache='none'/>
>    <source protocol='rbd' name='rbd/8489c04f-aab8-4796-a22a-ebaa7be247a7'>
>      <host name='31.25.XX.XX' port='6789'/>
>    </source>
>    <target dev='vda' bus='virtio'/>
> </disk>
>
> That fails with: "Operation not supported"
>
> I tried qemu-img:
>
> qemu-img info
> rbd:rbd/8489c04f-aab8-4796-a22a-ebaa7be247a7:mon_host=31.25.XX.XX\\:6789
>
> Same result.
>
> I then tried:
>
> qemu-img info
> rbd:rbd/8489c04f-aab8-4796-a22a-ebaa7be247a7:mon_host=31.25.XX.XX\\:6789:auth_supported=none
>
>
> And that worked :)
>
> This host does not have a local ceph.conf, all the parameters have to
> come from the command line.
>
> I know that recently auth_supported defaults to "cephx", but that now
> break the libvirt integration since it doesn't set auth_supported to
> explicitly none when no auth section is present.
>
> Should this be something that gets fixed in librados or in libvirt?

Thought about it, this is something in libvirt :)

>
> If it's libvirt, I'll write a patch for it :)

Just did so, very simple patch: 
https://www.redhat.com/archives/libvir-list/2012-June/msg01119.html

Wido

>
> Wido
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


