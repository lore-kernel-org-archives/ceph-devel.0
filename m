From: Xuehan Xu <xxhdx1985126@gmail.com>
Subject: Re: LOCK_SYNC_MIX state makes "getattr" operations extremely slow
 when there are lots of clients issue writes or reads to the same file
Date: Thu, 8 Feb 2018 15:19:37 +0800
Message-ID: <CAJACTuep9rVM_38o0YK8wuB0GBX-exaAzyVpDm4rfnf8aEuZkQ@mail.gmail.com>
References: <CAJACTudeJCqQiEOxuSxfFsH2KdnSeors-6cCvx9jh-Nn8u6huA@mail.gmail.com>
 <CAAM7YA=_+WQc+_y9ukX68DPzFBUotEcGXny1BvuHekvs_Q1kXQ@mail.gmail.com>
 <CAJACTud5FdaoybJ7W_CTQCRqZVBghHMwqGbsSyX3SZEpOvmN+A@mail.gmail.com>
 <CAJACTucSQM8hrCfj0aY4nsVhyFeB+PwxHGOfwxao5tnqxwDTtg@mail.gmail.com>
 <CAJACTucKaWvtAKKnPQVQ3EhkeEXTncJgFu2uJ6V2T0NBpkqqqg@mail.gmail.com>
 <CAAM7YA=pvgX2ty0B=FDsixp_A52rfvKVt2FUp-D8jJEK8z1V8A@mail.gmail.com> <CAJACTufiwTs4ijfQR=Pfjp1bteO=470Lq-YT3Lkr_2A=42XpoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:41082 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbeBHHTj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Feb 2018 02:19:39 -0500
Received: by mail-lf0-f42.google.com with SMTP id f136so4961952lff.8
        for <ceph-devel@vger.kernel.org>; Wed, 07 Feb 2018 23:19:38 -0800 (PST)
In-Reply-To: <CAJACTufiwTs4ijfQR=Pfjp1bteO=470Lq-YT3Lkr_2A=42XpoA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 8 February 2018 at 15:10, Xuehan Xu <xxhdx1985126@gmail.com> wrote:
> Hi, everyone.
>
> Actually, in our case, the whole procedure of a single run of
> "getattr" ops processing is this:
>
> 1. The "finish" phase of the previous "getattr" op processing turn the
> target inode's filelock state into LOCK_SYNC_MIX if its current state
> is LOCK_SYNC;
> 2. mds blocks all other "getattr" operations when the target inode's
> filelock state is LOCK_SYNC_MIX, and wait for all clients to release
> caps that are not allowed in LOCK_MIX;
> 3. When all clients release those not allowed caps, the inode's
> filelock state is turned in to LOCK_MIX;
> 4. A new "getattr" op is dispatched to be processed, during which the
> inode's filelock state is turned back to LOCK_SYNC and the "getattr"
> op is processed successfully;
>
> If the next op that is to be dispatched to be processed is, again, a
> "getattr", the whole procedure would be repeated. In our case, the
> waiting of the mds for all clients to release caps that are not
> allowed in state LOCK_MIX could take several hundreds of milliseconds,
> which means only a few "getattr" requests can be processed per second.
> And because the "getattr" operation is the mostly issued request in
> our case, the above procedure can repeat so many times that the
> response time of the process of a single "getattr" request can take
> 40+ seconds as they have to wait for their previous "getattr" ops to
> be processed first, and in the meantime, the "setattr" operations that
> are issued by the writing client can hardly get the chance to be
> processed

I'm now trying to read the related source code, however, I found it a
little hard to understand.
What does the MDSCacheObject's auth_pin method mean? Does it mean that
the MDSCacheObject cannot be evicted from the in memory cache?
