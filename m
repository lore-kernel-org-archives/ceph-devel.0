From: =?gb2312?B?zNW2rLas?= <tdd21151186@gmail.com>
Subject: Re: LOCK_SYNC_MIX state makes "getattr" operations extremely slow
 when there are lots of clients issue writes or reads to the same file
Date: Thu, 8 Feb 2018 15:35:30 +0800
Message-ID: <F76BED58-5B73-4B86-AFED-1B48E015738B@gmail.com>
References: <CAJACTudeJCqQiEOxuSxfFsH2KdnSeors-6cCvx9jh-Nn8u6huA@mail.gmail.com>
 <CAAM7YA=_+WQc+_y9ukX68DPzFBUotEcGXny1BvuHekvs_Q1kXQ@mail.gmail.com>
 <CAJACTud5FdaoybJ7W_CTQCRqZVBghHMwqGbsSyX3SZEpOvmN+A@mail.gmail.com>
 <CAJACTucSQM8hrCfj0aY4nsVhyFeB+PwxHGOfwxao5tnqxwDTtg@mail.gmail.com>
 <CAJACTucKaWvtAKKnPQVQ3EhkeEXTncJgFu2uJ6V2T0NBpkqqqg@mail.gmail.com>
 <CAAM7YA=pvgX2ty0B=FDsixp_A52rfvKVt2FUp-D8jJEK8z1V8A@mail.gmail.com>
 <CAJACTufiwTs4ijfQR=Pfjp1bteO=470Lq-YT3Lkr_2A=42XpoA@mail.gmail.com>
 <CAJACTuep9rVM_38o0YK8wuB0GBX-exaAzyVpDm4rfnf8aEuZkQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:44486 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751130AbeBHHff (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Feb 2018 02:35:35 -0500
Received: by mail-pf0-f170.google.com with SMTP id 17so1432023pfw.11
        for <ceph-devel@vger.kernel.org>; Wed, 07 Feb 2018 23:35:34 -0800 (PST)
In-Reply-To: <CAJACTuep9rVM_38o0YK8wuB0GBX-exaAzyVpDm4rfnf8aEuZkQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xuehan Xu <xxhdx1985126@gmail.com>
Cc: "Yan, Zheng" <ukernel@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>


I think it=A1=AFs used to stop that cache object from being frozen.
so that it won=A1=AFt be exported to other MDS.

Regards,
Dongdong
> =D4=DA 2018=C4=EA2=D4=C28=C8=D5=A3=AC=CF=C2=CE=E73:19=A3=ACXuehan Xu =
<xxhdx1985126@gmail.com> =D0=B4=B5=C0=A3=BA
>=20
> On 8 February 2018 at 15:10, Xuehan Xu <xxhdx1985126@gmail.com> wrote:
>> Hi, everyone.
>>=20
>> Actually, in our case, the whole procedure of a single run of
>> "getattr" ops processing is this:
>>=20
>> 1. The "finish" phase of the previous "getattr" op processing turn =
the
>> target inode's filelock state into LOCK_SYNC_MIX if its current state
>> is LOCK_SYNC;
>> 2. mds blocks all other "getattr" operations when the target inode's
>> filelock state is LOCK_SYNC_MIX, and wait for all clients to release
>> caps that are not allowed in LOCK_MIX;
>> 3. When all clients release those not allowed caps, the inode's
>> filelock state is turned in to LOCK_MIX;
>> 4. A new "getattr" op is dispatched to be processed, during which the
>> inode's filelock state is turned back to LOCK_SYNC and the "getattr"
>> op is processed successfully;
>>=20
>> If the next op that is to be dispatched to be processed is, again, a
>> "getattr", the whole procedure would be repeated. In our case, the
>> waiting of the mds for all clients to release caps that are not
>> allowed in state LOCK_MIX could take several hundreds of =
milliseconds,
>> which means only a few "getattr" requests can be processed per =
second.
>> And because the "getattr" operation is the mostly issued request in
>> our case, the above procedure can repeat so many times that the
>> response time of the process of a single "getattr" request can take
>> 40+ seconds as they have to wait for their previous "getattr" ops to
>> be processed first, and in the meantime, the "setattr" operations =
that
>> are issued by the writing client can hardly get the chance to be
>> processed
>=20
> I'm now trying to read the related source code, however, I found it a
> little hard to understand.
> What does the MDSCacheObject's auth_pin method mean? Does it mean that
> the MDSCacheObject cannot be evicted from the in memory cache?
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

