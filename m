From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: MAX_RBD_IMAGES
Date: Tue, 22 Sep 2015 15:42:29 -0700
Message-ID: <5601D955.7020701@redhat.com>
References: <866247178.20201562.1442958933148.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40228 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933730AbbIVWlx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 22 Sep 2015 18:41:53 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id 619558E70A
	for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2015 22:41:53 +0000 (UTC)
In-Reply-To: <866247178.20201562.1442958933148.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Shinobu Kinjo <skinjo@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

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
