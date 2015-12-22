From: Wido den Hollander <wido@42on.com>
Subject: Re: Is rbd_discard enough to wipe an RBD image?
Date: Tue, 22 Dec 2015 22:55:10 +0100
Message-ID: <5679C6BE.6050604@42on.com>
References: <56771BEE.4050705@42on.com>
 <1255550760.10644674.1450707915260.JavaMail.zimbra@oxygem.tv>
 <1795864225.1459105.1450710584514.JavaMail.zimbra@redhat.com>
 <56781FAF.3010907@redhat.com> <56784C4B.8020408@42on.com>
 <56787B17.2000807@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:45960 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752367AbbLVVzR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Dec 2015 16:55:17 -0500
In-Reply-To: <56787B17.2000807@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>, Jason Dillaman <dillaman@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Alexandre DERUMIER <aderumier@odiso.com>

On 12/21/2015 11:20 PM, Josh Durgin wrote:
> On 12/21/2015 11:00 AM, Wido den Hollander wrote:
>> My discard code now works, but I wanted to verify. If I understand Jason
>> correctly it would be a matter of figuring out the 'order' of a image
>> and call rbd_discard in a loop until you reach the end of the image.
> 
> You'd need to get the order via rbd_stat(), convert it to object size
> (i.e. (1 << order)), and fetch stripe_count with rbd_get_stripe_count().
> 
> Then do the discards in (object size * stripe_count) chunks. This
> ensures you discard entire objects. This is the size you'd want to use
> for import/export as well, ideally.
> 

Thanks! I just implemented this, could you take a look?

https://github.com/wido/libvirt/commit/b07925ad50fdb6683b5b21deefceb0829a7842dc

>> I just want libvirt to be as feature complete as possible when it comes
>> to RBD.
> 
> I see, makes sense.
> 
> Josh
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
