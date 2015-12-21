From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: Is rbd_discard enough to wipe an RBD image?
Date: Mon, 21 Dec 2015 07:50:07 -0800
Message-ID: <56781FAF.3010907@redhat.com>
References: <56771BEE.4050705@42on.com>
 <1255550760.10644674.1450707915260.JavaMail.zimbra@oxygem.tv>
 <1795864225.1459105.1450710584514.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35310 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751049AbbLUPuC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 21 Dec 2015 10:50:02 -0500
In-Reply-To: <1795864225.1459105.1450710584514.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>, Wido den Hollander <wido@42on.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Alexandre DERUMIER <aderumier@odiso.com>

On 12/21/2015 07:09 AM, Jason Dillaman wrote:
> You will have to ensure that your writes are properly aligned with the object size (or object set if fancy striping is used on the RBD volume).  In that case, the discard is translated to remove operations on each individual backing object.  The only time zeros are written to disk is if you specify an offset somewhere in the middle of an object (i.e. the whole object cannot be deleted nor can it be truncated) -- this is the partial discard case controlled by that configuration param.
>

I'm curious what's using the virVolWipe stuff - it can't guarantee it's
actually wiping the data in many common configurations, not just with
ceph but with any kind of disk, since libvirt is usually not consuming
raw disks, and with modern flash and smr drives even that is not enough.
There's a recent patch improving the docs on this [1].

If the goal is just to make the data inaccessible to the libvirt user,
removing the image is just as good.

That said, with rbd there's not much cost to zeroing the image with
object map enabled - it's effectively just doing the data removal step
of 'rbd rm' early.

Josh

[1] http://comments.gmane.org/gmane.comp.emulators.libvirt/122235
