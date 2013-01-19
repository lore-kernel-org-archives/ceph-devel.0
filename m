From: Jeff Mitchell <jeffrey.mitchell@gmail.com>
Subject: Re: Understanding Ceph
Date: Sat, 19 Jan 2013 13:08:22 -0500
Message-ID: <50FAE116.2010504@gmail.com>
References: <CAPrNTukzeSN8ZfO_Mhtx9LkHqe0M3tUxJuQG=gwwJD4w+-OGEg@mail.gmail.com> <50FAC92C.8030709@bmrb.wisc.edu> <alpine.DEB.2.00.1301190911470.29915@cobra.newdream.net> <CAPrNTukzfE0KNMG+Rww8FBOCFq_BZr29Kb0zQRCf0K40oX4enQ@mail.gmail.com> <alpine.DEB.2.00.1301190933000.29915@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f176.google.com ([209.85.220.176]:49919 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752240Ab3ASSI1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 19 Jan 2013 13:08:27 -0500
Received: by mail-vc0-f176.google.com with SMTP id fy27so204265vcb.7
        for <ceph-devel@vger.kernel.org>; Sat, 19 Jan 2013 10:08:27 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1301190933000.29915@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Peter Smith <peterfruits@gmail.com>, Dimitri Maziuk <dmaziuk@bmrb.wisc.edu>, ceph-devel@vger.kernel.org

Sage Weil wrote:
> On Sun, 20 Jan 2013, Peter Smith wrote:
>> Thanks for the reply, Sage and everyone.
>>
>> Sage, so I can expect Ceph-rbd works well on Centos 6.3 if I only use
>> it as the Cinder volume backend because the librbd in QEMU doesn't
>> make use of kernel client, right?
>
> Then the dependency is on the qemu version.  I don't remember that off the
> top of my head, or know what version rhel6 ships.  Most people deploying
> openstack and rbd are using a more modern distro (like ubuntu 12.04).

This discussion has made me curious: I'm using Ganeti to manage VMs, 
which manages the storage using the kernel client and passes in the dev 
device to qemu.

Can you comment on any known performance differences between the two 
methods -- native qemu+librbd creating a block device vs. the kernel 
client creating a block device?

Thanks,
Jeff
