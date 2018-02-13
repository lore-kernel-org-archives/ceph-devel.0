From: Xuehan Xu <xxhdx1985126@gmail.com>
Subject: Re: LOCK_SYNC_MIX state makes "getattr" operations extremely slow
 when there are lots of clients issue writes or reads to the same file
Date: Tue, 13 Feb 2018 10:06:56 +0800
Message-ID: <CAJACTuf7XgxiY0kF2y9b__F5AThHefD-4Zzu89-jc96ZgVc_EQ@mail.gmail.com>
References: <CAJACTudeJCqQiEOxuSxfFsH2KdnSeors-6cCvx9jh-Nn8u6huA@mail.gmail.com>
 <CAAM7YA=_+WQc+_y9ukX68DPzFBUotEcGXny1BvuHekvs_Q1kXQ@mail.gmail.com>
 <CAJACTud5FdaoybJ7W_CTQCRqZVBghHMwqGbsSyX3SZEpOvmN+A@mail.gmail.com>
 <CAJACTucSQM8hrCfj0aY4nsVhyFeB+PwxHGOfwxao5tnqxwDTtg@mail.gmail.com>
 <CAJACTucKaWvtAKKnPQVQ3EhkeEXTncJgFu2uJ6V2T0NBpkqqqg@mail.gmail.com>
 <CAAM7YA=pvgX2ty0B=FDsixp_A52rfvKVt2FUp-D8jJEK8z1V8A@mail.gmail.com> <CAJ4mKGapADYxUckAjFHHOXroFFvbYwW1XXEc2xQ1bao6PEOoWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:37252 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933057AbeBMCG7 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Feb 2018 21:06:59 -0500
Received: by mail-lf0-f41.google.com with SMTP id f137so23044526lfe.4
        for <ceph-devel@vger.kernel.org>; Mon, 12 Feb 2018 18:06:58 -0800 (PST)
In-Reply-To: <CAJ4mKGapADYxUckAjFHHOXroFFvbYwW1XXEc2xQ1bao6PEOoWg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: "Yan, Zheng" <ukernel@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

> I've been following this discussion casually and am a bit confused.
> The Client will happily send off an explicit getattr request if it
> doesn't have enough capabilities to answer it locally.
>
> Is the problem here that the MDS is not answering all pending
> CEPH_MDS_OP_GETATTR requests in one go? (Which I suppose it doesn't
> really have a way of doing, if they haven't all been processed into
> interior pending locks =E2=80=94 but I think they should have gotten ther=
e if
> caps are being recalled?)
> Or are the clients for some reason requesting capabilities instead of
> the single getattr message?
> -Greg

Hi, Greg.

In our case, the mds does answer each CEPH_MDS_OP_GETATTR request
seperately, even when there caps are recalled. According to our mds
log, when the caps are recalled, all of these CEPH_MDS_OP_GETATTR
requests are added to the waiter queue, and when the filelock goes
into a stable state, they would be dispatched to be reprocessed one by
one. However, as there are writing clients that want "Fw", the very
first CEPH_MDS_OP_GETATTR request of those in the waiter queue would,
again, turn the filelock into LOCK_SYNC_MIX state which would blocked
all remaining CEPH_MDS_OP_GETATTR requests to get processed.
