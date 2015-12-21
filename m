From: Wido den Hollander <wido@42on.com>
Subject: Re: Is rbd_discard enough to wipe an RBD image?
Date: Mon, 21 Dec 2015 20:00:27 +0100
Message-ID: <56784C4B.8020408@42on.com>
References: <56771BEE.4050705@42on.com>
 <1255550760.10644674.1450707915260.JavaMail.zimbra@oxygem.tv>
 <1795864225.1459105.1450710584514.JavaMail.zimbra@redhat.com>
 <56781FAF.3010907@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.139]:45537 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbbLUTAd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Dec 2015 14:00:33 -0500
In-Reply-To: <56781FAF.3010907@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>, Jason Dillaman <dillaman@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Alexandre DERUMIER <aderumier@odiso.com>

On 12/21/2015 04:50 PM, Josh Durgin wrote:
> On 12/21/2015 07:09 AM, Jason Dillaman wrote:
>> You will have to ensure that your writes are properly aligned with the
>> object size (or object set if fancy striping is used on the RBD
>> volume).  In that case, the discard is translated to remove operations
>> on each individual backing object.  The only time zeros are written to
>> disk is if you specify an offset somewhere in the middle of an object
>> (i.e. the whole object cannot be deleted nor can it be truncated) --
>> this is the partial discard case controlled by that configuration param.
>>
> 
> I'm curious what's using the virVolWipe stuff - it can't guarantee it's
> actually wiping the data in many common configurations, not just with
> ceph but with any kind of disk, since libvirt is usually not consuming
> raw disks, and with modern flash and smr drives even that is not enough.
> There's a recent patch improving the docs on this [1].
> 
> If the goal is just to make the data inaccessible to the libvirt user,
> removing the image is just as good.
> 
> That said, with rbd there's not much cost to zeroing the image with
> object map enabled - it's effectively just doing the data removal step
> of 'rbd rm' early.
> 

I was looking at the features the RBD storage pool driver is missing in
libvirt and it is:

- Build from Volume. That's RBD cloning
- Uploading and Downloading Volume
- Wiping Volume

The thing about wiping in libvirt is that the volume still exists
afterwards, it is just empty.

My discard code now works, but I wanted to verify. If I understand Jason
correctly it would be a matter of figuring out the 'order' of a image
and call rbd_discard in a loop until you reach the end of the image.

I just want libvirt to be as feature complete as possible when it comes
to RBD.

Wido

> Josh
> 
> [1] http://comments.gmane.org/gmane.comp.emulators.libvirt/122235
> -- 
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Wido den Hollander
42on B.V.
Ceph trainer and consultant

Phone: +31 (0)20 700 9902
Skype: contact42on
