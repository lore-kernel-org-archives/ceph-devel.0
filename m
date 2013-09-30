From: Dan van der Ster <dan@vanderster.com>
Subject: Re: status of fancy striping for krbd
Date: Mon, 30 Sep 2013 17:40:08 +0200
Message-ID: <CABZ+qqnboRZ-sts_SSawNV80huaBJQTaN2CdxseEsZRpo5A1pw@mail.gmail.com>
References: <CABZ+qqmWzDpv=FzwVyM0ai7RaQxiKE4gW+Zx7jELArGqjY+Vdg@mail.gmail.com>
 <alpine.DEB.2.00.1309300831330.12714@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f54.google.com ([209.85.214.54]:47146 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752855Ab3I3Pkv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Sep 2013 11:40:51 -0400
Received: by mail-bk0-f54.google.com with SMTP id mz12so2165547bkb.13
        for <ceph-devel@vger.kernel.org>; Mon, 30 Sep 2013 08:40:50 -0700 (PDT)
Received: by mail-la0-f53.google.com with SMTP id el20so4545587lab.26
        for <ceph-devel@vger.kernel.org>; Mon, 30 Sep 2013 08:40:49 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1309300831330.12714@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Sep 30, 2013 at 5:33 PM, Sage Weil <sage@inktank.com> wrote:
> On Mon, 30 Sep 2013, Dan van der Ster wrote:
>> Hi all,
>> I just noticed that krbd supports mapping format v2 images in 3.11,
>> but it doesn't yet support STRIPINGV2. Is this coming anytime soon?
>
> We don't have immediate plans to add the striping feature.  You may be the
> first person to ask for it.  :)

One of our students ran some preliminary tests under qemu and found
that fancy striping was worth turning on for his tests at least.

We will re-run the tests over the next couple weeks and fully quantify
how much it helps our typical use-cases.

Cheers, Dan


> The challenge is that it requires a fair bit of refactoring in the
> osd_client layer to do scatter/gather type IO.  The nice thing is that
> this will equally benefit CephFS, which supports the same range of
> striping configurations.
>
> sage
