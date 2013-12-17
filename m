From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: New Defects reported by Coverity Scan for ceph (fwd)
Date: Tue, 17 Dec 2013 11:01:15 +0200
Message-ID: <CALFYKtD3puoAozAkVYUumv3nACJ2YOcum8Mk99ejfXYoTNKukQ@mail.gmail.com>
References: <alpine.DEB.2.00.1312160807450.4454@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:47512 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839Ab3LQJBT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Dec 2013 04:01:19 -0500
Received: by mail-wi0-f173.google.com with SMTP id hm19so2300519wib.0
        for <ceph-devel@vger.kernel.org>; Tue, 17 Dec 2013 01:01:15 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1312160807450.4454@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Dec 16, 2013 at 6:07 PM, Sage Weil <sage@inktank.com> wrote:
>
>
> ---------- Forwarded message ----------
> From: scan-admin@coverity.com
> To: undisclosed-recipients:;
> Cc:
> Date: Mon, 16 Dec 2013 00:57:57 -0800
> Subject: New Defects reported by Coverity Scan for ceph
>
>
> Hi,
>
>
> Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.
>
> Defect(s) Reported-by: Coverity Scan
> Showing 4 of 4 defect(s)
>
>
> ** CID 1138366:  Resource leak  (RESOURCE_LEAK)
> /test/librados/tier.cc: 96 in LibRadosMisc_HitSetNone_Test::TestBody()()
> /test/librados/tier.cc: 98 in LibRadosMisc_HitSetNone_Test::TestBody()()
> /test/librados/tier.cc: 99 in LibRadosMisc_HitSetNone_Test::TestBody()()
>
> ** CID 1138367:  Time of check time of use  (TOCTOU)
> /rbd.cc: 2024 in do_kernel_rm(const char *)()
>
> ** CID 1138368:  Time of check time of use  (TOCTOU)
> /rbd.cc: 1735 in do_kernel_add(const char *, const char *, const char *)()

Look like these two refer to my recent work on rbd:

2019   const char *fname = "/sys/bus/rbd/remove_single_major";
2020   if (stat(fname, &sbuf)) {
2021     fname = "/sys/bus/rbd/remove";
2022   }
2023
2024   int fd = open(fname, O_WRONLY); <---
2025   if (fd < 0) {

This is not a TOCTOU as there is no race here, so technically
annotations are in order, but I'll redo it as two open()s instead.

Thanks,

                Ilya
