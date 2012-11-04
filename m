From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: Handle bad file descriptors with EBADF
Date: Sun, 4 Nov 2012 07:09:21 -0800
Message-ID: <CAPrxi58EjJnbL4bCuN09zfLmoqop=Sad-LrH0LmB7DU4dMmyYw@mail.gmail.com>
References: <CAPrxi5-9xAaUnJp5dhyvGpZ4rZ0cM=F6TcvtdBNi53EhSzU_NA@mail.gmail.com>
	<alpine.DEB.2.00.1211040412570.30792@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:35299 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754832Ab2KDPJW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 4 Nov 2012 10:09:22 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so5137243vbb.19
        for <ceph-devel@vger.kernel.org>; Sun, 04 Nov 2012 07:09:22 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1211040412570.30792@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Sun, Nov 4, 2012 at 4:17 AM, Sage Weil <sage@inktank.com> wrote:
>
> but this is actually doing the lookup twice.  A better pattern:
>
>         map<foo, bar>::iterator p = container.find(key);
>         if (p == container.end())
>                 return NULL;
>         return p->second;

Cool, thanks for tip!
