From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: LOCK_SYNC_MIX state makes "getattr" operations extremely slow
 when there are lots of clients issue writes or reads to the same file
Date: Tue, 6 Feb 2018 15:09:27 +0800
Message-ID: <CAAM7YA=pvgX2ty0B=FDsixp_A52rfvKVt2FUp-D8jJEK8z1V8A@mail.gmail.com>
References: <CAJACTudeJCqQiEOxuSxfFsH2KdnSeors-6cCvx9jh-Nn8u6huA@mail.gmail.com>
 <CAAM7YA=_+WQc+_y9ukX68DPzFBUotEcGXny1BvuHekvs_Q1kXQ@mail.gmail.com>
 <CAJACTud5FdaoybJ7W_CTQCRqZVBghHMwqGbsSyX3SZEpOvmN+A@mail.gmail.com>
 <CAJACTucSQM8hrCfj0aY4nsVhyFeB+PwxHGOfwxao5tnqxwDTtg@mail.gmail.com> <CAJACTucKaWvtAKKnPQVQ3EhkeEXTncJgFu2uJ6V2T0NBpkqqqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f181.google.com ([74.125.82.181]:35369 "EHLO
        mail-ot0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750974AbeBFHJ2 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Feb 2018 02:09:28 -0500
Received: by mail-ot0-f181.google.com with SMTP id a2so826587otf.2
        for <ceph-devel@vger.kernel.org>; Mon, 05 Feb 2018 23:09:28 -0800 (PST)
In-Reply-To: <CAJACTucKaWvtAKKnPQVQ3EhkeEXTncJgFu2uJ6V2T0NBpkqqqg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xuehan Xu <xxhdx1985126@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Feb 6, 2018 at 2:55 PM, Xuehan Xu <xxhdx1985126@gmail.com> wrote:
>>>
>>> Thanks, Zheng Yan:-)
>>>
>>> In our case, there is only one client want the "Fw" capability, most
>>> of the clients just needs "Fscr". However, as LOCK_MIX state allows
>>> only "Frwl", CInode::filelock had to wait in LOCK_SYNC_MIX state for
>>> those tens of READ clients to release "Fsc" caps, which led to the
>>> long wait and inefficient processing of getattr requests. We think
>>> waiting for clients to release "Fsc" in this case might not be
>>> necessary, is this right?
>>
>> Oh, sorry, in our case, the transition of CInode::filelock's state
>> from LOCK_SYNC to LOCK_SYNC_MIX is done in the "finish" phase of a
>> getattr request when there are clients who want the "Fw" cap at the
>> time. So I think, this should be the mds waiting for READ clients to
>> release "Fsc" so that it can issue "Fw" to the writing client.
>
> And, since "Fw" is still not issued to the writing client yet in the
> LOCK_SYNC_MIX state, it seems that getattr requests should be
> processed instead of blocked in this state, is this right?

this will starve writer if there are lots of getattr
