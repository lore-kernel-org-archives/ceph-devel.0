From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: [Xen-devel] Xen blktap driver for Ceph RBD : Anybody wants to
 test ? :p
Date: Fri, 21 Jun 2013 13:21:18 +0200
Message-ID: <CAF6-1L7xdHCOPmLTghdsMnbna=Y95uy3g9nv=pMmRG5kEKvhCw@mail.gmail.com>
References: <51C3FEF0.7030709@mammoth.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49]:38454 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933076Ab3FULVT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Jun 2013 07:21:19 -0400
Received: by mail-bk0-f49.google.com with SMTP id mz10so3308814bkb.8
        for <ceph-devel@vger.kernel.org>; Fri, 21 Jun 2013 04:21:18 -0700 (PDT)
In-Reply-To: <51C3FEF0.7030709@mammoth.com.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan O'Sullivan <nathan@mammoth.com.au>
Cc: ceph-devel@vger.kernel.org

Hi,

> I've been testing this on Ubuntu 12.04.02 64-bit with kernel 3.2.0-48 and
> ceph 0.61.4

Thanks for testing :)

> However when rbd cache is enabled with:
> [client]
> rbd_cache = true
>
> the tapdisk process crashes if I do this in the domU:
> dd if=/dev/xvda bs=1M > /dev/null

Interesting. I'm currently away for I'll try to setup a test and see
if I can reproduce the issue locally.

I never really tried with the cache enabled.

Cheers,

   Sylvain
