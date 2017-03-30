From: huang jun <hjwsm1989@gmail.com>
Subject: Re: Idea for optimize an OSD rebuild
Date: Thu, 30 Mar 2017 18:05:16 +0800
Message-ID: <CABAwU-bHxirBbT=SnjZuVL+M6PdN3FcOkvv_9wjNdObOsi9PGg@mail.gmail.com>
References: <CAL2-6bJLntQ3MzYffw3_tFQXjizErDLDY5RoBG5-DyZUoCAhnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f178.google.com ([209.85.216.178]:33280 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932949AbdC3KFX (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Mar 2017 06:05:23 -0400
Received: by mail-qt0-f178.google.com with SMTP id i34so34547908qtc.0
        for <ceph-devel@vger.kernel.org>; Thu, 30 Mar 2017 03:05:22 -0700 (PDT)
In-Reply-To: <CAL2-6bJLntQ3MzYffw3_tFQXjizErDLDY5RoBG5-DyZUoCAhnQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vincent Godin <vince.mlist@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Current ceph implement backfill mechanism,
let say, pg A primary is on the new osd,
but it will not serve client io during backfilling, bc there is a
replica  act as temp primary,
so it can recover fast,
after backfill finished, the osd's role will turn to primary, and
accept client io.

2017-03-30 17:47 GMT+08:00 Vincent Godin <vince.mlist@gmail.com>:
> When you replace a failed osd, it has to recover all of its pgs and so
> it is pretty busy. Is it possible to tell this OSD to not become
> primary for any of its already synchronized pgs till every pgs (of the
> OSD) have recovered ? It should accelerate the rebuild process because
> this OSD won't have to serve client's read requests but just sync the
> writes request from the OSDs owning the primary pgs and recover. Is
> there something wrong with this idea ?
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thank you!
HuangJun
