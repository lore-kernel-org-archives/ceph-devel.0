From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: LOCK_SYNC_MIX state makes "getattr" operations extremely slow
 when there are lots of clients issue writes or reads to the same file
Date: Mon, 12 Feb 2018 07:42:52 -0800
Message-ID: <CAJ4mKGapADYxUckAjFHHOXroFFvbYwW1XXEc2xQ1bao6PEOoWg@mail.gmail.com>
References: <CAJACTudeJCqQiEOxuSxfFsH2KdnSeors-6cCvx9jh-Nn8u6huA@mail.gmail.com>
 <CAAM7YA=_+WQc+_y9ukX68DPzFBUotEcGXny1BvuHekvs_Q1kXQ@mail.gmail.com>
 <CAJACTud5FdaoybJ7W_CTQCRqZVBghHMwqGbsSyX3SZEpOvmN+A@mail.gmail.com>
 <CAJACTucSQM8hrCfj0aY4nsVhyFeB+PwxHGOfwxao5tnqxwDTtg@mail.gmail.com>
 <CAJACTucKaWvtAKKnPQVQ3EhkeEXTncJgFu2uJ6V2T0NBpkqqqg@mail.gmail.com> <CAAM7YA=pvgX2ty0B=FDsixp_A52rfvKVt2FUp-D8jJEK8z1V8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:45697 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753159AbeBLPmx (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Feb 2018 10:42:53 -0500
Received: by mail-io0-f180.google.com with SMTP id p188so17681427ioe.12
        for <ceph-devel@vger.kernel.org>; Mon, 12 Feb 2018 07:42:53 -0800 (PST)
In-Reply-To: <CAAM7YA=pvgX2ty0B=FDsixp_A52rfvKVt2FUp-D8jJEK8z1V8A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: Xuehan Xu <xxhdx1985126@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Feb 5, 2018 at 11:09 PM, Yan, Zheng <ukernel@gmail.com> wrote:
> On Tue, Feb 6, 2018 at 2:55 PM, Xuehan Xu <xxhdx1985126@gmail.com> wrote:
>>>>
>>>> Thanks, Zheng Yan:-)
>>>>
>>>> In our case, there is only one client want the "Fw" capability, most
>>>> of the clients just needs "Fscr". However, as LOCK_MIX state allows
>>>> only "Frwl", CInode::filelock had to wait in LOCK_SYNC_MIX state for
>>>> those tens of READ clients to release "Fsc" caps, which led to the
>>>> long wait and inefficient processing of getattr requests. We think
>>>> waiting for clients to release "Fsc" in this case might not be
>>>> necessary, is this right?
>>>
>>> Oh, sorry, in our case, the transition of CInode::filelock's state
>>> from LOCK_SYNC to LOCK_SYNC_MIX is done in the "finish" phase of a
>>> getattr request when there are clients who want the "Fw" cap at the
>>> time. So I think, this should be the mds waiting for READ clients to
>>> release "Fsc" so that it can issue "Fw" to the writing client.
>>
>> And, since "Fw" is still not issued to the writing client yet in the
>> LOCK_SYNC_MIX state, it seems that getattr requests should be
>> processed instead of blocked in this state, is this right?
>
> this will starve writer if there are lots of getattr

I've been following this discussion casually and am a bit confused.
The Client will happily send off an explicit getattr request if it
doesn't have enough capabilities to answer it locally.

Is the problem here that the MDS is not answering all pending
CEPH_MDS_OP_GETATTR requests in one go? (Which I suppose it doesn't
really have a way of doing, if they haven't all been processed into
interior pending locks — but I think they should have gotten there if
caps are being recalled?)
Or are the clients for some reason requesting capabilities instead of
the single getattr message?
-Greg
