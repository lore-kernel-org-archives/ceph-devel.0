From: Samuel Just <sam.just@inktank.com>
Subject: Re: still recovery issues with cuttlefish
Date: Thu, 1 Aug 2013 11:34:07 -0700
Message-ID: <CA+4uBUYPDyQrP=Hg9kCVNvnh4mNi9URbbrGg39AJOmBWjEbCAg@mail.gmail.com>
References: <51FA1AC1.8040207@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f178.google.com ([209.85.128.178]:62314 "EHLO
	mail-ve0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466Ab3HASeI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Aug 2013 14:34:08 -0400
Received: by mail-ve0-f178.google.com with SMTP id ox1so2763724veb.9
        for <ceph-devel@vger.kernel.org>; Thu, 01 Aug 2013 11:34:08 -0700 (PDT)
In-Reply-To: <51FA1AC1.8040207@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Can you reproduce and attach the ceph.log from before you stop the osd
until after you have started the osd and it has recovered?
-Sam

On Thu, Aug 1, 2013 at 1:22 AM, Stefan Priebe - Profihost AG
<s.priebe@profihost.ag> wrote:
> Hi,
>
> i still have recovery issues with cuttlefish. After the OSD comes back
> it seem to hang for around 2-4 minutes and then recovery seems to start
> (pgs in recovery_wait start to decrement). This is with ceph 0.61.7. I
> get a lot of slow request messages an hanging VMs.
>
> What i noticed today is that if i leave the OSD off as long as ceph
> starts to backfill - the recovery and "re" backfilling wents absolutely
> smooth without any issues and no slow request messages at all.
>
> Does anybody have an idea why?
>
> Greets,
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
