From: Patrick Hahn <skorgu@gmail.com>
Subject: Re: [PATCH v3 0/2] Add ceph root filesystem
Date: Fri, 11 Jul 2014 11:56:51 -0400
Message-ID: <CAJWqenBtKcRbUE+_V5TWENHginc58xP4TOrEktRk0nT6490APQ@mail.gmail.com>
References: <cover.1389806186.git.mark.doffman@codethink.co.uk>
 <cover.1401306206.git.mark.doffman@codethink.co.uk> <lm5sg3$tn3$1@ger.gmane.org>
 <5390C15B.4060407@codethink.co.uk> <CAP=_KhqQcJmPLYCNqFkKtW_2jwB1XMWPgg-1jrJdfE6sC5gg3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:49615 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751923AbaGKP5R (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Jul 2014 11:57:17 -0400
Received: by mail-wi0-f179.google.com with SMTP id cc10so1634802wib.0
        for <ceph-devel@vger.kernel.org>; Fri, 11 Jul 2014 08:57:12 -0700 (PDT)
In-Reply-To: <CAP=_KhqQcJmPLYCNqFkKtW_2jwB1XMWPgg-1jrJdfE6sC5gg3Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

> On 05/28/2014 06:46 PM, Alex Elsayed wrote:
>>
>> mark.doffman@codethink.co.uk wrote:
>>
>>> From: Mark Doffman <mark.doffman@codethink.co.uk>
>>>
>>> Hi All,
>>>
>>> The following is a third version of a patch series that adds the ability
>>> to use a ceph distributed file system as the root device.
>>
>> <snip>
>>
>> Would you mind expanding on why you want to do this in the kernel, instead
>> of using an initramfs? For example, dracut supports the following syntax,
>> and sets it up using the same tools as mounting NFS in a running system
>> rather than the kernel's nfsroot support:
>>
>> root=nfs:[<server-ip>:]<root-dir>[:<nfs-options>]
>> root=nfs4:[<server-ip>:]<root-dir>[:<nfs-options>]
>> root={dhcp|dhcp6}
>>
>> root=dhcp alone directs initrd to look at the DHCP root-path where NFS
>> options can be specified.
>>
>> It also supports CIFS, as a further illustration:
>>
>> root=cifs://[<username>[:<password>]@]<server-ip>:<root-dir>
>>
>> Extending this to Ceph seems much simpler than implementing such a thing in
>> the kernel, especially given dracut's modular nature, and it's easy enough
>> to compile an initramfs into the kernel.
>
>
> An initramfs, and dracut, has been mentioned before as a possible solution. The reason I would prefer this in the kernel is simplicity. NFS root is in the kernel and we regularly use it without an initramfs.
>
> However simple dracut is still a more complex procedure, for something that is very easy to do in the kernel.
>
> Using a root device also has the advantage that it might produce smaller images for memory constrained devices.

Just a +1 that we'd love this ability. Not having to keep an initramfs
and kernel in sync would be a nice reduction in complexity in places
where we know exactly how we're going to boot and don't need dracut's
cornucopia of options.

Thanks,
-- 
Patrick Hahn
