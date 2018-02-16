From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: LOCK_SYNC_MIX state makes "getattr" operations extremely slow
 when there are lots of clients issue writes or reads to the same file
Date: Fri, 16 Feb 2018 15:53:51 -0800
Message-ID: <CAJ4mKGaMnDS6aCT9Go0KwnH-m5Lmi+9b3cSNAd_Dv2D6hmO3aw@mail.gmail.com>
References: <CAJACTudeJCqQiEOxuSxfFsH2KdnSeors-6cCvx9jh-Nn8u6huA@mail.gmail.com>
 <CAAM7YA=_+WQc+_y9ukX68DPzFBUotEcGXny1BvuHekvs_Q1kXQ@mail.gmail.com>
 <CAJACTud5FdaoybJ7W_CTQCRqZVBghHMwqGbsSyX3SZEpOvmN+A@mail.gmail.com>
 <CAJACTucSQM8hrCfj0aY4nsVhyFeB+PwxHGOfwxao5tnqxwDTtg@mail.gmail.com>
 <CAJACTucKaWvtAKKnPQVQ3EhkeEXTncJgFu2uJ6V2T0NBpkqqqg@mail.gmail.com>
 <CAAM7YA=pvgX2ty0B=FDsixp_A52rfvKVt2FUp-D8jJEK8z1V8A@mail.gmail.com>
 <CAJ4mKGapADYxUckAjFHHOXroFFvbYwW1XXEc2xQ1bao6PEOoWg@mail.gmail.com> <CAJACTuf7XgxiY0kF2y9b__F5AThHefD-4Zzu89-jc96ZgVc_EQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:44067 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750824AbeBPXxw (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Feb 2018 18:53:52 -0500
Received: by mail-io0-f175.google.com with SMTP id z6so5826618iob.11
        for <ceph-devel@vger.kernel.org>; Fri, 16 Feb 2018 15:53:52 -0800 (PST)
In-Reply-To: <CAJACTuf7XgxiY0kF2y9b__F5AThHefD-4Zzu89-jc96ZgVc_EQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xuehan Xu <xxhdx1985126@gmail.com>
Cc: "Yan, Zheng" <ukernel@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Feb 12, 2018 at 6:06 PM, Xuehan Xu <xxhdx1985126@gmail.com> wrote:
>> I've been following this discussion casually and am a bit confused.
>> The Client will happily send off an explicit getattr request if it
>> doesn't have enough capabilities to answer it locally.
>>
>> Is the problem here that the MDS is not answering all pending
>> CEPH_MDS_OP_GETATTR requests in one go? (Which I suppose it doesn't
>> really have a way of doing, if they haven't all been processed into
>> interior pending locks — but I think they should have gotten there if
>> caps are being recalled?)
>> Or are the clients for some reason requesting capabilities instead of
>> the single getattr message?
>> -Greg
>
> Hi, Greg.
>
> In our case, the mds does answer each CEPH_MDS_OP_GETATTR request
> seperately, even when there caps are recalled. According to our mds
> log, when the caps are recalled, all of these CEPH_MDS_OP_GETATTR
> requests are added to the waiter queue, and when the filelock goes
> into a stable state, they would be dispatched to be reprocessed one by
> one. However, as there are writing clients that want "Fw", the very
> first CEPH_MDS_OP_GETATTR request of those in the waiter queue would,
> again, turn the filelock into LOCK_SYNC_MIX state which would blocked
> all remaining CEPH_MDS_OP_GETATTR requests to get processed.

Hmm, that makes some sense but is sad. I think to resolve this we’d
need the MDS to recognize “repetitions” of the same op type that can
be serviced in a single lock operation for essentially no extra
(locking) cost, but I’m not sure how we’d integrate that with the
capability locking going on.
I guess that when we do locking operations, if they are a single
request and don't involve giving the client caps, maybe we could stick
stick any requests that require the same set of locks on a shared data
structure? And then run through them all when we get granted locks and
reply to those requests? That may not involve any real fairness
tradeoffs, as long as we're careful to only do stuff that doesn't
require extra effort (beyond queueing up the message send).

But I haven't looked at the data structures enough lately to have any
idea if something like this is really feasible.
-Greg
