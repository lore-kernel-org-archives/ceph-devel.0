From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH 1/8] rbd: show the entire chain of parent images
Date: Thu, 24 Jul 2014 16:45:14 +0400
Message-ID: <CALFYKtAYEC_KOLFG6ahER_DJq6vZ4+Ap+G8+gD+aWbt-zRW5hA@mail.gmail.com>
References: <1406191369-6746-1-git-send-email-ilya.dryomov@inktank.com>
	<1406191369-6746-2-git-send-email-ilya.dryomov@inktank.com>
	<53D0FCAC.3030801@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:51914 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758059AbaGXMpP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jul 2014 08:45:15 -0400
Received: by mail-qa0-f50.google.com with SMTP id s7so2828532qap.37
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jul 2014 05:45:15 -0700 (PDT)
In-Reply-To: <53D0FCAC.3030801@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Jul 24, 2014 at 4:31 PM, Alex Elder <elder@ieee.org> wrote:
> On 07/24/2014 03:42 AM, Ilya Dryomov wrote:
>> Make /sys/bus/rbd/devices/<id>/parent show the entire chain of parent
>> images.  While at it, kernel sprintf() doesn't return negative values,
>> casting to unsigned long long is no longer necessary and there is no
>> good reason to split into multiple sprintf() calls.
>
> I like the use of a single snprintf() call, it is much less
> cumbersome.
>
> The reason I always cast u64 values to (unsigned long long)
> in printf() calls is because on some 64-bit architectures,
> u64 is defined as simply (unsigned long), so without the
> cast they spit out warnings.  I hate this, but it is reality
> (see include/asm-generic/{int-l64.h,int-ll64.h}).  You can
> alternatively use %PRIu64 rather than %llu in your format
> strings, but I think I hate that more.  Anyway, if you want
> to avoid warnings on all architectures you should fix that.

IIRC all architectures nowadays use int-ll64.h.  int-l64.h is used only
in userspace for compatibility.

Thanks,

                Ilya
