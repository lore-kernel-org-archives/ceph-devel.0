From: Dan Mick <dmick@redhat.com>
Subject: Re: MAX_RBD_IMAGES
Date: Tue, 29 Sep 2015 17:04:35 -0700
Message-ID: <560B2713.8080107@redhat.com>
References: <866247178.20201562.1442958933148.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52032 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750947AbbI3AEf (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 29 Sep 2015 20:04:35 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id C09B5461E9
	for <ceph-devel@vger.kernel.org>; Wed, 30 Sep 2015 00:04:35 +0000 (UTC)
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
> 
>  - Shinobu
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

to....have more of them?

-- 
Dan Mick
Red Hat, Inc.
Ceph docs: http://ceph.com/docs
