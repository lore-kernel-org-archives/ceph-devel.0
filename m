From: Mark Doffman <mark.doffman@codethink.co.uk>
Subject: Re: [PATCH v3 0/2] Add ceph root filesystem
Date: Thu, 05 Jun 2014 14:13:31 -0500
Message-ID: <5390C15B.4060407@codethink.co.uk>
References: <cover.1389806186.git.mark.doffman@codethink.co.uk> <cover.1401306206.git.mark.doffman@codethink.co.uk> <lm5sg3$tn3$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:37713 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752110AbaFETNk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jun 2014 15:13:40 -0400
In-Reply-To: <lm5sg3$tn3$1@ger.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elsayed <eternaleye@gmail.com>, ceph-devel@vger.kernel.org



On 05/28/2014 06:46 PM, Alex Elsayed wrote:
> mark.doffman@codethink.co.uk wrote:
>
>> From: Mark Doffman <mark.doffman@codethink.co.uk>
>>
>> Hi All,
>>
>> The following is a third version of a patch series that adds the ability
>> to use a ceph distributed file system as the root device.
> <snip>
>
> Would you mind expanding on why you want to do this in the kernel, instead
> of using an initramfs? For example, dracut supports the following syntax,
> and sets it up using the same tools as mounting NFS in a running system
> rather than the kernel's nfsroot support:
>
> root=nfs:[<server-ip>:]<root-dir>[:<nfs-options>]
> root=nfs4:[<server-ip>:]<root-dir>[:<nfs-options>]
> root={dhcp|dhcp6}
>
> root=dhcp alone directs initrd to look at the DHCP root-path where NFS
> options can be specified.
>
> It also supports CIFS, as a further illustration:
>
> root=cifs://[<username>[:<password>]@]<server-ip>:<root-dir>
>
> Extending this to Ceph seems much simpler than implementing such a thing in
> the kernel, especially given dracut's modular nature, and it's easy enough
> to compile an initramfs into the kernel.

An initramfs, and dracut, has been mentioned before as a possible 
solution. The reason I would prefer this in the kernel is simplicity. 
NFS root is in the kernel and we regularly use it without an initramfs.

However simple dracut is still a more complex procedure, for something 
that is very easy to do in the kernel.

Using a root device also has the advantage that it might produce smaller 
images for memory constrained devices.

>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
