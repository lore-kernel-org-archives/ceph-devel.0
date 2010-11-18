From: Josh Durgin <joshd@hq.newdream.net>
Subject: Re: [libvirt] rbd storage pool support for libvirt
Date: Wed, 17 Nov 2010 16:33:07 -0800
Message-ID: <4CE47443.4000503@hq.newdream.net>
References: <Pine.LNX.4.64.1011012051190.28156@cobra.newdream.net> <20101103135900.GQ29893@redhat.com> <Pine.LNX.4.64.1011051530100.21692@cobra.newdream.net> <20101108131634.GJ26714@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:46991 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752243Ab0KRAdI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Nov 2010 19:33:08 -0500
In-Reply-To: <20101108131634.GJ26714@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Sage Weil <sage@newdream.net>, libvir-list@redhat.com, ceph-devel@vger.kernel.org

Hi Daniel,

On 11/08/2010 05:16 AM, Daniel P. Berrange wrote:
>>>> In any case, before someone goes off and implements something, does this
>>>> look like the right general approach to adding rbd support to libvirt?
>>>
>>> I think this looks reasonable. I'd be inclined to get the storage pool
>>> stuff working with the kernel RBD driver&  UDEV rules for stable path
>>> names, since that avoids needing to make any changes to guest XML
>>> format. Support for QEMU with the native librados CEPH driver could
>>> be added as a second patch.
>>
>> Okay, that sounds reasonable.  Supporting the QEMU librados driver is
>> definitely something we want to target, though, and seems to be route that
>> more users are interested in.  Is defining the XML syntax for a guest VM
>> something we can discuss now as well?
>>
>> (BTW this is biting NBD users too.  Presumably the guest VM XML should
>> look similar?
>
> And also Sheepdog storage volumes. To define a syntax for all these we need
> to determine what configuration metadata is required at a per-VM level for
> each of them. Then try and decide how to represent that in the guest XML.
> It looks like at a VM level we'd need a hostname, port number and a volume
> name (or path).

It looks like that's what Sheepdog needs from the patch that was
submitted earlier today. For RBD, we would want to allow multiple hosts,
and specify the pool and image name when the QEMU librados driver is
used, e.g.:

     <disk type="rbd" device="disk">
       <driver name="qemu" type="raw" />
       <source vdi="image_name" pool="pool_name">
         <host name="mon1.example.org" port="6000">
         <host name="mon2.example.org" port="6000">
         <host name="mon3.example.org" port="6000">
       </source>
       <target dev="vda" bus="virtio" />
     </disk>

As you mentioned earlier, we could just use the existing source format
for the kernel RBD driver.

Does this seem like a reasonable format for the VM XML? Any suggestions?

Thanks,
Josh
