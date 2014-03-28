From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH 08/33] libceph: assert length of osdmap osd arrays
Date: Fri, 28 Mar 2014 16:57:02 +0200
Message-ID: <CALFYKtDhvntxU6u+qLppHtAKEeEkeNTx9CHD3u64_YBKnNSpyw@mail.gmail.com>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
	<1395944299-21970-9-git-send-email-ilya.dryomov@inktank.com>
	<53347C59.9040004@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:49273 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858AbaC1O5D (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Mar 2014 10:57:03 -0400
Received: by mail-qa0-f43.google.com with SMTP id j15so5309468qaq.2
        for <ceph-devel@vger.kernel.org>; Fri, 28 Mar 2014 07:57:02 -0700 (PDT)
In-Reply-To: <53347C59.9040004@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Mar 27, 2014 at 9:30 PM, Alex Elder <elder@ieee.org> wrote:
> On 03/27/2014 01:17 PM, Ilya Dryomov wrote:
>> Assert length of osd_state, osd_weight and osd_addr arrays.  They
>> should all have exactly max_osd elements after the call to
>> osdmap_set_max_osd().
>
> Since this function is allowed to fail, could these
> conditions lead to returning an error code rather than
> killing the machine?
>
> Your testing incoming data (which you can't necessarily
> trust), not a fundamental assumption of the code, so
> a BUG() seems harsh.
>
> Checking is absolutely the right thing to do.
>
> Switch it to return an error if you can.  If you feel
> BUG() is right, so be it.  Either way:

Changed to returning -EINVAL.

Thanks,

                Ilya
