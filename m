From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: Is rbd_discard enough to wipe an RBD image?
Date: Mon, 21 Dec 2015 14:20:07 -0800
Message-ID: <56787B17.2000807@redhat.com>
References: <56771BEE.4050705@42on.com>
 <1255550760.10644674.1450707915260.JavaMail.zimbra@oxygem.tv>
 <1795864225.1459105.1450710584514.JavaMail.zimbra@redhat.com>
 <56781FAF.3010907@redhat.com> <56784C4B.8020408@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35579 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751201AbbLUWUI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 21 Dec 2015 17:20:08 -0500
In-Reply-To: <56784C4B.8020408@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>, Jason Dillaman <dillaman@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Alexandre DERUMIER <aderumier@odiso.com>

On 12/21/2015 11:00 AM, Wido den Hollander wrote:
> My discard code now works, but I wanted to verify. If I understand Jason
> correctly it would be a matter of figuring out the 'order' of a image
> and call rbd_discard in a loop until you reach the end of the image.

You'd need to get the order via rbd_stat(), convert it to object size 
(i.e. (1 << order)), and fetch stripe_count with rbd_get_stripe_count().

Then do the discards in (object size * stripe_count) chunks. This
ensures you discard entire objects. This is the size you'd want to use
for import/export as well, ideally.

> I just want libvirt to be as feature complete as possible when it comes
> to RBD.

I see, makes sense.

Josh
