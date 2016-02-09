From: Wido den Hollander <wido@42on.com>
Subject: Re: RBD image usage with librbd (rbd du)
Date: Tue, 9 Feb 2016 16:10:48 +0100 (CET)
Message-ID: <1733706853.3038.c431756f-cd7a-42e0-b485-4e1bed922f21.open-xchange@ox.pcextreme.nl>
References: <1015683166.2791.c431756f-cd7a-42e0-b485-4e1bed922f21.open-xchange@ox.pcextreme.nl>
 <537222148.20525326.1454939052122.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.139]:35712 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753107AbcBIPKv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Feb 2016 10:10:51 -0500
In-Reply-To: <537222148.20525326.1454939052122.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>


> Op 8 februari 2016 om 14:44 schreef Jason Dillaman <dillaman@redhat.com>:
> 
> 
> The 'rbd du' utility actually just performs a diff operation on the image [1].
>  If the image doesn't have the _FAST_DIFF feature enabled, this operation will
> require scanning all potential objects in the RBD image.
> 

Thanks! How does this look:
https://github.com/wido/libvirt/commit/16817a46b6948bd97968712d4865299da54b4fff

If all good I'll send it to libvirt upstream.

Wido

> [1]
> https://github.com/ceph/ceph/blob/master/src/tools/rbd/action/DiskUsage.cc#L58
> 
> -- 
> 
> Jason Dillaman 
> 
> 
> ----- Original Message -----
> > From: "Wido den Hollander" <wido@42on.com>
> > To: "ceph-devel" <ceph-devel@vger.kernel.org>
> > Sent: Saturday, February 6, 2016 2:57:23 AM
> > Subject: RBD image usage with librbd (rbd du)
> > 
> > Hi,
> > 
> > I'm working on libvirt again and for volumes libvirt has a 'capacity' and
> > 'allocation'.
> > 
> > Until recently both were set to the size of the RBD image since it was not
> > possible to fetch the allocation of a image.
> > 
> > We now have 'rbd du' and this uses a librbd call to fetch the real usage of
> > a
> > image.
> > 
> > What is the best way to fetch the 'allocation' of a RBD image using librbd
> > (C)?
> > rbd_stat() won't tell and looking through librbd.h I don't know which
> > function
> > to use.
> > 
> > Thanks,
> > 
> > Wido
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
