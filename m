From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Integration work
Date: Wed, 29 Aug 2012 11:53:31 +0200
Message-ID: <503DE69B.70804@widodh.nl>
References: <503D0A00.2080905@inktank.com> <CAF6-1L6QKQbgPZvXYMQw+0_vaLrP0cr_P0_nZs56Lh+A2B9k8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:55438 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160Ab2H2Jxd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Aug 2012 05:53:33 -0400
In-Reply-To: <CAF6-1L6QKQbgPZvXYMQw+0_vaLrP0cr_P0_nZs56Lh+A2B9k8Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: Ross Turk <ross@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 08/29/2012 10:20 AM, Sylvain Munaut wrote:
> Hi,
>
>> How about Xen?
>
> I vote for this :)
>
> Using RBD storage for Xen VM images / disks is IMHO a very nice fit,
> the same way people do with QEMU. This should even allow live
> migration of VM.
>

Correct me if I'm wrong, but when I was at Citrix in May this year 
somebody there told me that Xen was going 100% Qemu?

By going 100% Qemu they would also get RBD support.

Wido

> Currently we have to rely on the RBD kernel driver which has some
> downsides (no caching / need recent kernel to get latest ceph
> patches). There also seem to be some weird interactions between RBD
> and Xen that lead to significant performance hits that are not present
> when using only RBD or only Xen.
>
> One possibility would be to develop a blktap driver for xen to provide
> block device backend in userspace using librbd rather than kernel mode
> rbd.
>
> Cheers,
>
>      Sylvain
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

