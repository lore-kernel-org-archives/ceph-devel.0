From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Linux large IO size.
Date: Fri, 13 Jul 2012 13:02:52 -0700
Message-ID: <CADvuQRFmFX2aPMThmhc3T8j-bR8PBu9JY1cxyg9CbzAp6OUU4Q@mail.gmail.com>
References: <500071F8.7050206@genome.wustl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:33271 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753406Ab2GMUDN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Jul 2012 16:03:13 -0400
Received: by pbbrp8 with SMTP id rp8so5963716pbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 13 Jul 2012 13:03:12 -0700 (PDT)
In-Reply-To: <500071F8.7050206@genome.wustl.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Weil <mweil@genome.wustl.edu>
Cc: ceph-devel@vger.kernel.org

On Fri, Jul 13, 2012 at 12:07 PM, Matt Weil <mweil@genome.wustl.edu> wrote:
> Is it possible to get IO sizes 1024k and larger?

Can you be a bit more explicit in what you're asking?

Are you talking about submitting IO to RBD (via the kernel module?
inside a qemu vm?), are you talking about using the Ceph Distributed
File System, or are you talking about the IO ceph-osd submits to the
physical disk?
