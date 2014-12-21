From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH] net: ceph: ceph_strings.c: Remove unused function
Date: Sun, 21 Dec 2014 14:24:47 +0300
Message-ID: <CALFYKtD7wTNiTzekkWKZqBEb_7egij31Fhe=7J2Ey+arT3M_vA@mail.gmail.com>
References: <1419078894-31656-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:51436 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204AbaLULYs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 21 Dec 2014 06:24:48 -0500
Received: by mail-qa0-f44.google.com with SMTP id bm13so2336955qab.3
        for <ceph-devel@vger.kernel.org>; Sun, 21 Dec 2014 03:24:47 -0800 (PST)
In-Reply-To: <1419078894-31656-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Cc: Sage Weil <sage@inktank.com>, "David S. Miller" <davem@davemloft.net>, Ceph Development <ceph-devel@vger.kernel.org>, netdev@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sat, Dec 20, 2014 at 3:34 PM, Rickard Strandqvist
<rickard_strandqvist@spectrumdigital.se> wrote:
> Remove the function ceph_pool_op_name() that is not used anywhere.
>
> This was partially found by using a static code analysis program called cppcheck.

It's part of pool op infrastructure and I'd rather we use it in
monc_show() than remove it.  I'll make a patch.

Thanks,

                Ilya
