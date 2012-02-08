From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: Nova on RBD Device
Date: Tue, 07 Feb 2012 18:32:24 -0800
Message-ID: <4F31DEB8.3070409@dreamhost.com>
References: <CA+jddaPFD5qVmUFVygW-HgWbCCvhM6A+_2BCann7NuZgmwgRJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:53733 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755249Ab2BHCcY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Feb 2012 21:32:24 -0500
In-Reply-To: <CA+jddaPFD5qVmUFVygW-HgWbCCvhM6A+_2BCann7NuZgmwgRJA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mandell Degerness <mandell@pistoncloud.com>
Cc: ceph-devel@vger.kernel.org

On 02/07/2012 11:01 AM, Mandell Degerness wrote:
> Can anyone point me in the right direction for setting up Nova so that
> it allocates disk space on RBD device(s) rather than on local disk as
> defined in the --instances_path flag?

You probably want to use the boot-from-volume api extension. I think 
there's support in nova-client for this now.

> I've already got nova-volume working with RBD.
>
> I suspect that I need to modify _cache_image and _create_image in
> nova/virt/libvirt/connection.py.

Nova itself doesn't know how to do I/O to volumes - it just knows how to 
configure a hypervisor to use one. You'll need to attach the volume to 
an existing vm to write an image to it, or use a hack like:

rbd rm pool/image && qemu-img convert -f raw -O rbd /path/to/img 
rbd:pool/image

In the future, once rbd layering is implemented, we'd like to be able to 
store images in rbd via glance, and clone them into bootable nova volumes.

> Regards,
> Mandell Degerness

