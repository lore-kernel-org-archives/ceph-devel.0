From: Gregory Farnum <greg@inktank.com>
Subject: Re: 5GB object limit in the RADOS Gateway
Date: Thu, 30 May 2013 10:47:03 -0700
Message-ID: <CAPYLRzgFTgv3pPUdLny3MdiZCpFPCfSY-aj5+3sf16jBtL7T-Q@mail.gmail.com>
References: <51A78F84.1000607@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:44122 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965718Ab3E3RrF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 May 2013 13:47:05 -0400
Received: by mail-lb0-f177.google.com with SMTP id o10so834089lbi.8
        for <ceph-devel@vger.kernel.org>; Thu, 30 May 2013 10:47:03 -0700 (PDT)
In-Reply-To: <51A78F84.1000607@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, May 30, 2013 at 10:42 AM, Wido den Hollander <wido@42on.com> wrote:
> Hi,
>
> I was checking the source code today and found this macro:
>
> #define RGW_MAX_PUT_SIZE        (5ULL*1024*1024*1024)
>
> Why is that limit in place? Was that to mimic Amazon S3? (Which is at 5T
> now).
>
> I know that object size limit something that should be there, but just
> trying to find the reasoning behind this limit.
>
> Couldn't we make this  configurable at least?

That's the limit on an individual HTTP PUT operation. You can make
larger objects, but they need to be placed with multi-part uploads.
(I'm not sure what the actual limit is, if there is one.)
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
