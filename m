From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: RBD image usage with librbd (rbd du)
Date: Mon, 8 Feb 2016 08:44:12 -0500 (EST)
Message-ID: <537222148.20525326.1454939052122.JavaMail.zimbra@redhat.com>
References: <1015683166.2791.c431756f-cd7a-42e0-b485-4e1bed922f21.open-xchange@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:55509 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbcBHNoR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Feb 2016 08:44:17 -0500
In-Reply-To: <1015683166.2791.c431756f-cd7a-42e0-b485-4e1bed922f21.open-xchange@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

The 'rbd du' utility actually just performs a diff operation on the image [1].  If the image doesn't have the _FAST_DIFF feature enabled, this operation will require scanning all potential objects in the RBD image.

[1] https://github.com/ceph/ceph/blob/master/src/tools/rbd/action/DiskUsage.cc#L58

-- 

Jason Dillaman 


----- Original Message -----
> From: "Wido den Hollander" <wido@42on.com>
> To: "ceph-devel" <ceph-devel@vger.kernel.org>
> Sent: Saturday, February 6, 2016 2:57:23 AM
> Subject: RBD image usage with librbd (rbd du)
> 
> Hi,
> 
> I'm working on libvirt again and for volumes libvirt has a 'capacity' and
> 'allocation'.
> 
> Until recently both were set to the size of the RBD image since it was not
> possible to fetch the allocation of a image.
> 
> We now have 'rbd du' and this uses a librbd call to fetch the real usage of a
> image.
> 
> What is the best way to fetch the 'allocation' of a RBD image using librbd
> (C)?
> rbd_stat() won't tell and looking through librbd.h I don't know which
> function
> to use.
> 
> Thanks,
> 
> Wido
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
