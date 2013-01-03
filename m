From: Gregory Farnum <greg@inktank.com>
Subject: Re: kernel rbd format=2
Date: Thu, 3 Jan 2013 09:12:15 -0800
Message-ID: <CAPYLRzjAzyfbZyQdtmevdq1V0hW=ARV0ZH9JXy09z58bAU3Tiw@mail.gmail.com>
References: <20121218001054.GA17186@onthe.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:47148 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430Ab3ACRMQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jan 2013 12:12:16 -0500
Received: by mail-qc0-f169.google.com with SMTP id t2so8240868qcq.28
        for <ceph-devel@vger.kernel.org>; Thu, 03 Jan 2013 09:12:16 -0800 (PST)
In-Reply-To: <20121218001054.GA17186@onthe.net.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chris Dunlop <chris@onthe.net.au>, Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Alex has been doing a lot of work to support this lately, but I don't
think he's sketched out the actual implementation timeline yet.
-Greg

On Mon, Dec 17, 2012 at 4:10 PM, Chris Dunlop <chris@onthe.net.au> wrote:
> Hi,
>
> Format 2 images (and attendant layering support) are not yet
> supported by the kernel rbd client, according to:
>
> http://ceph.com/docs/master/rbd/rbd-snapshot/#layering
>
> When might this support be available?
>
> Cheers,
>
> Chris
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
