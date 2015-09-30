From: Shinobu Kinjo <skinjo@redhat.com>
Subject: Re: MAX_RBD_IMAGES
Date: Tue, 29 Sep 2015 23:58:44 -0400 (EDT)
Message-ID: <159480963.23629349.1443585524566.JavaMail.zimbra@redhat.com>
References: <866247178.20201562.1442958933148.JavaMail.zimbra@redhat.com> <560B2713.8080107@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:57062 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753374AbbI3D6o (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Sep 2015 23:58:44 -0400
In-Reply-To: <560B2713.8080107@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dmick@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

I just want to know what that number means.

Based on the Linux kenel, that number doesn't make sense but, for the Ceph cluster, would make sense from performance, resource handling including networking resource point of views.

So, do you remember?

Shinobu

----- Original Message -----
From: "Dan Mick" <dmick@redhat.com>
To: "Shinobu Kinjo" <skinjo@redhat.com>, "ceph-devel" <ceph-devel@vger.kernel.org>
Sent: Wednesday, September 30, 2015 9:04:35 AM
Subject: Re: [CEPH-DEVEL] MAX_RBD_IMAGES

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
