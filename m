From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: [Xen-devel] Xen blktap driver for Ceph RBD : Anybody wants to
 test ? :p
Date: Mon, 1 Jul 2013 11:57:35 +0200
Message-ID: <CAF6-1L4sFuoHieM2+6h_+dDYFOF0pf00jC_nVBUs=4oNPm9Rcg@mail.gmail.com>
References: <51C3FEF0.7030709@mammoth.com.au>
	<CAF6-1L7xdHCOPmLTghdsMnbna=Y95uy3g9nv=pMmRG5kEKvhCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:33237 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753418Ab3GAJ5h (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Jul 2013 05:57:37 -0400
Received: by mail-bk0-f46.google.com with SMTP id na10so1592496bkb.33
        for <ceph-devel@vger.kernel.org>; Mon, 01 Jul 2013 02:57:35 -0700 (PDT)
In-Reply-To: <CAF6-1L7xdHCOPmLTghdsMnbna=Y95uy3g9nv=pMmRG5kEKvhCw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan O'Sullivan <nathan@mammoth.com.au>
Cc: ceph-devel@vger.kernel.org

Hi again,

>> However when rbd cache is enabled with:
>> [client]
>> rbd_cache = true
>>
>> the tapdisk process crashes if I do this in the domU:
>> dd if=/dev/xvda bs=1M > /dev/null

I tested this locally and couldn't reproduce the issue.

Doing reads doesn't do anything bad AFAICT.
Doing writes OTOH seems to leak memory (or at least use much more
memory than the configured cache size).

I also rechecked the code and I don't see anything wrong with it.
AFAICT with or without cache shouldn't change anything so the issue
might be in librbd itself.

Cheers,

    Sylvain
