From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: RGW: Refusing FastCGI request with empty CONTENT_LENGTH ? Why ?
Date: Tue, 2 Apr 2013 15:28:42 +0200
Message-ID: <CAF6-1L5L1s4hdvrFLAiF7Z0ByJ0JcDASwrvM4AexPfmgvCg0=w@mail.gmail.com>
References: <CAF6-1L4GdD8w=3y-0fnVHLA1RPAoKmr-EwST9_pteD_i8opkPw@mail.gmail.com>
	<CAF6-1L6y81uVN29ZJyjxOHv5r=cQXqoYdSV22AGHY1U9Xgu57g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f41.google.com ([209.85.214.41]:43598 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760243Ab3DBN2n (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Apr 2013 09:28:43 -0400
Received: by mail-bk0-f41.google.com with SMTP id i18so213453bkv.14
        for <ceph-devel@vger.kernel.org>; Tue, 02 Apr 2013 06:28:42 -0700 (PDT)
In-Reply-To: <CAF6-1L6y81uVN29ZJyjxOHv5r=cQXqoYdSV22AGHY1U9Xgu57g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

Replying to myself

> So that means if there is a CONTENT_LENGTH field in the environment
> but it's empty, then the request is just refused.

This is fixed in master but wasn't backported to the bobtail branch,
which is how I missed it ...
Sorry for the noise.

Cheers,

    Sylvain
