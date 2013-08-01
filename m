From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: still recovery issues with cuttlefish
Date: Thu, 1 Aug 2013 18:50:55 +0400
Message-ID: <CABYiri_c4zO30veXsan5LzsKqAO70iPU+ubfqFwP8pt4RVRTWw@mail.gmail.com>
References: <51FA1AC1.8040207@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:48320 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755725Ab3HAOvQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Aug 2013 10:51:16 -0400
Received: by mail-oa0-f44.google.com with SMTP id l20so4611656oag.3
        for <ceph-devel@vger.kernel.org>; Thu, 01 Aug 2013 07:51:16 -0700 (PDT)
In-Reply-To: <51FA1AC1.8040207@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Second this. Also for long-lasting snapshot problem and related
performance issues I may say that cuttlefish improved things greatly,
but creation/deletion of large snapshot (hundreds of gigabytes of
commited data) still can bring down cluster for a minutes, despite
usage of every possible optimization.

On Thu, Aug 1, 2013 at 12:22 PM, Stefan Priebe - Profihost AG
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
