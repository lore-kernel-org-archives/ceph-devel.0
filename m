From: Alex Elder <elder@dreamhost.com>
Subject: Re: [PATCH] rbd: fix integer overflow in rbd_header_from_disk()
Date: Wed, 18 Apr 2012 13:47:17 -0500
Message-ID: <4F8F0C35.8090903@dreamhost.com>
References: <1334008335-8377-1-git-send-email-xi.wang@gmail.com> <4F8ECDFA.70209@dreamhost.com> <30227880-FACB-4180-B129-7B5D407094E5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:54484 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752841Ab2DRSrT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Apr 2012 14:47:19 -0400
In-Reply-To: <30227880-FACB-4180-B129-7B5D407094E5@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xi Wang <xi.wang@gmail.com>
Cc: ceph-devel@vger.kernel.org, Yehuda Sadeh <yehuda@hq.newdream.net>, Sage Weil <sage@newdream.net>

On 04/18/2012 01:09 PM, Xi Wang wrote:
> On Apr 18, 2012, at 10:21 AM, Alex Elder wrote:
>>
>> This looks good, however I have changed it to use UINT_MAX
>> rather than ULONG_MAX, because on some architectures size_t
>> (__kernel_size_t) is defined as type (unsigned int).  It
>> is the more conservative value, and even on architectures
>> where __BITS_PER_LONG is 64, it still offers a sane upper
>> bound on the number of snapshots for a rbd device.
>
> Looks good to me.
>
> BTW, on which arch is size_t 32-bit while long is 64?
> Several commits still use ULONG_MAX, such as

In my tree, these at least *can* be:  arm, m68k, mips,
powerpc, sparc, x86, and others (including generic).

It may not matter in practice, but I prefer to be very
careful.  As long as you're going out of your way to
avoid overflow might as well make sure it works on all
architectures in the process.

					-Alex

> http://git.kernel.org/linus/64486697
>
> - xi
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

