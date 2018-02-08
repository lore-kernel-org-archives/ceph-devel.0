From: Xuehan Xu <xxhdx1985126@gmail.com>
Subject: Re: LOCK_SYNC_MIX state makes "getattr" operations extremely slow
 when there are lots of clients issue writes or reads to the same file
Date: Thu, 8 Feb 2018 17:39:22 +0800
Message-ID: <CAJACTuf4zXoviM_ux07r3x5Ewe9pxS-zJQXoMBa3U4+sRXvkgg@mail.gmail.com>
References: <CAJACTudeJCqQiEOxuSxfFsH2KdnSeors-6cCvx9jh-Nn8u6huA@mail.gmail.com>
 <CAAM7YA=_+WQc+_y9ukX68DPzFBUotEcGXny1BvuHekvs_Q1kXQ@mail.gmail.com>
 <CAJACTud5FdaoybJ7W_CTQCRqZVBghHMwqGbsSyX3SZEpOvmN+A@mail.gmail.com>
 <CAJACTucSQM8hrCfj0aY4nsVhyFeB+PwxHGOfwxao5tnqxwDTtg@mail.gmail.com>
 <CAJACTucKaWvtAKKnPQVQ3EhkeEXTncJgFu2uJ6V2T0NBpkqqqg@mail.gmail.com>
 <CAAM7YA=pvgX2ty0B=FDsixp_A52rfvKVt2FUp-D8jJEK8z1V8A@mail.gmail.com>
 <CAJACTufiwTs4ijfQR=Pfjp1bteO=470Lq-YT3Lkr_2A=42XpoA@mail.gmail.com>
 <CAJACTuep9rVM_38o0YK8wuB0GBX-exaAzyVpDm4rfnf8aEuZkQ@mail.gmail.com> <F76BED58-5B73-4B86-AFED-1B48E015738B@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:32963 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750749AbeBHJjY (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Feb 2018 04:39:24 -0500
Received: by mail-lf0-f44.google.com with SMTP id t139so5495567lff.0
        for <ceph-devel@vger.kernel.org>; Thu, 08 Feb 2018 01:39:24 -0800 (PST)
In-Reply-To: <F76BED58-5B73-4B86-AFED-1B48E015738B@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?6Zm25Yas5Yas?= <tdd21151186@gmail.com>
Cc: "Yan, Zheng" <ukernel@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

> I think it=E2=80=99s used to stop that cache object from being frozen.
> so that it won=E2=80=99t be exported to other MDS.

Thanks:-)
By the way, is there any document about the whole architecture of
client capabilities mechanism? I found the source code really hard to
fully understand........Thanks:-)
