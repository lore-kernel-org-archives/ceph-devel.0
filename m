From: Shinobu Kinjo <skinjo@redhat.com>
Subject: Re: MAX_RBD_IMAGES
Date: Tue, 22 Sep 2015 18:53:36 -0400 (EDT)
Message-ID: <1358452839.20213671.1442962416283.JavaMail.zimbra@redhat.com>
References: <866247178.20201562.1442958933148.JavaMail.zimbra@redhat.com> <5601D955.7020701@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:53457 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934970AbbIVWxg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Sep 2015 18:53:36 -0400
In-Reply-To: <5601D955.7020701@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

> I don't think there's a reason for the exact limit. rbd-fuse was
> created as a prototype, and hasn't had much work on it since.

That's why I've ended up with asking. I've spent 2 days to find out any reason -;
The kernel says nothing to me, of course.
Thank you.

 Shinobu

----- Original Message -----
From: "Josh Durgin" <jdurgin@redhat.com>
To: "Shinobu Kinjo" <skinjo@redhat.com>, "ceph-devel" <ceph-devel@vger.kernel.org>
Sent: Wednesday, September 23, 2015 7:42:29 AM
Subject: Re: [CEPH-DEVEL] MAX_RBD_IMAGES

On 09/22/2015 02:55 PM, Shinobu Kinjo wrote:
> Hello,
>
> Does any of you know why *MAX_RBD_IMAGES* was changed from 16 to 128?
> I hope that Dan remember -;
>
> http://resources.ustack.com/ceph/ceph/commit/2a6dcabf7f1b7550a0fa4fd223970ffc24ad7870

I don't think there's a reason for the exact limit. rbd-fuse was
created as a prototype, and hasn't had much work on it since. A
hardcoded limit on open images is not necessary, for example. Some
more ideas for improvements if anyone's interested:

http://pad.ceph.com/p/rbd-fuse-2015

Josh
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
