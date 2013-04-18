From: Wido den Hollander <wido@42on.com>
Subject: Re: Xen blktap driver for Ceph RBD : Anybody wants to test ? :p
Date: Thu, 18 Apr 2013 21:35:16 +0200
Message-ID: <51704AF4.7060908@42on.com>
References: <CAF6-1L714v7xtXe_Bg396jm+7Fi5ivUoxX79dpZ4dmT8MFj-aA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:53466 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752602Ab3DRTfU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 18 Apr 2013 15:35:20 -0400
In-Reply-To: <CAF6-1L714v7xtXe_Bg396jm+7Fi5ivUoxX79dpZ4dmT8MFj-aA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: ceph-devel@vger.kernel.org

Hi,

On 04/18/2013 05:05 PM, Sylvain Munaut wrote:
> Hi,
>
> I've been working on getting a working blktap driver allowing to
> access ceph RBD block devices without relying on the RBD kernel driver
> and it finally got to a point where, it works and is testable.
>

This is really cool! I already pointed a couple at Citrix at this since 
I'd really love to see this go into XenServer at some point and expand 
the CloudStack RBD support from KVM to XenServer as well.

> Some of the advantages are:
>   - Easier to update to newer RBD version
>   - Allows functionality only available in the userspace RBD library
> (write cache, layering, ...)
>   - Less issue when you have OSD as domU on the same dom0
>   - Contains crash to user space :p (they shouldn't happen, but ...)
>
> It's still an early prototype, but if you want to give it a shot and
> give feedback.
>
> You can find the code there https://github.com/smunaut/blktap/tree/rbd
>   (rbd branch).
>
> Currently the username, poolname and image name are hardcoded ...
> (look for FIXME in the code). I'll get to that next, once I figured
> the best format for arguments.
>

My Xen is kind of rusty, last time I used it was about 3 years ago, but 
can't you do something similar like with Qemu? Just submit all the 
arguments semi-column separated?

> Cheers,
>
>      Sylvain
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
